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
#include "usb_device_audio.h"
#include "usb_device_ch9.h"
#include "usb_device_descriptor.h"

#include "composite.h"

#include "fsl_device_registers.h"
#include "clock_config.h"
#include "board.h"
#include "fsl_debug_console.h"

#include <stdio.h>
#include <stdlib.h>
#if (defined(FSL_FEATURE_SOC_SYSMPU_COUNT) && (FSL_FEATURE_SOC_SYSMPU_COUNT > 0U))
#include "fsl_sysmpu.h"
#endif /* FSL_FEATURE_SOC_SYSMPU_COUNT */
#if defined(FSL_FEATURE_SOC_USBPHY_COUNT) && (FSL_FEATURE_SOC_USBPHY_COUNT > 0U)
#include "usb_phy.h"
#endif


#include "pin_mux.h"
#include "fsl_i2c.h"
#include "fsl_i2s.h"
#include "fsl_i2s_dma.h"
#include "fsl_wm8904.h"
#include "fsl_power.h"
#include <stdbool.h>
#if defined(USB_DEVICE_AUDIO_USE_SYNC_MODE) && (USB_DEVICE_AUDIO_USE_SYNC_MODE > 0U)
#include "fsl_sctimer.h"
#endif
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define BOARD_I2S_DEMO_I2C_BASEADDR (I2C4)
#define DEMO_I2C_MASTER_CLOCK_FREQUENCY CLOCK_GetMclkClkFreq()
#define DEMO_I2S_TX (I2S1)
#define DEMO_I2S_RX (I2S3)
#define DEMO_I2S_TX_MODE (kI2S_MasterSlaveNormalSlave)
#define DEMO_I2S_RX_MODE (kI2S_MasterSlaveNormalMaster)
#define DEMO_DMA (DMA0)
#define DEMO_I2S_TX_CHANNEL (3)
#define DEMO_I2S_RX_CHANNEL (6)
#define I2S_CLOCK_DIVIDER 16

/*******************************************************************************
* Prototypes
******************************************************************************/
void BOARD_InitHardware(void);
void USB_DeviceClockInit(void);
void USB_DeviceIsrEnable(void);
#if USB_DEVICE_CONFIG_USE_TASK
void USB_DeviceTaskFn(void *deviceHandle);
#endif

usb_status_t USB_DeviceCallback(usb_device_handle handle, uint32_t event, void *param);
extern void Init_Board_Sai_Codec(void);
extern void USB_AudioSpeakerResetTask(void);
extern void Board_DMIC_DMA_Init(void);
/*******************************************************************************
* Variables
******************************************************************************/
extern usb_device_composite_struct_t g_composite;
extern uint8_t audioPlayDataBuff[AUDIO_SPEAKER_DATA_WHOLE_BUFFER_LENGTH * FS_ISO_OUT_ENDP_PACKET_SIZE];

static dma_handle_t s_DmaTxHandle;
static i2s_config_t s_TxConfig;
static i2s_dma_handle_t s_TxHandle;
static i2s_transfer_t s_TxTransfer;
USB_DMA_NONINIT_DATA_ALIGN(USB_DATA_ALIGN_SIZE)
static uint8_t audioPlayDMATempBuff[FS_ISO_OUT_ENDP_PACKET_SIZE];
codec_handle_t codecHandle = {0};
extern codec_config_t boardCodecConfig;
wm8904_config_t codecConfig;
#if defined(USB_DEVICE_AUDIO_USE_SYNC_MODE) && (USB_DEVICE_AUDIO_USE_SYNC_MODE > 0U)
static uint32_t eventCounterL = 0;
static uint32_t captureRegisterNumber;
static sctimer_config_t sctimerInfo;
#endif
/* Composite device structure. */
usb_device_composite_struct_t g_composite;
extern usb_device_class_struct_t g_UsbDeviceCdcVcomConfig;
extern usb_device_class_struct_t g_UsbDeviceAudioClassRecorder;
extern usb_device_class_struct_t g_UsbDeviceAudioClassSpeaker;
extern volatile bool g_ButtonPress;
extern usb_device_composite_struct_t *g_UsbDeviceComposite;
extern usb_device_composite_struct_t *g_deviceAudioComposite;

