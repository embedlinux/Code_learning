Overview
========
The WDOG Example project is to demonstrate usage of the KSDK wdog driver.
In this example,quick test is first implemented to achieve the timeout reset function.
And then after 5 times of refreshing the watchdog, a timeout reset is generated.
Once the CPU re-start from the timeout reset, the routine will feed the watch dog in IRQ 
all the time which is triggered by warning interrupt.

Toolchain supported
===================
- IAR embedded Workbench  8.32.1
- GCC ARM Embedded  7.3.1
- MCUXpresso 10.3.1

Hardware requirements
=====================
- Micro USB cable
- EVK-MIMXRT685 board
- Personal Computer

Board settings
==============


Prepare the Demo
================
1.  Connect a micro USB cable between the PC host and the CMSIS DAP USB port (J5) on the board
2.  Open a serial terminal with the following settings:
    - 115200 baud rate
    - 8 data bits
    - No parity
    - One stop bit
    - No flow control
3.  Download the program to the target board.
4.  Launch the debugger in your IDE to begin running the demo.

Running the demo
================
The log below shows example output of the WWDT driver demo in the terminal window:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--- Window mode refresh test start---
Watchdog reset occurred
~~~~~~~~~~~~~~~~~~~~~~
Customization options
=====================

