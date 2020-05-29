// ===========================================================
// ParamCounterTop:  Top level of a design showing the use
// of verilog parameters to modify the width of data objects.
//
// The Counter module does a simple count; the Converter module
// copies the result into a register of configurable width.
//
// Notice that the `define is used only at the top level.
// This is just for demonstration purposes; a better
// idea would be to define a parameter pWidth in the top
// level module header.
//
// This module contains the top structure of the design, which
// is made up of two lower-level modules.
//
// A testbench with an initial block for simulation is added 
// at the bottom of this file.
//
// ------------------------------------------------------------
// 2007-09-18 jmw: v. 1.1 Renamed OUTWIDTH to PADWIDTH.
// 2004-12-02 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
`define PADWIDTH 3  // Global width; controls parameter values.
                    // No reference to PADWIDTH except at top.
//
module ParamCounterTop  // Top-level params in ANSI format:
      #(parameter pHi = `PADWIDTH-1  // Saves repeated "-1".
               , pPad = 5            // The Count width control.
       )
       ( output[pHi+pPad:0] Count
       , input  Clock, CountEnable, CountReset, OutEnable);
  //
  wire[pHi:0] Xfer;  // Local bus to connect module instances.
  //
  // Pass parameter values by name:
  //
  Counter #(.pHi(pHi))
    Counter01(Xfer, Clock, CountEnable, CountReset);
  //
  Converter #(.pHi(pHi), .pPad(pPad))
    Converter01(Count, Xfer, OutEnable);
  //
endmodule // ParamCounterTop.
//
module TestBench;
  //
  // The parameter definitions in TestBench are redundant,
  // because testbench will not be synthesized.
  // Changing testbench param values will override the
  // values in the design, which become defaults when
  // the design is instantiated in the testbench module:
  //
  parameter pHi = `PADWIDTH - 1, pPad = 3;
  //
  wire[pHi+pPad:0] CountTest;
  reg CountEnableTest
      , ClockTest
      , CountResetTest
      , OutEnableTest;
  //
  // Design instance:
  ParamCounterTop
      #(.pHi(pHi), .pPad(pPad)) // Pass testbench size to design.
    Top(
          .Count(CountTest)
        , .CountEnable(CountEnableTest)
        , .Clock(ClockTest)
        , .CountReset(CountResetTest)
        , .OutEnable(OutEnableTest)
       );
  //
  initial
    begin
    #01 ClockTest       = 1'b0;
        CountEnableTest = 1'b0;
        CountResetTest  = 1'b0;
        OutEnableTest   = 1'b0;
    #02 CountResetTest  = 1'b1;
    #02 CountResetTest  = 1'b0;
    //
    #01 CountEnableTest = 1'b1;
    #02 OutEnableTest   = 1'b1;
    // Later, we shall see better ways to
    // define a clock:
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #01 OutEnableTest   = 1'b0;
    #02 OutEnableTest   = 1'b1;
    #05 ClockTest       = 1'b1;  // Clock skips #3 here.
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #05 ClockTest       = 1'b0;
    #05 ClockTest       = 1'b1;
    #10 $finish;
    end
  //
endmodule // TestBench.