/* USB device class information */
static usb_device_class_config_struct_t g_CompositeClassConfig[3] = {
    {
        USB_DeviceCdcVcomCallback, (class_handle_t)NULL, &g_UsbDeviceCdcVcomConfig,
    },
    {
        USB_DeviceAudioCompositeCallback, (class_handle_t)NULL, &g_UsbDeviceAudioClassRecorder,
    },
    {
        USB_DeviceAudioCompositeCallback, (class_handle_t)NULL, &g_UsbDeviceAudioClassSpeaker,
    }

};

/* USB device class configuraion information */
static usb_device_class_config_list_struct_t g_UsbDeviceCompositeConfigList = {
    g_CompositeClassConfig, USB_DeviceCallback, 3,
};

/*******************************************************************************
 * Code
 ******************************************************************************/
#if defined(USB_DEVICE_AUDIO_USE_SYNC_MODE) && (USB_DEVICE_AUDIO_USE_SYNC_MODE > 0U)
extern uint32_t USB_AudioSpeakerBufferSpaceUsed(void);
#endif

void BOARD_Codec_Init()
{
    WM8904_GetDefaultConfig(&codecConfig);
    codecConfig.mclk_HZ = DEMO_I2C_MASTER_CLOCK_FREQUENCY;
    boardCodecConfig.codecConfig = (void *)&codecConfig;
    CODEC_Init(&codecHandle, &boardCodecConfig);
    WM8904_SetVolume(&codecHandle, 0x0020, 0x0020);
}

void I2S_USB_Audio_TxInit(I2S_Type *SAIBase)
{
    /*
     * masterSlave = kI2S_MasterSlaveNormalMaster;
     * mode = kI2S_ModeI2sClassic;
     * rightLow = false;
     * leftJust = false;
     * pdmData = false;
     * sckPol = false;
     * wsPol = false;
     * divider = 1;
     * oneChannel = false;
     * dataLength = 16;
     * frameLength = 32;
     * position = 0;
     * watermark = 4;
     * txEmptyZero = true;
     * pack48 = false;
     */
    I2S_TxGetDefaultConfig(&s_TxConfig);
    s_TxConfig.divider = I2S_CLOCK_DIVIDER;
    I2S_TxInit(DEMO_I2S_TX, &s_TxConfig);
}

void BOARD_USB_Audio_TxInit(uint32_t samplingRate)
{
    I2S_USB_Audio_TxInit(DEMO_I2S_TX);
}

static void TxCallback(I2S_Type *base, i2s_dma_handle_t *handle, status_t completionStatus, void *userData)
{
    static uint32_t lastUsbRecvTimes = 0, usbAudioNoInputCounter = 0;
    if (lastUsbRecvTimes != g_composite.audioUnified.usbRecvTimes)
    {
        lastUsbRecvTimes = g_composite.audioUnified.usbRecvTimes;
        usbAudioNoInputCounter = 0;
    }
    else if (g_composite.audioUnified.usbRecvTimes)
    {
        usbAudioNoInputCounter++;
        if (usbAudioNoInputCounter == 3)
        {
            g_composite.audioUnified.startPlayHalfFull = 0;
            g_composite.audioUnified.speakerDetachOrNoInput = 1;
            lastUsbRecvTimes = 0;
            usbAudioNoInputCounter = 0;
        }
    }
    else
    {
    }
    if (g_composite.audioUnified.startPlayHalfFull)
    {
        s_TxTransfer.dataSize = FS_ISO_OUT_ENDP_PACKET_SIZE;
        s_TxTransfer.data = audioPlayDataBuff + g_composite.audioUnified.tdWriteNumberPlay;
        g_composite.audioUnified.audioSendCount += FS_ISO_OUT_ENDP_PACKET_SIZE;
        g_composite.audioUnified.audioSendTimes++;
        g_composite.audioUnified.tdWriteNumberPlay += FS_ISO_OUT_ENDP_PACKET_SIZE;
        if (g_composite.audioUnified.tdWriteNumberPlay >=
            AUDIO_SPEAKER_DATA_WHOLE_BUFFER_LENGTH * FS_ISO_OUT_ENDP_PACKET_SIZE)
        {
            g_composite.audioUnified.tdWriteNumberPlay = 0;
        }
    }
    else
    {
        s_TxTransfer.dataSize = FS_ISO_OUT_ENDP_PACKET_SIZE;
        s_TxTransfer.data = audioPlayDMATempBuff;
    }
    I2S_TxTransferSendDMA(base, handle, s_TxTransfer);
}

