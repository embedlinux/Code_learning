// ===========================================================
// FileNaem : VFO.v
// Function : A variable-frequency oscillator controlled by a
//            2-bit input which either increments or decrements
//            the current running frequency.
//
// AdjustFreq frequency codes:
//  2'b11 = speed-up
//  2'b00 = slow down
//  2'b01 = don't change.
//
// This design is unsynthesizable, but it permits adjustment
// of the VFO frequency with precision down to the limit of
// the `timescale resolution.
//
// ------------------------------------------------------------
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
// ============================================================

`include "PLL.inc"

module VFO (output ClockOut, input[1:0] AdjustFreq, input Reset);

reg  PLLClock;
real VFO_Delay;

assign ClockOut = PLLClock;

always@(PLLClock, Reset)
begin
  if (Reset==1'b1)
  begin
    VFO_Delay = `VFOBaseDelay;  // 1.25ns:400MHz
    PLLClock  = 1'b0;
  end
  else 
  begin
    if ( (AdjustFreq==2'b11) && (VFO_Delay > `VFO_Min) ) // VFO_Min:1.0
      VFO_Delay = VFO_Delay - `VFO_Delta;
    else if ( (AdjustFreq==2'b00) && (VFO_Delay < `VFO_Max) ) // VFO_Max:1.5
           VFO_Delay = VFO_Delay + `VFO_Delta;
           // else, leave VFO_Delay alone.
    #VFO_Delay PLLClock <= ~PLLClock;  // The oscillator, 
                                       // there are blocking and non-blocking assign in one always block
                                       // be careful for this usage; and not suitable for RTL coding
                                       // RTL Coding Style: Never mix the blocking and non-blocking assign
                                       //                   in a single always block.
  end
end
endmodule // VFO
