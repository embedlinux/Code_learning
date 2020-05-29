// ===========================================================
// XorNor:   Combinational logic module.
//
// ------------------------------------------------------------
// 2004-12-08 jmw:  v. 1.0 of XorNor implemented by copying
//            from Lab01.
// 2004-11-25 jmw:  v. 1.0 implemented.
// ============================================================
module XorNor (output X, Y, input A, B, C);
  wire x;
  //
  assign #1 X = x;
  //
  assign #10 x = A ^ B;
  assign #10 Y = ~(x | C);
endmodule // XorNor
