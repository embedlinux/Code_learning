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
//初始化QTIMER,TMR定时器的时钟源为IPG_CLK_ROOT=150MHz
//prisrc : 第一时钟源选择
//         0000~0011,通道0~3的输入引脚.
//         0100~0111,通道0~3的输出.可用于级联.
//         1000~1111,IPG_CLK_ROOT时钟的:1,2,4,8,16,32,64,128分频.
//cmp1	 : COMP1寄存器值,0~65535.
//定时时间=cmp1/QTMR1_CLK
//kQTMR_ClockDivide_128=1111,则QTMR1_CLK=1171875Hz.
//若cmp1=46875,则定时时间= 46875/1171875=0.04秒.

void Qtimer1_Init(uint16_t ticks)
{
	qtmr_config_t qtmr1_config;
	
	CLOCK_EnableClock(kCLOCK_Timer1);
	QTMR_GetDefaultConfig(&qtmr1_config);
	qtmr1_config.primarySource = kQTMR_ClockDivide_128;  //128分频,默认时钟源
	QTMR_Init(TMR1, kQTMR_Channel_0, &qtmr1_config);     //初始化 QTIMER
	
	QTMR_SetTimerPeriod(TMR1,kQTMR_Channel_0,ticks);	//定时周期，设置匹配值
	
	QTMR_EnableInterrupts(TMR1,kQTMR_Channel_0 ,kQTMR_CompareInterruptEnable);
	
	QTMR_StartTimer(TMR1,kQTMR_Channel_0,kQTMR_PriSrcRiseEdge);//第一时钟上升沿计数
	
	RT1064_NVIC_SetPriority(TMR1_IRQn,6,0); //抢占优先级 6，子优先级 0
	EnableIRQ(TMR1_IRQn); 					//使能 TMR1 中断

}
//计算2的乘方
//time:多少个2相乘，time不能大于7
//返回值：2^time,结果不能大于255;
uint8_t Calcu_2invo(uint8_t time)
{
    uint8_t i=0;
    uint8_t value=1;
    
    if(time>7)
			time=7;
    if(time==0)
        value=1;
    else
    {
        for(i=0;i<time;i++)
        {
            value*=2;
        }
    }
    return value;
}

//第一时钟源选择 ,prisrc
//clk: PWM频率
//duty: 占空比，百分比
void QTMR3_CH3_PWM_Init(uint8_t prisrc,uint32_t clk,uint8_t duty)
{
	uint8_t fredivi=1;
	
	qtmr_primary_count_source_t qtimer_source;
	qtimer_source = (qtmr_primary_count_source_t)prisrc;
	
	//初始化 QTMR3定时器CH3外部引脚
	Pin_B1_03_Init();
	
	fredivi=Calcu_2invo(prisrc-8);   //14-8=6,fredivi = 128
	
	qtmr_config_t qtimer3pwm_config;
	QTMR_GetDefaultConfig(&qtimer3pwm_config); 				    //先设置为默认配置
	qtimer3pwm_config.primarySource= qtimer_source; 		  //设置第一时钟源, 150MHz/64=2.34375MHz
	QTMR_Init(TMR3,kQTMR_Channel_3,&qtimer3pwm_config); 	//初始化 TIM3 通道 3
	
	//创建 CH3 的 PWM 输出，PWM signal frequency，PWM pulse width，Polarity， Main counter clock in Hz.
	QTMR_SetupPwm(TMR3, 			\
					kQTMR_Channel_3, \
					clk, 			\
					duty, 			\
					false, 			\
					CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi);
	
	//通道3在第一时钟源的上升沿计数
	QTMR_StartTimer(TMR3,kQTMR_Channel_3,kQTMR_PriSrcRiseEdge);
}

//是用来改变 PWM 占空比
void QTMR3_CH3_PWM_DutySet(uint8_t prisrc,uint32_t clk, uint8_t duty)
{
    uint8_t fredivi=1;
    uint32_t srcclk,period,hightime,lowtime;
    
    fredivi=Calcu_2invo(prisrc-8);
    srcclk=CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi;
    
    period=(srcclk/clk);                		//一个PWM周期需要的计数值
    hightime=(period*duty)/100;         		//一个PWM周期中高电平时间(计数值)
    lowtime=period-hightime;            		//一个PWM周期中低电平时间(计数值)
    
    TMR3->CHANNEL[kQTMR_Channel_3].CMPLD1=lowtime;
    TMR3->CHANNEL[kQTMR_Channel_3].CMPLD2=hightime;
}

void QTMR3_CH0_PWM_Init(uint8_t prisrc,uint32_t clk,uint8_t duty)
{
	uint8_t fredivi=1;
	
	qtmr_primary_count_source_t qtimer_source;
	qtimer_source = (qtmr_primary_count_source_t)prisrc;
	
	//初始化 QTMR3定时器CH0外部引脚
	Pin_B1_00_Init();
	
	fredivi=Calcu_2invo(prisrc-8);
	
	qtmr_config_t qtimer3pwm_config;
	QTMR_GetDefaultConfig(&qtimer3pwm_config); 				//先设置为默认配置
	qtimer3pwm_config.primarySource= qtimer_source; 		//设置第一时钟源, 150MHz/64=2.34375MHz
	QTMR_Init(TMR3,kQTMR_Channel_0,&qtimer3pwm_config); 	//初始化 TIM4 通道 1
	
	//创建 CH1 的 PWM 输出，并且指定 PWM 的频率与占空比
	QTMR_SetupPwm(TMR3, 			\
					kQTMR_Channel_0, \
					clk, 			\
					duty, 			\
					false, 			\
					CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi);
	
	//通道3在第一时钟源的上升沿计数
	QTMR_StartTimer(TMR3,kQTMR_Channel_0,kQTMR_PriSrcRiseEdge);
}

//是用来改变 PWM 占空比
void QTMR3_CH0_PWM_DutySet(uint8_t prisrc,uint32_t clk, uint8_t duty)
{
    uint8_t fredivi=1;
    uint32_t srcclk,period,hightime,lowtime;
    
    fredivi=Calcu_2invo(prisrc-8);
    srcclk=CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi;
    
    period=(srcclk/clk);                		//一个PWM周期需要的计数值
    hightime=(period*duty)/100;         		//一个PWM周期中高电平时间(计数值)
    lowtime=period-hightime;            		//一个PWM周期中低电平时间(计数值)
    
    TMR3->CHANNEL[kQTMR_Channel_0].CMPLD1=lowtime;
    TMR3->CHANNEL[kQTMR_Channel_0].CMPLD2=hightime;
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
	if(PIT_GetStatusFlags(PIT,kPIT_Chnl_0)&kPIT_TimerFlag)
	{
		printf("PIT chn1 interrupt 2s...\r\n");
	}
	PIT_ClearStatusFlags(PIT,kPIT_Chnl_0,kPIT_TimerFlag);
	__DSB();
}

void TMR1_IRQHandler(void)
{
	//0.04秒产生一次中断。1s/0.04 = 25 
	static uint8_t counter = 25 ;
	if(QTMR_GetStatus(TMR1,kQTMR_Channel_0)&kQTMR_CompareFlag)
	{
		counter--;
		if (0 == counter)
		{
			printf("TMR chn1_0 interrupt 1s...\r\n");
			counter = 25;
		}
		QTMR_ClearStatusFlags(TMR1,kQTMR_Channel_0, kQTMR_CompareFlag);
	}
	__DSB();
}
