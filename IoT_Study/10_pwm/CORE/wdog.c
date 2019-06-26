#include "wdog.h"

wdog_config_t wdog1_config; 			//WDOG配置结构体
rtwdog_config_t rtdog_config;  		//RTWDOG配置结构体
rtwdog_clock_prescaler_t prescal;	//RTWDOG是否分频

void WDOG1_Init(uint16_t wdgtimeout, uint16_t inttimeout)
{
	CLOCK_EnableClock(kCLOCK_Wdog1);				//使能看门狗时钟
	
	WDOG_GetDefaultConfig(&wdog1_config);   //先将WDOG1配置为默认值
	
	wdog1_config.workMode.enableDebug = false;     	//关闭debug模式
	wdog1_config.workMode.enableStop = false;				//关闭stop模式
	wdog1_config.workMode.enableWait = false;				//关闭等待模式
	wdog1_config.timeoutValue = wdgtimeout;					//超时时间(wdgtimeout + 1) *0.5
	wdog1_config.interruptTimeValue = inttimeout;		//wdog超时前几秒产生中断? inttimeout*0.5
	wdog1_config.enableInterrupt = true;						//使能中断
	wdog1_config.enableWdog = true;									//使能看门狗
	WDOG_Init(WDOG1,&wdog1_config);
	
	RT1064_NVIC_SetPriority(WDOG1_IRQn,4,0);		//抢占优先级4，子优先级0
	EnableIRQ(WDOG1_IRQn);											//使能WDOG1中断
	
}

//喂狗
void WDOG1_Feed(void)
{  
	WDOG_Refresh(WDOG1);//重装载	
}

//喂狗
void RTWDOG_Feed(void)
{
	RTWDOG_Refresh(RTWDOG);
}


//看门狗中断服务函数
void WDOG1_IRQHandler(void)
{
//	static uint8_t ledflag =1;
	if(WDOG_GetStatusFlags(WDOG1) & kWDOG_InterruptFlag)		//超时要发生
	{
		WDOG1_Feed();											//喂狗
//		if(ledflag == 1)
//		{	
//			ledflag = 0;
//			GPIO_PinWrite(GPIO1,9,ledflag);
//		}
//		else
//		{
//			ledflag = 1;
//			GPIO_PinWrite(GPIO1,9,ledflag);
//		}
		printf("kWDOG_InterruptFlag... 1s\r\n");
	}
	WDOG_ClearInterruptStatus(WDOG1,kWDOG_InterruptFlag);		//清除中断标志
	__DSB();																								//数据同步屏蔽指令
}

void WDOG3_Init(uint8_t pscen,uint16_t toval)			
{
	CLOCK_EnableClock(kCLOCK_Wdog3);												//使能看门狗时钟
	
	if(pscen == 1)
		prescal = kRTWDOG_ClockPrescalerDivide256;
	else
		prescal = kRTWDOG_ClockPrescalerDivide1;
	
	SysTick_DelayTicks(20);															//切换时钟前要等待一段时间
	RTWDOG_GetDefaultConfig(&rtdog_config);
	
	rtdog_config.enableRtwdog = true;
	rtdog_config.clockSource = kRTWDOG_ClockSource1;		//时钟源，LPO_CLK          32.768Khz
	rtdog_config.prescaler = prescal;                   //Trtwdog=TOVAL/Frtwdog;   超时时间   tRtwdog = 32.768kHZ/32768 = 1m溢出
	rtdog_config.testMode = kRTWDOG_UserModeEnabled;
	rtdog_config.enableInterrupt = false;
	rtdog_config.enableWindowMode = false;
	rtdog_config.timeoutValue = toval;

	RTWDOG_Init(RTWDOG,&rtdog_config);  //初始化看门狗
	
	RT1064_NVIC_SetPriority(RTWDOG_IRQn,4,0);  //抢占优先级 4，子优先级 0
	EnableIRQ(RTWDOG_IRQn); //使能 RTWDOG 中断
}

void RTWDOG_IRQHandler(void)
{
	if(RTWDOG_GetStatusFlags(RTWDOG) & kRTWDOG_InterruptFlag)		//超时要发生
	;																														//无法喂狗，因为必须在255个总线周期（约 1.7us）里面完成，但是喂狗函数的执行超过 1.7us。
	RTWDOG_ClearStatusFlags(RTWDOG,kRTWDOG_InterruptFlag);			//清除终端
}




