// ===========================================================
// ShiftFlop:  A flip-flop with asynchronous clear, for
// use in shift register models.
//
// Inherits simulation `timescale.
// ------------------------------------------------------------
// 2005-01-27 jmw: v. 1.1 Modified for synthesis.
// 2004-12-04 jmw: v. 1.0 implemented.
// ============================================================
//
module ShiftFlop (output Q, Qn, input D, Clk, Clr);
  //
  reg  QReg;  // Storage.
  //
  assign #2 Q  =  QReg;  // State changes get own delays.
  assign #1 Qn = ~QReg;
  //
  always@(posedge Clk, posedge Clr)
     if (Clr == 1'b1)
          QReg <= 1'b0;
     else QReg <= D;
  //
endmodule // ShiftFlop.
