// ===========================================================
// FileName : PLLTst.v
// Function : Pll 1x testbench.
// ------------------------------------------------------------
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
// ============================================================

`include "PLL.inc"

module PLLTst;

wire ClockInStim, PLLClockOut;
reg  TstClock, Reset, DriftDirection;
reg[7:0] DriftClock;
real HalfPeriod;

// Simulate a clock-distribution tree latency arc:
assign #0.5 ClockInStim = TstClock;
// assign ClockInStim = TstClock;

always@(TstClock)
begin
  #HalfPeriod TstClock <= ~TstClock;
  DriftClock <= DriftClock +7'h1;
end

always@(posedge DriftClock[7])
begin
  // Drift the clock:
  if (DriftDirection==1'b1)
       HalfPeriod = HalfPeriod + 0.001;
  else HalfPeriod = HalfPeriod - 0.001;
  
  if ( HalfPeriod>=(`ClockHalfPeriod+0.100) )
    DriftDirection = 1'b0;
  if ( HalfPeriod<=(`ClockHalfPeriod-0.100) )
    DriftDirection = 1'b1;
end

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

PLL 
u_PLL (.ClockOut    (PLLClockOut), 
       .ClockIn     (ClockInStim), 
       .Reset       (Reset));

initial begin
  $vcdpluson();
end
endmodule // PLLTst

