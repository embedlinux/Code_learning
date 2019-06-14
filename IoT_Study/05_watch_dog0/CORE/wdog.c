#include "wdog.h"

wdog_config_t wdog1_config; //WDOG���ýṹ��

void WDOG1_Init(uint16_t wdgtimeout, uint16_t inttimeout)
{
	CLOCK_EnableClock(kCLOCK_Wdog1);		//ʹ�ܿ��Ź�ʱ��
	
	WDOG_GetDefaultConfig(&wdog1_config);   //�Ƚ�WDOG1����ΪĬ��ֵ
	
	wdog1_config.workMode.enableDebug = false;     	//�ر�debugģʽ
	wdog1_config.workMode.enableStop = false;		//�ر�stopģʽ
	wdog1_config.workMode.enableWait = false;		//�رյȴ�ģʽ
	wdog1_config.timeoutValue = wdgtimeout;			//��ʱʱ��(wdgtimeout + 1) *0.5
	wdog1_config.interruptTimeValue = inttimeout;	//wdog��ʱǰ��������ж�? inttimeout*0.5
	
	wdog1_config.enableInterrupt = true;			//ʹ���ж�
	wdog1_config.enableWdog = true;					//ʹ�ܿ��Ź�
	WDOG_Init(WDOG1,&wdog1_config);
	
	RT1064_NVIC_SetPriority(WDOG1_IRQn,4,0);		//��ռ���ȼ�4�������ȼ�0
	EnableIRQ(WDOG1_IRQn);							//ʹ��WDOG1�ж�
	
}

//ι��
void WDOG1_Feed(void)
{  
	WDOG_Refresh(WDOG1);//��װ��	
}

//���Ź��жϷ�����
void WDOG1_IRQHandler(void)
{
	static uint8_t ledflag =1;
	if(WDOG_GetStatusFlags(WDOG1) & kWDOG_InterruptFlag)		//��ʱҪ����
	{
		WDOG1_Feed();											//ι��
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
	WDOG_ClearInterruptStatus(WDOG1,kWDOG_InterruptFlag);		//����жϱ�־
	__DSB();				//����ͬ������ָ��
}


