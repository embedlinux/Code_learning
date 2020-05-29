// ===========================================================
// XorNor:   Combinational logic using ^ and ~|.
// This module represents simple combinational logic including
// an XOR and a NOR expression.
//
// ANSI module header.
// ------------------------------------------------------------
// 2005-04-09 jmw: v. 1.1 modified comment on wire declarations.
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
module XorNor (output X, Y, input A, B, C);
  wire x; // To illustrate use of internal wiring.
  //
  assign #1 X = x;
  //
  assign #10 x = A ^ B;
  assign #10 Y = ~(x | C);
  //
endmodule // XorNor
