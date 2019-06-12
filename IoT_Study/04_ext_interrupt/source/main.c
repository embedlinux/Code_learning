#include "led.h"
#include "delay.h"
#include "uart.h"
#include "exit.h"

int main()
{
	BOARD_BootClockRUN();	//����ϵͳʱ��
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
	Clock_Init();			//ʹ��ʱ����ʱ
	Lpuart1_Init(115200);
	Led_Init();				//��ʼ��LED
	Ext_Init();				//���ð���Ϊ�ⲿ�ж�
	
	while(1)
	{
		printf("Int example driver!\r\n");
		SysTick_DelayTicks(2000);
	}
	
	
}
