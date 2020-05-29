// ===========================================================
// TestBench:  Simulation driver module (stimulus block) 
// for the top-level block instance of Intro_Top.
//
// No module port declaration.
// ------------------------------------------------------------
// 2005-02-09 jmw: v. 2.0 Modified for output FF's for DC scan
//            insertion.
// 2004-12-08 jmw: v. 1.0 implemented by copying from Lab01.
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1 ns/100ps
//
module TestBench;    // Stimulus blocks have no port.
//
reg  Astim, Bstim, Cstim, Dstim   // To accept initialization.
  ,  Clkstim, Clrstim;
wire Xwatch, Ywatch, Zwatch;      // To connect to design instance.
//
always@(Clkstim) #5 Clkstim <= ~Clkstim;
//
initial
  begin
  #0  Clrstim = 1'b0;
  #1  Astim   = 1'b0;   // For Astim, 1 bit, representing a binary 0.
  #1  Bstim   = 1'b0;
  #1  Cstim   = 1'b0;
  #1  Dstim   = 1'b0;
  #1  Clrstim = 1'b1;
  #1  Clkstim = 1'b0;
  #4  Clrstim = 1'b0;
  #50 Astim   = 1'b1;
  #50 Bstim   = 1'b1;
  #50 Cstim   = 1'b1;
  #50 Dstim   = 1'b1;
  #50 Bstim   = 1'b0;
  #50 Dstim   = 1'b0;
  #50 Dstim   = 1'b1;
  #50 Astim   = 1'b0;
  #50 Cstim   = 1'b0;
  #50 Dstim   = 1'b0;
  #50 $finish;
  end
//
// The instance of the design is named Top1:
//
Intro_TopFF
      Top1( .X(Xwatch), .Y(Ywatch), .Z(Zwatch)
          , .A(Astim),  .B(Bstim),  .C(Cstim), .D(Dstim)
          , .Clk(Clkstim), .Clr(Clrstim)
          );
//
endmodule // TestBench.
