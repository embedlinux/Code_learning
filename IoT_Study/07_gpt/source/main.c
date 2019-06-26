#include "led.h"
#include "delay.h"
#include "uart.h"
#include "exit.h"
#include "wdog.h"
#include "timer.h"

int main()
{
	BOARD_BootClockRUN();						//����ϵͳʱ��
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
	Clock_Init();								//ʹ��ʱ����ʱ
	Lpuart1_Init(115200);
	Led_Init();									//��ʼ��LED
	Ext_Init();									//���ð���Ϊ�ⲿ�ж�
	WDOG1_Init(3,2);							//��ʼ�����Ź�1,2�����,��ǰ1������ж�,����ι��
//	WDOG3_Init(0 ,32768);						//1�볬ʱʱ��
	GPT1_Init(3750-1,10000);					//����GPT1 0.5���Ӳ���һ���ж�
	
	while(1)
	{
		printf("Int example driver!\r\n");
		SysTick_DelayTicks(500);
//		RTWDOG_Feed();							//ι��RTWDOG
	}
}
