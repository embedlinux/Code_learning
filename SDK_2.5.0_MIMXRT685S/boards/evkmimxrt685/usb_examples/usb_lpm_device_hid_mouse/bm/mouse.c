/*
 * Copyright (c) 2015 - 2016, Freescale Semiconductor, Inc.
 * Copyright 2016 - 2017 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "usb_device_config.h"
#include "usb.h"
#include "usb_device.h"

#include "usb_device_class.h"
#include "usb_device_hid.h"
#include "usb_device_ch9.h"
#include "usb_device_descriptor.h"
#include "mouse.h"

#include "fsl_device_registers.h"
#include "clock_config.h"
#include "board.h"
#include "fsl_debug_console.h"
#include "pin_mux.h"

#include <stdio.h>
#include <stdlib.h>
#if (defined(FSL_FEATURE_SOC_SYSMPU_COUNT) && (FSL_FEATURE_SOC_SYSMPU_COUNT > 0U))
#include "fsl_sysmpu.h"
#endif /* FSL_FEATURE_SOC_SYSMPU_COUNT */

#if ((defined FSL_FEATURE_SOC_USBPHY_COUNT) && (FSL_FEATURE_SOC_USBPHY_COUNT > 0U))
#include "usb_phy.h"
#endif

#include <stdbool.h>
#include "fsl_inputmux.h"
#include "fsl_pint.h"
#include "fsl_power.h"
#include "usb_timer.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/

/*******************************************************************************
 * Prototypes
 ******************************************************************************/
void BOARD_InitHardware(void);
void USB_DeviceClockInit(void);
void USB_DeviceIsrEnable(void);
#if USB_DEVICE_CONFIG_USE_TASK
void USB_DeviceTaskFn(void *deviceHandle);
#endif

static usb_status_t USB_DeviceHidMouseAction(void);
static usb_status_t USB_DeviceHidMouseCallback(class_handle_t handle, uint32_t event, void *param);
static usb_status_t USB_DeviceCallback(usb_device_handle handle, uint32_t event, void *param);
static void USB_DeviceApplicationInit(void);

void BOARD_InitPins(void);
void BOARD_DeinitPins(void);
void SW_IntControl(uint8_t enable);
char *SW_GetName(void);
void HW_TimerControl(uint8_t enable);
void USB_LowpowerModeInit(void);
void USB_PreLowpowerMode(void);
uint8_t USB_EnterLowpowerMode(void);
void USB_PostLowpowerMode(void);
void USB_ControllerSuspended(void);
void USB_WaitClockLocked(void);

/*******************************************************************************
 * Variables
 ******************************************************************************/
extern usb_hid_mouse_struct_t g_UsbDeviceHidMouse;
static uint32_t needclk_intr_count = 0;

USB_DMA_NONINIT_DATA_ALIGN(USB_DATA_ALIGN_SIZE) static uint8_t s_MouseBuffer[USB_HID_MOUSE_REPORT_LENGTH];
usb_hid_mouse_struct_t g_UsbDeviceHidMouse;

extern usb_device_class_struct_t g_UsbDeviceHidMouseConfig;

/* Set class configurations */
usb_device_class_config_struct_t g_UsbDeviceHidConfig[1] = {{
    USB_DeviceHidMouseCallback, /* HID mouse class callback pointer */
    (class_handle_t)NULL,       /* The HID class handle, This field is set by USB_DeviceClassInit */
    &g_UsbDeviceHidMouseConfig, /* The HID mouse configuration, including class code, subcode, and protocol, class type,
                           transfer type, endpoint address, max packet size, etc.*/
}};

/* Set class configuration list */
usb_device_class_config_list_struct_t g_UsbDeviceHidConfigList = {
    g_UsbDeviceHidConfig, /* Class configurations */
    USB_DeviceCallback,   /* Device callback pointer */
    1U,                   /* Class count */
};

/*******************************************************************************
 * Code
 ******************************************************************************/
