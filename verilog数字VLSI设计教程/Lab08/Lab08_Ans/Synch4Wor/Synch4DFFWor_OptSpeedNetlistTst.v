// ===========================================================
// Synch4DFFWor_OptSpeedNetlistTst: Testbench for the speed
//    optimized synthesized netlist of a 4-bit synchronous
//    counter built in DFFs and using wired-or logic.
//
// ------------------------------------------------------------
// 2005-11-22 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Synch4DFFWor_OptSpeedNetlistTst; // Testbench.
  //
  reg ClockStim, ClearStim;
  wire[3:0] CountWatch;
  //
  //
  always@(ClockStim) #15 ClockStim <= ~ClockStim;
  //
  initial
    begin
    #0   ClockStim = 1'b0;
    #0   ClearStim = 1'b0;
    #1   ClearStim = 1'b1;
    #5   ClearStim = 1'b0;
    #510 ClearStim = 1'b1;
    #5   ClearStim = 1'b0;
    #100 $finish;
    end
  //
  Synch4DFFWor
  SynchNetlist01
           ( .CountOut(CountWatch)
           , .ClockIn(ClockStim)
           , .ClearIn(ClearStim)
           );
endmodule // Synch4DFFWor_OptSpeedNetlistTst.
