/*
 * Copyright (c) 2013 - 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "board.h"

#include "pin_mux.h"
#include "clock_config.h"
#include "fsl_puf.h"
//#include "skboot_common.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/


/*******************************************************************************
 * Prototypes
 ******************************************************************************/

/*******************************************************************************
 * Code
 ******************************************************************************/
/*!
 * @brief Main function
 */
int main(void)
{
//    char ch;
    status_t result;
    uint8_t activationCode[PUF_ACTIVATION_CODE_SIZE] = {0X0,};
    uint8_t udsKeyCode[PUF_GET_KEY_CODE_SIZE_FOR_KEY_SIZE(32)] = {0X0,};

    /* Init board hardware. */
    BOARD_InitPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    
    PRINTF("hello world.\r\n");
    
    //Init 
    result = PUF_Init(PUF, 1000, CLOCK_GetFreq(kCLOCK_CoreSysClk));
    if (result != kStatus_Success)
    {
        PRINTF("Error Init...\r\n");
    }
    //Start
    result = PUF_Start(PUF, activationCode, sizeof(activationCode));
    if (result != kStatus_Success)
    {
        PRINTF("Error during Start...\r\n");
    }
    
    uint8_t udsKey[32] = {0};
    result = PUF_GetKey(PUF, udsKeyCode, sizeof(udsKeyCode),udsKey, sizeof(udsKey));
    if (result != kStatus_Success)
    {
        PRINTF("PUF_GetKey failed...\r\n");
    }
    PRINTF("UDS Key = ");
    for(int i = 0; i < 32 ; i++ )
    {
        PRINTF("%2x",udsKey[i]);
    }
    PUF_Deinit(PUF,1000, CLOCK_GetFreq(kCLOCK_CoreSysClk));
//    while (1)
//    {
//        ch = GETCHAR();
//        PUTCHAR(ch);
//    }
}
