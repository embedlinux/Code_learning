#include "led.h"
#include "delay.h"
#include "uart.h"
#include "exit.h"
#include "wdog.h"

int main()
{
	BOARD_BootClockRUN();	//����ϵͳʱ��
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
	Clock_Init();			//ʹ��ʱ����ʱ
	Lpuart1_Init(115200);
	Led_Init();				//��ʼ��LED
	Ext_Init();				//���ð���Ϊ�ⲿ�ж�
	WDOG1_Init(3,2);		//��ʼ�����Ź�1,2�����,��ǰ1������ж�,����ι��
	
	
	while(1)
	{
		printf("Int example driver!\r\n");
		SysTick_DelayTicks(2000);
	}
}
