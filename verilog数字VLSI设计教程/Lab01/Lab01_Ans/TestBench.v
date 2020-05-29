// ===========================================================
// TestBench:  Simulation driver module (stimulus block) 
// for the top-level block instance of Intro_Top.
//
// This module includes an initial block which assigns various
// values to top-level inputs for simulation.   initial blocks
// are ignored in logic synthesis.
//
// No module port declaration.
// ------------------------------------------------------------
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1 ns/100ps   // No semicolon after `(anything).
//
module TestBench;    // Stimulus blocks have no port.
//
reg  Astim, Bstim, Cstim, Dstim;  // To accept initialization.
wire Xwatch, Ywatch, Zwatch;      // To connect to design instance.
//
initial
  begin
`include "../../VCS/Extras.inc"
  //
  // Each '#' precedes a delay time, here in 1 ns units:
  //
  #1  Astim = 1'b0;   // For Astim, 1 bit, representing a binary 0.
  #1  Bstim = 1'b0;
  #1  Cstim = 1'b0;
  #1  Dstim = 1'b0;
  #50 Astim = 1'b1;
  #50 Bstim = 1'b1;
  #50 Cstim = 1'b1;
  #50 Dstim = 1'b1;
  #50 Bstim = 1'b0;
  #50 Dstim = 1'b0;
  #50 Dstim = 1'b1;
  #50 Astim = 1'b0;
  #50 Cstim = 1'b0;
  #50 Dstim = 1'b0;
  #50 $finish;       // Terminates simulation.
  end // No semicolon after end.
//
// The instance of the design is named Topper01, and its
// ports are associated by name with stimulus input and simulation
// output wires:
//
Intro_Top Topper01 ( .X(Xwatch), .Y(Ywatch), .Z(Zwatch)
                   , .A(Astim),  .B(Bstim),  .C(Cstim), .D(Dstim)
                   );
//
endmodule // TestBench.
