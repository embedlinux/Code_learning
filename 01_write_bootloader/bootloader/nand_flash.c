#include "s3c2440_soc.h"


void nand_init()
{
	#define TACLS     0
	#define TWRPH0    1
	#define TWRPH1	  0

	NFCONF = (TACLS<<12) | (TWRPH0<<8) | (TWRPH1<<4);

	NFCONT = (1<<4) | (1<<1) | (1<<0);
}

int isbootnor()
{
	int ret = 1;
	volatile int* p = (volatile int*)0;

	int value = *p;

	*p = 0x12345678;

	if(value == *p)    //从nand启动
	{
		*p = value;
		ret = 0;
		return ret;
	}
	else    //从nor启动
	{
		return ret;
	}
}


void copy_code_to_sdram(unsigned char* src, unsigned char* dest, unsigned int len)
{
	int i = 0;

	if(isbootnor())
	{
		while(i < len)
		{
			dest[i] = src[i];
			i++;
		}
	}
	else
	{
		nand_read((unsigned int)src, dest, len);
	}
}


void clear_bss()
{
	extern int bss_start, bss_end;
	int *p = &bss_start;
	for(;p<(&__bss_start);p++)
	{
		*p = 0;
	}
}