/*
 * Copyright (c) 2016, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_debug_console.h"
#include "board.h"
#include "fsl_common.h"
#include "fsl_power.h"
#include "fsl_inputmux.h"
#include "fsl_pint.h"
#include "fsl_usart.h"

#include "pin_mux.h"
#include "clock_config.h"
#include "fsl_pca9420.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define APP_USART_RX_ERROR kUSART_RxError
#define APP_USER_WAKEUP_KEY_NAME "SW1"
#define APP_USER_WAKEUP_KEY_GPIO BOARD_SW1_GPIO
#define APP_USER_WAKEUP_KEY_PORT BOARD_SW1_GPIO_PORT
#define APP_USER_WAKEUP_KEY_PIN BOARD_SW1_GPIO_PIN
#define APP_USER_WAKEUP_KEY_INPUTMUX_SEL kINPUTMUX_GpioPort1Pin1ToPintsel
#define APP_DEEPSLEEP_RUNCFG0 0U  /*!< Power down all unnecessary blocks during deep sleep*/
#define APP_DEEPSLEEP_RAM_APD 0xFFFFF8U
#define APP_DEEPSLEEP_RAM_PPD 0xFFFFF8U
#define APP_EXCLUDE_FROM_DEEPSLEEP                                                                          \
    (((const uint32_t[]){APP_DEEPSLEEP_RUNCFG0,                                                             \
                         (SYSCTL0_PDSLEEPCFG1_OSPI_SRAM_APD_MASK | SYSCTL0_PDSLEEPCFG1_OSPI_SRAM_PPD_MASK), \
                         APP_DEEPSLEEP_RAM_APD, APP_DEEPSLEEP_RAM_PPD}))

#define APP_EXCLUDE_FROM_DEEP_POWERDOWN (((const uint32_t[]){0, 0, 0, 0}))
#define APP_EXCLUDE_FROM_FULL_DEEP_POWERDOWN (((const uint32_t[]){0, 0, 0, 0}))
const char *gWakeupInfoStr[] = {"Sleep [Press the user key to wakeup]", "Deep Sleep [Press the user key to wakeup]",
#if (defined(FSL_FEATURE_SYSCON_HAS_POWERDOWN_MODE) && FSL_FEATURE_SYSCON_HAS_POWERDOWN_MODE)
                                "Powerdown [Reset to wakeup]", "Deep Powerdown [Reset to wakeup]"};
#else
                                "Deep Powerdown [Reset to wakeup]", "Full Deep Powerdown [Reset to wakeup]"};
#endif
uint32_t gCurrentPowerMode;

/*******************************************************************************
 * Prototypes
 ******************************************************************************/
void BOARD_ConfigPMICModes(pca9420_modecfg_t *cfg, uint32_t num);
static uint32_t APP_GetUserSelection(void);
static void APP_InitWakeupPin(void);
static void pint_intr_callback(pint_pin_int_t pintr, uint32_t pmatch_status);

/*******************************************************************************
 * Code
 ******************************************************************************/
static pca9420_handle_t pca9420Handle;

void BOARD_ConfigPMICModes(pca9420_modecfg_t *cfg, uint32_t num)
{
    assert(cfg);
    /* Configuration PMIC mode to align with power lib like below:
     *  0b00    run mode, no special.
     *  0b01    deep sleep mode, no special.
     *  0b10    deep powerdown mode, vddcore off.
     *  0b11    full deep powerdown mode vdd1v8 and vddcore off. */

    /* Mode 2: VDDCORE off. */
    cfg[2].enableSw1Out = false;

    /* Mode 3: VDDCORE, VDD1V8 and VDDIO off. */
    cfg[3].enableSw1Out = false;
    cfg[3].enableSw2Out = false;
    cfg[3].enableLdo2Out = false;
}

/*!
 * @brief Main function
 */
