Overview
========

The I2S example project uses one I2S interface to continuously record input sound to a buffer
and another I2S interface to playback the buffer to output - digital loopback.


Toolchain supported
===================
- IAR embedded Workbench  8.32.1
- GCC ARM Embedded  7.3.1
- MCUXpresso 10.3.1

Hardware requirements
=====================
- Micro USB cable
- Two EVK-MIMXRT685 boards
- Personal Computer
- headphones with 3.5 mm stereo jack
- source of sound (line output to 3.5 mm stereo jack)
- source of sound (line output to 3.5 mm stereo jack)


Board settings
==============
To make example work, connections needed to be as follows:
  J14-1        <-->        J15-2
  J15-1        <-->        J14-2

Prepare the Demo
================
1.  Connect headphones to Audio HP / Line-Out connector (J4).
2.  Connect source of sound to Audio Line-In connector (J3).
3.  Connect a micro USB cable between the PC host and the CMSIS DAP USB port (J5) on the board
4.  Open a serial terminal with the following settings:
    - 115200 baud rate
    - 8 data bits
    - No parity
    - One stop bit
    - No flow control
5.  Download the program to the target board.
6.  Launch the debugger in your IDE to begin running the demo.
Running the demo
================
Headphones will play a sine wave sound.
The log below shows example output of the I2S driver demo in the terminal window:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Configure I2C
Configure WM8904 codec
Configure I2S
Setup looping playback of sine wave
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Modify i2s_interrupt_transfer.c to change condition to call StartDigitalLoopback() instead of StartSoundPlayback() function.
Terminal window will show:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Configure I2C
Configure WM8904 codec
Configure I2S
Setup digital loopback
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Customization options
=====================

