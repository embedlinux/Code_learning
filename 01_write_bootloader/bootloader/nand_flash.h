#ifndef _NAND_FLASH_H
#define _NAND_FLASH_H

#include "s3c2440_soc.h"
#include "nand_flash.h"


void nand_init();
void nand_select();
void nand_deselect();
void nand_cmd(unsigned char cmd);
void nand_addr_byte(unsigned char addr);
unsigned char nand_data();
void  nand_w_data(unsigned char val);
void wait_ready();
void nand_read(unsigned int addr, unsigned char *buf, unsigned int len);
int erase_nand(unsigned int addr, unsigned int len);
void nand_write(unsigned int addr, unsigned char *buf,unsigned int len );
int isbootnor();
void copy_code_to_sdram(unsigned char* src, unsigned char* dest, unsigned int len);
void clear_bss();

#endif