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
// 2006-10-25 jmw: v. 1.2 Added reset port & stimuli.  Made the
//            scan clock free-running.  Increased times by
//      factor of 3 (#50 --> #150, etc.).
// 2005-03-14 jmw: v. 1.1 Lab25:  Removed Extras.inc ref.
//               and some old comments; added scan I/O's.
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1 ns/100ps   // No semicolon after `(anything).
//
module TestBench;    // Stimulus blocks have no port.
//
reg  Astim, Bstim, Cstim, Dstim, ScanInStim, ScanModeStim
  ,  ScanClkStim, ScanRstStim;
wire Xwatch, Ywatch, Zwatch, ScanOutWatch;
//
integer i;
//
always@(ScanClkStim) #100 ScanClkStim <= ~ScanClkStim;
//
// Scan mode state:
initial
  begin
        ScanInStim   = 1'b1;
  #1    ScanModeStim = 1'b0;
  #1000 ScanModeStim = 1'b1;
  #1000 ScanModeStim = 1'b0;
  #2000 ScanModeStim = 1'b1;

  end
//
// Test Vectors:
initial
  begin
  //
  #1   Astim    = 1'b0;
  #1   Bstim    = 1'b0;
  #1   Cstim    = 1'b0;
  #1   Dstim    = 1'b0;
       ScanClkStim  = 1'b0;
       ScanRstStim  = 1'b0;
  #50   ScanRstStim  = 1'b1;
  #150  ScanRstStim  = 1'b0;
  //
  #150  Astim = 1'b1;
  #150  Bstim = 1'b1;
  #150  Cstim = 1'b1;
  #150  Dstim = 1'b1;
  #150  Bstim = 1'b0;
  #150  Dstim = 1'b0;
  #150  Dstim = 1'b1;
  #150  Astim = 1'b0;
  #150  Cstim = 1'b0;
  #150  Dstim = 1'b0;
  //
  #150  ScanRstStim  = 1'b0;
  #150  ScanRstStim  = 1'b1;
  #550  ScanRstStim  = 1'b0;
  //
  #150  Astim = 1'b1;
  #150  Bstim = 1'b1;
  #150  Cstim = 1'b1;
  #150  Dstim = 1'b1;
  #150  Bstim = 1'b0;
  #150  Dstim = 1'b0;
  #150  Dstim = 1'b1;
  #150  Astim = 1'b0;
  #150  Cstim = 1'b0;
  #150  Dstim = 1'b0;
  //
  #1000 $finish;       // Terminates simulation.
  end // No semicolon after end.
//
Intro_Top Topper01
  ( .X(Xwatch), .Y(Ywatch), .Z(Zwatch), .ScanOut(ScanOutWatch)
  , .A(Astim),  .B(Bstim),  .C(Cstim), .D(Dstim)
  , .ScanIn(ScanInStim), .ScanMode(ScanModeStim)
  , .ScanClk(ScanClkStim), .ScanRst(ScanRstStim)
  );
//
endmodule // TestBench.
