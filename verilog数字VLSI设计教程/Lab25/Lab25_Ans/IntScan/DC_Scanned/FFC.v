// ===========================================================
// FFC:  A flip-flop with asynchronous clear, for
// use in shift register models.
// ------------------------------------------------------------
// 2004-12-08 jmw: v. 1.0 of FFC implemented by copying my
//            ShiftFlop from Lab04 and renaming it "FFC"
//            (FF w. Clr).
// 2004-12-04 jmw: v. 1.0 implemented.
// ============================================================
//
module FFC (output Q, Qn, input D, Clk, Clr);
  //
  reg  QReg;  // Storage.
  //
  assign #2 Q  =  QReg;
  assign #1 Qn = ~QReg;
  //
  always@(posedge Clk, posedge Clr)
     if (Clr == 1'b1)
          QReg <= 1'b0;
     else QReg <= D;
  //
endmodule // FFC.
