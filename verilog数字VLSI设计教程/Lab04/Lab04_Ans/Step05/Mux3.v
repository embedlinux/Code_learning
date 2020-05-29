// ===========================================================
// Mux3:  A three-input mux model for Lab04, for
// use in shift register models.   Modified by adding one more
// input to Mux2.
//
// ------------------------------------------------------------
// 2007-01-30 jmw: v. 1.0 implemented.
// ============================================================
//
module Mux3 (output Z, input[1:0] Sel
            , input In1, In2, In3
            );
reg Zreg;
//
assign Z = Zreg;
//
always@(*)
  case (Sel)
    2'b00 : Zreg = In1;
    2'b01 : Zreg = In2;
  default : Zreg = In3;
  endcase
//
endmodule // Mux3.