void BOARD_DMA_EDMA_Config()
{
    /* Since in the audio_data_dmic.c has already init the DMA, so if init it twice will cause DMIC no callback and
     * sound. */
    /* DMA_Init(DEMO_DMA); */

    DMA_EnableChannel(DEMO_DMA, DEMO_I2S_TX_CHANNEL);
    DMA_SetChannelPriority(DEMO_DMA, DEMO_I2S_TX_CHANNEL, kDMA_ChannelPriority3);
    DMA_CreateHandle(&s_DmaTxHandle, DEMO_DMA, DEMO_I2S_TX_CHANNEL);
}

void BOARD_DMA_EDMA_Start()
{
    s_TxTransfer.dataSize = FS_ISO_OUT_ENDP_PACKET_SIZE;
    s_TxTransfer.data = audioPlayDMATempBuff;

    I2S_TxTransferCreateHandleDMA(DEMO_I2S_TX, &s_TxHandle, &s_DmaTxHandle, TxCallback, (void *)&s_TxTransfer);

    /* need to queue two transmit buffers so when the first one
     * finishes transfer, the other immediatelly starts */
    I2S_TxTransferSendDMA(DEMO_I2S_TX, &s_TxHandle, s_TxTransfer);
    I2S_TxTransferSendDMA(DEMO_I2S_TX, &s_TxHandle, s_TxTransfer);
}

void BOARD_DMA_EDMA_Set_AudioFormat()
{
}

void BOARD_DMA_EDMA_Enable_Audio_Interrupts()
{
}

#if defined(USB_DEVICE_AUDIO_USE_SYNC_MODE) && (USB_DEVICE_AUDIO_USE_SYNC_MODE > 0U)
void SCTIMER_SOF_TOGGLE_HANDLER()
{
    uint32_t currentSctCap = 0, pllCountPeriod = 0, pll_change = 0;
    uint32_t usedSpace = 0;
    static int32_t pllCount = 0, pllDiff = 0;
    static int32_t err, abs_err;
    if (SCTIMER_GetStatusFlags(SCT0) & (1 << eventCounterL))
    {
        /* Clear interrupt flag.*/
        SCTIMER_ClearStatusFlags(SCT0, (1 << eventCounterL));
    }

    if (g_composite.audioUnified.speakerIntervalCount != 100)
    {
        g_composite.audioUnified.speakerIntervalCount++;
        return;
    }
    g_composite.audioUnified.speakerIntervalCount = 1;
    currentSctCap = SCT0->SCTCAP[0];
    pllCountPeriod = currentSctCap - g_composite.audioUnified.audioPllTicksPrev;
    g_composite.audioUnified.audioPllTicksPrev = currentSctCap;
    pllCount = pllCountPeriod;
    if (g_composite.audioUnified.attach)
    {
        if (abs(pllCount - AUDIO_PLL_USB1_SOF_INTERVAL_COUNT) < (AUDIO_PLL_USB1_SOF_INTERVAL_COUNT >> 7))
        {
            pllDiff = pllCount - g_composite.audioUnified.audioPllTicksEma;
            g_composite.audioUnified.audioPllTickEmaFrac += (pllDiff % 8);
            g_composite.audioUnified.audioPllTicksEma +=
                (pllDiff / 8) + g_composite.audioUnified.audioPllTickEmaFrac / 8;
            g_composite.audioUnified.audioPllTickEmaFrac = (g_composite.audioUnified.audioPllTickEmaFrac % 8);

            err = g_composite.audioUnified.audioPllTicksEma - AUDIO_PLL_USB1_SOF_INTERVAL_COUNT;
            abs_err = abs(err);
            if (abs_err > g_composite.audioUnified.audioPllStep)
            {
                if (err > 0)
                {
                    g_composite.audioUnified.curAudioPllFrac -= abs_err / g_composite.audioUnified.audioPllStep;
                }
                else
                {
                    g_composite.audioUnified.curAudioPllFrac += abs_err / g_composite.audioUnified.audioPllStep;
                }
                pll_change = 1;
            }
            if (g_composite.audioUnified.startPlayHalfFull)
            {
                usedSpace = USB_AudioSpeakerBufferSpaceUsed();
                if (usedSpace > ((AUDIO_SPEAKER_DATA_WHOLE_BUFFER_LENGTH / 2 + 1) * HS_ISO_OUT_ENDP_PACKET_SIZE))
                {
                    g_composite.audioUnified.curAudioPllFrac++;
                    pll_change = 1;
                }
                else if (usedSpace < ((AUDIO_SPEAKER_DATA_WHOLE_BUFFER_LENGTH / 2 - 1) * HS_ISO_OUT_ENDP_PACKET_SIZE))
                {
                    g_composite.audioUnified.curAudioPllFrac--;
                    pll_change = 1;
                }
            }
            if (pll_change)
            {
                CLKCTL1->AUDIOPLL0NUM = g_composite.audioUnified.curAudioPllFrac;
            }
        }
    }
}

