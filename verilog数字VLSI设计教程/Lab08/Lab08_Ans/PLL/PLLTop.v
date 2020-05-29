// ===========================================================
// PLLTop: Top level of the PLL design simulation model.
//       Nominal frequency is 32 MHz, for the SerDes PLL
//       synchronized to a nominal 1 MHz parallel clock.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 2.2 Fixed comment error; deleted the
//            testbench from this file for Lab08.
// 2005-02-12 jmw: v. 2.1 For Lab08, ranamed to PLLTop.
//            Commented out testbench because of new one at
//            top of Lab08 design.
// 2005-02-02 jmw: v. 2.0 Fixed for pure integer operation.
// 2005-01-31 jmw: v. 1.1 Added Reset to get rid of initial blocks.
//            rewrote for synthesis in DC.
// 2004-12-11 jmw: v. 1.0 implemented to simulate VFO only.
//            Note: Changes in testbench are not logged.
// ============================================================
//
module PLLTop (output ClockOut, input ClockIn, Sample, Reset);
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
endmodule // PLLTop.
//
