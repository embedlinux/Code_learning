#include "key.h"


void Init_Key(void)
{
	gpio_pin_config_t key_config = {kGPIO_DigitalInput, 1,kGPIO_NoIntmode };
	
	//SNVS_WAKEUP ����Ϊ ALT5,�� GPIO5_00
	IOMUXC_SetPinMux(IOMUXC_SNVS_WAKEUP_GPIO5_IO00,0);
	
	//��ת���ٶ�,�ر��������,�ٶ�Ϊ 100Mhz���رտ�·���ܣ�ʹ�� pull/keepr
	//ѡ�� pull ���ܣ����� 22K Ohm���ر� Hyst
	IOMUXC_SetPinConfig(IOMUXC_SNVS_WAKEUP_GPIO5_IO00,0xF080);

	GPIO_PinInit(GPIO5,0,&key_config);
}

uint8_t Key_Scan(uint8_t mode)
{
	uint8_t key_up = 1;  //�ɿ�
	
	if(1 == mode)
		key_up = 1;
	if(key_up && (WK_UP==0))
	{
		SysTick_DelayTicks(10);
		key_up = 0;
		if(WK_UP == 0)
			return WKUP_PRES;
	}
	else if(WK_UP == 1)
	{
		key_up = 1;
	}
	return 0;
}

