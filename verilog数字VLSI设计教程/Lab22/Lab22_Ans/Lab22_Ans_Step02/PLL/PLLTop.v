// ===========================================================
// PLLTop: Top level of the PLL design simulation model.
//       Nominal frequency is 32 MHz, for the SerDes PLL
//       synchronized to a nominal 1 MHz parallel clock.
//
// ------------------------------------------------------------
// 2006-05-17 jmw: v. 1.0 Copied from Lab21.
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
