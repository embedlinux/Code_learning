// ===========================================================
// Comparator:  The comparator controlling frequency
//              of the PLL VFO.
// ------------------------------------------------------------
// 2007-04-16 jmw: v. 1.0 Copied v. 1.0 of verilog Lab22,
//      renamed to Comparator; CounterClock port to PLLClock.
//  Changed case all explicit + undefined defaults = no change.
// 2006-05-17 jmw: v. 1.0 Complete redesign with two counters
//      running concurrently.   One counter counts PLL
//  MultiCounter output edges (CounterClock); the other counts
//  the edges of the synchronizing ClockIn input clock.
//  Also modified the output command encoding:  AdjustFreq
//  values of 2'b10 or 2'b01 mean to do nothing to the
//  (adjustable) PLL CounterClock.
// ============================================================
//
module Comparator (output reg[1:0] AdjustFreq
                       , input ClockIn, PLLClock, Reset
                       );
reg[1:0] ClockInN, PLLClockN;
reg ZeroCounters;
//
always@(posedge ClockIn, posedge ZeroCounters)
  begin : ClockCtr
  if (ZeroCounters==1'b1)
       ClockInN <= 2'b00;
  else ClockInN <= ClockInN + 2'b01;
  end
//
always@(posedge PLLClock, posedge ZeroCounters)
  begin : PLLCtr
  if (ZeroCounters==1'b1)
       PLLClockN <= 2'b00;
  else PLLClockN <= PLLClockN + 2'b01;
  end
//
always@(posedge ClockIn, posedge Reset)
  begin : Zeroer
  if (Reset==1'b1)
       ZeroCounters <= 1'b1;
  else ZeroCounters <= (ClockInN==2'b11)? 1'b1 : 1'b0;
  end
//
// Clock with the sampled PLLClock so that
// ClockIn is set up for case statement:
//
always@(posedge PLLClock, posedge Reset)
  begin : EdgeComparator
  if (Reset==1'b1) AdjustFreq = 2'b01;
  else
  case (ClockInN)
    2'b00: begin
           case (PLLClockN)
             2'b00: AdjustFreq = 2'b01; // No change.
             2'b01: AdjustFreq = 2'b00; // Slow the counter.
             2'b10: AdjustFreq = 2'b00; // Slow the counter. 
             2'b11: AdjustFreq = 2'b00; // Slow the counter. 
           default: AdjustFreq = 2'b01; // No change.
           endcase
           end
    2'b01: begin
           case (PLLClockN)
             2'b00: AdjustFreq = 2'b11; // Speed up the counter.
             2'b01: AdjustFreq = 2'b01; // No change.
             2'b10: AdjustFreq = 2'b00; // Slow the counter.  
             2'b11: AdjustFreq = 2'b00; // Slow the counter.  
           default: AdjustFreq = 2'b01; // No change.
           endcase
           end
    2'b10: begin
           case (PLLClockN)
             2'b00: AdjustFreq = 2'b11; // Speed up the counter.
             2'b01: AdjustFreq = 2'b11; // Speed up the counter.
             2'b10: AdjustFreq = 2'b10; // No change.
             2'b11: AdjustFreq = 2'b00; // Slow the counter.  
           default: AdjustFreq = 2'b10; // No change.
           endcase
           end
    2'b11: begin
           case (PLLClockN)
             2'b00: AdjustFreq = 2'b11; // Speed up the counter.
             2'b01: AdjustFreq = 2'b11; // Speed up the counter.
             2'b10: AdjustFreq = 2'b11; // Speed up the counter.
             2'b11: AdjustFreq = 2'b10; // No change.
           default: AdjustFreq = 2'b10; // No change.
           endcase
           end
  default: begin // Allows initialization:
           case (PLLClockN)
           default: AdjustFreq = 2'b10; // No change.
           endcase
           end
  endcase
  end
//
endmodule // Comparator.
