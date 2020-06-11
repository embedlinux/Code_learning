//----------------------------------------------------------------------------
// Accellera Copyright (c) 2007. All rights reserved.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// CONTENTS (last updated: Wed Jul 25 21:18:03 BST 2007)
// ========
// 28.  Testbench (formal_pass simulation wrapper)
// 40.  
// 41.  OVL Ports
// 45.    - global: clock & reset
// 51.  
// 52.  DUT: tb_assert_formal_pass
// 62. 
// 63.  Clock (period = 100ns, run for 1M cycles)
// 73.  Done (should have no failures)");
// 78. 
// 79.  Main Stimulus (just reset asserted at start)
//----------------------------------------------------------------------------


`include "std_ovl_defines.h"

`timescale 1ns / 1ns

module tb_assert_formal_pass_sim_wrapper ;

   // INDEX: Testbench (formal_pass simulation wrapper)
   // =====
   // Simple simulation wrapper for the formal-passing testbench.
   //
   // It just clocks the formal_pass testbench, and shouldn't show any failures.
   //
   // It's a quick sanity-checking testbench to ensure that the formal-pass
   // testbench cannot easily fail, by stressing the assertions for 10 million
   // clock cycles. Only formal tools can prove that they are exhaustive.


   // ----------------------------------------------------------------------
   // INDEX: 
   // INDEX: OVL Ports
   // ----------------------------------------------------------------------


   // INDEX:   - global: clock & reset
   // =====
   reg clk, reset_n;


   // ----------------------------------------------------------------------
   // INDEX: 
   // INDEX: DUT: tb_assert_formal_pass
   // ----------------------------------------------------------------------
   tb_assert_formal_pass DUT
     (.clk             (clk), 
      .reset_n         (reset_n),
      .alw_2_test_expr (1'b1) // OVL_ASSUME
      );


   // ----------------------------------------------------------------------
   // INDEX:
   // INDEX: Clock (period = 100ns, run for 1M cycles)
   // ----------------------------------------------------------------------
   initial
      begin
         repeat(1000000) // One Million Cycles
            begin
                    clk=1'b1;
               #50  clk=1'b0;
               #50  ;
            end
         $display("INDEX: Done (should have no failures)");
      end


   // ----------------------------------------------------------------------
   // INDEX:
   // INDEX: Main Stimulus (just reset asserted at start)
   // ----------------------------------------------------------------------
   initial
      begin
         // Reset: Low until 3rd falling edge of clock
         #0
         $display ("INDEX: Reset On");
         reset_n=1'b0;
         #250
         $display ("INDEX: Reset Off");
         reset_n=1'b1;
      end

endmodule // tb_assert_formal_pass_SIM_WRAPPER
