/*
 * Copyright 2018 NXP.
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

/***********************************************************************************************************************
 * This file was generated by the MCUXpresso Config Tools. Any manual edits made to this file
 * will be overwritten if the respective MCUXpresso Config Tools is used to update this file.
 **********************************************************************************************************************/

/* clang-format off */
/*
 * TEXT BELOW IS USED AS SETTING FOR TOOLS *************************************
!!GlobalInfo
product: Pins v4.1
processor: MIMXRT685
package_id: MIMXRT685EVKA
mcu_data: ksdk2_0
processor_version: 0.0.0
 * BE CAREFUL MODIFYING THIS COMMENT - IT IS YAML SETTINGS FOR TOOLS ***********
 */
/* clang-format on */

#include "fsl_common.h"
#include "fsl_iopctl.h"
#include "pin_mux.h"

/* FUNCTION ************************************************************************************************************
 *
 * Function Name : BOARD_InitBootPins
 * Description   : Calls initialization functions.
 *
 * END ****************************************************************************************************************/
void BOARD_InitBootPins(void)
{
    BOARD_InitPins();
}

/* clang-format off */
/*
 * TEXT BELOW IS USED AS SETTING FOR TOOLS *************************************
BOARD_InitPins:
- options: {callFromInitBoot: 'true', coreID: cm33}
- pin_list:
  - {pin_num: G2, peripheral: FLEXCOMM0, signal: TXD_SCL_MISO_WS, pin_signal: PIO0_1/FC0_TXD_SCL_MISO_WS/CTIMER0_MAT1, direction: OUTPUT, pupdena: disabled, pupdsel: pullDown,
    ibena: disabled, slew_rate: normal, drive: normal, amena: disabled, odena: disabled, iiena: disabled}
  - {pin_num: G4, peripheral: FLEXCOMM0, signal: RXD_SDA_MOSI_DATA, pin_signal: PIO0_2/FC0_RXD_SDA_MOSI_DATA/CTIMER0_MAT2, direction: INPUT, pupdena: disabled, pupdsel: pullDown,
    ibena: enabled, slew_rate: normal, drive: normal, amena: disabled, odena: disabled, iiena: disabled}
  - {pin_num: L3, peripheral: FLEXCOMM1, signal: RXD_SDA_MOSI_DATA, pin_signal: PIO0_9/FC1_RXD_SDA_MOSI_DATA/SCT0_PIN_INP6/SCT0_OUT6/CTIMER1_MAT2, pupdena: disabled,
    pupdsel: pullDown, ibena: enabled, slew_rate: normal, drive: normal, amena: disabled, odena: disabled, iiena: disabled}
  - {pin_num: K4, peripheral: FLEXCOMM1, signal: TXD_SCL_MISO_WS, pin_signal: PIO0_8/FC1_TXD_SCL_MISO_WS/SCT0_PIN_INP5/SCT0_OUT5/CTIMER1_MAT1, direction: OUTPUT,
    pupdena: disabled, pupdsel: pullDown, ibena: enabled, slew_rate: normal, drive: normal, amena: disabled, odena: disabled, iiena: disabled}
 * BE CAREFUL MODIFYING THIS COMMENT - IT IS YAML SETTINGS FOR TOOLS ***********
 */
/* clang-format on */

/* FUNCTION ************************************************************************************************************
 *
 * Function Name : BOARD_InitPins
 * Description   : Configures pin routing and optionally pin electrical features.
 *
 * END ****************************************************************************************************************/
