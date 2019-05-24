/*
 * Copyright (c) 2016, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 * 
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_spi.h"
#include "board.h"
#include "fsl_debug_console.h"

#include "pin_mux.h"
#include "clock_config.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define USE_HS_SPI 0

#if USE_HS_SPI
#define EXAMPLE_SPI_MASTER SPI14
#define EXAMPLE_SPI_MASTER_IRQ FLEXCOMM14_IRQn
#define EXAMPLE_SPI_MASTER_CLK_SRC kCLOCK_Flexcomm14
#define EXAMPLE_SPI_MASTER_CLK_FREQ CLOCK_GetFreq(kCLOCK_Flexcomm14)
#else
#define EXAMPLE_SPI_MASTER SPI5
#define EXAMPLE_SPI_MASTER_IRQ FLEXCOMM5_IRQn
#define EXAMPLE_SPI_MASTER_CLK_SRC kCLOCK_Flexcomm5
#define EXAMPLE_SPI_MASTER_CLK_FREQ CLOCK_GetFreq(kCLOCK_Flexcomm5)
#endif /* USE_HS_SPI */

#define EXAMPLE_SPI_SSEL 0
#define EXAMPLE_SPI_SPOL kSPI_SpolActiveAllLow

/*******************************************************************************
 * Prototypes
 ******************************************************************************/

/*******************************************************************************
 * Variables
 ******************************************************************************/
#define BUFFER_SIZE (64)
static uint8_t srcBuff[BUFFER_SIZE];
static uint8_t destBuff[BUFFER_SIZE];
/*******************************************************************************
 * Code
 ******************************************************************************/

int main(void)
{
    spi_master_config_t userConfig = {0};
    uint32_t srcFreq = 0;
    uint32_t i = 0;
    uint32_t err = 0;
    spi_transfer_t xfer = {0};

#if USE_HS_SPI
    CLOCK_AttachClk(kFFRO_to_FLEXCOMM14);
#else
    CLOCK_AttachClk(kSFRO_to_FLEXCOMM5);
#endif
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    PRINTF("\n\rMaster Start...\n\r");
    /*
     * userConfig.enableLoopback = false;
     * userConfig.enableMaster = true;
     * userConfig.polarity = kSPI_ClockPolarityActiveHigh;
     * userConfig.phase = kSPI_ClockPhaseFirstEdge;
     * userConfig.direction = kSPI_MsbFirst;
     * userConfig.baudRate_Bps = 500000U;
     */
    SPI_MasterGetDefaultConfig(&userConfig);
    srcFreq = EXAMPLE_SPI_MASTER_CLK_FREQ;
    userConfig.sselNum = (spi_ssel_t)EXAMPLE_SPI_SSEL;
    userConfig.sselPol = (spi_spol_t)EXAMPLE_SPI_SPOL;
    SPI_MasterInit(EXAMPLE_SPI_MASTER, &userConfig, srcFreq);

    /* Init Buffer*/
    for (i = 0; i < BUFFER_SIZE; i++)
    {
        srcBuff[i] = i;
    }

    /*Start Transfer*/
    xfer.txData = srcBuff;
    xfer.rxData = destBuff;
    xfer.dataSize = sizeof(destBuff);
    SPI_MasterTransferBlocking(EXAMPLE_SPI_MASTER, &xfer);

    /*Check if the data is right*/
    for (i = 0; i < BUFFER_SIZE; i++)
    {
        if (srcBuff[i] != destBuff[i])
        {
            err++;
            PRINTF("The %d is wrong! data is %d\n\r", i, destBuff[i]);
        }
    }
    if (err == 0)
    {
        PRINTF("Succeed!\n\r");
    }

    while (1)
    {
    }
}
