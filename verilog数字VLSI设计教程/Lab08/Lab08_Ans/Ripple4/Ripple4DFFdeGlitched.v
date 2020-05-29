// ===========================================================
// Ripple4DFFdeGlitched:  A 4-bit ripple counter.
//
// ------------------------------------------------------------
// 2004-12-20 jmw: v. 1.1 Ripple4DFF copied and an output
//            FF added to prevent intermediate-count glitches.
// 2004-12-19 jmw: v. 1.0 of Ripple4DFF implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Ripple4DFFdeGlitched
       ( output[3:0] CountOut
       , input ClockIn, ClearIn);
  //
  reg[3:0]  OutLatch; // Deglitch with latches.
  wire[3:0] QtoLatch;
  //
  wire Qn_wire0, Qn_wire1, Qn_wire2, Qn_wire3;
  //
  DFFC FF_Bit0(.Q(QtoLatch[0]), .Qn(Qn_wire0), .D(Qn_wire0)
              , .Clk(ClockIn), .Clr(ClearIn) );
  DFFC FF_Bit1(.Q(QtoLatch[1]), .Qn(Qn_wire1), .D(Qn_wire1)
              , .Clk(Qn_wire0), .Clr(ClearIn) );
  DFFC FF_Bit2(.Q(QtoLatch[2]), .Qn(Qn_wire2), .D(Qn_wire2)
              , .Clk(Qn_wire1), .Clr(ClearIn) );
  DFFC FF_Bit3(.Q(QtoLatch[3]), .Qn(Qn_wire3), .D(Qn_wire3)
              , .Clk(Qn_wire2), .Clr(ClearIn) );
  //
  // Deglitching code.   New data are output only on
  // the next clock edge.
  // This prevents glitching, and it adds some more logic
  // delay; but, most importantly, it adds pattern latency
  // by delaying each count value update by a whole clock
  // period.
  // Another way would be to trigger changes on the opposite
  // clock edge, which would halve the latency but might still
  // allow glitching.   In a bigger design, a handshake or 
  // other control signal might be available to use latches
  // instead of FFs to remove the glitches (latches can be
  // smaller or faster than FFs).
  //
  // Imagine how slow a 32-bit ripple counter would be!
  //
  assign #2 CountOut = OutLatch;
  //
  always@(posedge ClockIn) OutLatch <= QtoLatch;
  //
endmodule // Ripple4DFFdeGlitched.
//
`ifdef DC
`else
module RippleTst; // Testbench.
  //
  reg ClockStim, ClearStim;
  wire[3:0] CountWatch;
  //
  //
  always@(ClockStim) #11 ClockStim <= ~ClockStim;
  //
  initial
    begin
    #0   ClockStim = 1'b0;
    #0   ClearStim = 1'b0;
    #1   ClearStim = 1'b1;
    #5   ClearStim = 1'b0;
    // #121 ClearStim = 1'b1;
    // #5   ClearStim = 1'b0;
    #500 $finish;
    end
  //
  Ripple4DFFdeGlitched
  Rippler( .CountOut(CountWatch)
         , .ClockIn(ClockStim)
         , .ClearIn(ClearStim)
         );
  //
endmodule // RippleTst.
`endif

