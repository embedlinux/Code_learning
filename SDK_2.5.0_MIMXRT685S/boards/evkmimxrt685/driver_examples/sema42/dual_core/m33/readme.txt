Overview
========
The sema42 example shows how to use SEMA42 driver to lock and unlock a sema gate:

In this example:
1. Firstly, Core 0 turn on LED  and lock a sema gate then boot up Core 1 wake up.
2. Core 1 must be wait until Core 0 unlocks this sema gate to lock it.
3. After user press any key in terminal window, the sema gate will be unlocked by core 0,
then core 1 will lock it and turn off the LED

If the board does not have LED to show the status, then core 1 will send a flag
to core 0 when core 1 has locked the sema gate. Core 0 outputs the success log
after it received the flag.

Toolchain supported
===================
- GCC ARM Embedded  7.3.1
- IAR embedded Workbench  8.32.1
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
This example run both M33 and DSP at the same time! 

When the demo runs successfully, the log would be seen on the M33's terminal like below.

~~~~~~~~~~~~~~~~~~~~~
Sema42 example!

Press any key to unlock semaphore and Core 1 will lock it
~~~~~~~~~~~~~~~~~~~~~

When press any key in the terminal, the terminal tells

~~~~~~~~~~~~~~~~~~~~~
Wait for core 1 lock the semaphore

Sema42 example succeed!
~~~~~~~~~~~~~~~~~~~~~
Customization options
=====================

