// ===========================================================
// VFO:  Synthesizable PLL Variable-Frequency Oscillator.
//
// A variable-frequency oscillator controlled by a 2-bit input
// which either increments or decrements the current running
// frequency of the PLL output clock.  Nominal output frequency
// was 32 MHz from a nominal 1 MHz input clock, but in this
// modified design is 1-to-1.
//
// This module MUST be calibrated to the synthesis library
// in use, by assigning the `defines below appropriately.
//
// The present design depends on a free-running oscillator in
// TSMC 90-nm library at a configurable frequency which must be
// slow enough to allow a counter to count correctly to
// control the output clock frequency by the AdjustFreq input.
//
// In tcbn90ghptc, VCS SDF back-annotated wire-load delays of
// the DEL005 instances (1 load each) are 0.07 - 0.08 ns.
//
// ------------------------------------------------------------
// 2007-04-16 jmw: v. 1.1 removed `VFO_Delta for use with
//      Lab06 1x PLL demo model.
// 2007-04-13 jmw: v. 1.0 Copied from verilog Lab22 v. 1.2.
//      Changed almost all parameters to make it lock at
//      1-to-1 frequency.  Renamed FastDivvy to ProgClk
//      (="Programmable Clock").  Instantiated an INVD0 to
//      close the FastClock generator loop.
// ============================================================
//
// ---------------------------------------------------
// The empirical frequency-setting parameters:
// DivideFactor is the number of fast-counter increments
// per PLL output clock.   Thus, PLL output period is
// given by: T = 2*DivideFactor*ElemDelay, in which,
//
// ElemDelay = DelayElementAvgDelay
//
// ElemDelay is estimated in ns, averaged over rise &
// fall, and it is used in VCS message calculations as
// well as VFO frequency limit stops.
//
// ---------------------------------------------------
// The next configures the FastClock oscillator and
// ProgClk counter (2 elems probably is too fast for
// DEL005 and 90-nm Typical gates):
//
`define NumElems  3    // Delay line length; for synth, > 2.
`define ElemDelay 0.085 // Delay element avg. delay.
// The FastClock period estimate, including 1 inverter, in ns:
`define FastPeriod ((`NumElems*`ElemDelay)+1.0)*2.0
// Hard-code the width of the fast counter:
`define NFastBits 5  // 5 -> 0..31; for synth, > 4.
`define InitialCount (1<<(`NFastBits-1))
`define MaxCount    ((1<<`NFastBits)-1)
// ===================================================
// ---------------------------------------------------
// ===================================================
//
`include "PLL.inc"
//
module VFO (output ClockOut, input[1:0] AdjustFreq
           , input ClockIn, Reset
           );
reg    ClockOutReg;
assign ClockOut = ClockOutReg;
//
localparam DivideLoLim = 0;
localparam DivideHiLim = `MaxCount;
//
// Messages:
`ifdef DC
`else
initial
  begin
  $display("VFO FastClock chain: %0.0f cells @%1.4f ns; f divider=[%0.0f] bits.\n"
          ,          `NumElems, `ElemDelay,         `NFastBits
          );
  $display("`VFO_Delta=[%0.0f]=> Limits: Low Lim=%1d and High Lim=%1d.\n"
          , `VFO_Delta,                 DivideLoLim,    DivideHiLim
          );
  $display("Free-running VFO at initial count of %1d --> %.0f ns.\n"
          ,                  `InitialCount, `InitialCount*`FastPeriod
          );
  end
`endif
//
// ----------------------------------------------------------
//synopsys dc_tcl_script_begin
// set_dont_touch *Delay85ps*
// set_dont_touch WireD*
// set_dont_touch FastClock*
//synopsys dc_tcl_script_end
// ----------------------------------------------------------
// Generate the free-running clock (FastClock), using a chain
// of delay cells:
//
wire[`NumElems:0] WireD;
//
generate
  genvar i;
  for (i=0; i<`NumElems; i = i+1)
    begin : DelayLine
    DEL005 Delay85ps ( .Z(WireD[i+1]), .I(WireD[i]) );
    end
endgenerate
//
reg FastClock;
//
always@(Reset, WireD)
  begin : FastClockGen
  if (Reset==1'b1)
       FastClock = 1'b0;
  else // The free-running clock gets the output of the delay line:
       FastClock = WireD[`NumElems];
  end
//
// Feed the inverted edge back into the delay line
// and create the oscillator inverter:
//
//INVD0 FastClockInv (WireD[0], FastClock);
INVD0 Inv75ps ( .ZN(WireD[0]), .I(FastClock) );
//
// ----------------------------------------------------------
// Define the adjustable output clock.  This is just a counter
// with a variable wrap to 0.   ProgClk wraps to set the delay
// according to the required DivideFactor.
//
reg[`NFastBits-1:0] ProgClk, DivideFactor;
//
always@(posedge FastClock, posedge Reset)
  begin : ClockOutGen
  if (Reset==1'b1)
       begin
       ProgClk     <=  'b0;
       ClockOutReg <= 1'b0;
       end
  else begin
       if (ProgClk < DivideFactor)
            ProgClk <= ProgClk + 1'b1;
       else begin
            ProgClk     <= 'b0;
            ClockOutReg <= ~ClockOutReg; // Oscillator.
            end
       end
  end // ClockOutGen.
// 
// ----------------------------------------------------------
// Use the PLL sampler to adjust the clock half-period.
//
always@(posedge ClockIn, posedge Reset)
  begin : FreqAdj
  if (Reset==1'b1)
       DivideFactor <= `InitialCount;
  else begin
       case (AdjustFreq)
         2'b00: // Adjust f down (delay up):
                if (DivideFactor < DivideHiLim)
                   DivideFactor <= DivideFactor + `VFO_Delta;
         2'b11: // Adjust f up (delay down):
                if (DivideFactor > DivideLoLim)
                   DivideFactor <= DivideFactor - `VFO_Delta;
       endcase // Default: leave DivideFactor alone.
       end
  end // FreqAdj.
//
endmodule // VFO.
//
// Prevent local defines from getting to other 
// compilation modules:
`undef ElemDelay
`undef NumElems
`undef DivideFactor
//
