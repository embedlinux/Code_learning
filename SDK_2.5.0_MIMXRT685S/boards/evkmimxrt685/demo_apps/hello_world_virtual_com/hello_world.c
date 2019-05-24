/*
 * Copyright (c) 2013 - 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "board.h"

#include "usb_device_config.h"
#include "usb.h"
#include "usb_device.h"
#include "serial_port_usb.h"
#include "pin_mux.h"
#include "usb_phy.h"
#include <stdbool.h>
#include "fsl_power.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/


/*******************************************************************************
 * Prototypes
 ******************************************************************************/
void USB_DeviceClockInit(void);
extern void USB1_IRQHandler();

/*******************************************************************************
 * Code
 ******************************************************************************/
void USB0_IRQHandler(void)
{
    USB1_IRQHandler();
}

void USB_DeviceClockInit(void)
{
    usb_phy_config_struct_t phyConfig = {
        BOARD_USB_PHY_D_CAL, BOARD_USB_PHY_TXCAL45DP, BOARD_USB_PHY_TXCAL45DM,
    };
    /* enable USB IP clock */
    CLOCK_EnableUsbhsDeviceClock();
    
    if ((SYSCTL0->PDRUNCFG1 & (SYSCTL0_PDRUNCFG1_USBHS_SRAM_APD_MASK | SYSCTL0_PDRUNCFG1_USBHS_SRAM_PPD_MASK)) ==
        (SYSCTL0_PDRUNCFG1_USBHS_SRAM_APD_MASK | SYSCTL0_PDRUNCFG1_USBHS_SRAM_PPD_MASK))
    {
        SYSCTL0->PDRUNCFG1_CLR = SYSCTL0_PDRUNCFG1_USBHS_SRAM_APD_MASK | SYSCTL0_PDRUNCFG1_USBHS_SRAM_PPD_MASK;
        PMC->CTRL |= PMC_CTRL_APPLYCFG_MASK;
        while (PMC->STATUS & PMC_STATUS_ACTIVEFSM_MASK)
            ;
    }

    /* enable usb1 phy */
    SYSCTL0->PDRUNCFG0_CLR |= SYSCTL0_PDRUNCFG0_USB_PD_MASK;
    /* enable usb1 host clock */
    CLOCK_EnableClock(kCLOCK_UsbhsHost);
    /*According to reference mannual, device mode setting has to be set by access usb host register */
    *((uint32_t *)(USBHSH_BASE + 0x50)) |= USBHSH_PORTMODE_PORT_MODE_MASK;
    /* disable usb1 host clock */
    CLOCK_DisableClock(kCLOCK_UsbhsHost);

    CLOCK_EnableUsbhsPhyClock();

#if defined(FSL_FEATURE_USBHSD_USB_RAM) && (FSL_FEATURE_USBHSD_USB_RAM)
    for (int i = 0; i < FSL_FEATURE_USBHSD_USB_RAM; i++)
    {
        ((uint8_t *)FSL_FEATURE_USBHSD_USB_RAM_BASE_ADDRESS)[i] = 0x00U;
    }
#endif
    USB_EhciPhyInit(kUSB_ControllerLpcIp3511Hs0, BOARD_XTAL_SYS_CLK_HZ, &phyConfig);
}
/*!
 * @brief Main function
 */
int main(void)
{
    char ch;

    /* Init board hardware. */
    BOARD_InitPins();
    BOARD_BootClockRUN();

    POWER_DisablePD(kPDRUNCFG_APD_USBHS_SRAM);
    POWER_DisablePD(kPDRUNCFG_PPD_USBHS_SRAM);

    POWER_ApplyPD();

    /* Initialize the debug console as CDC virtual com. */
    USB_DeviceClockInit();
    DbgConsole_Init((uint8_t)kSerialManager_UsbControllerLpcIp3511Hs0, (uint32_t)NULL, kSerialPort_UsbCdc,
                    (uint32_t)NULL);

    PRINTF("hello world.\r\n");

    while (1)
    {
        ch = GETCHAR();
        PUTCHAR(ch);
    }
}
