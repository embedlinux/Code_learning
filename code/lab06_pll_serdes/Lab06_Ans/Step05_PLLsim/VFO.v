// =======================================================================
// FileName : VFO.v
// Function : A variable-frequency oscillator controlled by a 2-bit input 
//            which either increments or decrements the current running 
//            frequency.
//            Nominal frequency is 32 MHz, for the SerDes PLL synchronized 
//            to a nominal 1 MHz parallel clock.
//
// ----------------------------------------------------------------------
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
// =====================================================================

// Path is relative to simulator invocation, not to design top:
`include "PLLsim.inc"

module VFO (output ClockOut, input[1:0] AdjustFreq,
            input SampleCmd, Reset
           );
  reg VFO_ClockOut;
  integer BaseDelay, VFO_Delay, VFO_Delta, VFO_MaxDelta;
  
  assign ClockOut = VFO_ClockOut;
  
  always@(Reset, SampleCmd, VFO_ClockOut)
    if (Reset==1'b1)
         begin
         BaseDelay    = `VFOBaseDelay;
         VFO_Delta    = `VFO_DelayDelta;
         VFO_MaxDelta = `VFO_MaxDelta;
         VFO_Delay    = `VFOBaseDelay;
         VFO_ClockOut = 1'b0;
         end
    else 
    begin
    if (SampleCmd==1'b1)
      begin
      if ( AdjustFreq>2'b01 
         && (BaseDelay - VFO_MaxDelta < VFO_Delay) )
           // If floor is lower than current:
           VFO_Delay = VFO_Delay - VFO_Delta;
      else if ( AdjustFreq<2'b01 
              && (BaseDelay + VFO_MaxDelta > VFO_Delay) )
           // If ceiling is higher than current:
           VFO_Delay = VFO_Delay + VFO_Delta;
      // else, leave VFO_Delay alone.
      end
    `ifdef DC
    #VFO_Delay VFO_ClockOut = ~VFO_ClockOut;
    `else
    #VFO_Delay VFO_ClockOut <= ~VFO_ClockOut;  // Or, VCS won't oscillate.
    `endif
    end
  
endmodule // VFO
