// ===========================================================
// Comparator:  The comparator controlling frequency
//              of the 1x PLL VFO.
//
// AdjustFreq frequency control encoding:
//  2'b11 = speed-up
//  2'b00 = slow down
//  2'b01 = don't change.
//
// This unsynthesizable design is consistent with the equally
// unsynthesizable VFO programmed delays -- which, however,
// permit fine, almost analogue frequency adjustments of the
// VFO.
//
// The averaging bidirectional counter is initialized at a
// midpoint value.  After a certain number of clock HiCounts
// have been evaluated, the total deviation from the init point
// is used to decide whether to increase of decrease the PLL
// oscillation frequency.
// HiCount is declared 3 bits instead of 2 to avoid overflow
// wraparound.
// All assignments are blocking, to make updated values
// available as procedural blocks are read.
// ------------------------------------------------------------
// 2007-04-15 jmw: v. 2.0 Added averaging counter to reduce
//      synchronization threshold.
// 2007-04-14 jmw: v. 1.0 Initial design from old Lab06 PLLsim
//      ClockComparator v. 1.3.
// ============================================================
//
module Comparator (output[1:0] AdjustFreq
                  , input ClockIn, PLLClock, Reset
                  );
localparam N = 3; // 2^(N+1) is averager resolution.
localparam InitAvg = 1<<N; // Midpoint value for AvgEdge.
//
reg[1:0] Adjr;
assign AdjustFreq = Adjr;
// -------------------------------
// Sanity-check assertion:
`ifdef DC
`else
initial
  if (N<3)
    begin
    $display("%m: Comparator averager width=%d is too low.", N);
    $display("%m: Cannot simulate this design.");
    $finish;
    end
`endif
// -------------------------------
//
reg[2:0] HiCount;  // Counts PLL highs per ClockIn.
reg[1:0] EdgeCode; // Locally encodes edge decision.
reg[N:0] AvgEdge;  // Decision variable.
reg[N-1:0] Done;   // Decision trigger variable.
//
// The first always block is edge-oriented:
// The value of EdgeCode is used to increment or decrement
// AvgEdge.
always@(ClockIn, Reset)
  begin : CheckEdges
  if (Reset==1'b1)
       begin
       EdgeCode = 2'b01;
       HiCount  =  'b0;
       end
  else if (PLLClock==1'b1) // Should be 1 of these per ClockIn cycle.
            HiCount = HiCount + 3'b1;
       else // Check to see how many PLL 1's we caught:
            begin
            case (HiCount)
             3'b000: EdgeCode = 2'b00; // PLL too slow.
             3'b001: EdgeCode = 2'b01; // Seems matched.
            default: EdgeCode = 2'b11; // PLL too fast.
            endcase
            HiCount = 'b0; // Initialize for next ClockIn edge.
            end
  end // CheckEdges.
//
// The second always block is decision-oriented:
always@(ClockIn, Reset)
  begin : MakeDecision
  if (Reset==1'b1)
       begin
       Adjr    = 2'b1; // No change code.
       Done    =  'b0;
       AvgEdge =  InitAvg;
       end
  else begin // Update the AvgEdge & check for decision:
       case (EdgeCode)
       2'b11: AvgEdge = AvgEdge + 1; // Add to PLL edge count.
       2'b00: AvgEdge = AvgEdge - 1; // Sub from PLL edge count.
       // default: do nothing.
       endcase
       Done = Done + 1;
       if (Done=='b0) // Wrap-around.
              begin
              if ( AvgEdge<(InitAvg-1) )
                  Adjr = 2'b11; // Better speed it up.
              else if ( AvgEdge>(InitAvg+1) )
                   Adjr = 2'b00; // Must be too fast.
              else Adjr = 2'b01; // No change.
              AvgEdge = InitAvg; // Initialize for next Done.
              end
       end
  end // MakeDecision.
//
endmodule // Comparator.
