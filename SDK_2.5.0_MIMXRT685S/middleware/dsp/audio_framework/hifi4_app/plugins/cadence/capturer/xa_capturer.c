/*
 * Copyright (c) 2018 NXP USA, Inc.
 * Copyright (c) 2015-2018 Cadence Design Systems, Inc.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*******************************************************************************
 * xa-capturer.c
 *
 * dummy (dumping data to file)capturer implementation
 ******************************************************************************/

#define MODULE_TAG CAPTURER
#define XAF_HW
/*******************************************************************************
 * Includes
 ******************************************************************************/
#include <xtensa/xos.h>
#include <xtensa/xos_timer.h>
#include <stdio.h>
#include "audio/xa-capturer-api.h"
#include "xf-debug.h"
#include <string.h>
#ifdef XAF_PROFILE
#include "xaf_clk_test.h"
extern clk_t capturer_cycles;
#endif
#include "xaf_fio_test.h"

#ifdef XAF_HW
#include "fsl_common.h"
#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "fsl_iopctl.h"
#include "fsl_dmic.h"
#include "fsl_dma.h"
#include "fsl_dmic_dma.h"
#include "fsl_i2s.h"
#include "fsl_i2s_dma.h"
#include "fsl_usart.h"
#include "fsl_gpio.h"
#include "fsl_i2c.h"
#include "fsl_inputmux.h"
#include <stdlib.h>
#include <string.h>

#include "evk_fsl_tfa9894.h"
#include "evk_hal_registers.h"
#include <stdbool.h>
#include <xtensa/xtruntime.h>
#include <xtensa/tie/xt_interrupt.h>
#endif /*XAF_HW*/

/*******************************************************************************
 * Tracing configuration
 ******************************************************************************/
TRACE_TAG(INIT, 1);
TRACE_TAG(WARNING, 1);

TRACE_TAG(OUTPUT, 0);
TRACE_TAG(INPUT, 1);

TRACE_TAG(FIFO, 1);
TRACE_TAG(ISR, 1);
TRACE_TAG(UNDERRUN, 1);

/*******************************************************************************
 * Codec parameters
 ******************************************************************************/
#ifdef XAF_HW
/* HW definitions in evk_dmic_dma.c*/
#define BUFFER_LENGTH 128U
#define BUFFER_RX_COUNT 64U
#define BUFFER_TX_COUNT 4U
#define DMIC_CH_COUNT 8U
#define REF_MIC0 6U
#define REF_MIC1 7U
#endif

/* ...total length of HW FIFO in bytes */
#define HW_FIFO_LENGTH 4096

/* ...total length of HW FIFO in samples */
#define HW_FIFO_LENGTH_SAMPLES (HW_FIFO_LENGTH / (2 * sizeof(WORD16)))
#define I2S_SF (44100)

#define XOS_INT_NUM 7

#define DMIC_MASK ((1 << FSL_FEATURE_DMIC_CHANNEL_NUM) - 1)

typedef struct XACapturer
{
    /***************************************************************************
     * Internal stuff
     **************************************************************************/

    /* ...component state */
    UWORD32 state;

    /* ...notification callback pointer */
    xa_capturer_cb_t *cdata;

    /* ...input buffer pointer */
    void *output;
#ifndef XAF_HW
    /* ...estimation of amount of samples that can be written into FIFO */
    UWORD32 fifo_avail;

    UWORD32 capturer_eof;
#endif

    /* ...number of samples produced */
    UWORD32 produced;
    /* ...number of bytes copied in fifo*/
    // UWORD32                     submited;
    /***************************************************************************
     * Run-time data
     **************************************************************************/

    /* ...size of PCM sample (respects channels and PCM width) */
    UWORD32 sample_size;

    /* ...number of channels */
    UWORD32 channels;

    /* ...sample width */
    UWORD32 pcm_width;

    /* ...current sampling rate */
    UWORD32 rate;

    UWORD32 over_flow_cnt;

    UWORD32 over_flow_flag;

    /* ...flag for detecting underrun..made to non zero over submit */
    // UWORD32              submit_flag;
#ifndef XAF_HW
    FILE *fw;
#else
    /* Number of audio channel */
    UWORD8 audiochannel;
#endif
    UWORD32 interrupt_cnt;

    /*total bytes produced by the component*/
    UWORD64 tot_bytes_produced;

    /*total bytes to be produced*/
    UWORD64 bytes_end;

} XACapturer;

#ifdef XAF_HW
typedef struct _DMIC_Context
{
    volatile uint8_t pingpong;
    dmic_dma_handle_t g_dmicDmaHandle;
    dma_handle_t g_dmicRxDmaHandle;
    int32_t audiochannel;
    dmic_transfer_t receiveXfer;
} DMIC_Context;

typedef struct circular_buf_t
{
    uint16_t (*buffer)[BUFFER_LENGTH * BUFFER_RX_COUNT];
    unsigned int head;
    unsigned int tail;
    uint8_t pingpong;
    uint8_t max;
    bool full;
} circular_buf_t;
#endif

/*******************************************************************************
 * Operating flags
 ******************************************************************************/

#define XA_CAPTURER_FLAG_PREINIT_DONE (1 << 0)
#define XA_CAPTURER_FLAG_POSTINIT_DONE (1 << 1)
#define XA_CAPTURER_FLAG_IDLE (1 << 2)
#define XA_CAPTURER_FLAG_RUNNING (1 << 3)
#define XA_CAPTURER_FLAG_PAUSED (1 << 4)

/*******************************************************************************
 * Local data definition
 ******************************************************************************/
