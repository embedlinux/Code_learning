#include "s3c2440_soc.h"
#include "nand_flash.h"


void nand_init()
{
	#define TACLS     0
	#define TWRPH0    1
	#define TWRPH1	  0

	NFCONF = (TACLS<<12) | (TWRPH0<<8) | (TWRPH1<<4);

	NFCONT = (1<<4) | (1<<1) | (1<<0);
}

void nand_select()
{
	NFCONT &= ~(1<<1);
}

void nand_deselect()
{
	NFCONT |= (1<<1);
}
void nand_cmd(unsigned char cmd)
{
	volatile int i;
	NFCMD = cmd;
	for(i=0;i<10;i++);
}

void nand_addr_byte(unsigned char addr)
{
	volatile int i;
	NFADDR = addr;
	for(i=0;i<10;i++);
}

unsigned char nand_data()
{	
	return NFDATA;
}

void  nand_w_data(unsigned char val)
{	
	NFDATA = val;
}

void wait_ready()
{
	while(!(NFSTAT & 1));
}

void nand_read(unsigned int addr, unsigned char *buf, unsigned int len)
{
	int i = 0;
	unsigned int page_addr = addr / 2048 ;
	unsigned int col_addr = addr & (2048-1);
	nand_select();
	
	while(i<len)
	{
		nand_cmd(0x00);

		nand_addr_byte(col_addr & 0xff);			//列地址
		nand_addr_byte((col_addr>>8) & 0xff);
	
		nand_addr_byte(page_addr & 0xff);		    //行地址
		nand_addr_byte((page_addr>>8) & 0xff);
		nand_addr_byte((page_addr>>16) & 0xff);
	
		nand_cmd(0x30);
		wait_ready();

		for(;(col_addr<2048)&&(i<len);col_addr++)
		{
			buf[i++] = nand_data();
		}
		if(i==len)
		{
			break;
		}
		else{
			col_addr = 0;
			page_addr++;					//读下一页数据
		}
	}
	
	nand_deselect();
}

int erase_nand(unsigned int addr, unsigned int len)
{
	int page_addr = addr / 2048;
	if(addr & (0x1ffff))
	{
//		printf("nand_erase error, addr is not block align\n\r");
		return -1;
	}
	if(len & (0x1ffff))
	{
//		printf("nand_erase error, len is not block align\n\r");
		return -1;
	}
	nand_select();
	while(1)
	{
		page_addr = addr / 2048;
		nand_cmd(0x60);
	
		nand_addr_byte(page_addr & 0xff);		    //行地址
		nand_addr_byte((page_addr>>8) & 0xff);
		nand_addr_byte((page_addr>>16) & 0xff);
	
		nand_cmd(0xD0);
		wait_ready();

		len -= (128*1024);
		if(0==len)
		{
			break;
		}
		addr += (128*1024);
		
	}
	
	nand_deselect();
	return 0;

}

void nand_write(unsigned int addr, unsigned char *buf,unsigned int len )
{
	int i = 0;
	unsigned int page_addr = addr / 2048 ;
	unsigned int col_addr = addr & (2048-1);

	nand_select();
	while(1)
	{
		
		nand_cmd(0x80);

		nand_addr_byte(col_addr & 0xff);			//列地址
		nand_addr_byte((col_addr>>8) & 0xff);
	
		nand_addr_byte(page_addr & 0xff);		    //行地址
		nand_addr_byte((page_addr>>8) & 0xff);
		nand_addr_byte((page_addr>>16) & 0xff);
	
		for(; (col_addr < 2048)&&(i<len); )
		{
			nand_w_data(buf[i++]);
		}
		
		nand_cmd(0x10);
		wait_ready();
		
		if(i==len)
		{
			break;
		}
		else{
			col_addr = 0;
			page_addr++;					//写下一页数据
		
		}
	}
	
	nand_deselect();

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
	else                //从nor启动
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
	for(;p<(&bss_start);p++)
	{
		*p = 0;
	}
}