/*!
* @brief Call back for PINT Pin interrupt 0-7.
*/
void pint_intr_callback(pint_pin_int_t pintr, uint32_t pmatch_status)
{
    g_UsbDeviceHidMouse.selfWakeup = 1U;
}

/*
 * Setup a GPIO input pin as wakeup source.
 */
void APP_InitWakeupPin(void)
{
    /* Connect trigger sources to PINT */
    INPUTMUX_Init(INPUTMUX);
    INPUTMUX_AttachSignal(INPUTMUX, kPINT_PinInt0, kINPUTMUX_GpioPort1Pin1ToPintsel);

    /* Turnoff clock to inputmux to save power. Clock is only needed to make changes */
    INPUTMUX_Deinit(INPUTMUX);

    g_UsbDeviceHidMouse.selfWakeup = 0U;

    /* Initialize PINT */
    PINT_Init(PINT);

    /* Setup Pin Interrupt 1 for falling edge */
    PINT_PinInterruptConfig(PINT, kPINT_PinInt0, kPINT_PinIntEnableFallEdge, pint_intr_callback);

    /* Enable callbacks for PINT */
    PINT_EnableCallback(PINT);
}

void BOARD_DeinitPins(void)
{
}

void SW_IntControl(uint8_t enable)
{
    if (enable)
    {
        g_UsbDeviceHidMouse.selfWakeup = 0U;
        PINT_EnableCallback(PINT);
    }
    else
    {
        PINT_DisableCallback(PINT);
    }
}

char *SW_GetName(void)
{
    return "SW1";
}

void HW_TimerCallback(void)
{
    g_UsbDeviceHidMouse.hwTick++;
    USB_DeviceUpdateHwTick(g_UsbDeviceHidMouse.deviceHandle, g_UsbDeviceHidMouse.hwTick);
}
void HW_TimerInit(void)
{
    USB_TimerInit(0, 1000U, CLOCK_GetFreq(kCLOCK_BusClk), HW_TimerCallback);
}

void HW_TimerControl(uint8_t enable)
{
    USB_TimerInt(0, enable);
}
void USB_LowpowerModeInit(void)
{
    HW_TimerInit();
}
void USB_PreLowpowerMode(void)
{
    __disable_irq();
    NVIC_ClearPendingIRQ(USB0_NEEDCLK_IRQn);
    EnableIRQ(USB0_NEEDCLK_IRQn);
    SYSCTL0->STARTEN1 |= SYSCTL0_STARTEN1_USB0_NEEDCLK(1);
}

uint8_t USB_EnterLowpowerMode(void)
{
    /* Enter Sleep mode */
    POWER_EnterSleep();
    return kStatus_Success;
}

void USB_PostLowpowerMode(void)
{
    __enable_irq();
    SYSCTL0->STARTEN1 &= ~SYSCTL0_STARTEN1_USB0_NEEDCLK(1);
    DisableIRQ(USB0_NEEDCLK_IRQn);
}

void USB_ControllerSuspended(void)
{
    while (SYSCTL0->USBCLKSTAT & (SYSCTL0_USBCLKSTAT_DEV_NEED_CLKST_MASK))
    {
        __ASM("nop");
    }
    SYSCTL0->USBCLKCTRL |= SYSCTL0_USBCLKCTRL_POL_FS_DEV_CLK_MASK;
}

void USB0_NEEDCLK_IRQHandler(void)
{
    needclk_intr_count++;
}

void USB_WaitClockLocked(void)
{
}

void USB0_IRQHandler(void)
{
    USB_DeviceLpcIp3511IsrFunction(g_UsbDeviceHidMouse.deviceHandle);
}

