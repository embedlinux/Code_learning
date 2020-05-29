// ===========================================================
// PLLsim: Top level of the PLL design simulation model.
//       Nominal frequency is 32 MHz, for the SerDes PLL
//       synchronized to a nominal 1 MHz parallel clock.
//
// ------------------------------------------------------------
// 2006-08-11 jmw: v. 2.1 Moved `include from PllsimTst to top
//      of file for new VCS checking.
// 2005-02-02 jmw: v. 2.0 Fixed for pure integer operation.
// 2005-01-31 jmw: v. 1.1 Added Reset to get rid of initial blocks.
//            rewrote for synthesis in DC.
// 2004-12-11 jmw: v. 1.0 implemented to simulate VFO only.
//            Note: Changes in testbench are not logged.
// ============================================================
//
`include "PLLsim.inc"
//
module PLLsim (output ClockOut, input ClockIn, Sample, Reset);
  //
  wire[1:0] AdjFreq;
  wire VFOOut, ClockFromCounter;
  //
  assign ClockOut = VFOOut;
  //
ClockComparator 
PLLComp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn)
         , .CounterClock(ClockFromCounter), .Reset(Reset)
         );
VFO
PLLVFO1 ( .ClockOut(VFOOut), .AdjustFreq(AdjFreq)
        , .SampleCmd(Sample), .Reset(Reset)
        );
MultiCounter
PLLCntr1 (.CarryOut(ClockFromCounter), .Clock(VFOOut)
         , .Reset(Reset));
//
endmodule // PLLsim.
//
// ----------------------------------------------------------------
// Simulation Testbench here:
//
`ifdef DC
`else
//
module PLLsimTst;
  //
  reg  PLLClockStim;
  reg  SampleStim;
  reg  Reset; // New 2005-01-31 jmw.
  //
  PLLsim 
  PLL_Top1 ( .ClockOut(PLLClockwatch)
           , .ClockIn(PLLClockStim), .Sample(SampleStim), .Reset(Reset)
           );
  //
  always@(PLLClockStim) // 500 ns is half-period at 1 MHz
     #`HalfPeriod32BitBus PLLClockStim <= ~PLLClockStim;
  //
  always@(posedge PLLClockStim)
    begin
    #50  SampleStim = 1'b1;
    #100 SampleStim = 1'b0;
    end
  //
  initial
    begin
    #0 Reset        = 1'b0;
    #1 Reset        = 1'b1;
    #9 Reset        = 1'b0;
    #1 SampleStim   = 1'b0;
    #1 PLLClockStim = 1'b0;
    #20000 $finish;
    end
  //
endmodule // PLLsimTst.
`endif
