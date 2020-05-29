// ===========================================================
// PLLTopTst: Testbench for the synthesizable PLL of Lab22.
// ------------------------------------------------------------
// 2005-05-17 jmw: v. 1.1 Added `define switch to change VFO
//      ref to Deserial.inc duing simulation.   Removed now
//      supernumerary .Sample pin from PLLTop inst, along with
//      the Sample-generating always code.
// 2005-05-17 jmw: v. 1.0 Copied from Lab21; removed everything
//      from old PLLsync module; moved Sample generator into
//      tb; changed dut name to PLLTop and named .Behavioral
//      pin to .ClockOut.  Named ClearIn pin to Reset; and,
//      added .Sample pin.
//      
// ============================================================
//
`define DeserializerTB  // For Deserial.inc ref in VFO.v.
`include "Deserial.inc"
//
// ----------------------------------------------------------------
// Simulation Testbench supplies PLL with exact clock
// frequency:
//
module PLLTopTst;
//
reg  ClockStimIn, ClearStim;
wire PLLClockWatch;
//
always@(ClockStimIn)
   #`HalfPeriod32BitBus ClockStimIn <= ~ClockStimIn;
//
initial
  begin
  #0     ClearStim   = 1'b0;
  #0     ClockStimIn = 1'b0;
  #1     ClearStim   = 1'b1;
  #9     ClearStim   = 1'b0;
         ClockStimIn = 1'b1;
  #465   ClearStim   = 1'b1;
  #500   ClearStim   = 1'b0;
  #50    ClearStim   = 1'b1;
  #500   ClearStim   = 1'b0;
  #55000 $finish;
  end
//
PLLTop
PLL_U1( .ClockOut(PLLClockWatch), .ClockIn(ClockStimIn), .Reset(ClearStim) );
//
endmodule // PLLTopTst.

