#ifndef __WDOG_H
#define __WDOG_H
#include "fsl_gpio.h"
#include "fsl_iomuxc.h"
#include "clock_config.h"
#include "system_MIMXRT1064.h"
#include "delay.h"
#include "fsl_wdog.h"
#include "uart.h"
#include "led.h"
#include "fsl_rtwdog.h"

void WDOG1_Init(uint16_t wdgtimeout, uint16_t inttimeout);
void WDOG1_Feed(void);
void RTWDOG_Feed(void);
void WDOG3_Init(uint8_t pscen,uint16_t toval);

#endif
