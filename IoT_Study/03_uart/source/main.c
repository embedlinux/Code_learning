#include "led.h"
#include "delay.h"
#include "key.h"
#include "uart.h"

int main()
{
	uint16_t times = 0;
	uint8_t len = 0;
	Clock_Init();						//初始化时钟中断
	RT1064_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);//优先级分组4
	lpuart1_init(115200);				//设置串口
	
	while(1)
	{	
		if(LPUART_RX_STA&0x8000)
		{ 
			len=LPUART_RX_STA&0x3fff; 						  //得到此次接收到的数据长度
			printf("\r\n 您发送的消息为:\r\n");
			LPUART_WriteBlocking(LPUART1,LPUART_RX_BUF,len);  //发送接收到的数据
			printf("\r\n\r\n");				//插入换行
			LPUART_RX_STA=0;
		}else
		{
			times++;
			if(times%500==0)
			{
				printf("\r\nALIENTEK RT1052 开发板 串口实验\r\n");
				printf("正点原子@ALIENTEK\r\n");
			}
			if(times%200==0)
				printf("请输入数据,以回车键结束\r\n");
				SysTick_DelayTicks(10);
		}
	}	
}
