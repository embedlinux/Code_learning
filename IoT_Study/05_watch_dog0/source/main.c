#include "led.h"
#include "delay.h"
#include "uart.h"
#include "exit.h"
#include "wdog.h"

int main()
{
	BOARD_BootClockRUN();	//配置系统时钟
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
	Clock_Init();			//使能时钟延时
	Lpuart1_Init(115200);
	Led_Init();				//初始化LED
	Ext_Init();				//配置按键为外部中断
	WDOG1_Init(3,2);		//初始化看门狗1,2秒溢出,提前1秒进入中断,方便喂狗
	
	
	while(1)
	{
		printf("Int example driver!\r\n");
		SysTick_DelayTicks(2000);
	}
}
