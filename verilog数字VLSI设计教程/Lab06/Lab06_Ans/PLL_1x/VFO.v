// ===========================================================
// VFO:  A variable-frequency oscillator controlled by a
//       2-bit input which either increments or decrements
//       the current running frequency.
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
// 2007-04-15 jmw: v. 1.0 Initial design copied from the old
//      PLLsim VFO v. 1.3.  Sample input removed.
//      Minor expression reformats.
// ============================================================
//
`include "PLL.inc"
//
module VFO (output ClockOut, input[1:0] AdjustFreq, input Reset);
reg PLLClock;
real VFO_Delay;
//
assign ClockOut = PLLClock;
//
always@(PLLClock, Reset)
  if (Reset==1'b1)
       begin
       VFO_Delay = `VFOBaseDelay;
       PLLClock  = 1'b0;
       end
  else begin
       if ( (AdjustFreq==2'b11) && (VFO_Delay > `VFO_Min) )
            VFO_Delay = VFO_Delay - `VFO_Delta;
       else
       if ( (AdjustFreq==2'b00) && (VFO_Delay < `VFO_Max) )
            VFO_Delay = VFO_Delay + `VFO_Delta;
       // else, leave VFO_Delay alone.
       #VFO_Delay PLLClock <= ~PLLClock;  // The oscillator.
       end
//
endmodule // VFO.
