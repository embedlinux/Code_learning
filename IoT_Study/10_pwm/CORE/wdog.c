#include "wdog.h"

wdog_config_t wdog1_config; 			//WDOG���ýṹ��
rtwdog_config_t rtdog_config;  		//RTWDOG���ýṹ��
rtwdog_clock_prescaler_t prescal;	//RTWDOG�Ƿ��Ƶ

void WDOG1_Init(uint16_t wdgtimeout, uint16_t inttimeout)
{
	CLOCK_EnableClock(kCLOCK_Wdog1);				//ʹ�ܿ��Ź�ʱ��
	
	WDOG_GetDefaultConfig(&wdog1_config);   //�Ƚ�WDOG1����ΪĬ��ֵ
	
	wdog1_config.workMode.enableDebug = false;     	//�ر�debugģʽ
	wdog1_config.workMode.enableStop = false;				//�ر�stopģʽ
	wdog1_config.workMode.enableWait = false;				//�رյȴ�ģʽ
	wdog1_config.timeoutValue = wdgtimeout;					//��ʱʱ��(wdgtimeout + 1) *0.5
	wdog1_config.interruptTimeValue = inttimeout;		//wdog��ʱǰ��������ж�? inttimeout*0.5
	wdog1_config.enableInterrupt = true;						//ʹ���ж�
	wdog1_config.enableWdog = true;									//ʹ�ܿ��Ź�
	WDOG_Init(WDOG1,&wdog1_config);
	
	RT1064_NVIC_SetPriority(WDOG1_IRQn,4,0);		//��ռ���ȼ�4�������ȼ�0
	EnableIRQ(WDOG1_IRQn);											//ʹ��WDOG1�ж�
	
}

//ι��
void WDOG1_Feed(void)
{  
	WDOG_Refresh(WDOG1);//��װ��	
}

//ι��
void RTWDOG_Feed(void)
{
	RTWDOG_Refresh(RTWDOG);
}


//���Ź��жϷ�����
void WDOG1_IRQHandler(void)
{
//	static uint8_t ledflag =1;
	if(WDOG_GetStatusFlags(WDOG1) & kWDOG_InterruptFlag)		//��ʱҪ����
	{
		WDOG1_Feed();											//ι��
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
	WDOG_ClearInterruptStatus(WDOG1,kWDOG_InterruptFlag);		//����жϱ�־
	__DSB();																								//����ͬ������ָ��
}

void WDOG3_Init(uint8_t pscen,uint16_t toval)			
{
	CLOCK_EnableClock(kCLOCK_Wdog3);												//ʹ�ܿ��Ź�ʱ��
	
	if(pscen == 1)
		prescal = kRTWDOG_ClockPrescalerDivide256;
	else
		prescal = kRTWDOG_ClockPrescalerDivide1;
	
	SysTick_DelayTicks(20);															//�л�ʱ��ǰҪ�ȴ�һ��ʱ��
	RTWDOG_GetDefaultConfig(&rtdog_config);
	
	rtdog_config.enableRtwdog = true;
	rtdog_config.clockSource = kRTWDOG_ClockSource1;		//ʱ��Դ��LPO_CLK          32.768Khz
	rtdog_config.prescaler = prescal;                   //Trtwdog=TOVAL/Frtwdog;   ��ʱʱ��   tRtwdog = 32.768kHZ/32768 = 1m���
	rtdog_config.testMode = kRTWDOG_UserModeEnabled;
	rtdog_config.enableInterrupt = false;
	rtdog_config.enableWindowMode = false;
	rtdog_config.timeoutValue = toval;

	RTWDOG_Init(RTWDOG,&rtdog_config);  //��ʼ�����Ź�
	
	RT1064_NVIC_SetPriority(RTWDOG_IRQn,4,0);  //��ռ���ȼ� 4�������ȼ� 0
	EnableIRQ(RTWDOG_IRQn); //ʹ�� RTWDOG �ж�
}

void RTWDOG_IRQHandler(void)
{
	if(RTWDOG_GetStatusFlags(RTWDOG) & kRTWDOG_InterruptFlag)		//��ʱҪ����
	;																														//�޷�ι������Ϊ������255���������ڣ�Լ 1.7us��������ɣ�����ι��������ִ�г��� 1.7us��
	RTWDOG_ClearStatusFlags(RTWDOG,kRTWDOG_InterruptFlag);			//����ն�
}




