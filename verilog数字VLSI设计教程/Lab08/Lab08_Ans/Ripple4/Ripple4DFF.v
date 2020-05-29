// ===========================================================
// Ripple4DFF:  A 4-bit ripple counter.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 2.0 Moved testbench to its own file.
// 2004-12-19 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Ripple4DFF ( output[3:0] CountOut
                  , input ClockIn, ClearIn);
  //
  wire Qn_wire0, Qn_wire1, Qn_wire2, Qn_wire3;
  //
  DFFC FF_Bit0(.Q(CountOut[0]), .Qn(Qn_wire0), .D(Qn_wire0)
              , .Clk(ClockIn), .Clr(ClearIn) );
  DFFC FF_Bit1(.Q(CountOut[1]), .Qn(Qn_wire1), .D(Qn_wire1)
              , .Clk(Qn_wire0), .Clr(ClearIn) );
  DFFC FF_Bit2(.Q(CountOut[2]), .Qn(Qn_wire2), .D(Qn_wire2)
              , .Clk(Qn_wire1), .Clr(ClearIn) );
  DFFC FF_Bit3(.Q(CountOut[3]), .Qn(Qn_wire3), .D(Qn_wire3)
              , .Clk(Qn_wire2), .Clr(ClearIn) );
  //
endmodule // Ripple4DFF.
//
