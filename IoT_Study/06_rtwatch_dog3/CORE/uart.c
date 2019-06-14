#include "uart.h"

static lpuart_config_t lpuart1_config;


//�������´���,֧��printf����,������Ҫѡ��use MicroLIB	  
//#define PUTCHAR_PROTOTYPE int fputc(int ch, FILE *f)	
#if 1
//#pragma import(__use_no_semihosting)             
//��׼����Ҫ��֧�ֺ���                 
struct __FILE 
{ 
	int handle; 
}; 

FILE __stdout;       
//����_sys_exit()�Ա���ʹ�ð�����ģʽ    
void _sys_exit(int x) 
{ 
	x = x; 
} 
//�ض���fputc���� 
int fputc(int ch, FILE *f)
{ 	
	while((LPUART1->STAT&LPUART_STAT_TDRE_MASK)==0);
	LPUART1->DATA=(uint8_t)ch;	
	
	return ch;
}
#endif 

#if EN_LPUART1_RX					   		//���ʹ���˽���,��������´���
//����1�жϷ������  	
uint8_t LPUART_RX_BUF[LPUART_REC_LEN];     	//���ջ���,���LPUART_REC_LEN���ֽ�.
//����״̬
//bit15��	������ɱ�־
//bit14��	���յ�0x0d
//bit13~0��	���յ�����Ч�ֽ���Ŀ
uint16_t LPUART_RX_STA=0;       					//����״̬���

//LPUART1�жϷ�������Ϊ�˽���Ч��ֱ�Ӳ����Ĵ���
/*
�����յ��ӵ��Է����������ݣ��ѽ��յ������ݱ����� LPUART_RX_BUF �У�ͬʱ�ڽ�
��״̬�Ĵ�����LPUART_RX_STA���м������յ�����Ч���ݸ��������յ��س����س��ı�ʾ
��2���ֽ���ɣ�0X0D��0X0A���ĵ�һ���ֽ�0X0Dʱ�����������������ӣ��ȴ�0X0A��
�����������0X0Aû������������Ϊ��ν���ʧ�ܣ����¿�ʼ��һ�ν��ա����˳�����յ�
0X0A������ LPUART_RX_STA �ĵ�15λ���������һ�ν��գ����ȴ���λ������������
�����Ӷ���ʼ��һ�εĽ��գ�������ٳ�û���յ�0X0D����ô�ڽ������ݳ���
LPUART_REC_LEN��ʱ����ᶪ��ǰ������ݣ����½��ա�

*/
void LPUART1_IRQHandler(void)
{
	uint8_t res=0;
	
	if((LPUART1->STAT)&kLPUART_RxDataRegFullFlag) 	//�����ж�
	{
		res=LPUART1->DATA;							//��ȡ����
		if((LPUART_RX_STA&0x8000)==0)				//����δ���
		{
			if(LPUART_RX_STA&0x4000)				//���յ���0x0d
			{
				if(res!=0x0a)
					LPUART_RX_STA=0;				//���մ���,���¿�ʼ
				else 
					LPUART_RX_STA|=0x8000;			//��������� 
			}
			else 									//��û�յ�0X0D
			{	
				if(res==0x0d)
					LPUART_RX_STA|=0x4000;
				else
				{
					LPUART_RX_BUF[LPUART_RX_STA&0X3FFF]=res ;
					LPUART_RX_STA++;
					if(LPUART_RX_STA>(LPUART_REC_LEN-1))
						LPUART_RX_STA=0;			//�������ݴ���,���¿�ʼ����	  
				}		 
			}
		} 
	}
	__DSB();										//����ͬ������ָ��
}
#endif

//��ȡLPUART��ʱ��ԴƵ�ʣ�����ǰ�����õ���80MHz
//����ֵ��LPUARTʱ��ԴƵ��,�������ǵ�ֻ��һ����80Mhz
uint32_t LPUART_SrcFreqGet(void)
{
    uint32_t freq;
	
    if(CLOCK_GetMux(kCLOCK_UartMux)==0) 		//LPUART��ʱ��Դѡ��PLL3/6
    {
        freq=(CLOCK_GetPllFreq(kCLOCK_PllUsb1)/6U)/(CLOCK_GetDiv(kCLOCK_UartDiv)+1U);
    }
    else										//LPUART��ʱ��Դѡ��OSC
    {
        freq=CLOCK_GetOscFreq()/(CLOCK_GetDiv(kCLOCK_UartDiv)+1U);
    }
    return freq;
}


void RT1064_NVIC_SetPriorityGrouping(uint32_t PriorityGroup)
{
	NVIC_SetPriorityGrouping(PriorityGroup);
}

void RT1064_NVIC_SetPriority(IRQn_Type IRQn,uint32_t prep,uint32_t subp)
{
uint32_t prioritygroup = 0x00;
prioritygroup=NVIC_GetPriorityGrouping();  //��ȡ��ǰ�ж����ȼ�����
NVIC_SetPriority(IRQn,NVIC_EncodePriority(prioritygroup,prep,subp)); //�������ȼ�
	
}

void Lpuart1_Init(uint32_t bound)
{
	BOARD_BootClockRUN();
	SystemCoreClockUpdate();
	uint32_t freq = 0;		 			 //����ʱ��Ƶ��
	
	CLOCK_EnableClock(kCLOCK_Lpuart1);   //ʹ��LPUART1ʱ��
	CLOCK_SetMux(kCLOCK_UartMux,0);      //����ʱ��Դ
	CLOCK_SetDiv(kCLOCK_UartDiv,0);		 //����UARTʱ��Ϊ80M
	
	//GPIO_AD_B0_12 ����Ϊ LPUART1_TX
	//GPIO_AD_B0_13 ����Ϊ LPUART1_RX
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B0_12_LPUART1_TX,0U);
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B0_13_LPUART1_RX,0U);

	//���ô�������
	//��ת���ٶ�,��������Ϊ R0/6,�ٶ�Ϊ 100Mhz���رտ�·���ܣ�ʹ�� pull/keepr
	//ѡ�� keeper ���ܣ����� 100K Ohm���ر� Hyst
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B0_12_LPUART1_TX,0x10B0u);
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B0_13_LPUART1_RX,0x10B0u);
	
	//��ȡ����ʱ��Ƶ�ʣ�80MB
	freq=LPUART_SrcFreqGet();
	
	LPUART_GetDefaultConfig(&lpuart1_config); 			//������ΪĬ������
	
	lpuart1_config.baudRate_Bps=bound; 					//������
	lpuart1_config.dataBitsCount=kLPUART_EightDataBits; //8 λ
	lpuart1_config.stopBitCount=kLPUART_OneStopBit; 	//1 λֹͣλ
	lpuart1_config.parityMode=kLPUART_ParityDisabled;  	//����żУ��
	lpuart1_config.enableRx=true;  						//ʹ�ܽ���
	lpuart1_config.enableTx=true;  						//ʹ�ܷ���

	LPUART_Init(LPUART1,&lpuart1_config,freq); 			//��ʼ�� LPUART1
	
	//LPUART �ж�����
#if EN_LPUART1_RX
	LPUART_EnableInterrupts(LPUART1,kLPUART_RxDataRegFullInterruptEnable);
	RT1064_NVIC_SetPriority(LPUART1_IRQn,5,0);  		//��ռ���ȼ� 5�������ȼ� 0
	EnableIRQ(LPUART1_IRQn);  							//ʹ�� LPUART1 �ж�
#endif
	
}

