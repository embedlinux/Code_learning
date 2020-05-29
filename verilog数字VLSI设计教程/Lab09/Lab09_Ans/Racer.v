// ===========================================================
// Racer:  Race condition simulation.
//
// Two different results can be obtained in simulation if the
// order of the always blocks (below) is reversed.
//
// To enable Case 2, comment out the `define Case1 below
// and rerun the simulation.
//
// ------------------------------------------------------------
// 2006-10-02 jmw: v. 2.1 Changed comments from VCS.
// 2005-12-19 jmw: v. 2.0 Both orderings in one sim. run.
// 2005-09-07 jmw: v. 1.1 2nd always assignment to blocking.
// 2004-12-26 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
`define Case1
//
module Racer (output RaceOut1, RaceOut2, input DoPulse);
  //
  reg RaceReg1, RaceReg2;
  //
  assign RaceOut1 = RaceReg1;
  assign RaceOut2 = RaceReg2;
  //
`ifdef Case1
  // These two always blocks are ordered one way:
  always@(DoPulse)
    begin
    #1 RaceReg1 = 1'b0;
    #1 RaceReg1 = 1'b1;
    #1 RaceReg1 = 1'b0;
    end
  always@(DoPulse) #1 RaceReg1 = ~RaceReg1;
  //
`else
  // These two always blocks are ordered the other way:
  always@(DoPulse) #1 RaceReg2 = ~RaceReg2;
  always@(DoPulse)
    begin
    #1 RaceReg2 = 1'b0;
    #1 RaceReg2 = 1'b1;
    #1 RaceReg2 = 1'b0;
    end
`endif
  //
endmodule // Racer.
//
module RacerTst;
  //
  wire Race1, Race2;
  reg  ClockStim;
  //
  always@(ClockStim) #10 ClockStim <= ~ClockStim;
  //
  initial
    begin
    #00   ClockStim = 1'b0;
    #100 $finish;
    end
  //
  Racer RacerInst1(
                    .RaceOut1(Race1)
                  , .RaceOut2(Race2)
                  , .DoPulse(ClockStim)
                  );
  //
endmodule // RacerTst.
