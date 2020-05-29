// ===========================================================
// PLLTopTst: Testbench for the synthesizable PLL of Lab22.
// ------------------------------------------------------------
// 2006-07-24 jmw: v. 1.0 Copied from Lab22, Step04 ans to
//      test PLL with synthesizable DesDecoder.
// ============================================================
//
`include "Deserial.inc"
//
// ----------------------------------------------------------------
// Simulation Testbench supplies PLL with exact clock
// frequency:
//
module PLLTopTst;
//
reg  ClockStim, ClearStim;
wire PLLClockWatch;
//
always@(ClockStim)
   #`HalfPeriod32BitBus ClockStim <= ~ClockStim;
//
initial
  begin
  #0     ClearStim = 1'b0;
  #0     ClockStim = 1'b0;
  #1     ClearStim = 1'b1;
  #9     ClearStim = 1'b0;
         ClockStim = 1'b1;
  #465   ClearStim = 1'b1;
  #500   ClearStim = 1'b0;
  #50    ClearStim = 1'b1;
  #500   ClearStim = 1'b0;
  #100000 $finish;
  end
//
PLLTop
PLL_U1( .ClockOut(PLLClockWatch), .ClockIn(ClockStim), .Reset(ClearStim) );
//
endmodule // PLLTopTst.