void USB_DeviceClockInit(void)
{
    usb_phy_config_struct_t phyConfig = {
        BOARD_USB_PHY_D_CAL, BOARD_USB_PHY_TXCAL45DP, BOARD_USB_PHY_TXCAL45DM,
    };
    /* enable USB IP clock */
    CLOCK_EnableUsbhsDeviceClock();
    /*Make sure USDHC ram buffer has power up*/
    POWER_DisablePD(kPDRUNCFG_APD_USBHS_SRAM);
    POWER_DisablePD(kPDRUNCFG_PPD_USBHS_SRAM);
    POWER_ApplyPD();

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
    USB_EhciLowPowerPhyInit(CONTROLLER_ID, BOARD_XTAL_SYS_CLK_HZ, &phyConfig);
}
void USB_DeviceIsrEnable(void)
{
    uint8_t irqNumber;

    uint8_t usbDeviceIP3511Irq[] = USBHSD_IRQS;
    irqNumber = usbDeviceIP3511Irq[CONTROLLER_ID - kUSB_ControllerLpcIp3511Hs0];

    /* Install isr, set priority, and enable IRQ. */
    NVIC_SetPriority((IRQn_Type)irqNumber, USB_DEVICE_INTERRUPT_PRIORITY);
    EnableIRQ((IRQn_Type)irqNumber);
}
#if USB_DEVICE_CONFIG_USE_TASK
void USB_DeviceTaskFn(void *deviceHandle)
{
    USB_DeviceLpcIp3511TaskFunction(deviceHandle);
}
#endif

/* Update mouse pointer location. Draw a rectangular rotation*/
static usb_status_t USB_DeviceHidMouseAction(void)
{
    static int8_t x = 0U;
    static int8_t y = 0U;
    enum
    {
        RIGHT,
        DOWN,
        LEFT,
        UP
    };
    static uint8_t dir = RIGHT;

    switch (dir)
    {
        case RIGHT:
            /* Move right. Increase X value. */
            g_UsbDeviceHidMouse.buffer[1] = 2U;
            g_UsbDeviceHidMouse.buffer[2] = 0U;
            x++;
            if (x > 99U)
            {
                dir++;
            }
            break;
        case DOWN:
            /* Move down. Increase Y value. */
            g_UsbDeviceHidMouse.buffer[1] = 0U;
            g_UsbDeviceHidMouse.buffer[2] = 2U;
            y++;
            if (y > 99U)
            {
                dir++;
            }
            break;
        case LEFT:
            /* Move left. Discrease X value. */
            g_UsbDeviceHidMouse.buffer[1] = (uint8_t)(-2);
            g_UsbDeviceHidMouse.buffer[2] = 0U;
            x--;
            if (x < 2U)
            {
                dir++;
            }
            break;
        case UP:
            /* Move up. Discrease Y value. */
            g_UsbDeviceHidMouse.buffer[1] = 0U;
            g_UsbDeviceHidMouse.buffer[2] = (uint8_t)(-2);
            y--;
            if (y < 2U)
            {
                dir = RIGHT;
            }
            break;
        default:
            break;
    }
    /* Send mouse report to the host */
    return USB_DeviceHidSend(g_UsbDeviceHidMouse.hidHandle, USB_HID_MOUSE_ENDPOINT_IN, g_UsbDeviceHidMouse.buffer,
                             USB_HID_MOUSE_REPORT_LENGTH);
}

/* The hid class callback */
static usb_status_t USB_DeviceHidMouseCallback(class_handle_t handle, uint32_t event, void *param)
{
    usb_status_t error = kStatus_USB_Error;
    usb_device_endpoint_callback_message_struct_t *message = (usb_device_endpoint_callback_message_struct_t *)param;

    switch (event)
    {
        case kUSB_DeviceHidEventSendResponse:
            /* Resport sent */
            if (g_UsbDeviceHidMouse.attach)
            {
                if ((NULL != message) && (message->length == USB_UNINITIALIZED_VAL_32))
                {
                    return error;
                }
                if (kStatus_MouseIdle == g_UsbDeviceHidMouse.sleep)
                {
                    error = USB_DeviceHidMouseAction();
                }
            }
            break;
        case kUSB_DeviceHidEventGetReport:
        case kUSB_DeviceHidEventSetReport:
        case kUSB_DeviceHidEventRequestReportBuffer:
            error = kStatus_USB_InvalidRequest;
            break;
        case kUSB_DeviceHidEventGetIdle:
        case kUSB_DeviceHidEventGetProtocol:
        case kUSB_DeviceHidEventSetIdle:
        case kUSB_DeviceHidEventSetProtocol:
            break;
        default:
            break;
    }

    return error;
}