int main(void)
{
    /* Init board hardware. */
    pca9420_config_t pca9420Config;
    pca9420_modecfg_t pca9420ModeCfg[3];
    uint32_t i;

    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();

    /* PMIC PCA9420 */
    CLOCK_AttachClk(kSFRO_to_FLEXCOMM15);
    BOARD_PMIC_I2C_Init();
    PCA9420_GetDefaultConfig(&pca9420Config);
    pca9420Config.powerGoodEnable = kPCA9420_PGoodDisabled;
    pca9420Config.I2C_SendFunc = BOARD_PMIC_I2C_Send;
    pca9420Config.I2C_ReceiveFunc = BOARD_PMIC_I2C_Receive;
    PCA9420_Init(&pca9420Handle, &pca9420Config);
    for (i = 0; i < ARRAY_SIZE(pca9420ModeCfg); i++)
    {
        PCA9420_GetDefaultModeConfig(&pca9420ModeCfg[i]);
    }
    BOARD_ConfigPMICModes(pca9420ModeCfg, ARRAY_SIZE(pca9420ModeCfg));
    PCA9420_WriteModeConfigs(&pca9420Handle, kPCA9420_Mode0, &pca9420ModeCfg[0], ARRAY_SIZE(pca9420ModeCfg));

    /* Determine the power mode before bring up. */
    if((POWER_GetEventFlags() & PMC_FLAGS_DEEPPDF_MASK) != 0)
    {
        PRINTF("Board wake up from deep or full deep power down mode.\r\n");
        POWER_ClearEventFlags(PMC_FLAGS_DEEPPDF_MASK);
    }

    APP_InitWakeupPin();

    PRINTF("Power Manager Demo.\r\n");
    PRINTF("The \"user key\" is: %s\r\n", APP_USER_WAKEUP_KEY_NAME);

    while (1)
    {
        gCurrentPowerMode = APP_GetUserSelection();
        PRINTF("Entering %s ...\r\n", gWakeupInfoStr[gCurrentPowerMode]);

        /* Enter the low power mode. */
        switch (gCurrentPowerMode)
        {
            case kPmu_Sleep: /* Enter sleep mode. */
                POWER_EnterSleep();
                break;
            case kPmu_Deep_Sleep: /* Enter deep sleep mode. */
                POWER_EnterDeepSleep(APP_EXCLUDE_FROM_DEEPSLEEP);
                break;
            case kPmu_Deep_PowerDown: /* Enter deep power down mode. */
                PRINTF(
                    "Press any key to confirm to enter the deep power down mode and wakeup the device by "
                    "reset.\r\n\r\n");
                GETCHAR();
                POWER_EnterDeepPowerDown(APP_EXCLUDE_FROM_DEEP_POWERDOWN);
                break;
            case kPmu_Full_Deep_PowerDown: /* Enter full deep power down mode. */
                PRINTF(
                    "Press any key to confirm to enter the full deep power down mode and wakeup the device by "
                    "reset.\r\n\r\n");
                GETCHAR();
                POWER_EnterFullDeepPowerDown(APP_EXCLUDE_FROM_FULL_DEEP_POWERDOWN);
                break;
            default:
                break;
        }

        PRINTF("Wakeup.\r\n");
    }
}

/*
 * Setup a GPIO input pin as wakeup source.
 */
static void APP_InitWakeupPin(void)
{
    gpio_pin_config_t gpioPinConfigStruct;

    /* Set SW pin as GPIO input. */
    gpioPinConfigStruct.pinDirection = kGPIO_DigitalInput;
    GPIO_PinInit(APP_USER_WAKEUP_KEY_GPIO, APP_USER_WAKEUP_KEY_PORT, APP_USER_WAKEUP_KEY_PIN, &gpioPinConfigStruct);

    /* Configure the Input Mux block and connect the trigger source to PinInt channle. */
    INPUTMUX_Init(INPUTMUX);
    INPUTMUX_AttachSignal(INPUTMUX, kPINT_PinInt0, APP_USER_WAKEUP_KEY_INPUTMUX_SEL); /* Using channel 0. */
    INPUTMUX_Deinit(INPUTMUX); /* Turnoff clock to inputmux to save power. Clock is only needed to make changes */

    /* Configure the interrupt for SW pin. */
    PINT_Init(PINT);
    PINT_PinInterruptConfig(PINT, kPINT_PinInt0, kPINT_PinIntEnableFallEdge, pint_intr_callback);
    PINT_EnableCallback(PINT); /* Enable callbacks for PINT */

    EnableDeepSleepIRQ(PIN_INT0_IRQn);
}

/*
 * Callback function when wakeup key is pressed.
 */
static void pint_intr_callback(pint_pin_int_t pintr, uint32_t pmatch_status)
{
    PRINTF("Pin event occurs\r\n");
}

/*
 * Get user selection from UART.
 */
static uint32_t APP_GetUserSelection(void)
{
    uint32_t ch;

    /* Clear rx overflow error once it happens during low power mode. */
    if (APP_USART_RX_ERROR == (APP_USART_RX_ERROR & USART_GetStatusFlags((USART_Type *)BOARD_DEBUG_UART_BASEADDR)))
    {
        USART_ClearStatusFlags((USART_Type *)BOARD_DEBUG_UART_BASEADDR, APP_USART_RX_ERROR);
    }

    PRINTF(
        "Select an option\r\n"
        "\t1. Sleep mode\r\n"
        "\t2. Deep Sleep mode\r\n"
        "\t3. Deep power down mode\r\n"
        "\t4. Full deep power down mode\r\n");
    while (1)
    {
        ch = GETCHAR();
        if ((ch < '1') || (ch > '4')) /* Only '1', '2', '3' , '4'. */
        {
            continue;
        }
        else
        {
            ch = ch - '1'; /* Only 0, 1, 2 , 3 . */
            break;
        }
    }
    switch (ch)
    {
        case 0:
            ch = kPmu_Sleep;
            break;
        case 1:
            ch = kPmu_Deep_Sleep;
            break;
        case 2:
            ch = kPmu_Deep_PowerDown;
            break;
        case 3:
            ch = kPmu_Full_Deep_PowerDown;
            break;
        default:
            break;
    }
    return ch;
}
