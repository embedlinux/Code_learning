// ===========================================================
// Mux2:  A two-input mux model for Lab04, for
// use in shift register models.
//
// Inherits simulation `timescale.
// ------------------------------------------------------------
// 2007-01-29 jmw: v. 1.0 implemented.
// ============================================================
//
module Mux2 (output Z, input Sel, In1, In2);
  //
  reg Zreg;
  //
  assign Z = Zreg;
  //
  always@(*)
     if (Sel == 1'b0)
          Zreg = In1;
     else Zreg = In2;
  //
endmodule // Mux2.