/* The device callback */
static usb_status_t USB_DeviceCallback(usb_device_handle handle, uint32_t event, void *param)
{
    usb_status_t error = kStatus_USB_Error;
    uint16_t *temp16 = (uint16_t *)param;
    uint8_t *temp8 = (uint8_t *)param;

    switch (event)
    {
        case kUSB_DeviceEventBusReset:
        {
            /* USB bus reset signal detected */
            g_UsbDeviceHidMouse.attach = 0U;
            g_UsbDeviceHidMouse.currentConfiguration = 0U;
            g_UsbDeviceHidMouse.remoteWakeup = 0U;
            g_UsbDeviceHidMouse.sleep = kStatus_MouseIdle;
            g_UsbDeviceHidMouse.isResume = 0U;
            error = kStatus_USB_Success;
#if (defined(USB_DEVICE_CONFIG_EHCI) && (USB_DEVICE_CONFIG_EHCI > 0U)) || \
    (defined(USB_DEVICE_CONFIG_LPCIP3511HS) && (USB_DEVICE_CONFIG_LPCIP3511HS > 0U))
            /* Get USB speed to configure the device, including max packet size and interval of the endpoints. */
            if (kStatus_USB_Success == USB_DeviceClassGetSpeed(CONTROLLER_ID, &g_UsbDeviceHidMouse.speed))
            {
                USB_DeviceSetSpeed(handle, g_UsbDeviceHidMouse.speed);
            }
#endif
        }
        break;
#if (defined(USB_DEVICE_CONFIG_DETACH_ENABLE) && (USB_DEVICE_CONFIG_DETACH_ENABLE > 0U))
        case kUSB_DeviceEventAttach:
        {
            usb_echo("USB device attached.\r\n");
            USB_DeviceRun(g_UsbDeviceHidMouse.deviceHandle);
        }
        break;
        case kUSB_DeviceEventDetach:
        {
            usb_echo("USB device detached.\r\n");
            g_UsbDeviceHidMouse.attach = 0;
            USB_DeviceStop(g_UsbDeviceHidMouse.deviceHandle);
        }
        break;
#endif
        case kUSB_DeviceEventSleeped:
        {
            /* USB device suspend signal detected */
            if (g_UsbDeviceHidMouse.attach)
            {
                usb_echo("USB device start sleep\r\n");
                USB_ControllerSuspended();
                g_UsbDeviceHidMouse.startTick = g_UsbDeviceHidMouse.hwTick;
                g_UsbDeviceHidMouse.sleep = kStatus_MouseStartSleep;
                error = kStatus_USB_Success;
            }
        }
        break;
        case kUSB_DeviceEventResume:
        {
            /* USB device bus resume signal detected */
            if ((g_UsbDeviceHidMouse.attach) && (kStatus_MouseIdle != g_UsbDeviceHidMouse.sleep))
            {
                g_UsbDeviceHidMouse.isResume = 1U;
                usb_echo("USB device start resume\r\n");
                error = kStatus_USB_Success;
            }
        }
        break;
        case kUSB_DeviceEventSetRemoteWakeup:
            if (param)
            {
                if (g_UsbDeviceHidMouse.attach)
                {
                    g_UsbDeviceHidMouse.remoteWakeup = *temp8;
                    usb_echo("USB device remote wakeup state: %d\r\n", g_UsbDeviceHidMouse.remoteWakeup);
                    error = kStatus_USB_Success;
                }
            }
            break;
        case kUSB_DeviceEventSetConfiguration:
            if (0U ==(*temp8))
            {
                g_UsbDeviceHidMouse.attach = 0;
                g_UsbDeviceHidMouse.currentConfiguration = 0U;
                g_UsbDeviceHidMouse.remoteWakeup = 0U;
                g_UsbDeviceHidMouse.sleep = kStatus_MouseIdle;
                g_UsbDeviceHidMouse.isResume = 0U;
            }
            else if (USB_HID_MOUSE_CONFIGURE_INDEX == (*temp8))
            {
                /* Set device configuration request */
                g_UsbDeviceHidMouse.attach = 1U;
                g_UsbDeviceHidMouse.currentConfiguration = *temp8;
                error = USB_DeviceHidMouseAction();
            }
            else
            {
                error = kStatus_USB_InvalidRequest;
            }

            break;
        case kUSB_DeviceEventSetInterface:
            if (g_UsbDeviceHidMouse.attach)
            {
                /* Set device interface request */
                uint8_t interface = (uint8_t)((*temp16 & 0xFF00U) >> 0x08U);
                uint8_t alternateSetting = (uint8_t)(*temp16 & 0x00FFU);
                if (interface < USB_HID_MOUSE_INTERFACE_COUNT)
                {
                    g_UsbDeviceHidMouse.currentInterfaceAlternateSetting[interface] = alternateSetting;
                    if (alternateSetting == 0U)
                    {
                        error = USB_DeviceHidMouseAction();
                    }
                }
            }
            break;
        case kUSB_DeviceEventGetConfiguration:
            if (param)
            {
                /* Get current configuration request */
                *temp8 = g_UsbDeviceHidMouse.currentConfiguration;
                error = kStatus_USB_Success;
            }
            break;
        case kUSB_DeviceEventGetInterface:
            if (param)
            {
                /* Get current alternate setting of the interface request */
                uint8_t interface = (uint8_t)((*temp16 & 0xFF00U) >> 0x08U);
                if (interface < USB_HID_MOUSE_INTERFACE_COUNT)
                {
                    *temp16 = (*temp16 & 0xFF00U) | g_UsbDeviceHidMouse.currentInterfaceAlternateSetting[interface];
                    error = kStatus_USB_Success;
                }
                else
                {
                    error = kStatus_USB_InvalidRequest;
                }
            }
            break;
        case kUSB_DeviceEventGetDeviceDescriptor:
            if (param)
            {
                /* Get device descriptor request */
                error = USB_DeviceGetDeviceDescriptor(handle, (usb_device_get_device_descriptor_struct_t *)param);
            }
            break;
        case kUSB_DeviceEventGetConfigurationDescriptor:
            if (param)
            {
                /* Get device configuration descriptor request */
                error = USB_DeviceGetConfigurationDescriptor(handle,
                                                             (usb_device_get_configuration_descriptor_struct_t *)param);
            }
            break;
#if (defined(USB_DEVICE_CONFIG_LPM_L1) && (USB_DEVICE_CONFIG_LPM_L1 > 0U))
        case kUSB_DeviceEventGetBOSDescriptor:
            if (param)
            {
                /* Get device configuration descriptor request */
                error = USB_DeviceGetBOSDescriptor(handle, (usb_device_get_bos_descriptor_struct_t *)param);
            }
            break;
#endif
        case kUSB_DeviceEventGetStringDescriptor:
            if (param)
            {
                /* Get device string descriptor request */
                error = USB_DeviceGetStringDescriptor(handle, (usb_device_get_string_descriptor_struct_t *)param);
            }
            break;
        case kUSB_DeviceEventGetHidDescriptor:
            if (param)
            {
                /* Get hid descriptor request */
                error = USB_DeviceGetHidDescriptor(handle, (usb_device_get_hid_descriptor_struct_t *)param);
            }
            break;
        case kUSB_DeviceEventGetHidReportDescriptor:
            if (param)
            {
                /* Get hid report descriptor request */
                error =
                    USB_DeviceGetHidReportDescriptor(handle, (usb_device_get_hid_report_descriptor_struct_t *)param);
            }
            break;
        case kUSB_DeviceEventGetHidPhysicalDescriptor:
            if (param)
            {
                /* Get hid physical descriptor request */
                error = USB_DeviceGetHidPhysicalDescriptor(handle,
                                                           (usb_device_get_hid_physical_descriptor_struct_t *)param);
            }
            break;
        default:
            break;
    }

    return error;
}