#ifdef XAF_HW
#define DMA_CALL 1
#define I2S_TDM 0
#define I2S_CHANNEL 3
#endif
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#ifdef XAF_HW
#define DMAREQ_DMIC_CH0 16U
#define FIFO_DEPTH 15U
#define BUFFER_LENGTH 128U
#define BUFFER_RX_COUNT 64U
#define BUFFER_TX_COUNT 4U
#define DMIC_CH_COUNT 8U
#define XOS_CLOCK_FREQ 559000000
#endif

/*******************************************************************************
 * global variables
 ******************************************************************************/
#ifndef XAF_HW
XosTimer rend_timer;
const char capturer_in_file[] = ".\\test\\test_inp\\src_48k_16bit_stereo.pcm";
#endif
XosTimer rend_timer;

#ifdef XAF_HW
uint16_t g_rxBuffer[DMIC_CH_COUNT][BUFFER_LENGTH * BUFFER_RX_COUNT] __attribute__((section(".sharedata"))) = {0, 0};
uint16_t g_txBuffer[2 * BUFFER_LENGTH * BUFFER_TX_COUNT] __attribute__((section(".sharedata")))                       = {0};

/*******************************************************************************
 * Variables
 ******************************************************************************/
volatile int32_t newDataAvailable = 0;
volatile uint8_t pingpong         = 0;
static i2s_config_t s_TxConfig;
static i2s_handle_t s_TxHandle;
DMIC_Context dmic_instance[FSL_FEATURE_DMIC_CHANNEL_NUM];
circular_buf_t g_circular_buf_h;
// static i2s_transfer_t s_TxTransfer;
i2s_transfer_t s_TxTransfer;
volatile int32_t newDataNeeded = 1;
dma_handle_t g_i2sTxDmaHandle;
i2s_dma_handle_t g_i2sDmaHandle;

dma_handle_t g_m2mDmaHandle;
volatile bool g_transferDone = false;
dma_channel_config_t g_transferConfig;
volatile uint32_t g_buffFullCnt  = 0;
volatile uint32_t g_buffEmptyCnt = 0;
#endif /*XAF_HW*/

/*******************************************************************************

 * Prototypes
 ******************************************************************************/
/* DMIC user callback */
void xa_capturer_callback(xa_capturer_cb_t *cdata, WORD32 i_idx);

#ifdef XAF_HW

void DMIC_UserCallback(DMIC_Type *base, dmic_dma_handle_t *handle, status_t status, void *userData);
extern void DMA0_DriverIRQHandler(void);

/* XosIntFunc type of handler function */
void XOS_DMA0_DriverIRQHandler(void *arg)
{
	DMA0_DriverIRQHandler();
}

/* DMIC user callback */
void DMIC_UserCallback(DMIC_Type *base, dmic_dma_handle_t *handle, status_t status, void *userData)
{
    XACapturer *capturer  = (XACapturer *)userData;
    uint32_t audiochannel = capturer->audiochannel;
    uint32_t i;

    if (status == kStatus_DMIC_Idle)
    {
#if (DMA_CALL == 1)
        if (audiochannel == FSL_FEATURE_DMIC_CHANNEL_NUM - 1)
        {
#endif
#if (DMA_CALL == 1)
            for (i = 0; i < FSL_FEATURE_DMIC_CHANNEL_NUM; i++)
            {
                newDataAvailable |= (1 << i);
            }
#else
        newDataAvailable |= (1 << audiochannel);
#endif
            capturer->cdata->cb(capturer->cdata, 0);
#if (DMA_CALL == 1)
        }
#endif
    }
}

static void DMICTransferReceiveDMA(void)
{
    uint32_t i;

    for (i = 0; i < FSL_FEATURE_DMIC_CHANNEL_NUM; i++)
    {
        dmic_instance[i].pingpong         = (dmic_instance[i].pingpong + 1) % BUFFER_RX_COUNT;
        dmic_instance[i].receiveXfer.data = &g_circular_buf_h.buffer[i][(BUFFER_LENGTH)*dmic_instance[i].pingpong];
    }

    g_circular_buf_h.head = dmic_instance[FSL_FEATURE_DMIC_CHANNEL_NUM - 1].pingpong;
    if (g_circular_buf_h.head == g_circular_buf_h.tail)
    {
        // g_circular_buf_h.full = true;
        g_circular_buf_h.tail = (g_circular_buf_h.tail + 1) % g_circular_buf_h.max;
        g_buffFullCnt++;
    }

    for (i = 0; i < FSL_FEATURE_DMIC_CHANNEL_NUM; i++)
    {
        DMIC_TransferReceiveDMA(DMIC0, &dmic_instance[i].g_dmicDmaHandle, &dmic_instance[i].receiveXfer,
                                kDMIC_Channel0 + i);
    }

    // g_circular_buf_h.head = (dmic_instance[i].pingpong + 1) % BUFFER_RX_COUNT;
    g_circular_buf_h.full = (g_circular_buf_h.head == g_circular_buf_h.tail);
}

static void SysTick_Handler(void)
{
}

static void TxCallback(I2S_Type *base, i2s_dma_handle_t *handle, status_t completionStatus, void *userData)
{
    if (completionStatus == /*kStatus_I2S_Done*/ kStatus_I2S_BufferComplete)
    {
        newDataNeeded += 1;
    }
}

static void DMA_Callback(dma_handle_t *handle, void *param, bool transferDone, uint32_t tcds)
{
    if (transferDone)
    {
        g_transferDone = true;
    }
}

static void evk_dmic_dma_start(void)
{
    uint32_t i;

    for (i = 0; i < FSL_FEATURE_DMIC_CHANNEL_NUM; i++)
    {
        DMIC_TransferReceiveDMA(DMIC0, &dmic_instance[i].g_dmicDmaHandle, &dmic_instance[i].receiveXfer,
                                kDMIC_Channel0 + i);
    }

    g_circular_buf_h.head++;
    g_transferDone = false;
}

