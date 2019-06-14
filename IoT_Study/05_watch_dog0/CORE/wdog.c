#include "wdog.h"

wdog_config_t wdog1_config; //WDOG配置结构体

void WDOG1_Init(uint16_t wdgtimeout, uint16_t inttimeout)
{
	CLOCK_EnableClock(kCLOCK_Wdog1);		//使能看门狗时钟
	
	WDOG_GetDefaultConfig(&wdog1_config);   //先将WDOG1配置为默认值
	
	wdog1_config.workMode.enableDebug = false;     	//关闭debug模式
	wdog1_config.workMode.enableStop = false;		//关闭stop模式
	wdog1_config.workMode.enableWait = false;		//关闭等待模式
	wdog1_config.timeoutValue = wdgtimeout;			//超时时间(wdgtimeout + 1) *0.5
	wdog1_config.interruptTimeValue = inttimeout;	//wdog超时前几秒产生中断? inttimeout*0.5
	
	wdog1_config.enableInterrupt = true;			//使能中断
	wdog1_config.enableWdog = true;					//使能看门狗
	WDOG_Init(WDOG1,&wdog1_config);
	
	RT1064_NVIC_SetPriority(WDOG1_IRQn,4,0);		//抢占优先级4，子优先级0
	EnableIRQ(WDOG1_IRQn);							//使能WDOG1中断
	
}

//喂狗
void WDOG1_Feed(void)
{  
	WDOG_Refresh(WDOG1);//重装载	
}

//看门狗中断服务函数
void WDOG1_IRQHandler(void)
{
	static uint8_t ledflag =1;
	if(WDOG_GetStatusFlags(WDOG1) & kWDOG_InterruptFlag)		//超时要发生
	{
		WDOG1_Feed();											//喂狗
		if(ledflag == 1)
		{	
			ledflag = 0;
			GPIO_PinWrite(GPIO1,9,ledflag);
		}
		else
		{
			ledflag = 1;
			GPIO_PinWrite(GPIO1,9,ledflag);
		}
		
	}
	WDOG_ClearInterruptStatus(WDOG1,kWDOG_InterruptFlag);		//清除中断标志
	__DSB();				//数据同步屏蔽指令
}


