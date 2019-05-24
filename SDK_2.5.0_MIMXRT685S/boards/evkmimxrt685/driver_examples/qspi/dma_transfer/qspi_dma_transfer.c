/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#include "board.h"
#include "fsl_debug_console.h"
#include "fsl_inputmux.h"
#include "fsl_qspi_dma.h"

#include "pin_mux.h"
#include "clock_config.h"
#include "fsl_qspi.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
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
#define DUMMY_MASTER (0xE)

/*******************************************************************************
 * Prototypes
 ******************************************************************************/
extern uint32_t lut[FSL_FEATURE_QSPI_LUT_DEPTH];
extern qspi_dqs_config_t dqsConfig;
extern qspi_flash_config_t single_config;


void QSPI_ClockUpdate(QuadSPI_Type *base);

void enable_ddr_mode(void);
// AT_QUICKACCESS_SECTION_CODE(static void callback(QuadSPI_Type *base, qspi_dma_handle_t *handle, status_t status, void
// *userData));
extern void qspi_nor_flash_init(QuadSPI_Type *base);
#if defined(FLASH_ENABLE_QUAD_CMD)
extern void enable_quad_mode(void);
#endif
#if defined(FLASH_ENABLE_OCTAL_CMD)
extern void enable_octal_mode(void);
#endif
extern void erase_sector(uint32_t addr);
extern void erase_all(void);
extern void program_page(uint32_t dest_addr, uint32_t *src_addr);
extern void BOARD_SetQspiClock(QuadSPI_Type *qspi, uint32_t qspiClockSrc, uint32_t divider);
extern void DMA0_DriverIRQHandler(void);
/*******************************************************************************
 * Variables
 ******************************************************************************/

#if !defined(FSL_FEATURE_QSPI_CLOCK_CONTROL_EXTERNAL) || (!FSL_FEATURE_QSPI_CLOCK_CONTROL_EXTERNAL)
static bool isDivNeedRestore = false;
#endif
AT_NONCACHEABLE_SECTION_ALIGN(static uint32_t buff[64], 4); /* Test data */

dma_handle_t dmaHandle = {0};
/*******************************************************************************
 * Code
 ******************************************************************************/
uint32_t lut[FSL_FEATURE_QSPI_LUT_DEPTH] = {
        /* Seq0 :Octa Read */
        /* CMD:        0xEE11 - Octa IO Read, Octa pad */
        /* ADDR:       0x20 - 32bit address, Octa pads */
        /* DUMMY:      0x04 -4 clock cyles, Octa Pad */
        /* READ:       0x80 - Read 128 bytes, Octa pads */
        [0] = 0x471147EE, [1] = 0x0F042B20, [2] = 0x3B80,

        /* Seq1: Write Enable */
        /* CMD:      0x06F9 - Write Enable, Octa pad */
        [4] = 0x47F94706,

        /* Seq2: Erase All */
        /* CMD:    0x609F - Erase All chip, Octa pad */
        [8] = 0x479F4760,

        /* Seq3: Read Status */
        /* CMD:    0x05FA - Read Status, Octa pad */
        [12] = 0x47FA4705, [13] = 0x47004700, [14] = 0x47004700, [15] = 0x3B04,

        /* Seq4: Page Program */
        /* CMD:    0x12ED - Page Program, Octa pad */
        /* ADDR:   0x20 - 32bit address, Octa pad */
        [16] = 0x47ED4712, [17] = 0x3F042B20,

        /* Seq5: Write configuration register 2 */
        /* CMD:    0x72 - Write configuration Register 2, single pad */
        /* ADDR:   0x00000000 - Use 4 commands to simulate address. */
        /* WRITE:  0x01 - Write 1 byte of data, single pad */
        [20] = 0x04000472, [21] = 0x04000400, [22] = 0x20010400,

        /* Seq6: Read Config Register */
        /* CMD:  0x718E - Read configuration register 2, Octa pad */
        /* ADDR: 0x00000000 - Use 4 commands to simulate address. */
        /* DUMMY: 0x4 */
        /* READ: 0x01 - Read 1 byte, Octa pad */
        [24] = 0x478E4771, [25] = 0x47004700, [26] = 0x47004700, [27] = 0x3B010F04,

        /* Seq7: Erase Sector */
        /* CMD:    0x21DE - Sector Erase, Octa pad */
        /* ADDR:   0x20 - 32 bit address, Octa pad */
        [28] = 0x47DE4721, [29] = 0x2B20,

        /* Seq8: Write Enable */
        /* CMD:      0x06 - Write Enable, Single pad */
        [32] = 0x0406,

        /* Match MISRA rule */
        [63] = 0};

