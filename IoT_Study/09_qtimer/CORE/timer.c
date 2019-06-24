#include "timer.h"


void GPT1_Init(uint16_t divi,uint32_t value)
{
	gpt_config_t gpt1_config;
	GPT_GetDefaultConfig(&gpt1_config);
	gpt1_config.clockSource = kGPT_ClockSource_Periph;   //����ʱ�ӣ�ipg_clk(75Mhz)
	gpt1_config.divider = divi;							 //��ƵΪ20000Hz   75/(3749+1)
	GPT_Init(GPT1,&gpt1_config);
	
	GPT_SetOutputCompareValue(GPT1,kGPT_OutputCompare_Channel1,value);	//0.5�����һ���ж�
	
	GPT_EnableInterrupts(GPT1, kGPT_OutputCompare1InterruptEnable);
	
	GPT_StartTimer(GPT1);
	
	RT1064_NVIC_SetPriority(GPT1_IRQn,5,0);  	//��ռ���ȼ� 5�������ȼ� 0
	EnableIRQ(GPT1_IRQn);  						//ʹ�� GPT1 �ж�
	
}


//ֻ��ͨ��0�����жϣ���������ͨ��ֻ�ܼ���ʹ�ã���
void PIT1_Init(uint32_t count)
{
	pit_config_t pit1_config;
	CLOCK_EnableClock(kCLOCK_Pit);     		//ʹ��PITʱ��
	
	PIT_GetDefaultConfig(&pit1_config);		//Ĭ������
	pit1_config.enableRunInDebug=true; 		//����ģʽ�� PIT ��������
	PIT_Init(PIT,&pit1_config);
	
	PIT_SetTimerPeriod(PIT, kPIT_Chnl_0,count);//����ʱ��
	
	PIT_EnableInterrupts(PIT,kPIT_Chnl_0,kPIT_TimerInterruptEnable);	//ʹ���ж�
	
	RT1064_NVIC_SetPriority(PIT_IRQn,6,0); 		//��ռ���ȼ� 6�������ȼ� 0
	EnableIRQ(PIT_IRQn); 						//ʹ�� PIT �ж�

	PIT_StartTimer(PIT,kPIT_Chnl_0);			//����PIT��ʱ��,���򿪶�ʱ��
}
//��ʼ��QTIMER,TMR��ʱ����ʱ��ԴΪIPG_CLK_ROOT=150MHz
//prisrc : ��һʱ��Դѡ��
//         0000~0011,ͨ��0~3����������.
//         0100~0111,ͨ��0~3�����.�����ڼ���.
//         1000~1111,IPG_CLK_ROOTʱ�ӵ�:1,2,4,8,16,32,64,128��Ƶ.
//cmp1	 : COMP1�Ĵ���ֵ,0~65535.
//��ʱʱ��=cmp1/QTMR1_CLK
//kQTMR_ClockDivide_128=1111,��QTMR1_CLK=1171875Hz.
//��cmp1=46875,��ʱʱ��= 46875/1171875=0.04��.

void Qtimer1_Init(uint16_t ticks)
{
	qtmr_config_t qtmr1_config;
	
	CLOCK_EnableClock(kCLOCK_Timer1);
	QTMR_GetDefaultConfig(&qtmr1_config);
	qtmr1_config.primarySource = kQTMR_ClockDivide_128;  //128��Ƶ,Ĭ��ʱ��Դ
	QTMR_Init(TMR1, kQTMR_Channel_0, &qtmr1_config);     //��ʼ�� QTIMER
	
	QTMR_SetTimerPeriod(TMR1,kQTMR_Channel_0,ticks);	//��ʱ���ڣ�����ƥ��ֵ
	
	QTMR_EnableInterrupts(TMR1,kQTMR_Channel_0 ,kQTMR_CompareInterruptEnable);
	
	QTMR_StartTimer(TMR1,kQTMR_Channel_0,kQTMR_PriSrcRiseEdge);//��һʱ�������ؼ���
	
	RT1064_NVIC_SetPriority(TMR1_IRQn,6,0); //��ռ���ȼ� 6�������ȼ� 0
	EnableIRQ(TMR1_IRQn); 					//ʹ�� TMR1 �ж�

}

void GPT1_IRQHandler(void)
{
	if(GPT_GetStatusFlags(GPT1,kGPT_OutputCompare1Flag)&kGPT_OutputCompare1Flag)
	{
		printf("kGPT_OutputCompare1Flag...\r\n");		//0.5s���һ��
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
	//0.04�����һ���жϡ�1s/0.04 = 25 
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