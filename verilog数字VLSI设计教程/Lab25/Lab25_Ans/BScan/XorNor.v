// ===========================================================
// XorNor:   Combinational logic using ^ and ~|.
// This module represents simple combinational logic including
// an XOR and a NOR expression.
//
// ANSI module header.
// ------------------------------------------------------------
// 2004-11-25 jmw:  v. 1.0 implemented.
// ============================================================
module XorNor (output X, Y, input A, B, C);
  wire x; // Must use wire, because can't read an output port.
  //
  assign #1 X = x;
  //
  assign #10 x = A ^ B;
  assign #10 Y = ~(x | C);
endmodule // XorNor