qspi_dqs_config_t dqsConfig = {
    .portADelayTapNum = 0x05,
    .shift = kQSPI_DQSNoPhraseShift,
    .rxSampleClock = kQSPI_ReadSampleClkExternalInputFromDqsPad,
    .enableDQSClkInverse = false,
};

qspi_flash_config_t single_config = {.flashA1Size = FLASH_SIZE, /* 4MB */
                                     .flashA2Size = 0,
#if defined(FSL_FEATURE_QSPI_SUPPORT_PARALLEL_MODE) && (FSL_FEATURE_QSPI_SUPPORT_PARALLEL_MODE)
                                     .flashB1Size = FLASH_SIZE,
                                     .flashB2Size = 0,
#endif
#if !defined(FSL_FEATURE_QSPI_HAS_NO_TDH) || (!FSL_FEATURE_QSPI_HAS_NO_TDH)
                                     .dataHoldTime = 1,
#endif
                                     .CSHoldTime = 3,
                                     .CSSetupTime = 3,
                                     .cloumnspace = 0,
                                     .dataLearnValue = 0,
                                     .endian = kQSPI_64LittleEndian,
                                     .enableWordAddress = false};

AT_QUICKACCESS_SECTION_CODE(void QSPI_ClockUpdate(QuadSPI_Type *base))
{
#if defined(FSL_FEATURE_QSPI_SOCCR_HAS_CLR_LPCAC) && (FSL_FEATURE_QSPI_SOCCR_HAS_CLR_LPCAC)
    QSPI_ClearCache(base);
#endif
    /* Re-configure QSPI Serial clock frequency in order to acheive high performance. */
    QSPI_Enable(base, false);
    CLOCK_AttachClk(kAUX0_PLL_to_QSPI_CLK);
    CLOCK_SetClkDiv(kCLOCK_DivQspiClk, 1);
    QSPI_Enable(base, true);
}


