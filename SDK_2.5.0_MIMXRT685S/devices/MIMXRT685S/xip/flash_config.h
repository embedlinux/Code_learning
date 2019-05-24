/*
 * Copyright 2018 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#ifndef __FLASH_CONFIG__
#define __FLASH_CONFIG__

#include <stdint.h>
#include <stdbool.h>
#include "fsl_common.h"

#define CMD_SDR 0x01
#define CMD_DDR 0x21
#define RADDR_SDR 0x02
#define RADDR_DDR 0x22
#define CADDR_SDR 0x03
#define CADDR_DDR 0x23
#define MODE1_SDR 0x04
#define MODE1_DDR 0x24
#define MODE2_SDR 0x05
#define MODE2_DDR 0x25
#define MODE4_SDR 0x06
#define MODE4_DDR 0x26
#define MODE8_SDR 0x07
#define MODE8_DDR 0x27
#define WRITE_SDR 0x08
#define WRITE_DDR 0x28
#define READ_SDR 0x09
#define READ_DDR 0x29
#define LEARN_SDR 0x0A
#define LEARN_DDR 0x2A
#define DATSZ_SDR 0x0B
#define DATSZ_DDR 0x2B
#define DUMMY_SDR 0x0C
#define DUMMY_DDR 0x2C
#define DUMMY_RWDS_SDR 0x0D
#define DUMMY_RWDS_DDR 0x2D
#define JMP_ON_CS 0x1F
#define STOP 0

#define QSPI_1PAD 0
#define QSPI_2PAD 1
#define QSPI_4PAD 2
#define QSPI_8PAD 3

#define QSPI_LUT_SEQ(cmd0, pad0, op0, cmd1, pad1, op1)                                                       \
    (QuadSPI_LUT_OPRND0(op0) | QuadSPI_LUT_PAD0(pad0) | QuadSPI_LUT_INSTR0(cmd0) | QuadSPI_LUT_OPRND1(op1) | \
     QuadSPI_LUT_PAD1(pad1) | QuadSPI_LUT_INSTR1(cmd1))

typedef enum _QspiModeOfOperation
{
    QSPI_MODE_OF_OP_SINGLE = 1,
    QSPI_MODE_OF_OP_DUAL = 2,
    QSPI_MODE_OF_OP_QUAD = 4,
    QSPI_MODE_OF_OP_OCTAL = 8,
} qspi_mode_of_operation_t;

typedef enum _QspiSerialClk
{
    QSPI_SERIAL_CLOCK_FREQ_24MHZ = 1,
    QSPI_SERIAL_CLOCK_FREQ_48MHZ = 2,
    QSPI_SERIAL_CLOCK_FREQ_60MHZ = 3,
    QSPI_SERIAL_CLOCK_FREQ_72MHZ = 4,
    QSPI_SERIAL_CLOCK_FREQ_80MHZ = 5,
    QSPI_SERIAL_CLOCK_FREQ_90MHZ = 6,
    QSPI_SERIAL_CLOCK_FREQ_100MHZ = 7,
} qspi_serial_clk_t;

typedef struct _QspiBootConfig
{
    uint32_t tag;
    uint32_t version;
    uint32_t reserved0;
    uint8_t readSamplingOption;
    uint8_t csHoldTime;
    uint8_t csSetupTime;
    uint8_t columAddressWidth;
    uint8_t deviceModeCfgEnable; /* off: 0x10 */
    uint8_t deviceModeType;
    uint16_t waitTimeCfgCommands;
    uint32_t deviceModeSeq;
    uint32_t deviceModeArg;
    uint8_t configCmdEnable;
    uint8_t configModeType[3];
    uint32_t configCmdSeqs[3]; /* off: 0x20 */
    uint32_t reserved1;
    uint32_t configCmdArgs[3]; /* off: 0x30 */
    uint32_t reserved2;
    uint32_t controllerMiscOption; /* off: 0x40 */
    uint8_t deviceType;
    uint8_t sflashPadType;
    uint8_t serialClkFreq;
    uint8_t reserved3[9];
    uint32_t flashA1Size; /* off: 0x50 */
    uint32_t flashA2Size;
    uint32_t flashB1Size;
    uint32_t flashB2Size;
    uint32_t csPadSettingOverride; /* off: 0x60 */
    uint32_t sclkPadSettingOverride;
    uint32_t dataPadSettingOverride;
    uint32_t dqsPadSettingOverride;
    uint32_t timeoutInMs; /* off: 0x70 */
    uint8_t coarseTuning;
    uint8_t reserved4;
    uint16_t fineTuning;
    uint8_t samplePoint;
    uint8_t dataHoldTime;
    uint16_t reserved5;
    uint16_t busyOffset;
    uint16_t busyBitPolarity;
    uint32_t lut[64];       /* off: 0x80 */
    uint32_t reserved6[16]; /* off: 0x180 */
    uint32_t pageSize;      /* off: 0x1C0 */
    uint32_t sectorSize;
    uint8_t ipcmdSerialClkFreq;
    uint8_t isUniformBlockSize;
    uint8_t reserved7[6];
    uint32_t blockSize; /* off: 0x1D0 */
    uint8_t isNonBlockingMode;
    uint8_t reserved8[43];
} qspi_boot_config_t;

#define FLASH_CONFIG_BLOCK_TAG (0x42464346)
#define FLASH_CONFIG_BLOCK_VERSION (0x56020000)

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
}
#endif
#endif /* __FLASH_CONFIG__ */