void SCTIMER_CaptureInit(void)
{
    INPUTMUX->SCT0_IN_SEL[eventCounterL] = 0xFU; /* 0xFU for USB1.*/
    SCTIMER_GetDefaultConfig(&sctimerInfo);

    /* Switch to 16-bit mode */
    sctimerInfo.clockMode = kSCTIMER_Input_ClockMode;
    sctimerInfo.clockSelect = kSCTIMER_Clock_On_Rise_Input_7;

    /* Initialize SCTimer module */
    SCTIMER_Init(SCT0, &sctimerInfo);

    if (SCTIMER_SetupCaptureAction(SCT0, kSCTIMER_Counter_L, &captureRegisterNumber, eventCounterL) == kStatus_Fail)
    {
        usb_echo("SCT Setup Capture failed!\r\n");
    }
    SCT0->EVENT[0].STATE = 0x1;
    SCT0->EVENT[0].CTRL = (0x01 << 10) | (0x2 << 12);

    /* Enable interrupt flag for event associated with out 4, we use the interrupt to update dutycycle */
    SCTIMER_EnableInterrupts(SCT0, (1 << eventCounterL));

    /* Receive notification when event is triggered */
    SCTIMER_SetCallback(SCT0, SCTIMER_SOF_TOGGLE_HANDLER, eventCounterL);

    /* Enable at the NVIC */
    EnableIRQ(SCT0_IRQn);

    /* Start the L counter */
    SCTIMER_StartTimer(SCT0, kSCTIMER_Counter_L);
}
#endif
void USB0_IRQHandler(void)
{
    USB_DeviceLpcIp3511IsrFunction(g_composite.deviceHandle);
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
    USB_EhciPhyInit(CONTROLLER_ID, BOARD_XTAL_SYS_CLK_HZ, &phyConfig);
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

/*!
 * @brief USB device callback function.
 *
 * This function handles the usb device specific requests.
 *
 * @param handle		  The USB device handle.
 * @param event 		  The USB device event type.
 * @param param 		  The parameter of the device specific request.
 *
 * @return A USB error code or kStatus_USB_Success.
 */
usb_status_t USB_DeviceCallback(usb_device_handle handle, uint32_t event, void *param)
{
    usb_status_t error = kStatus_USB_Error;
    uint16_t *temp16 = (uint16_t *)param;
    uint8_t *temp8 = (uint8_t *)param;

    switch (event)
    {
        case kUSB_DeviceEventBusReset:
        {
            g_composite.attach = 0U;
            g_composite.currentConfiguration = 0U;
            error = kStatus_USB_Success;
#if (defined(USB_DEVICE_CONFIG_EHCI) && (USB_DEVICE_CONFIG_EHCI > 0U)) || \
    (defined(USB_DEVICE_CONFIG_LPCIP3511HS) && (USB_DEVICE_CONFIG_LPCIP3511HS > 0U))
            /* Get USB speed to configure the device, including max packet size and interval of the endpoints. */
            if (kStatus_USB_Success == USB_DeviceClassGetSpeed(CONTROLLER_ID, &g_composite.speed))
            {
                USB_DeviceSetSpeed(handle, g_composite.speed);
            }
#endif
        }
        break;
        case kUSB_DeviceEventSetConfiguration:
            if (param)
            {
                g_composite.attach = 1U;
                g_composite.currentConfiguration = *temp8;
                USB_DeviceAudioCompositeSetConfigure(g_composite.audioUnified.audioSpeakerHandle, *temp8);
                USB_DeviceAudioCompositeSetConfigure(g_composite.audioUnified.audioRecorderHandle, *temp8);
                USB_DeviceCdcVcomSetConfigure(g_composite.cdcVcom.cdcAcmHandle, *temp8);
                error = kStatus_USB_Success;
            }
            break;
        case kUSB_DeviceEventSetInterface:

            if (g_composite.attach)
            {
                uint8_t interface = (uint8_t)((*temp16 & 0xFF00U) >> 0x08U);
                uint8_t alternateSetting = (uint8_t)(*temp16 & 0x00FFU);
                if (USB_AUDIO_RECORDER_STREAM_INTERFACE_INDEX == interface)
                {
                    USB_DeviceAudioRecorderSetInterface(g_composite.audioUnified.audioRecorderHandle, interface,
                                                        alternateSetting);
                }
                else if (USB_AUDIO_SPEAKER_STREAM_INTERFACE_INDEX == interface)
                {
                    USB_DeviceAudioSpeakerSetInterface(g_composite.audioUnified.audioSpeakerHandle, interface,
                                                       alternateSetting);
                }
                error = kStatus_USB_Success;
            }
            break;
        case kUSB_DeviceEventGetConfiguration:
            if (param)
            {
                *temp8 = g_composite.currentConfiguration;
                error = kStatus_USB_Success;
            }
            break;
        case kUSB_DeviceEventGetInterface:
            if (param)
            {
                uint8_t interface = (uint8_t)((*temp16 & 0xFF00U) >> 0x08U);
                if (interface < USB_DEVICE_INTERFACE_COUNT)
                {
                    *temp16 = (*temp16 & 0xFF00U) | g_composite.currentInterfaceAlternateSetting[interface];
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
                error = USB_DeviceGetDeviceDescriptor(handle, (usb_device_get_device_descriptor_struct_t *)param);
            }
            break;
        case kUSB_DeviceEventGetConfigurationDescriptor:
            if (param)
            {
                error = USB_DeviceGetConfigurationDescriptor(handle,
                                                             (usb_device_get_configuration_descriptor_struct_t *)param);
            }
            break;
        case kUSB_DeviceEventGetStringDescriptor:
            if (param)
            {
                error = USB_DeviceGetStringDescriptor(handle, (usb_device_get_string_descriptor_struct_t *)param);
            }
            break;
#if (defined(USB_DEVICE_CONFIG_CV_TEST) && (USB_DEVICE_CONFIG_CV_TEST > 0U))
        case kUSB_DeviceEventGetDeviceQualifierDescriptor:
            if (param)
            {
                /* Get device descriptor request */
                error = USB_DeviceGetDeviceQualifierDescriptor(
                    handle, (usb_device_get_device_qualifier_descriptor_struct_t *)param);
            }
            break;
#endif
        default:
            break;
    }

    return error;
}

/*!
 * @brief Application initialization function.
 *
 * This function initializes the application.
 *
 * @return None.
 */
void APPInit(void)
{
    USB_DeviceClockInit();
#if (defined(FSL_FEATURE_SOC_SYSMPU_COUNT) && (FSL_FEATURE_SOC_SYSMPU_COUNT > 0U))
    SYSMPU_Enable(SYSMPU, 0);
#endif /* FSL_FEATURE_SOC_SYSMPU_COUNT */

    g_composite.speed = USB_SPEED_FULL;
    g_composite.attach = 0U;
    g_composite.audioUnified.audioSpeakerHandle = (class_handle_t)NULL;
    g_composite.audioUnified.audioRecorderHandle = (class_handle_t)NULL;
    g_composite.cdcVcom.cdcAcmHandle = (class_handle_t)NULL;
    g_composite.deviceHandle = NULL;

    if (kStatus_USB_Success !=
        USB_DeviceClassInit(CONTROLLER_ID, &g_UsbDeviceCompositeConfigList, &g_composite.deviceHandle))
    {
        usb_echo("USB device composite demo init failed\r\n");
        return;
    }
    else
    {
        usb_echo("USB device composite demo\r\n");

        g_composite.cdcVcom.cdcAcmHandle = g_UsbDeviceCompositeConfigList.config[0].classHandle;
        g_composite.audioUnified.audioRecorderHandle = g_UsbDeviceCompositeConfigList.config[1].classHandle;
        g_composite.audioUnified.audioSpeakerHandle = g_UsbDeviceCompositeConfigList.config[2].classHandle;

        USB_DeviceAudioCompositeInit(&g_composite);
        USB_DeviceCdcVcomInit(&g_composite);
    }

    Init_Board_Sai_Codec();

    USB_DeviceIsrEnable();

    USB_DeviceRun(g_composite.deviceHandle);
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

    CLOCK_EnableClock(kCLOCK_InputMux);

    /* attach main clock to I3C */
    CLOCK_AttachClk(kMAIN_CLK_to_I3C_CLK);
    CLOCK_SetClkDiv(kCLOCK_DivI3cClk, 20);

    /* attach AUDIO PLL clock to FLEXCOMM1 (I2S1) */
    CLOCK_AttachClk(kAUDIO_PLL_to_FLEXCOMM1);
    /* attach AUDIO PLL clock to FLEXCOMM3 (I2S3) */
    CLOCK_AttachClk(kAUDIO_PLL_to_FLEXCOMM3);

    /* attach AUDIO PLL clock to MCLK */
    CLOCK_AttachClk(kAUDIO_PLL_to_MCLK_CLK);
    CLOCK_SetClkDiv(kCLOCK_DivMclkClk, 1);
    SYSCTL1->MCLKPINDIR = SYSCTL1_MCLKPINDIR_MCLKPINDIR_MASK;

    CLOCK_AttachClk(kAUDIO_PLL_to_DMIC);
    CLOCK_SetClkDiv(kCLOCK_DivDmicClk, 32);

    /* Set shared signal set 0: SCK, WS from Flexcomm1 */
    SYSCTL1->SHAREDCTRLSET[0] = SYSCTL1_SHAREDCTRLSET_SHAREDSCKSEL(1) | SYSCTL1_SHAREDCTRLSET_SHAREDWSSEL(1);
    /* Set flexcomm3 SCK, WS from shared signal set 0 */
    SYSCTL1->FCCTRLSEL[3] = SYSCTL1_FCCTRLSEL_SCKINSEL(1) | SYSCTL1_FCCTRLSEL_WSINSEL(1);
#if defined(USB_DEVICE_AUDIO_USE_SYNC_MODE) && (USB_DEVICE_AUDIO_USE_SYNC_MODE > 0U)
    /* attach AUDIO PLL clock to SCTimer input7. */
    CLOCK_AttachClk(kAUDIO_PLL_to_SCT_CLK);
    CLOCK_SetClkDiv(kCLOCK_DivSctClk, 1);

    g_composite.audioUnified.curAudioPllFrac = CLKCTL1->AUDIOPLL0NUM;
#endif

    Board_DMIC_DMA_Init();

    APPInit();

    while (1)
    {
        USB_DeviceCdcVcomTask();

        USB_AudioSpeakerResetTask();

#if USB_DEVICE_CONFIG_USE_TASK
        USB_DeviceTaskFn(g_composite.deviceHandle);
#endif
    }
}