/* Use QSPI DMA way to program serial flash */
void qspi_dma(void)
{
    uint32_t i = 0;
    uint32_t err = 0;
    uint32_t addr = 0;
#if !defined(QSPI_ERASE_ADDR_OFFSET)
    addr = FSL_FEATURE_QSPI_AMBA_BASE;
#else
    addr = FSL_FEATURE_QSPI_AMBA_BASE + QSPI_ERASE_ADDR_OFFSET;
#endif
    erase_sector(addr);
    PRINTF("Erase finished!\r\n");

#if !defined(FSL_FEATURE_QSPI_CLOCK_CONTROL_EXTERNAL) || (!FSL_FEATURE_QSPI_CLOCK_CONTROL_EXTERNAL)
    /* Reduce frequency while clock divder is less than 2 */
    uint8_t qspiClockDiv = ((EXAMPLE_QSPI->MCR & QuadSPI_MCR_SCLKCFG_MASK) >> QuadSPI_MCR_SCLKCFG_SHIFT) + 1U;
    if (qspiClockDiv == 1U)
    {
        /* Reduce the frequency */
        isDivNeedRestore = true;
        QSPI_Enable(EXAMPLE_QSPI, false);
        EXAMPLE_QSPI->MCR &= ~QuadSPI_MCR_SCLKCFG_MASK;
        EXAMPLE_QSPI->MCR |= QuadSPI_MCR_SCLKCFG(1U);
        QSPI_Enable(EXAMPLE_QSPI, true);
    }
#endif

#if defined(FSL_SDK_DRIVER_QUICK_ACCESS_ENABLE)
    BOARD_SetQspiClock(EXAMPLE_QSPI, CLKCTL0_OSPIFFCLKSEL_SEL(0), 5);
#endif

    /* Program pages in a sector */
    for (i = 0; i < FLASH_SECTORE_SIZE / FLASH_PAGE_SIZE; i++)
    {
        program_page(addr + i * FLASH_PAGE_SIZE, buff);
    }
    PRINTF("Program data finished!\r\n");

#if !defined(FSL_FEATURE_QSPI_CLOCK_CONTROL_EXTERNAL) || (!FSL_FEATURE_QSPI_CLOCK_CONTROL_EXTERNAL)
    /* Restore the frequency if needed */
    if (isDivNeedRestore)
    {
        QSPI_Enable(EXAMPLE_QSPI, false);
        EXAMPLE_QSPI->MCR &= ~QuadSPI_MCR_SCLKCFG_MASK;
        EXAMPLE_QSPI->MCR |= QuadSPI_MCR_SCLKCFG(0U);
        QSPI_Enable(EXAMPLE_QSPI, true);
    }
#endif

#if defined(FLASH_NEED_DQS)
#if defined(FSL_SDK_DRIVER_QUICK_ACCESS_ENABLE)
    BOARD_SetQspiClock(EXAMPLE_QSPI, CLKCTL0_OSPIFFCLKSEL_SEL(0), 2);
#else
    /* Re-configure QSPI Serial clock frequency in order to acheive high performance. */
    QSPI_ClockUpdate(EXAMPLE_QSPI);
#endif
#endif

    for (i = 0; i < FLASH_SECTORE_SIZE / 4; i++)
    {
        if (((uint32_t *)addr)[i] != buff[i % 64])
        {
            PRINTF("The data in %d is wrong!!\r\n", i);
            PRINTF("The flash value in %d is %d\r\n", i, ((uint32_t *)addr)[i]);
            err++;
        }
    }
    if (err == 0)
    {
        PRINTF("Program through QSPI DMA succeed!\r\n");
    }
}

int main(void)
{
    uint32_t i = 0;

    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();

#if !defined(FSL_SDK_DRIVER_QUICK_ACCESS_ENABLE)
    RESET_PeripheralReset(kOTFADQSPI_RST_SHIFT_RSTn);
    /* attach aux0 clock to QSPI: 396M/8, QSPI source 50M, could acheive 25M bytes/sec programming
    performance for QSPI octal DDR mode. Program performance could achieve 50M bytes/sec by reducing
    the clock divider to 4, except for ARMGCC debug, which needs to do appropriate compiler optimization. */
    CLOCK_AttachClk(kAUX0_PLL_to_QSPI_CLK);
    CLOCK_SetClkDiv(kCLOCK_DivQspiClk, 8);
#endif

    PRINTF("QSPI example started!\r\n");

    /* Configure DMAMUX. */
    INPUTMUX_Init(INPUTMUX);
    INPUTMUX_AttachSignal(INPUTMUX, EXAMPLE_CHANNEL, kINPUTMUX_QspiTxToDma0);

    /* DMA init */
    DMA_Init(EXAMPLE_DMA);

    /* According to ERRATA QSPI.1, configure DMA channel 23 for QSPI TX DMA.*/
    DMA_EnableChannel(EXAMPLE_DMA, EXAMPLE_CHANNEL);
    DMA_CreateHandle(&dmaHandle, EXAMPLE_DMA, EXAMPLE_CHANNEL);

#if defined(ENABLE_RAM_VECTOR_TABLE)
    InstallIRQHandler(DMA0_IRQn, (uint32_t)DMA0_DriverIRQHandler);
#endif

    /* Copy the LUT table */
    memcpy(single_config.lookuptable, lut, sizeof(lut));

    qspi_nor_flash_init(EXAMPLE_QSPI);

    /*Initialize data buffer */
    for (i = 0; i < 64; i++)
    {
        buff[i] = i;
    }

#if defined(FLASH_ENABLE_QUAD_CMD)
    /* Enable Quad mode for the flash */
    enable_quad_mode();
#endif

#if defined(FLASH_ENABLE_OCTAL_CMD)
    enable_ddr_mode();
    /* Enable Octal mode for the flash */
    enable_octal_mode();
#endif

    /* Use dma to program flash. */
    qspi_dma();

    while (1)
    {
    }
}
