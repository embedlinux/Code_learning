/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 * 
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_common.h"
#include "fsl_debug_console.h"
#include "fsl_mu.h"
#include "board.h"

#include "pin_mux.h"
#include "clock_config.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define APP_MU MUA
#define CORE0_BOOT_CORE1 0

/* Address of RAM, where the image for dsp should be copied */
#define DSP_BOOT_ADDRESS (uint32_t *)0x24000000

#if defined(__CC_ARM)
extern uint32_t Image$$DSP_REGION$$Base;
extern uint32_t Image$$DSP_REGION$$Length;
#define DSP_IMAGE_START &Image$$DSP_REGION$$Base
#elif defined(__ICCARM__)
#define DSP_IMAGE_START (uint32_t *) __section_begin("__dsp_core")
#define DSP_IMAGE_SIZE (int32_t)__section_end("__dsp_core") - (uint32_t)__section_begin("__dsp_core")
#elif defined(__GNUC__)
extern const char dsp_tcm_image_start[];
extern const char *dsp_tcm_image_end;
extern int dsp_tcm_image_size;
#define DSP_IMAGE_START ((uint32_t *)dsp_tcm_image_start)
#define DSP_IMAGE_SIZE ((int32_t)dsp_tcm_image_size)
#endif
/* Flag indicates Core Boot Up*/
#define BOOT_FLAG 0x01U

/* Channel transmit and receive register */
#define CHN_MU_REG_NUM 0U

/* How many message is used to test message sending */
#define MSG_LENGTH 32U

/*
 * Use core 0 to boot core 1.
 */
#ifndef CORE0_BOOT_CORE1
#define CORE0_BOOT_CORE1 1
#endif
/*******************************************************************************
 * Prototypes
 ******************************************************************************/
void copy_dsp_image(void);

/*******************************************************************************
 * Variables
 ******************************************************************************/
static uint32_t g_msgSend[MSG_LENGTH];
static uint32_t g_msgRecv[MSG_LENGTH];
/*******************************************************************************
 * Code
 ******************************************************************************/
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
        size -=4;
    }
    /* Run DSP core */
    SYSCTL0->DSPSTALL = 0x0;
}

/*!
 * @brief Function to fill the g_msgSend array.
 * This function set the g_msgSend values 0, 1, 2, 3...
 */
static void FillMsgSend(void)
{
    uint32_t i;
    for (i = 0U; i < MSG_LENGTH; i++)
    {
        g_msgSend[i] = i;
    }
}

/*!
 * @brief Function to clear the g_msgRecv array.
 * This function set g_msgRecv to be 0.
 */
static void ClearMsgRecv(void)
{
    uint32_t i;
    for (i = 0U; i < MSG_LENGTH; i++)
    {
        g_msgRecv[i] = 0U;
    }
}

/*!
 * @brief Function to validate the received messages.
 * This function compares the g_msgSend and g_msgRecv, if they are the same, this
 * function returns true, otherwise returns false.
 */
static bool ValidateMsgRecv(void)
{
    uint32_t i;
    for (i = 0U; i < MSG_LENGTH; i++)
    {
        PRINTF("Send: %d. Receive %d\r\n", g_msgSend[i], g_msgRecv[i]);

        if (g_msgRecv[i] != g_msgSend[i])
        {
            return false;
        }
    }
    return true;
}

/*!
 * @brief Main function
 */
int main(void)
{
    uint32_t i;

    /* Init board hardware.*/
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    /* Enable MUA clock before run DSP core */
    CLOCK_EnableClock(kCLOCK_Mu);
    RESET_PeripheralReset(kMU_RST_SHIFT_RSTn);
    copy_dsp_image();

    /* MUA init */
    MU_Init(APP_MU);
    
#if CORE0_BOOT_CORE1
    /* Boot core 1. */
    MU_BootCoreB(APP_MU, APP_CORE1_BOOT_MODE);
#endif
    
    /* Print the initial banner */
    PRINTF("\r\nMU example polling!\r\n");

    /* Wait Core 1 is Boot Up */
    while (BOOT_FLAG != MU_GetFlags(APP_MU))
    {
    }

    /* Fill the g_msgSend array before send */
    FillMsgSend();
    /* Clear the g_msgRecv array before receive */
    ClearMsgRecv();
    /* Core 0 send message to Core 1 */
    for (i = 0U; i < MSG_LENGTH; i++)
    {
        MU_SendMsg(APP_MU, CHN_MU_REG_NUM, g_msgSend[i]);
    }
    /* Core 0 receive message from Core 1 */
    for (i = 0U; i < MSG_LENGTH; i++)
    {
        g_msgRecv[i] = MU_ReceiveMsg(APP_MU, CHN_MU_REG_NUM);
    }

    /* Compare the data send and receive */
    if (true == ValidateMsgRecv())
    {
        PRINTF("MU example run succeed!");
    }
    else
    {
        PRINTF("MU example run Error!");
    }

    while (1)
    {
    }
}
