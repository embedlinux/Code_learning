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

void GPT1_IRQHandler(void)
{
	if(GPT_GetStatusFlags(GPT1,kGPT_OutputCompare1Flag)&kGPT_OutputCompare1Flag)
	{
		printf("kGPT_OutputCompare1Flag...\r\n ");		//0.5s输出一次
	}
	GPT_ClearStatusFlags(GPT1, kGPT_OutputCompare1Flag);
	__DSB();
}


