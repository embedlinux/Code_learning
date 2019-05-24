/*
 * Copyright 2018 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include <stdlib.h>
#include <string.h>
#include "board.h"
#include "fsl_debug_console.h"
#include "fsl_device_registers.h"
#include "fsl_dmic.h"
#include "fsl_dmic_dma.h"
#include "fsl_i2c.h"
#include "fsl_i2s.h"
#include "fsl_i2s_dma.h"
#include "fsl_wm8904.h"

#include "pin_mux.h"
#include <stdbool.h>
/*******************************************************************************
 * Definitions
 ******************************************************************************/

#define DMAREQ_DMIC0 16U
#define DEMO_I2S_MASTER_CLOCK_FREQUENCY CLOCK_GetMclkClkFreq()
#define DEMO_I2S_TX (I2S1)
#define I2S_CLOCK_DIVIDER                                                                                      \
    (24576000U / 48000U / 16U / 2) /* I2S source clock 24.576MHZ, sample rate 48KHZ, bits width 16, 2 channel, \
                                  so bitclock should be 48KHZ * 16 = 768KHZ, divider should be 24.576MHZ / 768KHZ */

#define DEMO_DMA (DMA0)
#define DEMO_DMIC_RX_CHANNEL DMAREQ_DMIC0
#define DEMO_I2S_TX_CHANNEL (3)

#define DEMO_DMIC_CHANNEL kDMIC_Channel0
#define DEMO_DMIC_CHANNEL_ENABLE DMIC_CHANEN_EN_CH0(1)
#define FIFO_DEPTH (15U)
#define BUFFER_SIZE (256)
#define BUFFER_NUM (2U)
/*******************************************************************************
 * Prototypes
 ******************************************************************************/

/*******************************************************************************
 * Variables
 ******************************************************************************/
static i2s_config_t tx_config;
extern codec_config_t boardCodecConfig;
static uint8_t s_buffer[BUFFER_SIZE * BUFFER_NUM];
static uint32_t volatile s_writeIndex = 0U;
static uint32_t volatile s_emptyBlock = BUFFER_NUM;
static dmic_dma_handle_t s_dmicDmaHandle;
static dma_handle_t s_dmicRxDmaHandle;
static dma_handle_t s_i2sTxDmaHandle;
static i2s_dma_handle_t s_i2sTxHandle;
SDK_ALIGN(dma_descriptor_t s_dmaDescriptorPingpong[2], 16);

static dmic_transfer_t s_receiveXfer[2U] = {
    /* transfer configurations for channel0 */
    {
        .data = s_buffer,
        .dataWidth = sizeof(uint16_t),
        .dataSize = BUFFER_SIZE / 2U,
        .dataAddrInterleaveSize = kDMA_AddressInterleave2xWidth,
        .linkTransfer = &s_receiveXfer[1],
    },

    {
        .data = &s_buffer[BUFFER_SIZE],
        .dataWidth = sizeof(uint16_t),
        .dataSize = BUFFER_SIZE / 2U,
        .dataAddrInterleaveSize = kDMA_AddressInterleave2xWidth,
        .linkTransfer = &s_receiveXfer[0],
    },
};

/*******************************************************************************
 * Code
 ******************************************************************************/

void dmic_Callback(DMIC_Type *base, dmic_dma_handle_t *handle, status_t status, void *userData)
{
    if (s_emptyBlock)
    {
        s_emptyBlock--;
    }
}

void i2s_Callback(I2S_Type *base, i2s_dma_handle_t *handle, status_t completionStatus, void *userData)
{
    if (s_emptyBlock < BUFFER_NUM)
    {
        s_emptyBlock++;
    }
}

/*!
 * @brief Main function
 */

