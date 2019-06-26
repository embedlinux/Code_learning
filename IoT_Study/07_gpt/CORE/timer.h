#ifndef __TIMER_H
#define __TIMER_H

#include "fsl_gpio.h"
#include "fsl_iomuxc.h"
#include "clock_config.h"
#include "system_MIMXRT1064.h"
#include "delay.h"
#include "uart.h"
#include "led.h"
#include "fsl_gpt.h"

void GPT1_Init(uint16_t divi,uint32_t value);




#endif