/* Function assigned for the Cortex-M33 */
void BOARD_InitPins(void)
{

    const uint32_t port0_pin1_config = (/* Pin is configured as FC0_TXD_SCL_MISO_WS */
                                        IOPCTL_PIO_FUNC1 |
                                        /* Disable pull-up / pull-down function */
                                        IOPCTL_PIO_PUPD_DI |
                                        /* Enable pull-down function */
                                        IOPCTL_PIO_PULLDOWN_EN |
                                        /* Disable input buffer function */
                                        IOPCTL_PIO_INBUF_DI |
                                        /* Normal mode */
                                        IOPCTL_PIO_SLEW_RATE_NORMAL |
                                        /* Normal drive */
                                        IOPCTL_PIO_FULLDRIVE_DI |
                                        /* Analog mux is disabled */
                                        IOPCTL_PIO_ANAMUX_DI |
                                        /* Pseudo Output Drain is disabled */
                                        IOPCTL_PIO_PSEDRAIN_DI |
                                        /* Input function is not inverted */
                                        IOPCTL_PIO_INV_DI);
    /* PORT0 PIN1 (coords: G2) is configured as FC0_TXD_SCL_MISO_WS */
    IOPCTL_PinMuxSet(IOPCTL, 0U, 1U, port0_pin1_config);

    const uint32_t port0_pin2_config = (/* Pin is configured as FC0_RXD_SDA_MOSI_DATA */
                                        IOPCTL_PIO_FUNC1 |
                                        /* Disable pull-up / pull-down function */
                                        IOPCTL_PIO_PUPD_DI |
                                        /* Enable pull-down function */
                                        IOPCTL_PIO_PULLDOWN_EN |
                                        /* Enables input buffer function */
                                        IOPCTL_PIO_INBUF_EN |
                                        /* Normal mode */
                                        IOPCTL_PIO_SLEW_RATE_NORMAL |
                                        /* Normal drive */
                                        IOPCTL_PIO_FULLDRIVE_DI |
                                        /* Analog mux is disabled */
                                        IOPCTL_PIO_ANAMUX_DI |
                                        /* Pseudo Output Drain is disabled */
                                        IOPCTL_PIO_PSEDRAIN_DI |
                                        /* Input function is not inverted */
                                        IOPCTL_PIO_INV_DI);
    /* PORT0 PIN2 (coords: G4) is configured as FC0_RXD_SDA_MOSI_DATA */
    IOPCTL_PinMuxSet(IOPCTL, 0U, 2U, port0_pin2_config);

    const uint32_t port0_pin29_config = (/* Pin is configured as FC4_TXD_SCL_MISO_WS */
                                        IOPCTL_PIO_FUNC1 |
                                        /* Enable pull-up / pull-down function */
                                        IOPCTL_PIO_PUPD_EN |
                                        /* Enable pull-up function */
                                        IOPCTL_PIO_PULLUP_EN |
                                        /* Enables input buffer function */
                                        IOPCTL_PIO_INBUF_EN |
                                        /* Normal mode */
                                        IOPCTL_PIO_SLEW_RATE_NORMAL |
                                        /* Normal drive */
                                        IOPCTL_PIO_FULLDRIVE_DI |
                                        /* Analog mux is disabled */
                                        IOPCTL_PIO_ANAMUX_DI |
                                        /* Pseudo Output Drain is enabled */
                                        IOPCTL_PIO_PSEDRAIN_EN |
                                        /* Input function is not inverted */
                                        IOPCTL_PIO_INV_DI);
    IOPCTL_PinMuxSet(IOPCTL, 0U, 29U, port0_pin29_config);

    const uint32_t port0_pin30_config = (/* Pin is configured as FC4_RXD_SDA_MOSI_DATA */
                                        IOPCTL_PIO_FUNC1 |
                                        /* Enable pull-up / pull-down function */
                                        IOPCTL_PIO_PUPD_EN |
                                        /* Enable pull-up function */
                                        IOPCTL_PIO_PULLUP_EN |
                                        /* Enables input buffer function */
                                        IOPCTL_PIO_INBUF_EN |
                                        /* Normal mode */
                                        IOPCTL_PIO_SLEW_RATE_NORMAL |
                                        /* Normal drive */
                                        IOPCTL_PIO_FULLDRIVE_DI |
                                        /* Analog mux is disabled */
                                        IOPCTL_PIO_ANAMUX_DI |
                                        /* Pseudo Output Drain is enabled */
                                        IOPCTL_PIO_PSEDRAIN_EN |
                                        /* Input function is not inverted */
                                        IOPCTL_PIO_INV_DI);
    IOPCTL_PinMuxSet(IOPCTL, 0U, 30U, port0_pin30_config);
}
/***********************************************************************************************************************
 * EOF
 **********************************************************************************************************************/
