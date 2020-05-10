/*
 *-----------------------------------------------------------------------------
 * The confidential and proprietary information contained in this file may
 * only be used by a person authorised under and to the extent permitted
 * by a subsisting licensing agreement from ARM Limited.
 *
 *            (C) COPYRIGHT 2010-2017  ARM Limited or its affiliates.
 *                ALL RIGHTS RESERVED
 *
 * This entire notice must be reproduced on all copies of this file
 * and copies of this file may only be made by a person if such person is
 * permitted to do so under the terms of a subsisting license agreement
 * from ARM Limited.
 *
 *      SVN Information
 *
 *      Checked In          : $Date: 2013-04-08 14:40:10 +0100 (Mon, 08 Apr 2013) $
 *
 *      Revision            : $Revision: 243193 $
 *
 *      Release Information : CM3DesignStart-r0p0-00rel0
 *-----------------------------------------------------------------------------
 */

/*
  A simple test to check the operation of default slave and the handling of
  error response in the AHB interconnection.
  The hardfault handler is assuming that r0 contains the address used for
  generating a fault, and the cault can be cleared by modifying the stacked
  r0 value
*/
#include "CM3DS_MPS2.h"
#include <stdio.h>
#include "uart_stdout.h"
#include "CM3DS_function.h"

void                HardFault_Handler_c(unsigned int * hardfault_args, unsigned lr_value);

/* Global variables */
volatile int hardfault_occurred;
volatile int hardfault_expected;
volatile int temp_data;

int main (void)
{
  int err_code = 0;
  int rdata; /* dummy variable for read data in bus fault testing */

  // UART init
  UartStdOutInit();

  // Test banner message and revision number
  puts("\nCortex-M3 DesignStart - Default Slave Test - revision $Revision: 243193 $\n");


  puts("Default slave tests - hard faults expected\n");
  temp_data=0;
  hardfault_occurred = 0;
  hardfault_expected = 1;
  address_test_write(0x18000000, 0x3456789A);
  if (hardfault_occurred==0) {err_code |= (1<<0);}
  hardfault_occurred = 0;

  rdata = address_test_read(0x18000000);
  if (hardfault_occurred==0) {err_code |= (1<<1);}
  hardfault_occurred = 0;

  address_test_write(0x58000000, 0x3456789A);
  if (hardfault_occurred==0) {err_code |= (1<<2);}
  hardfault_occurred = 0;

  rdata = address_test_read(0x58000000);
  if (hardfault_occurred==0) {err_code |= (1<<3);}
  hardfault_occurred = 0;

  /* clean up */
  hardfault_expected = 0;

  /* Generate test pass/fail and return value */
  if (err_code==0) {
    printf ("\n** TEST PASSED **\n");
  } else {
    printf ("\n** TEST FAILED **, Error code = (0x%x)\n", err_code);
  }
  UartEndSimulation();
  return 0;
}

#if defined ( __CC_ARM   )
/* ARM or Keil toolchain */
__asm void HardFault_Handler(void)
{
  MOVS   r0, #4
  MOV    r1, LR
  TST    r0, r1
  BEQ    stacking_used_MSP
  MRS    R0, PSP ; // first parameter - stacking was using PSP
  B      get_LR_and_branch
stacking_used_MSP
  MRS    R0, MSP ; // first parameter - stacking was using MSP
get_LR_and_branch
  MOV    R1, LR  ; // second parameter is LR current value
  LDR    R2,=__cpp(HardFault_Handler_c)
  BX     R2
  ALIGN
}
#elif defined ( __IAR_SYSTEMS_ICC__ )
/* IAR Systems C Compiler */
void HardFault_Handler(void)
{
  __asm("  mov    r1,lr\n"  /*  second parameter is LR current value */
        "  lsls   r0,r1,#29\n"
        "  bpl    stacking_used_MSP\n"
        "  mrs    r0,psp\n" /*  first parameter - stacking was using PSP */
        "  bx     r2\n"
        "stacking_used_MSP:\n"
        "  mrs    r0,msp\n" /*  first parameter - stacking was using MSP */
        "  bx     r2"
        :: "r2" (HardFault_Handler_c) : "r0", "r1", "memory" );
}
#else
/* gcc toolchain */
void HardFault_Handler(void) __attribute__((naked));
void HardFault_Handler(void)
{
  __asm("  movs   r0,#4\n"
        "  mov    r1,lr\n"
        "  tst    r0,r1\n"
        "  beq    stacking_used_MSP\n"
        "  mrs    r0,psp\n" /*  first parameter - stacking was using PSP */
        "  ldr    r1,=HardFault_Handler_c  \n"
        "  bx     r1\n"
        "stacking_used_MSP:\n"
        "  mrs    r0,msp\n" /*  first parameter - stacking was using PSP */
        "  ldr    r1,=HardFault_Handler_c  \n"
        "  bx     r1\n"
        ".pool\n" );
}

#endif
/* C part of the fault handler - common between ARM / Keil / IAR/ gcc */
void HardFault_Handler_c(unsigned int * hardfault_args, unsigned lr_value)
{
  unsigned int stacked_pc;
  unsigned int stacked_r0;
  hardfault_occurred++;
  puts ("[Hard Fault Handler]");
  if (hardfault_expected==0) {
    puts ("ERROR : Unexpected HardFault interrupt occurred.\n");
    UartEndSimulation();
    while (1);
    }
  stacked_r0  = ((unsigned long) hardfault_args[0]);
  stacked_pc  = ((unsigned long) hardfault_args[6]);
  printf(" - Stacked R0 : 0x%x (test address)\n", stacked_r0);
  printf(" - Stacked PC : 0x%x\n", stacked_pc);
  /* Modify R0 to a valid address */
  hardfault_args[0] = (unsigned long) &temp_data;

  return;
}

