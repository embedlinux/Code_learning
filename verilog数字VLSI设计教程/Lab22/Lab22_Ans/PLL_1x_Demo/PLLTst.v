// ===========================================================
// PLL: Pll 1x testbench.
// ------------------------------------------------------------
// 2007-04-15 jmw: v. 1.1 Added clock drift.
// 2007-04-14 jmw: v. 1.0 Initial design.
// ============================================================
//
`include "PLL.inc"
//
module PLLTst;
//
wire ClockInStim, PLLClockOut;
reg  TstClock, Reset, DriftDirection;
reg[7:0] DriftClock;
real HalfPeriod;
//
// Simulate a clock-distribution tree latency arc:
assign #0.5 ClockInStim = TstClock;
// assign ClockInStim = TstClock;
//
always@(TstClock)
  begin
  #HalfPeriod TstClock <= ~TstClock;
  DriftClock <= DriftClock +7'h1;
  end
//
always@(posedge DriftClock[7])
  begin
  // Drift the clock:
  if (DriftDirection==1'b1)
       HalfPeriod = HalfPeriod + 0.001;
  else HalfPeriod = HalfPeriod - 0.001;
  //
  if ( HalfPeriod>=(`ClockHalfPeriod+0.100) )
    DriftDirection = 1'b0;
  if ( HalfPeriod<=(`ClockHalfPeriod-0.100) )
    DriftDirection = 1'b1;
  end
//
initial
  begin
  Reset      = 1'b0;
  HalfPeriod = `ClockHalfPeriod*1.0 + 0.003;
  DriftDirection = 1'b1;
  DriftClock   =  'b0;
  #1  TstClock = 1'b0;
  #1  Reset    = 1'b1;
  #18 Reset    = 1'b0;
  #20000 $finish;
  end
//
PLL 
PLL_U1 (.ClockOut(PLLClockOut), .ClockIn(ClockInStim), .Reset(Reset));
//
endmodule // PLLTst.

