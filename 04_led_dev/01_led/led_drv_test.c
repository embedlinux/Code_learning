#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>


int main(int argc, char **argv)
{
	int fd;
	int val = 1;
	fd = open("/dev/led",O_RDWR);
	if(fd < 0)
		printf("Can't open...\n");
	if(argc != 2)
	{
		printf("Usage :\n");
		printf("%s <on|off>\n", argv[0]);
		return 0;
	}
	if(strcmp(argv[1], "on") == 0)
	{
		val = 0;
	}
	else
	{
		val = 1;
	}
	write(fd,&val,4);
	return 0;
}
