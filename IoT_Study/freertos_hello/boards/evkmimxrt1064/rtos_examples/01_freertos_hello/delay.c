#include "FreeRTOS.h"					//FreeRTOS使用	 
#include "task.h"
#include "delay.h"
#include "clock_config.h"

volatile uint32_t g_systickCounter;

extern void xPortSysTickHandler(void);

//void SysTick_Handler(void)
//{  
//    if(xTaskGetSchedulerState()!=taskSCHEDULER_NOT_STARTED)     //系统已经运行
//    {
//        xPortSysTickHandler();	
//    }
//    else if(g_systickCounter != 0U)
//    {
//      g_systickCounter--;
//    }
//    if(g_systickCounter != 0U)
//    {
//      g_systickCounter--;
//    }
//}

void delay(uint32_t n)
{
    g_systickCounter = n;
    while (g_systickCounter != 0U)
    {
    }
}

void delay_init(void)
{
    /* Set systick reload value to generate 1ms interrupt */
    if (SysTick_Config(SystemCoreClock / 1000U))
    {
        while (1)
        {
        }
    }
}
			   

























