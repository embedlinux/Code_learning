#include "nand_flash.h"
#include "uart.h"
#include "setup.h"

static struct tag *params;

unsigned int  strlen(const char * s)
{
	const char *sc;

	for (sc = s; *sc != '\0'; ++sc)
		/* nothing */;
	return sc - s;
}

char * strcpy(char * dest,const char *src)
{
	char *tmp = dest;

	while ((*dest++ = *src++) != '\0')
		/* nothing */;
	return tmp;
}

void setup_start_tag()
{
	params = (struct tag *)0x30000100;

	params->hdr.tag = ATAG_CORE;
	params->hdr.size = tag_size (tag_core);

	params->u.core.flags = 0;
	params->u.core.pagesize = 0;
	params->u.core.rootdev = 0;

	params = tag_next (params);
}

void setup_memory_tags()
{
		params->hdr.tag = ATAG_MEM;
		params->hdr.size = tag_size (tag_mem32);

		params->u.mem.start = 0x30000000;
		params->u.mem.size = 64*1024*1024;

		params = tag_next (params);
}

void setup_commandline_tag(char* p)
{
	params->hdr.tag = ATAG_CMDLINE;
	params->hdr.size = (sizeof (struct tag_header) + strlen (p) + 3) >> 2;

	strcpy(params->u.cmdline.cmdline, p);

	params = tag_next (params);
}

void setup_end_tag()
{
	params->hdr.tag = ATAG_NONE;
	params->hdr.size = 0;
}

int main()
{
	void (*kernel_entry)(int zero, int arch, unsigned int params);


	//将kernel从NAND 拷贝到 SDRAM
	nand_read(0x60000+64, 0x30008000, 0x200000);


	//设置参数
	puts("Set boot params\n\r");
	setup_start_tag();
	setup_memory_tags();
	setup_commandline_tag("noinitrd root=/dev/mtdblock3 init=/linuxrc console=ttySAC0");
	setup_end_tag();


	//跳转到kernel
	kernel_entry = (void (*)(int, int, unsigned int))0x30008000;
	kernel_entry(0,362, 0x30000100);


	puts("Error!\n\r");
	return -1;
}