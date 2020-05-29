// ===========================================================
// TestBench:  Simulation driver module (stimulus block) 
// for the top-level block instance of Intro_Top.
//
// No module port declaration.
// ------------------------------------------------------------
// 2004-12-08 jmw: v. 1.0 implemented by copying from Lab01;
//            added FF scan clock stimulus.
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1 ns/100ps
//
module TestBench;    // Stimulus blocks have no port.
//
reg  Astim, Bstim, Cstim, Dstim;  // To accept initialization.
reg  ClockStim, ClearStim;        // For scan FFs.
wire Xwatch, Ywatch, Zwatch;      // To connect to design instance.
//
always@(ClockStim) #25 ClockStim <= ~ClockStim;
//
initial
  begin
  #0  ClockStim = 1'b0;
  #0  ClearStim = 1'b0;
  #1  Astim = 1'b0;   // For Astim, 1 bit, representing a binary 0.
  #1  Bstim = 1'b0;
  #1  Cstim = 1'b0;
  #1  Dstim = 1'b0;
  #100 Astim = 1'b1; // Increased all data delays from #50 to #100.
  #100 Bstim = 1'b1;
  #100 Cstim = 1'b1;
  #100 Dstim = 1'b1;
  #100 Bstim = 1'b0;
  #100 Dstim = 1'b0;
  #100 Dstim = 1'b1;
  #100 Astim = 1'b0;
  #100 Cstim = 1'b0;
  #100 Dstim = 1'b0;
  #100 $finish;
  end
//
// The instance of the design is named Top1:
//
Intro_Top Top1( .X(Xwatch), .Y(Ywatch), .Z(Zwatch)
              , .A(Astim),  .B(Bstim),  .C(Cstim), .D(Dstim)
              , .ScanClk(ClockStim), .ScanClr(ClearStim)
              );
//
endmodule // TestBench.
