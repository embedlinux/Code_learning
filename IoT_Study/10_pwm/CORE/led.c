#include "led.h"


void Led_Init(void)
{
	gpio_pin_config_t led_config = {kGPIO_DigitalOutput, 0,kGPIO_NoIntmode};
	
//	CLOCK_EnableClock(kCLOCK_Iomuxc);  
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B0_09_GPIO1_IO09,0);
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B0_09_GPIO1_IO09,0x10B0u);
	
	
	GPIO_PinInit(GPIO1,9, &led_config);
	GPIO_PinWrite(GPIO1,9,1U);
}

//TIMER3,3
void Pin_B1_03_Init(void)
{
	gpio_pin_config_t pwm_config = {kGPIO_DigitalOutput, 1,kGPIO_NoIntmode};
	
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B1_03_QTIMER3_TIMER3,0U);
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B1_03_QTIMER3_TIMER3,0x10B0u);
	
	GPIO_PinInit(GPIO1,19,&pwm_config);
}

//TIMER3,0
void Pin_B1_00_Init(void)
{
	gpio_pin_config_t pwm_config = {kGPIO_DigitalOutput,1,kGPIO_NoIntmode};
	
	IOMUXC_SetPinMux(IOMUXC_GPIO_AD_B1_00_QTIMER3_TIMER0,0U);
	IOMUXC_SetPinConfig(IOMUXC_GPIO_AD_B1_00_QTIMER3_TIMER0,0x10B0u);
	
	GPIO_PinInit(GPIO1,16,&pwm_config);
}
