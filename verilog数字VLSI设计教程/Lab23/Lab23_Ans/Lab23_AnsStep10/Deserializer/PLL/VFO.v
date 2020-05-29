// ===========================================================
// VFO:  Synthesizable PLL Variable-Frequency Oscillator.
//       Rewritten entirely from the  Lab21 VFO model.
//
// A variable-frequency oscillator controlled by a 2-bit input
// which either increments or decrements the current running
// frequency of the PLL output clock.  Nominal output frequency
// is 32 MHz from a nominal 1 MHz input clock.
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
// Multiplied by 32 by MultiCounter, the resulting ~0.230 ns
// per clock edge makes the parameterization below work.
//
// The synthesized result is a very inaccurate PLL which,
// however, is self-correcting and does run in the range
// of the correct (32 MHz) output frequency.
//
// ------------------------------------------------------------
// 2006-07-24 jmw: v. 1.4 Fixed ElemDelay from 0.0825 to
//      0.0850 to better match actual delay in my modified
//      tcbn90ghp_v2001.v library (with full-path delays).
// 2006-05-23 jmw: v. 1.3 Changed include for easy synthesis. 
// 2006-05-17 jmw: v. 1.2 Added automatic calculation of 
//            `DivideFactor.  Renamed some `defines and params.
// 2006-05-09 jmw: v. 1.1 Modified for faster DEL005 verilog
//      model (based on low loading).
// 2006-04-26 jmw: v. 1.0 implemented as a complete redesign
//      of the Lab21 PLL VFO.   Uses instances of DEL005 
//   delay cells for oscillator.
// ============================================================
//
// The timescale and VFO_MaxDelta from the Deserializer
// design are used in VFO:
//
`include "Deserial.inc"
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
// The next macro configures the FastClock oscillator and
// FastDivvy counter (2 elems probably is too fast for
// DEL005 and 90-nm Typical gates):
//
`define NumElems  5      // Delay line length.
//
// ---------------------------------------------------
// We use the PLL multiplication factor, 32, to set the
// initial DivideFactor.
// We want to divide the frequency, and the delay line
// just gives edge delays, so the initial divide factor
// should be about 1/4 the PLL multiplication factor:
//
`define ElemDelay 0.0850 // Delay element avg. delay.
`define DivideFactor 32.0/(4.0*`NumElems*`ElemDelay)
//
// NFastBits will be calculated to ensure that the
// frequency initialization value (`DivideFactor) will
// be less than the maximum value of the FastDivvy and
// DivideFactor regs declared below.
// ---------------------------------------------------
module VFO (output ClockOut, input[1:0] AdjustFreq
           , input Sample, Reset
           );
reg    ClockOutReg;
assign ClockOut = ClockOutReg;
//
// Configure the fast clock counter:
localparam NFastBits =   (`DivideFactor < (2**3 - (`VFO_MaxDelta/(2.0*`ElemDelay) + 1)) )? 3
                   : (`DivideFactor < (2**4 - (`VFO_MaxDelta/(2.0*`ElemDelay) + 1)) )? 4
                   : (`DivideFactor < (2**5 - (`VFO_MaxDelta/(2.0*`ElemDelay) + 1)) )? 5
                   : (`DivideFactor < (2**6 - (`VFO_MaxDelta/(2.0*`ElemDelay) + 1)) )? 6
                   : (`DivideFactor < (2**7 - (`VFO_MaxDelta/(2.0*`ElemDelay) + 1)) )? 7
                   : (`DivideFactor < (2**8 - (`VFO_MaxDelta/(2.0*`ElemDelay) + 1)) )? 8
                   : 9;
//
localparam[NFastBits-1:0] DivideLoLim = (`VFO_MaxDelta/(2.0*`ElemDelay)) + 1;
localparam[NFastBits-1:0] DivideHiLim =  2**NFastBits - 2;
//
// Assertions:
`ifdef DC
`else
initial
  begin
  $display("VFO FastClock delay chain: %0.0f cells @%1.4f ns; f divider=[%0.0f] bits.\n"
          ,                          `NumElems, `ElemDelay,         NFastBits
          );
  $display("VFO divide factor=%0.0f; so, initial SYNTH 1 MHz in => %2.1f MHz out.\n"
          ,       `DivideFactor, 1000.0/(4*`ElemDelay*`NumElems*`DivideFactor)
          );
  $display("`VFO_MaxDelta=[%0.0f]=> Divider limits: Low Lim=%0.0f and High Lim=%0.0f.\n"
          , `VFO_MaxDelta,                           DivideLoLim,          DivideHiLim
          );
  end
`endif
//
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
    DEL005 Delay83ps ( .Z(WireD[i+1]), .I(WireD[i]) );
    end
endgenerate
//
//synopsys dc_tcl_script_begin
// set_dont_touch *Delay83ps*
// set_dont_touch WireD*
//synopsys dc_tcl_script_end
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
assign WireD[0] = ~FastClock;
//
// ----------------------------------------------------------
// Define the adjustable output clock.  This is just a counter
// with a variable wrap to 0.   FastDivvy wraps to set the delay
// according to the required DivideFactor.
//
reg[NFastBits-1:0] FastDivvy, DivideFactor;
//
always@(posedge FastClock, posedge Reset)
  begin : ClockOutGen
  if (Reset==1'b1)
       begin
       FastDivvy   <=  'b0;
       ClockOutReg <= 1'b0;
       end
  else begin
       if (FastDivvy < DivideFactor)
            FastDivvy <= FastDivvy + 1'b1;
       else begin
            FastDivvy   <= 'b0;
            ClockOutReg <= ~ClockOutReg;
            end
       end
  end // ClockOutGen.
// 
// ----------------------------------------------------------
// Use the PLL sampler to adjust the clock half-period.
//
always@(posedge Sample, posedge Reset)
  begin : Sampler
  if (Reset==1'b1)
       DivideFactor <= `DivideFactor;
  else begin
       case (AdjustFreq)
         2'b00: // Adjust f down (delay up):
                if (DivideFactor < DivideHiLim)
                   DivideFactor <= DivideFactor + 1'b1;
         2'b11: // Adjust f up (delay down):
                if (DivideFactor > DivideLoLim)
                   DivideFactor <= DivideFactor - 1'b1;
       endcase // Default: leave DivideFactor alone.
       end
  end // Sampler.
//
endmodule // VFO.
//
// Prevent local defines from getting to other 
// compilation modules:
`undef ElemDelay
`undef NumElems
`undef DivideFactor
//
