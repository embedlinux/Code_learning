Overview
========
The qspi_dma_transfer example shows how to use qspi driver with DMA:

In this example, qspi will send data and operate the external flash connected with QSPI. Some simple flash command will
be executed, such as Write Enable, Erase sector, Program page.
Example will first erase the sector and programe a page into the flash, at last check if the data in flash is correct.

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
For IAR, please don't choose Use flash loader option when download flash_debug/flash_release target output files, and the binary size for flash_debug/release target will be very large because it also contains the RAM data.

When the example runs successfully, you can see the similar information from the terminal as below.

~~~~~~~~~~~~~~~~~~~~~
QSPI example started!
Erase finished!
Program data finished!
Program through QSPI DMA succeed!
~~~~~~~~~~~~~~~~~~~~~
Customization options
=====================

