// ===========================================================
// MultiCounter: The counter which is used to multiply
//               the VFO frequency for PLL clock output.
//
// ------------------------------------------------------------
// 2005-02-12 jmw: v. 1.3 Removed some irrelevant comments for Lab08.
// 2005-01-31 jmw: v. 1.2 Replaced initial with Reset.
// 2004-12-12 jmw: v. 1.1 Implemented 5-bit counter.
// 2004-12-11 jmw: v. 1.0 Implemented for port wiring only.
// ============================================================
//
module MultiCounter (output CarryOut, input Clock, Reset);
  //
  reg[4:0] Ctr; // Carry from bit 3 to bit 4 is used.
  //
  always@(posedge Reset, posedge Clock)
    if (Reset==1'b1)
         Ctr <= 'b0;
    else Ctr <= Ctr + 1;
  //
  assign CarryOut = Ctr[4];
  //
endmodule // MultiCounter.
