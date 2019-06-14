#ifndef __UART_H
#define __UART_H

#include "fsl_common.h"
#include "fsl_clock.h"
#include "fsl_iomuxc.h"
#include "fsl_lpuart.h"
#include "core_cm7.h"
#include "stdio.h"
#include "clock_config.h"


#define LPUART_REC_LEN          200  	//定义最大接收字节数 200
#define EN_LPUART1_RX 			1		//使能（1）/禁止（0）串口1接收

//中断相关配置
#define NVIC_PRIORITYGROUP_0   	((uint8_t)0x7)                                                               
#define NVIC_PRIORITYGROUP_1	((uint8_t)0x6)
#define NVIC_PRIORITYGROUP_2   	((uint8_t)0x5)
#define NVIC_PRIORITYGROUP_3   	((uint8_t)0x4) 
#define NVIC_PRIORITYGROUP_4   	((uint8_t)0x3) 
	  	
extern uint8_t  LPUART_RX_BUF[LPUART_REC_LEN]; //接收缓冲,最大LPUART_REC_LEN个字节.末字节为换行符 
extern uint16_t LPUART_RX_STA;         		  //接收状态标记	

uint32_t LPUART_SrcFreqGet(void);
void RT1064_NVIC_SetPriorityGrouping(uint32_t PriorityGroup);
void RT1064_NVIC_SetPriority(IRQn_Type IRQn,uint32_t prep,uint32_t subp);
void Lpuart1_Init(uint32_t bound);



#endif
