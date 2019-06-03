#include "led.h"
#include "delay.h"
#include "key.h"

int main()
{
	uint8_t key_value = 0;
	Clock_Init();
	Init_Led();
	Init_Key();
	
	while(1)
	{
		key_value = Key_Scan(0);
		if(key_value == WKUP_PRES)
			 GPIO_PinWrite(GPIO1,9,0);
		else
			 GPIO_PinWrite(GPIO1,9,1);
	}
}