static void evk_dmic_dma_config(void *ptr)
{
    dmic_channel_config_t dmic_channel_cfg;
    i2c_master_config_t masterConfig;

    gpio_pin_config_t gpio_cfg;

    uint32_t i;

    XACapturer *capturer = (XACapturer *)ptr;

#if 1
    xthal_set_region_attribute((void *)0x2C0000, 0x40000, 0x2, 0);
//	xthal_set_region_attribute((void *)0x40000000, 0xFFFFFFF, 0x2, 0);
// printf("Driver Init: disable cache for share data\r\n");
#endif

    xos_set_clock_freq(XOS_CLOCK_FREQ);
    xos_start_system_timer(-1, 0);
    //_xtos_set_interrupt_handler(XOS_INT_NUM, XOS_DMA0_DriverIRQHandler);
    xos_register_interrupt_handler(XOS_INT_NUM, XOS_DMA0_DriverIRQHandler, NULL);
    //_xtos_interrupt_enable(XOS_INT_NUM);
    xos_interrupt_enable(XOS_INT_NUM);
#if 1
    I2S_TxGetDefaultConfig(&s_TxConfig);
#if (I2S_TDM == 0)
    s_TxConfig.divider = 48U;
    s_TxConfig.mode    = kI2S_ModeDspWs50;
#endif
#if (I2S_TDM == 1)
    s_TxConfig.divider     = 12U;
    s_TxConfig.mode        = kI2S_ModeDspWsLong;
    s_TxConfig.wsPol       = true;
    s_TxConfig.frameLength = 128U;
#endif

    I2S_TxInit(I2S1, &s_TxConfig);
#if (I2S_TDM == 1)
    I2S_EnableSecondaryChannel(I2S1, kI2S_SecondaryChannel1, false, 32);
    I2S_EnableSecondaryChannel(I2S1, kI2S_SecondaryChannel2, false, 64);
    I2S_EnableSecondaryChannel(I2S1, kI2S_SecondaryChannel3, false, 96);
#endif
#endif

    dmic_channel_cfg.divhfclk            = kDMIC_PdmDiv1;
    dmic_channel_cfg.osr                 = 32U;
    dmic_channel_cfg.gainshft            = 4U;
    dmic_channel_cfg.preac2coef          = kDMIC_CompValueZero;
    dmic_channel_cfg.preac4coef          = kDMIC_CompValueZero;
    dmic_channel_cfg.dc_cut_level        = kDMIC_DcCut155;
    dmic_channel_cfg.post_dc_gain_reduce = 4;
    dmic_channel_cfg.saturate16bit       = 1U;
    dmic_channel_cfg.sample_rate         = kDMIC_PhyFullSpeed;
    DMIC_Init(DMIC0);

    DMIC_SetIOCFG(DMIC0, kDMIC_PdmStereo | kDMIC_PdmStereo2 | kDMIC_PdmStereo4 | kDMIC_PdmStereo6);

    DMIC_Use2fs(DMIC0, false);
    for (i = 0; i < FSL_FEATURE_DMIC_CHANNEL_NUM; i++)
    {
        DMIC_EnableChannelDma(DMIC0, (dmic_channel_t)(kDMIC_Channel0 + i), true);
    }

    for (i = 0; i < FSL_FEATURE_DMIC_CHANNEL_NUM; i += 2)
    {
        DMIC_ConfigChannel(DMIC0, (dmic_channel_t)(kDMIC_Channel0 + i), kDMIC_Left, &dmic_channel_cfg);
        DMIC_FifoChannel(DMIC0, kDMIC_Channel0 + i, FIFO_DEPTH, true, true);
        DMIC_ConfigChannel(DMIC0, (dmic_channel_t)(kDMIC_Channel0 + i + 1), kDMIC_Right, &dmic_channel_cfg);
        DMIC_FifoChannel(DMIC0, kDMIC_Channel0 + i + 1, FIFO_DEPTH, true, true);
    }
    DMIC_EnableChannnel(DMIC0, DMIC_CHANEN_EN_CH0_MASK | DMIC_CHANEN_EN_CH1_MASK | DMIC_CHANEN_EN_CH2_MASK |
                                   DMIC_CHANEN_EN_CH3_MASK | DMIC_CHANEN_EN_CH4_MASK | DMIC_CHANEN_EN_CH5_MASK |
                                   DMIC_CHANEN_EN_CH6_MASK | DMIC_CHANEN_EN_CH7_MASK);

    RESET_PeripheralReset(kDMAC0_RST_SHIFT_RSTn);
    DMA_Init(DMA0);

    DMA_EnableChannel(DMA0, 3);
    DMA_SetChannelPriority(DMA0, 3, kDMA_ChannelPriority1);
    DMA_CreateHandle(&g_i2sTxDmaHandle, DMA0, 3);

    DMA_EnableChannel(DMA0, 31);
    DMA_SetChannelPriority(DMA0, 31, kDMA_ChannelPriority2);
    DMA_CreateHandle(&g_m2mDmaHandle, DMA0, 31);
    DMA_SetCallback(&g_m2mDmaHandle, DMA_Callback, NULL);

    I2C_MasterGetDefaultConfig(&masterConfig);

    /* Initialize the I2C master peripheral */
    I2C_MasterInit(I2C4, &masterConfig, CLOCK_GetFreq(kCLOCK_Flexcomm4));

    s_TxTransfer.data = (uint8_t *)&g_txBuffer[0];
#if (I2S_TDM == 0)
    s_TxTransfer.dataSize = BUFFER_LENGTH * BUFFER_TX_COUNT;
#endif
#if (I2S_TDM == 1)
    s_TxTransfer.dataSize = BUFFER_LENGTH * 16;
#endif

    I2S_TxTransferCreateHandleDMA(I2S1, &g_i2sDmaHandle, &g_i2sTxDmaHandle, TxCallback, (void *)&s_TxTransfer);
    I2S_TxTransferSendDMA(I2S1, &g_i2sDmaHandle, s_TxTransfer);

#if (I2S_TDM == 0)
    TFA9894_Init_Generic() /*TFA9894_Init_Bypass()*/;
#endif

    for (i = 0; i < FSL_FEATURE_DMIC_CHANNEL_NUM; i++)
    {
        dmic_instance[i].audiochannel = i;
        dmic_instance[i].pingpong     = 0;
        DMA_EnableChannel(DMA0, DMAREQ_DMIC_CH0 + i);
        DMA_SetChannelPriority(DMA0, DMAREQ_DMIC_CH0 + i, kDMA_ChannelPriority0);
        /* Request dma channels from DMA manager. */
        DMA_CreateHandle(&dmic_instance[i].g_dmicRxDmaHandle, DMA0, DMAREQ_DMIC_CH0 + i);
#if (DMA_CALL == 1)
        if (i != (FSL_FEATURE_DMIC_CHANNEL_NUM - 1))
        {
            DMA_DisableChannelInterrupts(DMA0, DMAREQ_DMIC_CH0 + i);
        }
#endif
        capturer->audiochannel = dmic_instance[i].audiochannel;
        DMIC_TransferCreateHandleDMA(DMIC0, &dmic_instance[i].g_dmicDmaHandle, DMIC_UserCallback, capturer,
                                     &dmic_instance[i].g_dmicRxDmaHandle);
        dmic_instance[i].receiveXfer.data                   = &g_rxBuffer[i][0];
        dmic_instance[i].receiveXfer.dataSize               = 2 * BUFFER_LENGTH;
        dmic_instance[i].receiveXfer.dataAddrInterleaveSize = kDMA_AddressInterleave1xWidth;
        dmic_instance[i].receiveXfer.dataWidth              = sizeof(uint16_t);
        dmic_instance[i].receiveXfer.linkTransfer           = NULL;
    }
}

