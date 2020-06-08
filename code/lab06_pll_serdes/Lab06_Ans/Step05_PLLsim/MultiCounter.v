// ====================================================================
// FileName : MultiCounter.v
// Function : The counter which is used to multiply the VFO frequency 
//            for PLL clock output.
//
// --------------------------------------------------------------------
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
//====================================================================

module MultiCounter (output CarryOut, input Clock, Reset);
  
  reg[4:0] Ctr; // Carry from bit 3 to bit 4 is used.
  
  // always@(posedge Reset, posedge Clock)
  always@(posedge Clock, posedge Reset)
    if (Reset==1'b1)
         Ctr <= 'b0;
    else Ctr <= Ctr + 1;
  
  assign CarryOut = Ctr[4];
  
endmodule // MultiCounter
