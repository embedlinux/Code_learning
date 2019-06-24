#include "exit.h"

void Ext_Init(void)
{
	//SNVS_WAKEUP 配置为 ALT5,即 GPIO5_00
	IOMUXC_SetPinMux(IOMUXC_SNVS_WAKEUP_GPIO5_IO00,0);
	
	//低转换速度,关闭输出驱动,速度为 100Mhz，关闭开路功能，使能 pull/keepr
	//选择 pull 功能，上拉 22K Ohm，关闭 Hyst
	IOMUXC_SetPinConfig(IOMUXC_SNVS_WAKEUP_GPIO5_IO00,0xF080);
	
	//输入，默认高电平，下降沿触发
	gpio_pin_config_t exit_gpio={kGPIO_DigitalInput,1,kGPIO_IntRisingOrFallingEdge};
	GPIO_PinInit(GPIO5,0,&exit_gpio);
	
	GPIO_PortEnableInterrupts(GPIO5,1<<0); 						//GPIO5_00 中断使能
	RT1064_NVIC_SetPriority(GPIO5_Combined_0_15_IRQn,3,0);  	//抢占优先级位 3，0 位子优先级
	EnableIRQ(GPIO5_Combined_0_15_IRQn);  						//使能 GPIO5_0~15IO 的中断
}

void GPIO5_Combined_0_15_IRQHandler(void)
{
	if(GPIO_GetPinsInterruptFlags(GPIO5)&(1<<0))    //判断是否为GPIO5_0中断
	{
		if(GPIO_PinRead(GPIO5,0)==0)
		{
			GPIO_PinWrite(GPIO1,9,0U);
		}
		else
		{
			GPIO_PinWrite(GPIO1,9,1U);
		}
	}
	GPIO_PortClearInterruptFlags(GPIO5,1<<0);		//清除中断标志位
	__DSB(); 										//数据同步屏蔽指令
	
}
