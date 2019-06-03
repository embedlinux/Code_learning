#include "delay.h"


volatile uint32_t g_systickCounter;


	/* Set systick reload value to generate 1ms interrupt */
void Clock_Init()
{
	if(SysTick_Config(SystemCoreClock / 1000U))
    {
        while(1)
        {
        }
    }
}

void SysTick_DelayTicks(uint32_t n)
{
    g_systickCounter = n;
    while(g_systickCounter != 0U)
    {
    }
}

void SysTick_Handler(void)
{
    if (g_systickCounter != 0U)
    { 
        g_systickCounter--;
    }
}
