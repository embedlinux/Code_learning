// ===========================================================
// AndOr:   Combinational logic using & and |.
// This module represents simple combinational logic including
// an AND and an OR expression.
//
// ANSI module header.
// ------------------------------------------------------------
// 2004-11-25 jmw:  v. 1.0 implemented.
// ============================================================
module AndOr (output X, Y, input A, B, C);
  assign #10 X = A & B;
  assign #10 Y = B | C;
endmodule
