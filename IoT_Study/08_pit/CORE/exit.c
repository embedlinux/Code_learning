#include "exit.h"

void Ext_Init(void)
{
	//SNVS_WAKEUP ����Ϊ ALT5,�� GPIO5_00
	IOMUXC_SetPinMux(IOMUXC_SNVS_WAKEUP_GPIO5_IO00,0);
	
	//��ת���ٶ�,�ر��������,�ٶ�Ϊ 100Mhz���رտ�·���ܣ�ʹ�� pull/keepr
	//ѡ�� pull ���ܣ����� 22K Ohm���ر� Hyst
	IOMUXC_SetPinConfig(IOMUXC_SNVS_WAKEUP_GPIO5_IO00,0xF080);
	
	//���룬Ĭ�ϸߵ�ƽ���½��ش���
	gpio_pin_config_t exit_gpio={kGPIO_DigitalInput,1,kGPIO_IntRisingOrFallingEdge};
	GPIO_PinInit(GPIO5,0,&exit_gpio);
	
	GPIO_PortEnableInterrupts(GPIO5,1<<0); 						//GPIO5_00 �ж�ʹ��
	RT1064_NVIC_SetPriority(GPIO5_Combined_0_15_IRQn,3,0);  	//��ռ���ȼ�λ 3��0 λ�����ȼ�
	EnableIRQ(GPIO5_Combined_0_15_IRQn);  						//ʹ�� GPIO5_0~15IO ���ж�
}

void GPIO5_Combined_0_15_IRQHandler(void)
{
	if(GPIO_GetPinsInterruptFlags(GPIO5)&(1<<0))    //�ж��Ƿ�ΪGPIO5_0�ж�
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
	GPIO_PortClearInterruptFlags(GPIO5,1<<0);		//����жϱ�־λ
	__DSB(); 										//����ͬ������ָ��
	
}
