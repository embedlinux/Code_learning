// ===========================================================
// DFFC:  A flip-flop with asynchronous clear, for
// use in shift register models of Lab 4
//
// Inherits simulation `timescale.
// ------------------------------------------------------------
// 2005-01-28 jmw: v. 1.2 Moved delays away from nonblocks for
//            synthesis.
// 2004-12-19 jmw: v. 1.1 Renamed to DFFC & timing for Lab08.
// 2004-12-04 jmw: v. 1.0  of ShiftFlop implemented.
// ============================================================
//
module DFFC (output Q, Qn, input D, Clk, Clr);
  //
  reg  QReg;  // Storage.
  //
  assign #3 Q  =  QReg; // Timing for Lab08.
  assign #3 Qn = ~QReg;
  //
  always@(posedge Clk, posedge Clr)
     if (Clr == 1'b1)
          QReg <= 1'b0;
     else QReg <= D;
  //
endmodule // DFFC.
