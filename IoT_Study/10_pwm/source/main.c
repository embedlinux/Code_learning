#include "led.h"
#include "delay.h"
#include "uart.h"
#include "exit.h"
#include "wdog.h"
#include "timer.h"

int main()
{
	uint8_t dir=1; 
	uint16_t led1pwmval=0;  
	BOARD_BootClockRUN();						//配置系统时钟
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
	Clock_Init();								//使能时钟延时
	Lpuart1_Init(115200);
	Led_Init();									//初始化LED
	Ext_Init();									//配置按键为外部中断
	WDOG1_Init(3,2);							//初始化看门狗1,2秒溢出,提前1秒进入中断,方便喂狗
//	WDOG3_Init(0 ,32768);						//1秒超时时间
//	GPT1_Init(3750-1,10000);					//设置GPT1 0.5秒钟产生一次中断
	PIT1_Init(75000000*2);						//75Mhz, 75000000*2, 2秒产生一次中断
	Qtimer1_Init(46875);						//150Mhz/128 = 1171875Hz
	//初始化PWM，定时器时钟为：150/64=2.34375Mhz，设置频率为5Khz,50%占空比
	QTMR4_CH3_PWM_Init(14,5000,0);	 			//GPIO_B1_11,pwm输出，没有该引脚
	while(1)
	{
		printf("Int example driver!\r\n");
		SysTick_DelayTicks(10);				//延时一秒
		if(dir)
			led1pwmval++;
		else
			led1pwmval--;	 
 		if(led1pwmval>=100)
			dir=0;
		if(led1pwmval==0)
			dir=1;	 
        QTMER4CH3_PWM_DutySet(14,5000,led1pwmval);   
		
//		RTWDOG_Feed();							//喂狗RTWDOG
	}
}
