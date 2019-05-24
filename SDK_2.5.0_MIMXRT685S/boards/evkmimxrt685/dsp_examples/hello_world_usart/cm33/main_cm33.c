/*
 * Copyright 2019 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "board.h"
#include "fsl_debug_console.h"

#include "clock_config.h"
#include "fsl_dsp.h"
#include "pin_mux.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/

/* Copy DSP image to RAM during BOARD_DSP_Init(). */
#define DSP_IMAGE_COPY_TO_RAM 1

/* Address of RAM, where the image for dsp should be copied */
#define DSP_BOOT_ADDRESS (uint32_t *)0x24000000
#define DSP_SRAM_ADDRESS (uint32_t *)0x00300000

#if defined(__ICCARM__)
#define DSP_IMAGE_TCM_START (uint32_t *)__section_begin("__dsp_tcm_section")
#define DSP_IMAGE_TCM_SIZE \
    (int32_t) __section_end("__dsp_tcm_section") - (uint32_t)__section_begin("__dsp_tcm_section");
#define DSP_IMAGE_SRAM_START (uint32_t *)__section_begin("__dsp_sram_section")
#define DSP_IMAGE_SRAM_SIZE \
    (int32_t) __section_end("__dsp_sram_section") - (uint32_t)__section_begin("__dsp_sram_section");

#elif defined(__GNUC__)
extern const char dsp_tcm_image_start[];
extern int dsp_tcm_image_size;
extern const char dsp_sram_image_start[];
extern int dsp_sram_image_size;
#define DSP_IMAGE_TCM_START ((uint32_t *)dsp_tcm_image_start)
#define DSP_IMAGE_TCM_SIZE ((int32_t)dsp_tcm_image_size)
#define DSP_IMAGE_SRAM_START ((uint32_t *)dsp_sram_image_start)
#define DSP_IMAGE_SRAM_SIZE ((int32_t)dsp_sram_image_size)
#endif



/*******************************************************************************
 * Prototypes
 ******************************************************************************/
void BOARD_DSP_Init(void);
/*******************************************************************************
 * Code
 ******************************************************************************/

void BOARD_DSP_Init(void)
{
    dsp_copy_image_t tcm_image;
    dsp_copy_image_t sram_image;

    tcm_image.destAddr = DSP_BOOT_ADDRESS;
    sram_image.destAddr = DSP_SRAM_ADDRESS;

#if defined(__CC_ARM)
    size = (uint32_t)&Image$$DSP_REGION$$Length;
#elif defined(__ICCARM__)
#pragma section = "__dsp_tcm_section"
#pragma section = "__dsp_sram_section"
    tcm_image.srcAddr = DSP_IMAGE_TCM_START;
    tcm_image.size = DSP_IMAGE_TCM_SIZE;
    sram_image.srcAddr = DSP_IMAGE_SRAM_START;
    sram_image.size = DSP_IMAGE_SRAM_SIZE;
#elif defined(__GNUC__)
    tcm_image.srcAddr = DSP_IMAGE_TCM_START;
    tcm_image.size = DSP_IMAGE_TCM_SIZE;
    sram_image.srcAddr = DSP_IMAGE_SRAM_START;
    sram_image.size = DSP_IMAGE_SRAM_SIZE;
#endif

    DSP_Init();

#if DSP_IMAGE_COPY_TO_RAM
    /* Copy application from RAM to DSP_TCM */
    DSP_CopyImage(&tcm_image);

    /* Copy application from RAM to DSP_RAM */
    DSP_CopyImage(&sram_image);
#endif

    /* Run DSP core */
    DSP_Start();
}


/*!
 * @brief Main function
 */
int main(void)
{
    /* Initialize standard SDK demo application pins */
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    /* Enable MUA clock before run DSP core */
    CLOCK_EnableClock(kCLOCK_Mu);
    RESET_PeripheralReset(kMU_RST_SHIFT_RSTn);

    /* Print the initial banner */
    PRINTF("\r\nHello World running on core 'Cortex-M33'\r\n");

    /* Copy DSP image to RAM and start DSP core. */
    BOARD_DSP_Init();

    while (1)
        ;
}