static void USB_DeviceApplicationInit(void)
{
    USB_DeviceClockInit();
#if (defined(FSL_FEATURE_SOC_SYSMPU_COUNT) && (FSL_FEATURE_SOC_SYSMPU_COUNT > 0U))
    SYSMPU_Enable(SYSMPU, 0);
#endif /* FSL_FEATURE_SOC_SYSMPU_COUNT */

    /* Set HID mouse to default state */
    g_UsbDeviceHidMouse.speed = USB_SPEED_FULL;
    g_UsbDeviceHidMouse.attach = 0U;
    g_UsbDeviceHidMouse.hidHandle = (class_handle_t)NULL;
    g_UsbDeviceHidMouse.deviceHandle = NULL;
    g_UsbDeviceHidMouse.remoteWakeup = 0U;
    g_UsbDeviceHidMouse.sleep = kStatus_MouseIdle;
    g_UsbDeviceHidMouse.selfWakeup = 0U;
    g_UsbDeviceHidMouse.isResume = 0U;
    g_UsbDeviceHidMouse.buffer = s_MouseBuffer;

    /* Initialize the usb stack and class drivers */
    if (kStatus_USB_Success !=
        USB_DeviceClassInit(CONTROLLER_ID, &g_UsbDeviceHidConfigList, &g_UsbDeviceHidMouse.deviceHandle))
    {
        usb_echo("USB device mouse failed\r\n");
        return;
    }
    else
    {
        usb_echo("USB device HID mouse demo\r\n");
        /* Get the HID mouse class handle */
        g_UsbDeviceHidMouse.hidHandle = g_UsbDeviceHidConfigList.config->classHandle;
    }

    USB_DeviceIsrEnable();

    /* Start USB device HID mouse */
    USB_DeviceRun(g_UsbDeviceHidMouse.deviceHandle);
}

