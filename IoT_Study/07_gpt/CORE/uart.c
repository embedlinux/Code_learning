#include "uart.h"

static lpuart_config_t lpuart1_config;


//加入以下代码,支持printf函数,而不需要选择use MicroLIB	  
//#define PUTCHAR_PROTOTYPE int fputc(int ch, FILE *f)	
#if 1
//#pragma import(__use_no_semihosting)             
//标准库需要的支持函数                 
struct __FILE 
{ 
	int handle; 
}; 

FILE __stdout;       
//定义_sys_exit()以避免使用半主机模式    
void _sys_exit(int x) 
{ 
	x = x; 
} 
//重定义fputc函数 
int fputc(int ch, FILE *f)
{ 	
	while((LPUART1->STAT&LPUART_STAT_TDRE_MASK)==0);
	LPUART1->DATA=(uint8_t)ch;	
	
	return ch;
}
#endif 

#if EN_LPUART1_RX					   		//如果使能了接收,则编译以下代码
//串口1中断服务程序  	
uint8_t LPUART_RX_BUF[LPUART_REC_LEN];     	//接收缓冲,最大LPUART_REC_LEN个字节.
//接收状态
//bit15，	接收完成标志
//bit14，	接收到0x0d
//bit13~0，	接收到的有效字节数目
uint16_t LPUART_RX_STA=0;       					//接收状态标记

//LPUART1中断服务函数，为了接收效率直接操作寄存器
/*
当接收到从电脑发过来的数据，把接收到的数据保存在 LPUART_RX_BUF 中，同时在接
收状态寄存器（LPUART_RX_STA）中计数接收到的有效数据个数，当收到回车（回车的表示
由2个字节组成：0X0D和0X0A）的第一个字节0X0D时，计数器将不再增加，等待0X0A的
到来，而如果0X0A没有来到，则认为这次接收失败，重新开始下一次接收。如果顺利接收到
0X0A，则标记 LPUART_RX_STA 的第15位，这样完成一次接收，并等待该位被其他程序清
除，从而开始下一次的接收，而如果迟迟没有收到0X0D，那么在接收数据超过
LPUART_REC_LEN的时候，则会丢弃前面的数据，重新接收。

*/
void LPUART1_IRQHandler(void)
{
	uint8_t res=0;
	
	if((LPUART1->STAT)&kLPUART_RxDataRegFullFlag) 	//接收中断
	{
		res=LPUART1->DATA;							//读取数据
		if((LPUART_RX_STA&0x8000)==0)				//接收未完成
		{
			if(LPUART_RX_STA&0x4000)				//接收到了0x0d
			{
				if(res!=0x0a)
					LPUART_RX_STA=0;				//接收错误,重新开始
				else 
					LPUART_RX_STA|=0x8000;			//接收完成了 
			}
			else 									//还没收到0X0D
			{	
				if(res==0x0d)
					LPUART_RX_STA|=0x4000;
				else
				{
					LPUART_RX_BUF[LPUART_RX_STA&0X3FFF]=res ;
					LPUART_RX_STA++;
					if(LPUART_RX_STA>(LPUART_REC_LEN-1))
						LPUART_RX_STA=0;			//接收数据错误,重新开始接收	  
				}		 
			}
		} 
	}
	__DSB();										//数据同步屏蔽指令
}
#endif

//获取LPUART的时钟源频率，我们前面设置的是80MHz
//返回值：LPUART时钟源频率,根据我们的只是一般是80Mhz
uint32_t LPUART_SrcFreqGet(void)
{
    uint32_t freq;
	
    if(CLOCK_GetMux(kCLOCK_UartMux)==0) 		//LPUART的时钟源选择PLL3/6
    {
        freq=(CLOCK_GetPllFreq(kCLOCK_PllUsb1)/6U)/(CLOCK_GetDiv(kCLOCK_UartDiv)+1U);
    }
    else										//LPUART的时钟源选择OSC
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
prioritygroup=NVIC_GetPriorityGrouping();  //获取当前中断优先级分组
NVIC_SetPriority(IRQn,NVIC_EncodePriority(prioritygroup,prep,subp)); //设置优先级
	
}

void Lpuart1_Init(uint32_t bound)
{
	BOARD_BootClockRUN();
	SystemCoreClockUpdate();
	uint32_t freq = 0;		 			 //串口时钟频率
	
	CLOCK_EnableClock(kCLOCK_Lpuart1);   //使能LPUART1时钟
	CLOCK_SetMux(kCLOCK_UartMux,0);      //设置时钟源
	CLOCK_SetDiv(kCLOCK_UartDiv,0);		 //设置UART时钟为80M
	
	//GPIO_AD_B0_12 设置为 LPUART1_TX
	//GPIO_AD_B0_13 设置为 LPUART1_RX
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B0_12_LPUART1_TX,0U);
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B0_13_LPUART1_RX,0U);

	//配置串口属性
	//低转换速度,驱动能力为 R0/6,速度为 100Mhz，关闭开路功能，使能 pull/keepr
	//选择 keeper 功能，下拉 100K Ohm，关闭 Hyst
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B0_12_LPUART1_TX,0x10B0u);
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B0_13_LPUART1_RX,0x10B0u);
	
	//获取串口时钟频率，80MB
	freq=LPUART_SrcFreqGet();
	
	LPUART_GetDefaultConfig(&lpuart1_config); 			//先设置为默认配置
	
	lpuart1_config.baudRate_Bps=bound; 					//波特率
	lpuart1_config.dataBitsCount=kLPUART_EightDataBits; //8 位
	lpuart1_config.stopBitCount=kLPUART_OneStopBit; 	//1 位停止位
	lpuart1_config.parityMode=kLPUART_ParityDisabled;  	//无奇偶校验
	lpuart1_config.enableRx=true;  						//使能接收
	lpuart1_config.enableTx=true;  						//使能发送

	LPUART_Init(LPUART1,&lpuart1_config,freq); 			//初始化 LPUART1
	
	//LPUART 中断设置
#if EN_LPUART1_RX
	LPUART_EnableInterrupts(LPUART1,kLPUART_RxDataRegFullInterruptEnable);
	RT1064_NVIC_SetPriority(LPUART1_IRQn,5,0);  		//抢占优先级 5，子优先级 0
	EnableIRQ(LPUART1_IRQn);  							//使能 LPUART1 中断
#endif
	
}

