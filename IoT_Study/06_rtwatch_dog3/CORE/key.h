#ifndef __KEY_H__
#define __KEY_H__

#include "fsl_gpio.h"
#include "fsl_iomuxc.h"
#include "clock_config.h"
#include "system_MIMXRT1064.h"
#include "delay.h"

#define WK_UP GPIO_PinRead(GPIO5,0) //WK_UP 按键 GPIO5_00
#define WKUP_PRES 1                 //WKUP 按下后返回值

void Init_Key(void);
uint8_t Key_Scan(uint8_t mode);

#endif
