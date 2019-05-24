/*
 * Copyright 2018 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_debug_console.h"
#include "board.h"
#include "fsl_utick.h"

#include "pin_mux.h"
#include "clock_config.h"
#include "fsl_common.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define EXAMPLE_UTICK UTICK0
#define UTICK_TIME_1S (1000000UL)

/*******************************************************************************
 * Prototypes
 ******************************************************************************/

/*******************************************************************************
 * Variables
 ******************************************************************************/
static volatile bool utickExpired;

/*******************************************************************************
 * Code
 ******************************************************************************/
/*!
 * @brief Main function
 */
static void UTickCallback(void)
{
    utickExpired = true;
}

static void UTickDelay(uint32_t usec)
{
    /* Set the UTICK timer to wake up the device from reduced power mode */
    UTICK_SetTick(EXAMPLE_UTICK, kUTICK_Onetime, usec - 1, UTickCallback);

    while (!utickExpired)
    {
    }

    utickExpired = false;
}

int main(void)
{
    /* Init board hardware. */
    CLOCK_AttachClk(kLPOSC_to_UTICK_CLK);

    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();

    PRINTF("Utick example start...\r\n");

    /* Intiialize UTICK */
    UTICK_Init(EXAMPLE_UTICK);

    while (true)
    {
        PRINTF("UTICK delay 1 second...\r\n");
        UTickDelay(UTICK_TIME_1S);
    }
}
