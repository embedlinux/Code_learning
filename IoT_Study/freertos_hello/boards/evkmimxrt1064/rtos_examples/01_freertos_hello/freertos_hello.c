/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * Copyright 2016-2017 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

/* FreeRTOS kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"

/* Freescale includes. */
#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "board.h"
#include "delay.h"

#include "pin_mux.h"
#include "clock_config.h"
/*******************************************************************************
 * Definitions
 ******************************************************************************/

/* Task priorities. */
#define hello_task_PRIORITY (configMAX_PRIORITIES - 1)
/*******************************************************************************
 * Prototypes
 ******************************************************************************/
//static void hello_task(void *pvParameters);

/*******************************************************************************
 * Code
 ******************************************************************************/
/*!
 * @brief Application entry point.
 */

#define START_TASK_PRIO			1
#define START_STK_SIZE			120
void start_task(void * pvParameters);   //任务函数
TaskHandle_t StartTask_Handler;		//任务句柄	 
 
 
#define TASK1_TASK_PRIO			2
#define TASK1_STK_SIZE			120
void task1_task(void * pvParameters);
TaskHandle_t Task1Task_Handler;		//任务句柄	 

#define TASK2_TASK_PRIO			3
#define TASK2_STK_SIZE			120 
void task2_task(void * pvParameters);
TaskHandle_t Task2Task_Handler;		//任务句柄

volatile bool g_pinSet = false;
   
int main(void)
{
    /* Init board hardware. */
    BOARD_ConfigMPU();
    BOARD_InitPins();           // uart and led
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();
    delay_init();
    
    gpio_pin_config_t led_config = {kGPIO_DigitalOutput, 0,kGPIO_NoIntmode,};
    GPIO_PinInit(BOARD_USER_LED_GPIO, BOARD_USER_LED_GPIO_PIN, &led_config);
    
    int i= 0;
    for(i=0; i<=5;i++)
    {
      PRINTF("My first freertos demo.\n\r");
    }
    
    xTaskCreate((TaskFunction_t	) start_task,
                (char*          ) "start_task",
                (uint16_t       ) START_STK_SIZE,
                (void *         ) NULL,
                (UBaseType_t	) START_TASK_PRIO,
                (TaskHandle_t*	) &StartTask_Handler);
    vTaskStartScheduler();                        //开启任务调度
}

void start_task(void * pvParameters)
{
	//创建Task1
	xTaskCreate((TaskFunction_t	) task1_task,
                    (char*		) "task1_task",
                    (uint16_t		) TASK1_STK_SIZE,
                    (void * 		) NULL,
                    (UBaseType_t	) TASK1_TASK_PRIO,
                    (TaskHandle_t*	) &Task1Task_Handler);
				
	//创建Task2
	xTaskCreate((TaskFunction_t	) task2_task,
                    (char*		) "task2_task",
                    (uint16_t		) TASK1_STK_SIZE,
                    (void * 		) NULL,
                    (UBaseType_t	) TASK2_TASK_PRIO,
                    (TaskHandle_t*	) &Task2Task_Handler);
	vTaskDelete(StartTask_Handler);    //NULL
}

void task1_task(void * pvParameters)
{
  while(1)
  {
        if (g_pinSet)
        {
            GPIO_PinWrite(BOARD_USER_LED_GPIO, BOARD_USER_LED_GPIO_PIN, 0U);
            g_pinSet = false;
        }
        else
        {
            GPIO_PinWrite(BOARD_USER_LED_GPIO, BOARD_USER_LED_GPIO_PIN, 1U);
            g_pinSet = true;
        }
       vTaskDelay(500);
  }
}

void task2_task(void * pvParameters)
{
      char task2_num=0;
      while(1)
      {
            task2_num++;
            PRINTF("Task2 Runing %d!\r\n",task2_num);
            vTaskDelay(1000);
      }
}



