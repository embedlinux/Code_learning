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
//����2�ĳ˷�
//time:���ٸ�2��ˣ�time���ܴ���7
//����ֵ��2^time,������ܴ���255;
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

//��һʱ��Դѡ��,prisrc
//clk: PWMƵ��
//duty: ռ�ձȣ��ٷֱ�
void QTMR3_CH3_PWM_Init(uint8_t prisrc,uint32_t clk,uint8_t duty)
{
	uint8_t fredivi=1;
	
	qtmr_primary_count_source_t qtimer_source;
	qtimer_source = (qtmr_primary_count_source_t)prisrc;
	
	//��ʼ�� QTMR3��ʱ��CH3�ⲿ����
	Pin_B1_03_Init();
	
	fredivi=Calcu_2invo(prisrc-8);   //14-8=6,fredivi = 128
	
	qtmr_config_t qtimer3pwm_config;
	QTMR_GetDefaultConfig(&qtimer3pwm_config); 				    //������ΪĬ������
	qtimer3pwm_config.primarySource= qtimer_source; 		  //���õ�һʱ��Դ, 150MHz/64=2.34375MHz
	QTMR_Init(TMR3,kQTMR_Channel_3,&qtimer3pwm_config); 	//��ʼ�� TIM3 ͨ�� 3
	
	//���� CH3 �� PWM �����PWM signal frequency��PWM pulse width��Polarity�� Main counter clock in Hz.
	QTMR_SetupPwm(TMR3, 			\
					kQTMR_Channel_3, \
					clk, 			\
					duty, 			\
					false, 			\
					CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi);
	
	//ͨ��3�ڵ�һʱ��Դ�������ؼ���
	QTMR_StartTimer(TMR3,kQTMR_Channel_3,kQTMR_PriSrcRiseEdge);
}

//�������ı� PWM ռ�ձ�
void QTMR3_CH3_PWM_DutySet(uint8_t prisrc,uint32_t clk, uint8_t duty)
{
    uint8_t fredivi=1;
    uint32_t srcclk,period,hightime,lowtime;
    
    fredivi=Calcu_2invo(prisrc-8);
    srcclk=CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi;
    
    period=(srcclk/clk);                		//һ��PWM������Ҫ�ļ���ֵ
    hightime=(period*duty)/100;         		//һ��PWM�����иߵ�ƽʱ��(����ֵ)
    lowtime=period-hightime;            		//һ��PWM�����е͵�ƽʱ��(����ֵ)
    
    TMR3->CHANNEL[kQTMR_Channel_3].CMPLD1=lowtime;
    TMR3->CHANNEL[kQTMR_Channel_3].CMPLD2=hightime;
}

void QTMR3_CH0_PWM_Init(uint8_t prisrc,uint32_t clk,uint8_t duty)
{
	uint8_t fredivi=1;
	
	qtmr_primary_count_source_t qtimer_source;
	qtimer_source = (qtmr_primary_count_source_t)prisrc;
	
	//��ʼ�� QTMR3��ʱ��CH0�ⲿ����
	Pin_B1_00_Init();
	
	fredivi=Calcu_2invo(prisrc-8);
	
	qtmr_config_t qtimer3pwm_config;
	QTMR_GetDefaultConfig(&qtimer3pwm_config); 				//������ΪĬ������
	qtimer3pwm_config.primarySource= qtimer_source; 		//���õ�һʱ��Դ, 150MHz/64=2.34375MHz
	QTMR_Init(TMR3,kQTMR_Channel_0,&qtimer3pwm_config); 	//��ʼ�� TIM4 ͨ�� 1
	
	//���� CH1 �� PWM ���������ָ�� PWM ��Ƶ����ռ�ձ�
	QTMR_SetupPwm(TMR3, 			\
					kQTMR_Channel_0, \
					clk, 			\
					duty, 			\
					false, 			\
					CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi);
	
	//ͨ��3�ڵ�һʱ��Դ�������ؼ���
	QTMR_StartTimer(TMR3,kQTMR_Channel_0,kQTMR_PriSrcRiseEdge);
}

