/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 * 
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_common.h"
#include "fsl_sema42.h"
#include "fsl_mu.h"
#include "board.h"
#include "fsl_debug_console.h"

#include "pin_mux.h"
#include "clock_config.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define APP_MU MUA
#define APP_SEMA42 SEMA42
#define APP_BOARD_HAS_LED 0
#define USE_STATIC_DOMAIN_ID 0
#define CORE0_BOOT_CORE1 0
/* Address of RAM, where the image for dsp should be copied */
#define DSP_BOOT_ADDRESS (uint32_t *)0x24000000

#if defined(__CC_ARM)
extern uint32_t Image$$DSP_REGION$$Base;
extern uint32_t Image$$DSP_REGION$$Length;
#define DSP_IMAGE_START &Image$$DSP_REGION$$Base
#elif defined(__ICCARM__)
#define DSP_IMAGE_START (uint32_t *) __section_begin("__dsp_core")
#define DSP_IMAGE_SIZE (int32_t)__section_end("__dsp_core") - (uint32_t)__section_begin("__dsp_core");
#elif defined(__GNUC__)
extern const char dsp_tcm_image_start[];
extern const char *dsp_tcm_image_end;
extern int dsp_tcm_image_size;
#define DSP_IMAGE_START ((uint32_t *)dsp_tcm_image_start)
#define DSP_IMAGE_SIZE ((int32_t)dsp_tcm_image_size)
#endif
/* Flag indicates Core Boot Up*/
#define BOOT_FLAG 0x01U
/* Flag indicates Core 0 has locked the sema42 gate. */
#define SEMA42_LOCK_FLAG 0x02U
/* Flag indicates Core 1 has locked the sema42 gate. */
#define SEMA42_CORE1_LOCK_FLAG 0x03U
/* The SEMA42 gate */
#define SEMA42_GATE 0U

/*
 * Use core 0 to boot core 1.
 * When set to 1, the core 0 assign domain ID for core 0 and core 1, then boot core 1.
 * When set to 0, core 0 and core 1 are boot up by uboot or other component, and
 * they assign their own domain ID seperately.
 */
#ifndef CORE0_BOOT_CORE1
#define CORE0_BOOT_CORE1 1
#endif

/*
 * Use static domain ID or dynamic domain ID.
 */
#ifndef USE_STATIC_DOMAIN_ID
#define USE_STATIC_DOMAIN_ID 1
#endif

/*
 * The board has LED to show the status.
 */
#ifndef APP_BOARD_HAS_LED
#define APP_BOARD_HAS_LED 1
#endif

/*******************************************************************************
 * Prototypes
 ******************************************************************************/
void APP_InitCore0Domain(void);
void copy_dsp_image(void);
#if USE_STATIC_DOMAIN_ID
uint8_t APP_GetCore0DomainID(void)
{
    return 0U;
}
#else
uint8_t APP_GetCore0DomainID(void);
#endif

/*******************************************************************************
 * Variables
 ******************************************************************************/

/*******************************************************************************
 * Code
 ******************************************************************************/
void APP_InitCore0Domain(void)
{
}
uint8_t APP_GetCore0DomainID(void)
{
    return 1U;
}
void copy_dsp_image(void)
{
    int32_t size;
    uint32_t *src;
    uint32_t *dst = DSP_BOOT_ADDRESS;
#if defined(__CC_ARM)
    size = (uint32_t)&Image$$DSP_REGION$$Length;
#elif defined(__ICCARM__)
#pragma section = "__dsp_core"
    src = DSP_IMAGE_START;
    size = DSP_IMAGE_SIZE;
#elif defined(__GNUC__)
    src = DSP_IMAGE_START;
    size = DSP_IMAGE_SIZE;
#endif

    SYSCTL0->PDRUNCFG1_CLR = 0x0F000000; /* Power up DSP TCM */
    PMC->MEMSEQCTRL = 0x00000000;
    PMC->CTRL |= 0x00000001;
    while ((PMC->STATUS & PMC_STATUS_ACTIVEFSM_MASK) != 0)
    {
    }

    CLOCK_EnableClock(kCLOCK_Dsp);
    RESET_PeripheralReset(kDSP_RST_SHIFT_RSTn);
    /* Copy application from RAM to DSP_RAM */
    while (size > 0)
    {
        *dst++ = *src++;
        size -= 4;
    }
    /* Run DSP core */
    SYSCTL0->DSPSTALL = 0x0;
}
/*!
 * @brief Main function
 */
int main(void)
{
    uint8_t domainId;
    /* Init board hardware.*/
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    /* Enable MUA clock before run DSP core */
    CLOCK_EnableClock(kCLOCK_Mu);
    RESET_PeripheralReset(kMU_RST_SHIFT_RSTn);
    /* Clear SEMA42 reset */
    RESET_PeripheralReset(kSEMA_RST_SHIFT_RSTn);
    copy_dsp_image();
#if APP_BOARD_HAS_LED
    /* Initialize LED */
    LED_INIT();
#endif

    /* MUA init */
    MU_Init(APP_MU);

    /* Print the initial banner */
    PRINTF("\r\nSema42 example!\r\n");

    /* SEMA42 init */
    SEMA42_Init(APP_SEMA42);
    /* Reset the sema42 gate */
    SEMA42_ResetAllGates(APP_SEMA42);

#if CORE0_BOOT_CORE1
    APP_InitDomain();
    /* Boot Core 1. */
    MU_BootCoreB(APP_MU, APP_CORE1_BOOT_MODE);
#else
    APP_InitCore0Domain();
#endif

    MU_SetFlags(APP_MU, BOOT_FLAG);

    /* Wait Core 1 is Boot Up */
    while (BOOT_FLAG != MU_GetFlags(APP_MU))
    {
    }

    domainId = APP_GetCore0DomainID();

    /* Lock the sema42 gate. */
    SEMA42_Lock(APP_SEMA42, SEMA42_GATE, domainId);

    MU_SetFlags(APP_MU, SEMA42_LOCK_FLAG);

    /* Wait until user press any key */
#if APP_BOARD_HAS_LED
    PRINTF("Press any key to unlock semaphore and Core 1 will turn off the LED\r\n");
#else
    PRINTF("Press any key to unlock semaphore and Core 1 will lock it\r\n");
#endif
    GETCHAR();

    /* Unlock the sema42 gate. */
    SEMA42_Unlock(APP_SEMA42, SEMA42_GATE);

#if APP_BOARD_HAS_LED
    PRINTF("Now the LED should be turned off\r\n");
#else
    PRINTF("Wait for core 1 lock the semaphore\r\n");
#endif
    /* Wait for core 1 lock the sema */
    while (SEMA42_CORE1_LOCK_FLAG != MU_GetFlags(APP_MU))
    {
    }

#if CORE0_BOOT_CORE1
    APP_DeinitDomain();
#endif

    PRINTF("\r\nSema42 example succeed!\r\n");

    while (1)
    {
    }
}