int main(void)
{
    dmic_channel_config_t dmic_channel_cfg;
    wm8904_config_t codecConfig;
    codec_handle_t codecHandle;
    i2s_transfer_t i2sTxTransfer;

    /* Board pin, clock, debug console init */
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
    /* DMIC source from audio pll, divider 8, 24.576M/8=3.072MHZ */
    CLOCK_AttachClk(kAUDIO_PLL_to_DMIC);
    CLOCK_SetClkDiv(kCLOCK_DivDmicClk, 8);

    PRINTF("Configure I2C\r\n");
    BOARD_Codec_I2C_Init();

    PRINTF("Configure WM8904 codec\r\n");

    WM8904_GetDefaultConfig(&codecConfig);
    codecConfig.mclk_HZ = DEMO_I2S_MASTER_CLOCK_FREQUENCY;
    boardCodecConfig.codecConfig = (void *)&codecConfig;
    if (CODEC_Init(&codecHandle, &boardCodecConfig) != kStatus_Success)
    {
        PRINTF("WM8904_Init failed!\r\n");
    }

    /* Adjust it to your needs, 0x0006 for -51 dB, 0x0039 for 0 dB etc. */
    WM8904_SetVolume(&codecHandle, 0x0030, 0x0030);

    DMA_Init(DEMO_DMA);

    DMA_EnableChannel(DEMO_DMA, DEMO_I2S_TX_CHANNEL);
    DMA_EnableChannel(DEMO_DMA, DEMO_DMIC_RX_CHANNEL);
    DMA_SetChannelPriority(DEMO_DMA, DEMO_I2S_TX_CHANNEL, kDMA_ChannelPriority3);
    DMA_SetChannelPriority(DEMO_DMA, DEMO_DMIC_RX_CHANNEL, kDMA_ChannelPriority2);
    DMA_CreateHandle(&s_i2sTxDmaHandle, DEMO_DMA, DEMO_I2S_TX_CHANNEL);
    DMA_CreateHandle(&s_dmicRxDmaHandle, DEMO_DMA, DEMO_DMIC_RX_CHANNEL);

    memset(&dmic_channel_cfg, 0U, sizeof(dmic_channel_config_t));

    dmic_channel_cfg.divhfclk = kDMIC_PdmDiv1;
    dmic_channel_cfg.osr = 32U;
    dmic_channel_cfg.gainshft = 3U;
    dmic_channel_cfg.preac2coef = kDMIC_CompValueZero;
    dmic_channel_cfg.preac4coef = kDMIC_CompValueZero;
    dmic_channel_cfg.dc_cut_level = kDMIC_DcCut155;
    dmic_channel_cfg.post_dc_gain_reduce = 1U;
    dmic_channel_cfg.saturate16bit = 1U;
    dmic_channel_cfg.sample_rate = kDMIC_PhyFullSpeed;
    DMIC_Init(DMIC0);
    DMIC_SetIOCFG(DMIC0, kDMIC_PdmDual);
    DMIC_Use2fs(DMIC0, true);
    DMIC_EnableChannelDma(DMIC0, DEMO_DMIC_CHANNEL, true);
    DMIC_ConfigChannel(DMIC0, DEMO_DMIC_CHANNEL, kDMIC_Left, &dmic_channel_cfg);

    /* FIFO disabled */
    DMIC_FifoChannel(DMIC0, DEMO_DMIC_CHANNEL, FIFO_DEPTH, true, true);
    DMIC_EnableChannnel(DMIC0, DEMO_DMIC_CHANNEL_ENABLE);
    PRINTF("Configure I2S\r\n");

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
     * fifoLevel = 4;
     */
    I2S_TxGetDefaultConfig(&tx_config);
    tx_config.divider = I2S_CLOCK_DIVIDER; /* divide by 16*/
                                           /*
                                            * masterSlave = kI2S_MasterSlaveNormalSlave;
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
                                            * fifoLevel = 4;
                                            */
    tx_config.oneChannel = true;
    I2S_TxInit(DEMO_I2S_TX, &tx_config);
    I2S_TxTransferCreateHandleDMA(DEMO_I2S_TX, &s_i2sTxHandle, &s_i2sTxDmaHandle, i2s_Callback, NULL);
    DMIC_TransferCreateHandleDMA(DMIC0, &s_dmicDmaHandle, dmic_Callback, NULL, &s_dmicRxDmaHandle);
    DMIC_InstallDMADescriptorMemory(&s_dmicDmaHandle, s_dmaDescriptorPingpong, 2U);
    DMIC_TransferReceiveDMA(DMIC0, &s_dmicDmaHandle, s_receiveXfer, DEMO_DMIC_CHANNEL);

    while (1)
    {
        if (s_emptyBlock < BUFFER_NUM)
        {
            i2sTxTransfer.data = s_buffer + s_writeIndex * BUFFER_SIZE;
            i2sTxTransfer.dataSize = BUFFER_SIZE;
            if (I2S_TxTransferSendDMA(DEMO_I2S_TX, &s_i2sTxHandle, i2sTxTransfer) == kStatus_Success)
            {
                if (++s_writeIndex >= BUFFER_NUM)
                {
                    s_writeIndex = 0U;
                }
            }
        }
    }
}
