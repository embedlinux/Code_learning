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
#include "fsl_pit.h"
#include "fsl_qtmr.h"

void GPT1_Init(uint16_t divi,uint32_t value);
void PIT1_Init(uint32_t count);
void Qtimer1_Init(uint16_t ticks);
void QTMER4CH3_PWM_DutySet(uint8_t prisrc,uint32_t clk, uint8_t duty);
void QTMR4_CH3_PWM_Init(uint8_t prisrc,uint32_t clk,uint8_t duty);
uint8_t Calcu_2invo(uint8_t time);
#endif
