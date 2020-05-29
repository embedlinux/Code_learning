// ===========================================================
// TwoNetlistsTst:  Testbench for simultaneous count of
// a 4-bit ripple counter and a 4-bit synchronous counter
// built in DFFs and synthesized.
//
// ------------------------------------------------------------
// 2006-08-11 jmw: v. 1.0 copied from Sync4DFF_Tst & modified
//      for two instances.
// ============================================================
//
`timescale 1ns/100ps
//
module TwoNets_Tst; // Testbench.
//
reg ClockStim, ClearStim;
wire[3:0] RipCnt, SynCnt;
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
Ripple4DFF Ripl_U1( .CountOut(RipCnt)
                  , .ClockIn(ClockStim), .ClearIn(ClearStim)
                  );
Synch4DFF Sync_U2 ( .CountOut(SynCnt)
                  , .ClockIn(ClockStim), .ClearIn(ClearStim)
                  );
endmodule // TwoNets_Tst.

