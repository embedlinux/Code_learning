Overview
========
The spi_interrupt_b2b_master example shows how to use spi functional API to do interrupt transfer as a master:

In this example, the spi instance as master. Master sends a piece of data to slave, receive data from slave,and check
if the data master received is correct. This example needs to work with spi_interrupt_b2b_slave example.

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
The example provides 2 options of SPI interfaces in communication.
1. SPI5 (default, normal SPI: #define USE_HS_SPI 0)
2. SPI14 (optional, high speed SPI: #define USE_HS_SPI 1)
User can change the USE_HS_SPI value in spi_interrupt_b2b_master.c to choose different SPI interface.

Connect SPI master on board to SPI slave on other board. Only 1 set of signals need to be connected, either
SPI5 or SPI14 depending on the USE_HS_SPI setting.
NOTE: To use SPI14 on EVK board, debug probe bridge need to be disabled (shunt J10 and use J16 as debug console).

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Master_board(SPI5)           Slave_board(SPI5)
Pin Name   Board Location     Pin Name   Board Location
MISO       J28 pin 5          MISO       J28 pin 5
MOSI       J28 pin 4          MOSI       J28 pin 4
SCK        J28 pin 6          SCK        J28 pin 6
PCS0       J28 pin 3          PCS0       J28 pin 3
GND        J28 pin 7          GND        J28 pin 7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Master_board(SPI14)          Slave_board(SPI14)
Pin Name   Board Location     Pin Name   Board Location
MISO       J36 pin 5          MISO       J36 pin 5
MOSI       J36 pin 3          MOSI       J36 pin 3
SCK        J36 pin 7          SCK        J36 pin 7
PCS0       J36 pin 1          PCS0       J36 pin 1
GND        J36 pin 9          GND        J36 pin 9
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
When the demo runs successfully, the log would be seen on the terminal like:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SPI board to board interrupt master example started!

SPI transfer finished!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Customization options
=====================