//�������ı� PWM ռ�ձ�
void QTMR3_CH0_PWM_DutySet(uint8_t prisrc,uint32_t clk, uint8_t duty)
{
    uint8_t fredivi=1;
    uint32_t srcclk,period,hightime,lowtime;
    
    fredivi=Calcu_2invo(prisrc-8);
    srcclk=CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi;
    
    period=(srcclk/clk);                		//һ��PWM������Ҫ�ļ���ֵ
    hightime=(period*duty)/100;         		//һ��PWM�����иߵ�ƽʱ��(����ֵ)
    lowtime=period-hightime;            		//һ��PWM�����е͵�ƽʱ��(����ֵ)
    
    TMR3->CHANNEL[kQTMR_Channel_0].CMPLD1=lowtime;
    TMR3->CHANNEL[kQTMR_Channel_0].CMPLD2=hightime;
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

void QTMR_PWM_Init(uint8_t pin,uint8_t prisrc,uint32_t clk,uint8_t duty)
{		
	uint8_t fredivi=1;
	qtmr_primary_count_source_t qtimer_source;
	qtimer_source = (qtmr_primary_count_source_t)prisrc;
	
	//��ʼ��QTIMER�ⲿ����
	Pin_Timer_Init(pin);
	
	fredivi=Calcu_2invo(prisrc-8);   //14-8=6,fredivi = 128
	
	qtmr_config_t qtimerpwm_config;
	QTMR_GetDefaultConfig(&qtimerpwm_config); 				  //������ΪĬ������
	qtimerpwm_config.primarySource= qtimer_source; 		  //���õ�һʱ��Դ, 150MHz/64=2.34375MHz
	
	switch(pin)
	{
		case 30:
				QTMR_Init(TMR3,kQTMR_Channel_0,&qtimerpwm_config); 	//��ʼ�� TIM ͨ�� 
				QTMR_SetupPwm(TMR3,kQTMR_Channel_0, clk, duty,false,CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi);
				QTMR_StartTimer(TMR3,kQTMR_Channel_0,kQTMR_PriSrcRiseEdge);
				break;
		case 33:
				QTMR_Init(TMR3,kQTMR_Channel_3,&qtimerpwm_config); 	//��ʼ�� TIM ͨ�� 
				QTMR_SetupPwm(TMR3,kQTMR_Channel_3, clk, duty,false,CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi);
				QTMR_StartTimer(TMR3,kQTMR_Channel_3,kQTMR_PriSrcRiseEdge);
				break;
		case 40:
				QTMR_Init(TMR4,kQTMR_Channel_0,&qtimerpwm_config); 	//��ʼ�� TIM ͨ�� 
				QTMR_SetupPwm(TMR4,kQTMR_Channel_0, clk, duty,false,CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi);
				QTMR_StartTimer(TMR4,kQTMR_Channel_0,kQTMR_PriSrcRiseEdge);
				break;
		default:
				break;
	}
}
void QTMR_PWM_DutySet(uint8_t pin,uint8_t prisrc,uint32_t clk, uint8_t duty)
{
	uint8_t fredivi=1;
	uint32_t srcclk,period,hightime,lowtime;
    
  fredivi=Calcu_2invo(prisrc-8);
  srcclk=CLOCK_GetFreq(kCLOCK_IpgClk)/fredivi;
    
  period=(srcclk/clk);                		//һ��PWM������Ҫ�ļ���ֵ
  hightime=(period*duty)/100;         		//һ��PWM�����иߵ�ƽʱ��(����ֵ)
  lowtime=period-hightime;            		//һ��PWM�����е͵�ƽʱ��(����ֵ)
	
	switch(pin)
	{
		case 30:
				TMR3->CHANNEL[kQTMR_Channel_0].CMPLD1=lowtime;
				TMR3->CHANNEL[kQTMR_Channel_0].CMPLD2=hightime;
				break;
		case 33:
				TMR3->CHANNEL[kQTMR_Channel_3].CMPLD1=lowtime;
				TMR3->CHANNEL[kQTMR_Channel_3].CMPLD2=hightime;
				break;
		case 40:
				TMR4->CHANNEL[kQTMR_Channel_0].CMPLD1=lowtime;
				TMR4->CHANNEL[kQTMR_Channel_0].CMPLD2=hightime;
				break;
		default:
				break;
	}
}

void XBARA1_Signal_Set(uint8_t inpin,uint8_t outpin)
{
	xbar_input_signal_t input;
	xbar_output_signal_t output;
	uint8_t outx;
	
	switch(inpin)
	{
		case 30:
			input = kXBARA1_InputQtimer3Tmr0Output;
			break;
		case 40:
			input = kXBARA1_InputQtimer4Tmr0Output;
			break;
		default:
			break;
	}
	switch(outpin)
	{
		case 13:
			output = kXBARA1_OutputIomuxXbarInout17;
			break;
		default:
			break;
	}
	
  outx=output&0XFF;																		//�õ�������XBARA_OUT���. 
	if(outx>3&&outx<20)
		IOMUXC_GPR->GPR6|=1<<(12+outx);										//GPIO�����,�����ö�Ӧ��I0Ϊ���ģʽ

	XBARA_Init(XBARA1);                                 //��ʼ��XBARA1
	XBARA_SetSignalsConnection(XBARA1,input,output);    //����������������
}

void XBAR1_Init(uint8_t inpin,uint8_t outpin)
{
	QTMR_PWM_Init(inpin,14,5000,0);											//��ʼ��TIMER
	Pin_Timer_Init(outpin);															//��ʼ���ܽ����
	
	XBARA1_Signal_Set(inpin,outpin);   									//QTMR4_CH0�����XBARA1_INOUT17����.
}

