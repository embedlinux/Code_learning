#include "timer.h"


void GPT1_Init(uint16_t divi,uint32_t value)
{
	gpt_config_t gpt1_config;
	GPT_GetDefaultConfig(&gpt1_config);
	gpt1_config.clockSource = kGPT_ClockSource_Periph;   //外设时钟，ipg_clk(75Mhz)
	gpt1_config.divider = divi;							 //分频为20000Hz   75/(3749+1)
	GPT_Init(GPT1,&gpt1_config);
	
	GPT_SetOutputCompareValue(GPT1,kGPT_OutputCompare_Channel1,value);	//0.5秒产生一次中断
	
	GPT_EnableInterrupts(GPT1, kGPT_OutputCompare1InterruptEnable);
	
	GPT_StartTimer(GPT1);
	
	RT1064_NVIC_SetPriority(GPT1_IRQn,5,0);  	//抢占优先级 5，子优先级 0
	EnableIRQ(GPT1_IRQn);  						//使能 GPT1 中断
	
}


//只能通道0产生中断？？？其他通道只能级联使用？？
void PIT1_Init(uint32_t count)
{
	pit_config_t pit1_config;
	CLOCK_EnableClock(kCLOCK_Pit);     		//使能PIT时钟
	
	PIT_GetDefaultConfig(&pit1_config);		//默认配置
	pit1_config.enableRunInDebug=true; 		//调试模式下 PIT 继续运行
	PIT_Init(PIT,&pit1_config);
	
	PIT_SetTimerPeriod(PIT, kPIT_Chnl_0,count);//加载时间
	
	PIT_EnableInterrupts(PIT,kPIT_Chnl_0,kPIT_TimerInterruptEnable);	//使能中断
	
	RT1064_NVIC_SetPriority(PIT_IRQn,6,0); 		//抢占优先级 6，子优先级 0
	EnableIRQ(PIT_IRQn); 						//使能 PIT 中断

	PIT_StartTimer(PIT,kPIT_Chnl_0);			//开启PIT定时器,最后打开定时器
}

void GPT1_IRQHandler(void)
{
	if(GPT_GetStatusFlags(GPT1,kGPT_OutputCompare1Flag)&kGPT_OutputCompare1Flag)
	{
		printf("kGPT_OutputCompare1Flag...\r\n");		//0.5s输出一次
	}
	GPT_ClearStatusFlags(GPT1, kGPT_OutputCompare1Flag);
	__DSB();
}

void PIT_IRQHandler(void)
{
	if((PIT_GetStatusFlags(PIT,kPIT_Chnl_0)&kPIT_TimerFlag)== kPIT_TimerFlag)
	{
		printf("PIT chn1 interrupt 2s...\r\n");
	}
	PIT_ClearStatusFlags(PIT,kPIT_Chnl_0,kPIT_TimerFlag);
	__DSB();
}

