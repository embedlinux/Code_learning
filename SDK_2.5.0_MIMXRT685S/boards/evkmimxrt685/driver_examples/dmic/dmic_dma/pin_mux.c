/*
 * Copyright (c) 2017, NXP Semiconductor, Inc.
 * All rights reserved.
 *
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 */

/*
 * TEXT BELOW IS USED AS SETTING FOR TOOLS *************************************
!!GlobalInfo
product: Pins v3.0
processor: LPC54018
package_id: LPC54018JET180
mcu_data: ksdk2_0
processor_version: 0.0.0
 * BE CAREFUL MODIFYING THIS COMMENT - IT IS YAML SETTINGS FOR TOOLS ***********
 */

#include "fsl_common.h"
#include "fsl_iopctl.h"
#include "pin_mux.h"

/*FUNCTION**********************************************************************
 * 
 * Function Name : BOARD_InitBootPins
 * Description   : Calls initialization functions.
 * 
 *END**************************************************************************/
void BOARD_InitBootPins(void) {
    BOARD_InitPins();
}

/*
 * TEXT BELOW IS USED AS SETTING FOR TOOLS *************************************
BOARD_InitPins:
- options: {callFromInitBoot: 'true', coreID: core0, enableClock: 'true'}
- pin_list:
  - {pin_num: B13, peripheral: FLEXCOMM0, signal: RXD_SDA_MOSI, pin_signal: PIO0_29/FC0_RXD_SDA_MOSI/CTIMER2_MAT3/SCT0_OUT8/TRACEDATA(2), mode: inactive, invert: disabled,
    glitch_filter: disabled, slew_rate: standard, open_drain: disabled}
  - {pin_num: A2, peripheral: FLEXCOMM0, signal: TXD_SCL_MISO, pin_signal: PIO0_30/FC0_TXD_SCL_MISO/CTIMER0_MAT0/SCT0_OUT9/TRACEDATA(1), mode: inactive, invert: disabled,
    glitch_filter: disabled, slew_rate: standard, open_drain: disabled}
  - {pin_num: L14, peripheral: DMIC0, signal: 'CLK, 1', pin_signal: PIO1_2/CAN0_TD/CTIMER0_MAT3/SCT0_GPI6/PDM1_CLK/FC10_TXD_SCL_MISO/USB1_PORTPWRN, mode: pullUp,
    invert: disabled, glitch_filter: disabled, slew_rate: standard, open_drain: disabled}
  - {pin_num: J13, peripheral: DMIC0, signal: 'DATA, 1', pin_signal: PIO1_3/CAN0_RD/SCT0_OUT4/PDM1_DATA/USB0_PORTPWRN/FC10_SCK, mode: pullUp, invert: disabled, glitch_filter: disabled,
    slew_rate: standard, open_drain: disabled}
 * BE CAREFUL MODIFYING THIS COMMENT - IT IS YAML SETTINGS FOR TOOLS ***********
 */

/*FUNCTION**********************************************************************
 *
 * Function Name : BOARD_InitPins
 *
 *END**************************************************************************/
void BOARD_InitPins(void) {
    /* Initialize UART pins below */
    const uint32_t port0_pin1_config = (
      IOPCTL_FUNC1                                         /* Pin is configured as fc0_txd */
    );
    IOPCTL_PinMuxSet(IOPCTL, 0, 1, port0_pin1_config); /* PORT0 PIN1 is configured as UART TX */
    const uint32_t port0_pin2_config = (
      IOPCTL_FUNC1 |                                       /* Pin is configured as fc0_rxd */
      IOPCTL_INBUF_EN                                      /* Enables input buffer */
    );
    IOPCTL_PinMuxSet(IOPCTL, 0, 2, port0_pin2_config); /* PORT0 PIN2 is configured as UART RX */

    /* Initialize DMIC pins below */
    const uint32_t port2_pin16_config = (
      IOPCTL_FUNC1 |                                       /* Pin is configured as pdm_clk01 */
      IOPCTL_INBUF_EN                                      /* Enables input buffer */
    );
    IOPCTL_PinMuxSet(IOPCTL, 2, 16, port2_pin16_config); /* PORT2 PIN16 is configured as DMIC CLK01 */
    const uint32_t port2_pin20_config = (
      IOPCTL_FUNC1 |                                       /* Pin is configured as pdm_data01 */
      IOPCTL_INBUF_EN                                      /* Enables input buffer */
    );
    IOPCTL_PinMuxSet(IOPCTL, 2, 20, port2_pin20_config); /* PORT2 PIN20 is configured as DMIC DATA01 */
}

/*******************************************************************************
 * EOF
 ******************************************************************************/
