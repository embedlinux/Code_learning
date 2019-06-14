#ifndef __UART_H
#define __UART_H

#include "fsl_common.h"
#include "fsl_clock.h"
#include "fsl_iomuxc.h"
#include "fsl_lpuart.h"
#include "core_cm7.h"
#include "stdio.h"
#include "clock_config.h"


#define LPUART_REC_LEN          200  	//�����������ֽ��� 200
#define EN_LPUART1_RX 			1		//ʹ�ܣ�1��/��ֹ��0������1����

//�ж��������
#define NVIC_PRIORITYGROUP_0   	((uint8_t)0x7)                                                               
#define NVIC_PRIORITYGROUP_1	((uint8_t)0x6)
#define NVIC_PRIORITYGROUP_2   	((uint8_t)0x5)
#define NVIC_PRIORITYGROUP_3   	((uint8_t)0x4) 
#define NVIC_PRIORITYGROUP_4   	((uint8_t)0x3) 
	  	
extern uint8_t  LPUART_RX_BUF[LPUART_REC_LEN]; //���ջ���,���LPUART_REC_LEN���ֽ�.ĩ�ֽ�Ϊ���з� 
extern uint16_t LPUART_RX_STA;         		  //����״̬���	

uint32_t LPUART_SrcFreqGet(void);
void RT1064_NVIC_SetPriorityGrouping(uint32_t PriorityGroup);
void RT1064_NVIC_SetPriority(IRQn_Type IRQn,uint32_t prep,uint32_t subp);
void Lpuart1_Init(uint32_t bound);



#endif