void USB_PowerPreSwitchHook(void)
{
    HW_TimerControl(0U);

    DbgConsole_Deinit();

    BOARD_DeinitPins();

    USB_PreLowpowerMode();
}

void USB_PowerPostSwitchHook(void)
{
    USB_WaitClockLocked();
    USB_PostLowpowerMode();
    BOARD_InitPins();
    BOARD_InitDebugConsole();
    HW_TimerControl(1U);
}

void USB_DeviceSuspendResumeTask(void)
{
    if (g_UsbDeviceHidMouse.isResume)
    {
        g_UsbDeviceHidMouse.isResume = 0U;
        if (kStatus_MouseIdle != g_UsbDeviceHidMouse.sleep)
        {
            g_UsbDeviceHidMouse.sleep = kStatus_MouseResumed;
        }
    }

    switch (g_UsbDeviceHidMouse.sleep)
    {
        case kStatus_MouseIdle:
            break;
        case kStatus_MouseStartSleep:
            g_UsbDeviceHidMouse.sleep = kStatus_MouseSleeping;
            break;
        case kStatus_MouseSleeping:
            usb_echo("USB device sleeped.\r\n");
            USB_DeviceGetStatus(g_UsbDeviceHidMouse.deviceHandle, kUSB_DeviceStatusRemoteWakeup,
                                &g_UsbDeviceHidMouse.remoteWakeup);
            usb_echo("USB device remote wakeup state: %d\r\n", g_UsbDeviceHidMouse.remoteWakeup);
            if (g_UsbDeviceHidMouse.remoteWakeup)
            {
                usb_echo("Please Press wakeup switch(%s) to remote wakeup the host.\r\n", SW_GetName());
            }
            g_UsbDeviceHidMouse.sleep = kStatus_MouseSleeped;
            break;
        case kStatus_MouseSleeped:
            USB_PowerPreSwitchHook();
            if (g_UsbDeviceHidMouse.remoteWakeup)
            {
                SW_IntControl(1);
            }

            USB_DeviceSetStatus(g_UsbDeviceHidMouse.deviceHandle, kUSB_DeviceStatusBusSleep, NULL);
            if (kStatus_Success != USB_EnterLowpowerMode())
            {
                g_UsbDeviceHidMouse.selfWakeup = 1U;
                USB_PowerPostSwitchHook();
                usb_echo("Enter VLPS mode failed!\r\n");
            }
            else
            {
                USB_PowerPostSwitchHook();
            }
            if (g_UsbDeviceHidMouse.remoteWakeup)
            {
                SW_IntControl(0);
            }

            if (g_UsbDeviceHidMouse.attach)
            {
                g_UsbDeviceHidMouse.sleep = kStatus_MouseStartResume;
            }
            else
            {
                g_UsbDeviceHidMouse.sleep = kStatus_MouseIdle;
            }
            break;
        case kStatus_MouseStartResume:
            if (g_UsbDeviceHidMouse.selfWakeup)
            {
                g_UsbDeviceHidMouse.selfWakeup = 0U;
                if (g_UsbDeviceHidMouse.remoteWakeup)
                {
                    if (kStatus_USB_Success ==
                        USB_DeviceSetStatus(g_UsbDeviceHidMouse.deviceHandle, kUSB_DeviceStatusBusSleepResume, NULL))
                    {
                        usb_echo("Remote wakeup the host.\r\n");
                        g_UsbDeviceHidMouse.sleep = kStatus_MouseResuming;
                    }
                    else
                    {
                        usb_echo("Send resume signal failed.\r\n");
                        g_UsbDeviceHidMouse.sleep = kStatus_MouseStartResume;
                    }
                }
                else
                {
                    g_UsbDeviceHidMouse.sleep = kStatus_MouseResuming;
                }
            }
            else
            {
                g_UsbDeviceHidMouse.sleep = kStatus_MouseResumed;
            }
            break;
        case kStatus_MouseResuming:
            break;
        case kStatus_MouseResumed:
            usb_echo("USB device resumed.\r\n");
            if (g_UsbDeviceHidMouse.attach)
            {
                USB_DeviceHidMouseAction();
            }
            g_UsbDeviceHidMouse.sleep = kStatus_MouseIdle;
            break;
        default:
            g_UsbDeviceHidMouse.sleep = kStatus_MouseIdle;
            break;
    }
}

#if defined(__CC_ARM) || (defined(__ARMCC_VERSION)) || defined(__GNUC__)
int main(void)
#else
void main(void)
#endif
{
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    APP_InitWakeupPin();

#if ((defined(USB_DEVICE_CONFIG_LOW_POWER_MODE)) && (USB_DEVICE_CONFIG_LOW_POWER_MODE > 0U))
    USB_LowpowerModeInit();
#endif

    USB_DeviceApplicationInit();

#if ((defined(USB_DEVICE_CONFIG_LOW_POWER_MODE)) && (USB_DEVICE_CONFIG_LOW_POWER_MODE > 0U))
    HW_TimerControl(1);
#endif

    while (1U)
    {
#if USB_DEVICE_CONFIG_USE_TASK
        USB_DeviceTaskFn(g_UsbDeviceHidMouse.deviceHandle);
#endif
        USB_DeviceSuspendResumeTask();
    }
}