/*******************************************************************************
// * evk_hw_init
 *
 * Outbount fifo registers are configured here.
// ******************************************************************************/
void evk_hw_init(void *ptr)
{
    uint32_t i;

    g_circular_buf_h.buffer   = g_rxBuffer;
    g_circular_buf_h.head     = 0;
    g_circular_buf_h.tail     = 0;
    g_circular_buf_h.pingpong = 0;
    g_circular_buf_h.full     = false;
    g_circular_buf_h.max      = BUFFER_RX_COUNT;

    evk_dmic_dma_config(ptr);
}
#endif

#ifndef XAF_HW
static void xa_fw_handler(void *arg)
{
    XACapturer *d = arg;

    d->fifo_avail = d->fifo_avail + (HW_FIFO_LENGTH_SAMPLES >> 1);

    if ((d->fifo_avail) > HW_FIFO_LENGTH_SAMPLES)
    { /*over run case*/
        d->fifo_avail = 0;
    }
    else if (((int)d->fifo_avail) < 0)
    { /* under run */
        d->fifo_avail = 0;
    }
    else
    {
        d->cdata->cb(d->cdata, 0);
    }
}
#else
static void xa_hw_handler(void *ptr)
{
    xos_timer_stop(&rend_timer);
    evk_dmic_dma_start();
}
#endif

/*******************************************************************************
 * Codec access functions
 ******************************************************************************/
#ifndef XAF_HW
static inline void xa_fw_capturer_close(XACapturer *d)
{
    fclose(d->fw);
    xos_timer_stop(&rend_timer);
}
#else
static inline void xa_hw_capturer_close(XACapturer *d)
{
    /*
     *((volatile unsigned int*) (STRM_1_L_IN + 0x10) ) = 0;
     *((volatile unsigned int*) (STRM_1_R_IN + 0x10) ) = 0;
     */
}
#endif
/* ...submit data (in samples) into internal capturer ring-buffer */

/*******************************************************************************
 * API command hooks
 ******************************************************************************/
