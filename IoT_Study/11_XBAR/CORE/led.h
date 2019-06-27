#ifndef __LED_H__
#define __LED_H__
#include "fsl_gpio.h"
#include "fsl_iomuxc.h"
#include "clock_config.h"
#include "system_MIMXRT1064.h"
#include "delay.h"


void Led_Init(void);
void Pin_B1_03_Init(void); 
void Pin_B1_00_Init(void);
void Pin_Timer_Init(uint8_t pin);

#endif
