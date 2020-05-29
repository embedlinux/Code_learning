// ===========================================================
// MultiCounter: The counter which is used to multiply
//               the VFO frequency for PLL clock output.
//
// ------------------------------------------------------------
// 2006-12-07 jmw: v. 1.0 Copied from Lab21.
// ============================================================
//
module MultiCounter (output CarryOut, input Clock, Reset);
//
reg[4:0] Ctr; // Carry from bit 3 to bit 4 is used.
//
always@(posedge Reset, posedge Clock)
  if (Reset==1'b1)
       Ctr <= 'b0;
  else Ctr <= Ctr + 5'h1;
//
assign CarryOut = Ctr[4];
//
endmodule // MultiCounter.
