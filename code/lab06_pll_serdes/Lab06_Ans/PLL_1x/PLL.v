// ===========================================================
// FileName : PLL.v
// Function : Top level of a 1x PLL design simulation model.
//            Nominal frequency is 400 MHz.
//
// ------------------------------------------------------------
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
// ============================================================

module PLL (output ClockOut, input ClockIn, Reset);

wire[1:0] AdjFreq;
wire VFO_Ck;

assign ClockOut = VFO_Ck;

Comparator 
u_Comparator ( .AdjustFreq  (AdjFreq), 
               .ClockIn     (ClockIn),
               .PLLClock    (VFO_Ck), 
               .Reset       (Reset)
             );
VFO
u_VFO ( .ClockOut     (VFO_Ck), 
        .AdjustFreq   (AdjFreq), 
        .Reset        (Reset)
      );

endmodule // PLL

