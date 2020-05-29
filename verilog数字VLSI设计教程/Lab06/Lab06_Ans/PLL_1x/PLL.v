// ===========================================================
// PLL: Top level of a 1x PLL design simulation model.
//       Nominal frequency is 400 MHz.
//
// ------------------------------------------------------------
// 2007-04-14 jmw: v. 1.0 Initial design.
// ============================================================
//
module PLL (output ClockOut, input ClockIn, Reset);
//
wire[1:0] AdjFreq;
wire VFO_Ck;
//
assign ClockOut = VFO_Ck;
//
Comparator 
Comp_U1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn)
        , .PLLClock(VFO_Ck), .Reset(Reset)
        );
VFO
VFO_U1 (.ClockOut(VFO_Ck), .AdjustFreq(AdjFreq), .Reset(Reset));
//
endmodule // PLL.