/* ...standard codec initialization routine */
static XA_ERRORCODE xa_capturer_get_api_size(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...check parameters are sane */
    XF_CHK_ERR(pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...retrieve API structure size */
    *(WORD32 *)pv_value = sizeof(*d);

    return XA_NO_ERROR;
}
#ifndef XAF_HW
static XA_ERRORCODE xa_fw_capturer_init(XACapturer *d)
{
    d->produced           = 0;
    d->fw                 = NULL;
    d->tot_bytes_produced = 0;
    /*opening the output file*/
    d->fw = fopen(capturer_in_file, "rb");
    if (d->fw == NULL)
    {
        /*file open failed*/
        return XA_FATAL_ERROR;
    }

    /*initialy FIFO will be empty so fifo_avail = HW_FIFO_LENGTH_SAMPLES*/
    d->fifo_avail = 0;

    /*initialises the timer ;timer0 is used as system timer*/
    xos_timer_init(&rend_timer);

    return XA_NO_ERROR;
}
#else
static XA_ERRORCODE xa_hw_capturer_init(XACapturer *d)
{
    int status;
    d->produced = 0;
    d->tot_bytes_produced = 0;
    d->interrupt_cnt = 0;
    d->over_flow_flag = 0;
    d->over_flow_cnt = 0;
    xos_timer_init(&rend_timer);
    return 0;
}
#endif

/* ...standard codec initialization routine */
static XA_ERRORCODE xa_capturer_init(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    int status;
    /* ...sanity check - pointer must be valid */
    XF_CHK_ERR(d, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...process particular initialization type */
    switch (i_idx)
    {
        case XA_CMD_TYPE_INIT_API_PRE_CONFIG_PARAMS:
        {
            /* ...pre-configuration initialization; reset internal data */
            memset(d, 0, sizeof(*d));

            /* ...set default capturer parameters - 16-bit little-endian stereo @ 48KHz */
            d->sample_size = 2;
            d->channels    = 2;
            d->pcm_width   = 16;
#ifdef XAF_HW
            d->rate = 16000;
#else
            d->rate = 48000;
#endif
            /* ...and mark capturer has been created */
            d->state = XA_CAPTURER_FLAG_PREINIT_DONE;

            return XA_NO_ERROR;
        }

        case XA_CMD_TYPE_INIT_API_POST_CONFIG_PARAMS:
        {
            /* ...post-configuration initialization (all parameters are set) */

            XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_PREINIT_DONE, XA_API_FATAL_INVALID_CMD_TYPE);
#ifndef XAF_HW

            XF_CHK_ERR(xa_fw_capturer_init(d) == 0, XA_CAPTURER_CONFIG_FATAL_HW);
#else
            XF_CHK_ERR(xa_hw_capturer_init(d) == 0, XA_CAPTURER_CONFIG_FATAL_HW);
#endif
            /* ...mark post-initialization is complete */
            d->state |= XA_CAPTURER_FLAG_POSTINIT_DONE;

            return XA_NO_ERROR;
        }

        case XA_CMD_TYPE_INIT_PROCESS:
        {
            /* ...kick run-time initialization process; make sure setup is complete */
            XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_POSTINIT_DONE, XA_API_FATAL_INVALID_CMD_TYPE);
            /* ...mark capturer is in idle state */
            d->state |= XA_CAPTURER_FLAG_IDLE;
#ifndef XAF_HW
            xos_timer_start(&rend_timer,
                            ((long long)(HW_FIFO_LENGTH_SAMPLES >> 1) * xos_get_clock_freq() / I2S_SF) /* 2133334*/, 1,
                            xa_fw_handler, d);
#else
            evk_hw_init(d);
            xos_timer_start(&rend_timer,
                            ((long long)(HW_FIFO_LENGTH_SAMPLES >> 1) * xos_get_clock_freq() / I2S_SF) /* 2133334*/, 1,
                            xa_hw_handler, d);
#endif

            return XA_NO_ERROR;
        }

        case XA_CMD_TYPE_INIT_DONE_QUERY:
        {
            /* ...check if initialization is done; make sure pointer is sane */
            XF_CHK_ERR(pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

            /* ...put current status */
            *(WORD32 *)pv_value = (d->state & XA_CAPTURER_FLAG_IDLE ? 1 : 0);

            d->state ^= XA_CAPTURER_FLAG_IDLE | XA_CAPTURER_FLAG_RUNNING;
            return XA_NO_ERROR;
        }

        default:
            /* ...unrecognized command type */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }
}

/* ...HW-capturer control function */
static inline XA_ERRORCODE xa_hw_capturer_control(XACapturer *d, UWORD32 state)
{
    switch (state)
    {
        case XA_CAPTURER_STATE_RUN:
            /* ...capturer must be in paused state */
            XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_PAUSED, XA_CAPTURER_EXEC_NONFATAL_STATE);

            /* ...resume capturer operation */
            // xa_hw_capturer_resume(d);

            /* ...mark capturer is running */
            d->state ^= XA_CAPTURER_FLAG_RUNNING | XA_CAPTURER_FLAG_PAUSED;

            return XA_NO_ERROR;

        case XA_CAPTURER_STATE_PAUSE:
            /* ...capturer must be in running state */
            XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_RUNNING, XA_CAPTURER_EXEC_NONFATAL_STATE);

            /* ...pause capturer operation */

            /* ...mark capturer is paused */
            d->state ^= XA_CAPTURER_FLAG_RUNNING | XA_CAPTURER_FLAG_PAUSED;

            return XA_NO_ERROR;

        case XA_CAPTURER_STATE_IDLE:
            /* ...command is valid in any active state; stop capturer operation */
#ifndef XAF_HW
            xa_fw_capturer_close(d);
#else
            xa_hw_capturer_close(d);
#endif
            /* ...reset capturer flags */
            d->state &= ~(XA_CAPTURER_FLAG_RUNNING | XA_CAPTURER_FLAG_PAUSED);

            return XA_NO_ERROR;

        default:
            /* ...unrecognized command */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }
}

