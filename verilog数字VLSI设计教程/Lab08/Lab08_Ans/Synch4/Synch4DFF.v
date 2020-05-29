// ===========================================================
// Synch4DFF:  A 4-bit synchronous counter built in DFFs.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 2.0 Removed testbench to separate file.
// 2004-12-19 jmw: v. 1.0 implemented.
// ============================================================
//
module Synch4DFF ( output[3:0] CountOut
                  , input ClockIn, ClearIn);
  //
  wire Qn_wire0, Qn_wire1, Qn_wire2, Qn_wire3;
  wire wireToD1, wireToD2, wireToD3;
  wire OrToFF2, OrToFF3;
  //
  // The OR expressions:
  //
  assign #2 OrToFF2 = Qn_wire0 | Qn_wire1;
  assign #2 OrToFF3 = OrToFF2  | Qn_wire2;
  //
  // The XOR expressions:
  //
  assign #2 wireToD1 = Qn_wire0 ^ Qn_wire1; // Actually, 1-input or.
  assign #2 wireToD2 = Qn_wire2 ^ OrToFF2;
  assign #2 wireToD3 = Qn_wire3 ^ OrToFF3;
  //
  // The LSB DFF just toggles:
  DFFC FF_Bit0(.Q(CountOut[0]), .Qn(Qn_wire0), .D(Qn_wire0)
              , .Clk(ClockIn), .Clr(ClearIn) );

  DFFC FF_Bit1(.Q(CountOut[1]), .Qn(Qn_wire1), .D(wireToD1)
              , .Clk(ClockIn), .Clr(ClearIn) );
              
  DFFC FF_Bit2(.Q(CountOut[2]), .Qn(Qn_wire2), .D(wireToD2)
              , .Clk(ClockIn), .Clr(ClearIn) );

  DFFC FF_Bit3(.Q(CountOut[3]), .Qn(Qn_wire3), .D(wireToD3)
              , .Clk(ClockIn), .Clr(ClearIn) );
  //
endmodule // Synch4DFF.
//
