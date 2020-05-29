// ===========================================================
// Synch4DFF_Tst:  Testbench for a 4-bit synchronous counter
//                 built in DFFs.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Synch4DFF_Tst; // Testbench.
  //
  reg ClockStim, ClearStim;
  wire[3:0] CountWatch;
  //
  //
  always@(ClockStim) #5 ClockStim <= ~ClockStim;
  //
  initial
    begin
    #0   ClockStim = 1'b0;
    #0   ClearStim = 1'b0;
    #1   ClearStim = 1'b1;
    #5   ClearStim = 1'b0;
    // #510 ClearStim = 1'b1;
    // #5   ClearStim = 1'b0;
    #200 $finish;
    end
  //
  Synch4DFF Syncher( .CountOut(CountWatch)
                   , .ClockIn(ClockStim)
                   , .ClearIn(ClearStim)
                   );
endmodule // Synch4DFF_Tst.

