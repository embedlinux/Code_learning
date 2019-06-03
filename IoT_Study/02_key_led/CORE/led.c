#include "led.h"


void Init_Led(void)
{
	gpio_pin_config_t led_config = {kGPIO_DigitalOutput, 0,kGPIO_NoIntmode,};
	
//	CLOCK_EnableClock(kCLOCK_Iomuxc);  
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B0_09_GPIO1_IO09,0);
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B0_09_GPIO1_IO09,0x10B0u);
	
	BOARD_BootClockRUN();
	SystemCoreClockUpdate();
	
	GPIO_PinInit(GPIO1,9, &led_config);
	
	GPIO_PinWrite(GPIO1,9,1);

}
