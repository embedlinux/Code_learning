#ifndef _DELAY_H
#define _DELAY_H

#include "clock_config.h"

void SysTick_DelayTicks(uint32_t n);
void SysTick_Handler(void);
void Clock_Init(void);

#endif

