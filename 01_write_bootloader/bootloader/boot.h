#ifndef _BOOT_H
#define _BOOT_H

unsigned int  strlen(const char * s);
char * strcpy(char * dest,const char *src);
void setup_start_tag();
void setup_memory_tags();
void setup_commandline_tag();
void setup_end_tag();
int main();

#endif