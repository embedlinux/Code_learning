// ===========================================================
// PLLTop: Top level of the PLL design simulation model.
//       Nominal frequency is 32 MHz, for the SerDes PLL
//       synchronized to a nominal 1 MHz parallel clock.
//
// ------------------------------------------------------------
// 2006-05-17 jmw: v. 1.0 Renamed VFO Sample input port and
//      replaced occasional, random sampling with the locally
//      set up SampleWire edge.
//      An instance of the same delay cell used in the VFO is
//      added here, too.
// ============================================================
//
module PLLTop (output ClockOut, input ClockIn, Reset);
//
wire[1:0] AdjFreq;
wire MHz32, CtrCarry;
//
// -----------------------------------------------
// The new sample edge generator:
wire SampleWire;
//
DEL005 SampleDelay1 (.Z(SampleWire), .I(ClockIn));
//
//synopsys dc_tcl_script_begin
// set_dont_touch SampleDelay1
// set_dont_touch SampleWire
// set_dont_touch ClockIn
//synopsys dc_tcl_script_end
//
// -----------------------------------------------
assign ClockOut = MHz32;
//
ClockComparator 
Comp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn)
      , .CounterClock(CtrCarry), .Reset(Reset)
      );
//
VFO
VFO1 ( .ClockOut(MHz32), .AdjustFreq(AdjFreq)
     , .Sample(SampleWire), .Reset(Reset)
     );
//
MultiCounter
MCntr1 (.CarryOut(CtrCarry), .Clock(MHz32), .Reset(Reset));
//
endmodule // PLLTop.
//

