// ===========================================================
// Synch4DFFWor:  A 4-bit synchronous counter built in DFFs
//          and using wired-or logic.
//
// A wor represents a set of drivers of a new kind, which
// are allowed to contend on a multiply-driven wire to
// function as a logic or.  We thus assume there will be no
// additional delay on the wor output (expression).
//
// Because the or'd wires connect to pins that should not
// be or'd, redeclaring anything as wor type would cause
// errors.   New wor wires have to be declared.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 2.0 Removed testbench to separate file.
// 2004-12-20 jmw: v. 1.0 implemented.
// ============================================================
//
module Synch4DFFWor ( output[3:0] CountOut
                    , input ClockIn, ClearIn);
  //
  wire Qn_wire0, Qn_wire1, Qn_wire2, Qn_wire3;
  wire wireToD1, wireToD2, wireToD3;
  wor OrToFF2, OrToFF3;  // Redeclared wire types.
  //
  // The OR expressions:
  //
  assign OrToFF2 = Qn_wire0;
  assign OrToFF2 = Qn_wire1;
  assign OrToFF3 = OrToFF2;
  assign OrToFF3 = Qn_wire2;
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
endmodule // Synch4DFFWor.
//
