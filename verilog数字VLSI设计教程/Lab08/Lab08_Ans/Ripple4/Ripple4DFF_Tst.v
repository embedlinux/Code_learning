// ===========================================================
// Ripple4DFF_Tst:  Testbench for a 4-bit ripple counter.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Ripple4DFF_Tst;
  //
  reg ClockStim, ClearStim;
  wire[3:0] CountWatch;
  //
  //
  always@(ClockStim) #11 ClockStim <= ~ClockStim;
  //
  initial
    begin
    #0   ClockStim = 1'b0;
    #0   ClearStim = 1'b0;
    #1   ClearStim = 1'b1;
    #5   ClearStim = 1'b0;
    // #121 ClearStim = 1'b1;
    // #5   ClearStim = 1'b0;
    #500 $finish;
    end
  //
  Ripple4DFF Rippler( .CountOut(CountWatch)
                    , .ClockIn(ClockStim)
                    , .ClearIn(ClearStim)
                    );
  //
endmodule // Ripple4DFF_Tst.
