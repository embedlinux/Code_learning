// ===========================================================
// ClockComparator:  The comparator controlling frequency
//                   of the PLL VFO.
// ------------------------------------------------------------
// 2006-05-17 jmw: v. 1.0 Complete redesign with two counters
//      running concurrently.   One counter counts PLL
//  MultiCounter output edges (CounterClock); the other counts
//  the edges of the synchronizing ClockIn input clock.
//  Also modified the output command encoding:  AdjustFreq
//  values of 2'b10 or 2'b01 mean to do nothing to the
//  (adjustable) PLL CounterClock.
// ============================================================
//
module ClockComparator (output reg[1:0] AdjustFreq
                       , input ClockIn, CounterClock, Reset
                       );
reg[1:0] ClockInN, CounterClockN;
reg ZeroCounters;
//
always@(posedge ClockIn, posedge ZeroCounters)
  begin : ClockCtr
  if (ZeroCounters==1'b1)
       ClockInN <= 2'b00;
  else ClockInN <= ClockInN + 2'b01;
  end
//
always@(posedge CounterClock, posedge ZeroCounters)
  begin : CounterCtr
  if (ZeroCounters==1'b1)
       CounterClockN <= 2'b00;
  else CounterClockN <= CounterClockN + 2'b01;
  end
//
always@(posedge ClockIn, posedge Reset)
  begin : Zeroer
  if (Reset==1'b1)
       ZeroCounters <= 1'b1;
  else ZeroCounters <= (ClockInN==2'b11)? 1'b1 : 1'b0;
  end
//
// Clock with the sampled CounterClock so that
// ClockIn is set up for case statement:
//
always@(posedge CounterClock, posedge Reset)
  begin : EdgeComparator
  if (Reset==1'b1) AdjustFreq = 2'b01;
  else
  case (ClockInN)
    2'b00: begin
           case (CounterClockN)
             2'b00: AdjustFreq = 2'b01; // No change.
             2'b01: AdjustFreq = 2'b00; // Slow the counter.
             2'b10: AdjustFreq = 2'b00; // Slow the counter. 
           default: AdjustFreq = 2'b00; // Slow the counter. 
           endcase
           end
    2'b01: begin
           case (CounterClockN)
             2'b00: AdjustFreq = 2'b11; // Speed up the counter.
             2'b01: AdjustFreq = 2'b01; // No change.
             2'b10: AdjustFreq = 2'b00; // Slow the counter.  
           default: AdjustFreq = 2'b00; // Slow the counter.  
           endcase
           end
    2'b10: begin
           case (CounterClockN)
             2'b00: AdjustFreq = 2'b11; // Speed up the counter.
             2'b01: AdjustFreq = 2'b11; // Speed up the counter.
             2'b10: AdjustFreq = 2'b10; // No change.
           default: AdjustFreq = 2'b00; // Slow the counter.  
           endcase
           end
  default: begin // Includes 2'b11; allows initialization:
           case (CounterClockN)
             2'b00: AdjustFreq = 2'b11; // Speed up the counter.
             2'b01: AdjustFreq = 2'b11; // Speed up the counter.
             2'b10: AdjustFreq = 2'b11; // Speed up the counter.
           default: AdjustFreq = 2'b10; // No change.
           endcase
           end
  endcase
  end
//
endmodule // ClockComparator.
