/*
 * Copyright (c) 2016, Freescale Semiconductor, Inc.
 * Copyright 2016-2019 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "board.h"
#include "fsl_common.h"
#include "fsl_debug_console.h"
#include "fsl_gpio.h"
#include "pin_mux.h"

#include "clock_config.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define APP_BOARD_TEST_LED_PORT 0U
#define APP_BOARD_TEST_LED_PIN 26U
#define APP_SW_PORT 0U
#define APP_SW_PIN 27U
#define APP_GPIO_INTA_IRQHandler GPIO_INTA_DriverIRQHandler
#define APP_SW_IRQ GPIO_INTA_IRQn
#define APP_SW_CONNECTED_LEVEL 0U
#define APP_SW_NAME "SW2"


/*******************************************************************************
 * Prototypes
 ******************************************************************************/
/*!
 * @brief delay a while.
 */
static void delay(void);

/*******************************************************************************
 * Variables
 ******************************************************************************/
/* Whether the SW is turned on */
volatile bool g_InputSignal = false;

/*******************************************************************************
 * Code
 ******************************************************************************/
/*!
 * @brief Interrupt service fuction of switch.
 */
void APP_GPIO_INTA_IRQHandler(void)
{
    /* clear the interrupt status */
    GPIO_PinClearInterruptFlag(GPIO, APP_SW_PORT, APP_SW_PIN, 0);
    /* Change state of switch. */
    g_InputSignal = true;
/* Add for ARM errata 838869, affects Cortex-M4, Cortex-M4F Store immediate overlapping
  exception return operation might vector to incorrect interrupt */
#if defined __CORTEX_M && (__CORTEX_M == 4U)
    __DSB();
#endif
}

/*!
 * @brief Main function
 */
int main(void)
{
    /* Define the init structure for the input switch pin */
    gpio_pin_config_t sw_config = {kGPIO_DigitalInput, 0};
    gpio_interrupt_config_t config = {kGPIO_PinIntEnableEdge, kGPIO_PinIntEnableLowOrFall};

    /* hardware initialiize, include IOMUX, Uart debug initialize */
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    PRINTF("GPIO Driver example.\r\n");

    /* Init input switch GPIO. */
    EnableIRQ(APP_SW_IRQ);
    GPIO_PortInit(GPIO, APP_SW_PORT);
    GPIO_PinInit(GPIO, APP_SW_PORT, APP_SW_PIN, &sw_config);

    /* Enable GPIO pin interrupt */
    GPIO_SetPinInterruptConfig(GPIO, APP_SW_PORT, APP_SW_PIN, &config);
    GPIO_PinEnableInterrupt(GPIO, APP_SW_PORT, APP_SW_PIN, 0);

    while (1)
    {
        if (g_InputSignal)
        {
            delay();
            if (APP_SW_CONNECTED_LEVEL == GPIO_PinRead(GPIO, APP_SW_PORT, APP_SW_PIN))
            {
                PRINTF("%s is turned on.\r\n", APP_SW_NAME);
            }
            /* Reset state of switch. */
            g_InputSignal = false;
        }
    }
}

static void delay(void)
{
    volatile uint32_t i = 0;
    for (i = 0; i < 1000000; ++i)
    {
        __NOP(); /* delay */
    }
}
