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
	BOARD_BootClockRUN();						//����ϵͳʱ��
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
	Clock_Init();								//ʹ��ʱ����ʱ
	Lpuart1_Init(115200);
	Led_Init();									//��ʼ��LED
	Ext_Init();									//���ð���Ϊ�ⲿ�ж�
	WDOG1_Init(3,2);							//��ʼ�����Ź�1,2�����,��ǰ1������ж�,����ι��
//	WDOG3_Init(0 ,32768);						//1�볬ʱʱ��
//	GPT1_Init(3750-1,10000);					//����GPT1 0.5���Ӳ���һ���ж�
	PIT1_Init(75000000*2);						//75Mhz, 75000000*2, 2�����һ���ж�
	Qtimer1_Init(46875);						//150Mhz/128 = 1171875Hz
	//��ʼ��PWM����ʱ��ʱ��Ϊ��150/64=2.34375Mhz������Ƶ��Ϊ5Khz,50%ռ�ձ�
	QTMR4_CH3_PWM_Init(14,5000,0);	 			//GPIO_B1_11,pwm�����û�и�����
	while(1)
	{
		printf("Int example driver!\r\n");
		SysTick_DelayTicks(10);				//��ʱһ��
		if(dir)
			led1pwmval++;
		else
			led1pwmval--;	 
 		if(led1pwmval>=100)
			dir=0;
		if(led1pwmval==0)
			dir=1;	 
        QTMER4CH3_PWM_DutySet(14,5000,led1pwmval);   
		
//		RTWDOG_Feed();							//ι��RTWDOG
	}
}
