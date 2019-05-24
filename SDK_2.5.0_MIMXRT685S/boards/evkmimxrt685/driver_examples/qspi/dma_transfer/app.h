/*
 * Copyright (c) 2016, Freescale Semiconductor, Inc.
 * Copyright 2016-2018 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef _APP_H_
#define _APP_H_

/*${header:start}*/
#include "fsl_qspi.h"

/*${header:end}*/
/*******************************************************************************
 * Definitions
 ******************************************************************************/
/*${macro:start}*/
#define EXAMPLE_DMA DMA0
#define EXAMPLE_CHANNEL 23
#define EXAMPLE_QSPI QUADSPI
#define QSPI_CLK_FREQ CLOCK_GetFreq(kCLOCK_QspiClk)
#define FLASH_PAGE_SIZE 256U
#define FLASH_SECTORE_SIZE 4096U
#define FLASH_SIZE 0x04000000U
#define QSPI_ERASE_ADDR_OFFSET 0x400000U
#define FLASH_ENABLE_OCTAL_CMD 0x2U
#define FLASH_NEED_DQS
/*${macro:end}*/

/*******************************************************************************
 * Prototypes
 ******************************************************************************/
/*${prototype:start}*/
extern uint32_t lut[FSL_FEATURE_QSPI_LUT_DEPTH];
extern qspi_dqs_config_t dqsConfig;
extern qspi_flash_config_t single_config;

void BOARD_InitHardware(void);

void QSPI_ClockUpdate(QuadSPI_Type *base);

void enable_ddr_mode(void);
/*${prototype:end}*/

#endif /* _APP_H_ */
