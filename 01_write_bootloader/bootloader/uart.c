#include "s3c2440_soc.h"


void putchar(int c)
{
	while(!(UTRSTAT0 & (1<<2)));
	UTXH0 = (unsigned char)c;
}
int getchar(void)
{
	while(!(UTRSTAT0 & (1<<0)));
	return URXH0;
}
void puts(const char *s)
{
	while(*s)
	{
		putchar(*s);
		s++;
	}

}
int init_uart0()
{
	/* 配置串口输入、输出引脚 GPH2/PGH3 */
	GPHCON &= ~((3<<4)|(3<<6));
	GPHCON |= ((2<<4)|(2<<6));
	GPHUP &= ~((1<<2)|(1<<3));
	
	/* 配置数据传输格式 8位数据位，没有校验位，1位停止位 */
	ULCON0 |=(3<<0);
	
	/* 配置波特率 UBRDIVn = (int)( UART clock / ( buad rate x 16) ) –1 
		50000000/(115200*16) -1
	*/
	UBRDIV0 = 26;
	
	/* 其他配置 */
	UCON0 |= ((1<<2)|(1<<0)); //采用中断或轮询方式读写数据

	return 0;
	
}


// c=0x12345678ab,输出整数
void putHex(unsigned int val)
{	int i;
	unsigned char char_c[8];
	for(i=0;i<8;i++)
	{
		char_c[i] = val & 0xf;
		val >>= 4;
	}
	puts("0x");
	for(i=7;i>=0;i--)
	{
		if((char_c[i]>=0)&&(char_c[i]<=9))
			putchar(char_c[i]+'0');
		else if((char_c[i]>=0xA)&&(char_c[i]<=0xF))
			putchar(char_c[i]-0xA +'A');
	}
}

