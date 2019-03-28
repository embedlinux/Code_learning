#ifndef __UART_H
#define __UART_H

	void putchar(int c);
	int getchar(void);
	void puts(const char *s);
//	void init_uart0();
	int init_uart0();
	void putHex(int c);

#endif


