#include "led.h"
#include "delay.h"
#include "key.h"
#include "uart.h"

int main()
{
	uint16_t times = 0;
	uint8_t len = 0;
	Clock_Init();						//��ʼ��ʱ���ж�
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);//���ȼ�����4
	lpuart1_init(115200);				//���ô���
	
	while(1)
	{	
		if(LPUART_RX_STA&0x8000)
		{ 
			len=LPUART_RX_STA&0x3fff; 						  //�õ��˴ν��յ������ݳ���
			printf("\r\n �����͵���ϢΪ:\r\n");
			LPUART_WriteBlocking(LPUART1,LPUART_RX_BUF,len);  //���ͽ��յ�������
			printf("\r\n\r\n");				//���뻻��
			LPUART_RX_STA=0;
		}else
		{
			times++;
			if(times%500==0)
			{
				printf("\r\nALIENTEK RT1052 ������ ����ʵ��\r\n");
				printf("����ԭ��@ALIENTEK\r\n");
			}
			if(times%200==0)
				printf("����������,�Իس�������\r\n");
				SysTick_DelayTicks(10);
		}
	}	
}