/* ...set capturer configuration parameter */
static XA_ERRORCODE xa_capturer_set_config_param(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    UWORD32 i_value;

    /* ...sanity check - pointers must be sane */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...pre-initialization must be completed */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_PREINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

    /* ...process individual configuration parameter */
    switch (i_idx)
    {
        case XA_CAPTURER_CONFIG_PARAM_PCM_WIDTH:
            /* ...command is valid only in configuration state */
            XF_CHK_ERR((d->state & XA_CAPTURER_FLAG_POSTINIT_DONE) == 0, XA_CAPTURER_CONFIG_FATAL_STATE);

            /* ...get requested PCM width */
            i_value = (UWORD32) * (WORD32 *)pv_value;

            /* ...check value is permitted (16 bits only) */
            XF_CHK_ERR(i_value == 16, XA_CAPTURER_CONFIG_NONFATAL_RANGE);

            /* ...apply setting */
            d->pcm_width = i_value;

            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_CHANNELS:
            /* ...command is valid only in configuration state */
            XF_CHK_ERR((d->state & XA_CAPTURER_FLAG_POSTINIT_DONE) == 0, XA_CAPTURER_CONFIG_FATAL_STATE);

            /* ...get requested channel number */
            i_value = (UWORD32) * (WORD32 *)pv_value;

            /* ...allow stereo only */
            XF_CHK_ERR(i_value == 2, XA_CAPTURER_CONFIG_NONFATAL_RANGE);

            /* ...apply setting */
            d->channels = (UWORD32)i_value;

            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_SAMPLE_RATE:
            /* ...command is valid only in configuration state */
            XF_CHK_ERR((d->state & XA_CAPTURER_FLAG_POSTINIT_DONE) == 0, XA_CAPTURER_CONFIG_FATAL_STATE);

            /* ...get requested sampling rate */
            i_value = (UWORD32) * (WORD32 *)pv_value;

            /* ...allow 44.1 and 48KHz only - tbd */
#ifndef XAF_HW
            XF_CHK_ERR(i_value == 44100 || i_value == 48000, XA_CAPTURER_CONFIG_NONFATAL_RANGE);
#else
            XF_CHK_ERR(i_value == 44100 || i_value == 48000 || i_value == 16000, XA_CAPTURER_CONFIG_NONFATAL_RANGE);
#endif
            /* ...apply setting */
            d->rate = (UWORD32)i_value;

            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_FRAME_SIZE:
            /* ...command is valid only in configuration state */
            XF_CHK_ERR((d->state & XA_CAPTURER_FLAG_POSTINIT_DONE) == 0, XA_CAPTURER_CONFIG_FATAL_STATE);

            /* ...get requested frame size */
            i_value = (UWORD32) * (WORD32 *)pv_value;

            /* ...check it is equal to the only frame size we support */
#ifndef XAF_HW
            XF_CHK_ERR(i_value == HW_FIFO_LENGTH_SAMPLES / 2, XA_CAPTURER_CONFIG_NONFATAL_RANGE);
#else
            XF_CHK_ERR(i_value == BUFFER_LENGTH, XA_CAPTURER_CONFIG_NONFATAL_RANGE);
#endif
            return XA_NO_ERROR;
        case XA_CAPTURER_CONFIG_PARAM_SAMPLE_END:
            /* ...command is valid only in configuration state */
            XF_CHK_ERR((d->state & XA_CAPTURER_FLAG_POSTINIT_DONE) == 0, XA_CAPTURER_CONFIG_FATAL_STATE);

            /* ...get requested frame size */
            d->bytes_end = ((UWORD64) * (UWORD64 *)pv_value) * (d->sample_size) * (d->channels);

            /* ...check it is equal to the only frame size we support */
#ifndef XAF_HW
            XF_CHK_ERR(i_value == HW_FIFO_LENGTH_SAMPLES / 2, XA_CAPTURER_CONFIG_NONFATAL_RANGE);
#endif
            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_CB:
            /* ...set opaque callback data function */
            d->cdata = (xa_capturer_cb_t *)pv_value;

            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_STATE:
            /* ...runtime state control parameter valid only in execution state */
            XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_POSTINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

            /* ...get requested state */
            i_value = (UWORD32) * (WORD32 *)pv_value;

            /* ...pass to state control hook */
            return xa_hw_capturer_control(d, i_value);

        default:
            /* ...unrecognized parameter */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }
}

/* ...state retrieval function */
static inline UWORD32 xa_hw_capturer_get_state(XACapturer *d)
{
    if (d->state & XA_CAPTURER_FLAG_RUNNING)
        return XA_CAPTURER_STATE_RUN;
    else if (d->state & XA_CAPTURER_FLAG_PAUSED)
        return XA_CAPTURER_STATE_PAUSE;
    else
        return XA_CAPTURER_STATE_IDLE;
}

/* ...retrieve configuration parameter */
static XA_ERRORCODE xa_capturer_get_config_param(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...sanity check - capturer must be initialized */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...make sure pre-initialization is completed */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_PREINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

    /* ...process individual configuration parameter */
    switch (i_idx)
    {
        case XA_CAPTURER_CONFIG_PARAM_PCM_WIDTH:
            /* ...return current PCM width */
            *(WORD32 *)pv_value = d->pcm_width;
            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_CHANNELS:
            /* ...return current channel number */
            *(WORD32 *)pv_value = d->channels;
            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_SAMPLE_RATE:
            /* ...return current sampling rate */
            *(WORD32 *)pv_value = d->rate;
            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_FRAME_SIZE:
            /* ...return current audio frame length (in samples) */
#ifndef XAF_HW
            *(WORD32 *)pv_value = HW_FIFO_LENGTH_SAMPLES / 2;
#else
            *(WORD32 *)pv_value = BUFFER_LENGTH;
#endif
            return XA_NO_ERROR;

        case XA_CAPTURER_CONFIG_PARAM_STATE:
            /* ...return current execution state */
            *(WORD32 *)pv_value = xa_hw_capturer_get_state(d);
            return XA_NO_ERROR;
        case XA_CAPTURER_CONFIG_PARAM_BYTES_PRODUCED:
            /* ...return current execution state */
            *(WORD32 *)pv_value = d->tot_bytes_produced;
            return XA_NO_ERROR;
        default:
            /* ...unrecognized parameter */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }
}

