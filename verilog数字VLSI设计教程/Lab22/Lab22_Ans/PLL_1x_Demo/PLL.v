// ===========================================================
// PLL: Top level of a 1x synthesizable, digital PLL.
//
// ------------------------------------------------------------
// 2007-04-16 jmw: v. 1.0 modified from verilog Lab22 v. 1.0
//      by removing the Multiplier-Counter instance from PLLTop
//      and renaming PLLTop to PLL.  Also renamed VFO port from
//      Sample to ClockIn.
// ============================================================
//
module PLL (output ClockOut, input ClockIn, Reset);
//
wire[1:0] AdjFreq;
wire VFOut, CkInWire;
//
assign ClockOut = VFOut;
//
DEL005 CkInDelay1 (.Z(CkInWire), .I(ClockIn));
//
//synopsys dc_tcl_script_begin
// set_dont_touch CkInDelay1
// set_dont_touch CkInWire
// set_dont_touch ClockIn
//synopsys dc_tcl_script_end
//
Comparator 
Comp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn)
      , .PLLClock(VFOut), .Reset(Reset)
      );
//
VFO
VFO1 ( .ClockOut(VFOut), .AdjustFreq(AdjFreq)
     , .ClockIn(CkInWire), .Reset(Reset)
     );
//
endmodule // PLL.
//

