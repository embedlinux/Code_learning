// ===========================================================
// AndOr:   Combinational logic module.
//
// ------------------------------------------------------------
// 2004-12-08 jmw:  v. 1.0 implemented by copying from Lab01.
// 2004-11-25 jmw:  v. 1.0 implemented.
// ============================================================
module AndOr (output X, Y, input A, B, C);
  assign #10 X = A & B;
  assign #10 Y = B | C;
endmodule
