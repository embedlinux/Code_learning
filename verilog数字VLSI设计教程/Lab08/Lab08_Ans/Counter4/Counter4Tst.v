// ===========================================================
// Counter4Tst:  Testbench for Counter4 netlists
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 1.1 Renamed the instance.
// 2005-04-12 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Counter4Tst; // Testbench.
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
  Counter4 Behaver( .CountOut(CountWatch)
                   , .ClockIn(ClockStim)
                   , .Clear(ClearStim)
                   );
  //
endmodule // Counter4Tst.