/* ...execution command */
static XA_ERRORCODE xa_capturer_execute(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...sanity check - pointer must be valid */
    XF_CHK_ERR(d, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...capturer must be in running state */
    XF_CHK_ERR(d->state & (XA_CAPTURER_FLAG_RUNNING | XA_CAPTURER_FLAG_IDLE), XA_CAPTURER_EXEC_FATAL_STATE);

    /* ...process individual command type */
    switch (i_idx)
    {
        case XA_CMD_TYPE_DO_EXECUTE:
            /* ...silently ignore; everything is done in "set_input" */
            return XA_NO_ERROR;

        case XA_CMD_TYPE_DONE_QUERY:
            /* ...always report "no" - tbd - is that needed at all? */
            XF_CHK_ERR(pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

            if ((d->produced == 0))
            {
#ifndef XAF_HW
                xos_timer_stop(&rend_timer);
#else
#ifdef __TOOLS_RF2__
                xos_disable_ints(1 << 5);
#else
                // xos_interrupt_disable(XCHAL_EXTINT5_NUM);
#endif
#endif
                *(WORD32 *)pv_value = 1;
            }
            else
            {
                *(WORD32 *)pv_value = 0;
            }

            return XA_NO_ERROR;

        case XA_CMD_TYPE_DO_RUNTIME_INIT:
            /* ...silently ignore */
            return XA_NO_ERROR;

        default:
            /* ...unrecognized command */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }
}

/* ...get number of produced bytes */
static XA_ERRORCODE xa_capturer_get_output_bytes(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...sanity check - check parameters */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...input buffer index must be valid */
    XF_CHK_ERR(i_idx == 0, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...capturer must be in post-init state */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_POSTINIT_DONE, XA_CAPTURER_EXEC_FATAL_STATE);

    /* ...input buffer must exist */
    XF_CHK_ERR(d->output, XA_CAPTURER_EXEC_FATAL_INPUT);

    /* ...return number of bytes produced */
    *(WORD32 *)pv_value = d->produced;

    d->produced = 0;

    return XA_NO_ERROR;
}

/*******************************************************************************
 * Memory information API
 ******************************************************************************/

/* ..get total amount of data for memory tables */
static XA_ERRORCODE xa_capturer_get_memtabs_size(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...basic sanity checks */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...check capturer is pre-initialized */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_PREINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

    /* ...we have all our tables inside API structure */
    *(WORD32 *)pv_value = 0;

    return XA_NO_ERROR;
}

/* ..set memory tables pointer */
static XA_ERRORCODE xa_capturer_set_memtabs_ptr(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...basic sanity checks */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...check capturer is pre-initialized */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_PREINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

    /* ...do not do anything; just return success - tbd */
    return XA_NO_ERROR;
}

/* ...return total amount of memory buffers */
static XA_ERRORCODE xa_capturer_get_n_memtabs(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...basic sanity checks */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...we have 1 input buffer only */
    *(WORD32 *)pv_value = 1;

    return XA_NO_ERROR;
}

/* ...return memory buffer data */
static XA_ERRORCODE xa_capturer_get_mem_info_size(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    UWORD32 i_value;

    /* ...basic sanity check */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...command valid only after post-initialization step */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_POSTINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

    switch (i_idx)
    {
        case 0:
            /* ...input buffer specification; accept exact audio frame */
#ifdef XAF_HW
            i_value = BUFFER_LENGTH * 2 * 2;
#else
            i_value = HW_FIFO_LENGTH / 2;
#endif
            break;

        default:
            /* ...invalid index */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }

    /* ...return buffer size to caller */
    *(WORD32 *)pv_value = (WORD32)i_value;

    return XA_NO_ERROR;
}

/* ...return memory alignment data */
static XA_ERRORCODE xa_capturer_get_mem_info_alignment(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...basic sanity check */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...command valid only after post-initialization step */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_POSTINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

    /* ...all buffers are at least 4-bytes aligned */
    *(WORD32 *)pv_value = 4;

    return XA_NO_ERROR;
}

/* ...return memory type data */
static XA_ERRORCODE xa_capturer_get_mem_info_type(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    /* ...basic sanity check */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...command valid only after post-initialization step */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_POSTINIT_DONE, XA_CAPTURER_CONFIG_FATAL_STATE);

    switch (i_idx)
    {
        case 0:
            /* ...input buffers */
            *(WORD32 *)pv_value = XA_MEMTYPE_OUTPUT;
            return XA_NO_ERROR;

        default:
            /* ...invalid index */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }
}

#ifdef XAF_HW
static inline UWORD32 xa_hw_capturer_read_FIFO(XACapturer *d)
{
    WORD16 *out_buffer_ptr = NULL;
    UWORD32 i;

    d->over_flow_flag = 0;
    out_buffer_ptr    = d->output;

    if ((g_circular_buf_h.tail == g_circular_buf_h.head) && !g_circular_buf_h.full)
    {
        g_buffEmptyCnt++;
    }

    for (i = 0; i < BUFFER_LENGTH; i++)
    {
        *((unsigned short *)out_buffer_ptr) =
            g_circular_buf_h.buffer[REF_MIC0][(BUFFER_LENGTH)*g_circular_buf_h.tail + i];
        out_buffer_ptr++;
        *((unsigned short *)out_buffer_ptr) =
            g_circular_buf_h.buffer[REF_MIC1][(BUFFER_LENGTH)*g_circular_buf_h.tail + i];
        out_buffer_ptr++;
    }

    g_circular_buf_h.full = false;
    g_circular_buf_h.tail = (g_circular_buf_h.tail + 1) % g_circular_buf_h.max;

    return (BUFFER_LENGTH << 2);
}
#endif

/* ...set memory pointer */
static XA_ERRORCODE xa_capturer_set_mem_ptr(XACapturer *d, WORD32 i_idx, pVOID pv_value)
{
    WORD32 bytes_read        = 0;
    static UWORD32 frame_cnt = 0;
    /* ...basic sanity check */
    XF_CHK_ERR(d && pv_value, XA_API_FATAL_INVALID_CMD_TYPE);

    /* ...codec must be initialized */
    XF_CHK_ERR(d->state & XA_CAPTURER_FLAG_POSTINIT_DONE, XA_API_FATAL_INVALID_CMD_TYPE);

    TRACE(INIT, _b("xa_capturer_set_mem_ptr[%u]: %p"), i_idx, pv_value);

    /* ...select memory buffer */
    switch (i_idx)
    {
        case 0:
            /* ...input buffer */
            d->output = pv_value;

#ifndef XAF_HW
            FIO_PRINTF(stdout, "%d\n", ++frame_cnt);
            if (d->fifo_avail >= (HW_FIFO_LENGTH_SAMPLES >> 1))
            {
                d->fifo_avail         = d->fifo_avail - (HW_FIFO_LENGTH_SAMPLES >> 1);
                bytes_read            = fread(d->output, 1, (HW_FIFO_LENGTH_SAMPLES << 1), d->fw);
                d->produced           = bytes_read;
                d->tot_bytes_produced = d->tot_bytes_produced + d->produced;
                if (d->bytes_end != 0)
                {
                    if (d->tot_bytes_produced > d->bytes_end)
                    {
                        if (d->produced > (d->tot_bytes_produced - d->bytes_end))
                        {
                            d->produced = d->produced - (d->tot_bytes_produced - d->bytes_end);
                        }
                        else
                        {
                            d->produced = 0;
                        }
                    }
                }
            }
            else
            {
                /*overrun happened*/
                d->produced = 0;
            }
#else
            if ((newDataAvailable & (DMIC_MASK << 0)) == (DMIC_MASK << 0))
            {
                DMICTransferReceiveDMA();
                bytes_read = xa_hw_capturer_read_FIFO(d);

                d->produced = bytes_read;
                d->tot_bytes_produced = d->tot_bytes_produced + d->produced;
#if 0
			if(d->bytes_end!=0)
            {
                if( d->tot_bytes_produced > d->bytes_end )
                {
                    if(d->produced > ( d->tot_bytes_produced - d->bytes_end ))
                    {
                        d->produced = d->produced - ( d->tot_bytes_produced - d->bytes_end );
                    }
                    else
                    {
                        d->produced = 0;
                    }
                }
            }
#endif
                newDataNeeded -= 1;
                newDataAvailable &= ~(DMIC_MASK << 0);

                return XA_NO_ERROR;
            }
#endif

        default:
            /* ...invalid index */
            return XF_CHK_ERR(0, XA_API_FATAL_INVALID_CMD_TYPE);
    }
}

/*******************************************************************************
 * API command hooks
 ******************************************************************************/
static XA_ERRORCODE (*const xa_capturer_api[])(XACapturer *, WORD32, pVOID) = {
    [XA_API_CMD_GET_API_SIZE]           = xa_capturer_get_api_size,
    [XA_API_CMD_INIT]                   = xa_capturer_init,
    [XA_API_CMD_SET_CONFIG_PARAM]       = xa_capturer_set_config_param,
    [XA_API_CMD_GET_CONFIG_PARAM]       = xa_capturer_get_config_param,
    [XA_API_CMD_EXECUTE]                = xa_capturer_execute,
    [XA_API_CMD_GET_OUTPUT_BYTES]       = xa_capturer_get_output_bytes,
    [XA_API_CMD_GET_MEMTABS_SIZE]       = xa_capturer_get_memtabs_size,
    [XA_API_CMD_SET_MEMTABS_PTR]        = xa_capturer_set_memtabs_ptr,
    [XA_API_CMD_GET_N_MEMTABS]          = xa_capturer_get_n_memtabs,
    [XA_API_CMD_GET_MEM_INFO_SIZE]      = xa_capturer_get_mem_info_size,
    [XA_API_CMD_GET_MEM_INFO_ALIGNMENT] = xa_capturer_get_mem_info_alignment,
    [XA_API_CMD_GET_MEM_INFO_TYPE]      = xa_capturer_get_mem_info_type,
    [XA_API_CMD_SET_MEM_PTR]            = xa_capturer_set_mem_ptr,

};

/* ...total numer of commands supported */
#define XA_CAPTURER_API_COMMANDS_NUM (sizeof(xa_capturer_api) / sizeof(xa_capturer_api[0]))

/*******************************************************************************
 * API entry point
 ******************************************************************************/

XA_ERRORCODE xa_capturer(xa_codec_handle_t p_xa_module_obj, WORD32 i_cmd, WORD32 i_idx, pVOID pv_value)
{
    XA_ERRORCODE sh_test = 0;
    XACapturer *capturer = (XACapturer *)p_xa_module_obj;
#ifdef XAF_PROFILE
    clk_t comp_start, comp_stop;
#endif
    /* ...check if command index is sane */
    XF_CHK_ERR(i_cmd < XA_CAPTURER_API_COMMANDS_NUM, XA_API_FATAL_INVALID_CMD);

    /* ...see if command is defined */
    XF_CHK_ERR(xa_capturer_api[i_cmd], XA_API_FATAL_INVALID_CMD);

    /* ...execute requested command */
#ifdef XAF_PROFILE
    comp_start = clk_read_start(CLK_SELN_THREAD);
#endif
    sh_test = xa_capturer_api[i_cmd](capturer, i_idx, pv_value);
#ifdef XAF_PROFILE
    comp_stop = clk_read_stop(CLK_SELN_THREAD);
    capturer_cycles += clk_diff(comp_stop, comp_start);
#endif
    return sh_test;
}
