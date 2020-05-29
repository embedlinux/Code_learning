// ===========================================================
// ClockComparator:  The comparator controlling frequency
//                   of the PLL VFO.
//
// The small, v. 1.1 6-bit counter assumes that the frequency 
// difference will never exceed a factor of 63, which would
// possibly cause an overflow.
// ------------------------------------------------------------
// 2006-05-17 jmw: v. 1.0 Copied from Lab21.
// ============================================================
//
module ClockComparator (output reg[1:0] AdjustFreq
                       , input ClockIn, CounterClock, Reset
                       );
reg[1:0] VarClockCount;
//
// The count from the previous edge is used for the
// comparison:
always@(ClockIn, Reset)
  if (Reset==1'b1)
       begin
       AdjustFreq    = 2'b01;
       VarClockCount = 2'b01;
       end
  else if (CounterClock==1'b1)
            VarClockCount = VarClockCount + 2'b01;
       else begin
            case (VarClockCount)
                2'b00: AdjustFreq = 2'b11; // Better speed it up.
                2'b01: AdjustFreq = 2'b01; // Seems matched.
              default: AdjustFreq = 2'b00; // Must be too fast.
            endcase
            VarClockCount = 2'b00; // Initialize for next ClockIn edge.
            end
endmodule // ClockComparator.
