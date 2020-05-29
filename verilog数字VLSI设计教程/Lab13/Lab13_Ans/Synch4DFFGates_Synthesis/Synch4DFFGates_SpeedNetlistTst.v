// ===========================================================
// SynchDFFGatesTst:  Extracted from the testbench for Synch4DFFGates.
//
// ------------------------------------------------------------
// 2007-11-19 jmw: v. 1.0 Copied.
// ============================================================
//
`timescale 1ns/100ps
//
`ifdef DC
`else
module Synch4DFFGatesTst; // Testbench.
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
    #300 $finish;
    end
  //
  Synch4DFFGates Netlist( .CountOut(CountWatch)
                        , .ClockIn(ClockStim)
                        , .ClearIn(ClearStim)
                        );
  //
endmodule // Synch4DFFGatesTst.
`endif
