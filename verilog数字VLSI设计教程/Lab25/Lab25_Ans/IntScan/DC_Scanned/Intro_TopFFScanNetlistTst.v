// ===========================================================
// Intro_TopFF_Tst:  Simulation driver module (stimulus block) 
// for the synthesized, scan-inserted netlist Intro_Top.
//
// ------------------------------------------------------------
// 2005-12-01 jmw: v. 3.0 Modified for scan netlist.
// 2005-02-09 jmw: v. 2.0 Modified for output FF's before DC scan
//            insertion.
// 2004-12-08 jmw: v. 1.0 implemented by copying from Lab01.
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Intro_TopFF_Tst;
//
reg  Astim, Bstim, Cstim, Dstim, Clkstim, Clrstim;
wire Xwatch, Ywatch, Zwatch;
// New for scan:
wire tdoWatch;
reg  tdiStim, tmsStim;
//
integer i;
//
always@(Clkstim) #5 Clkstim <= ~Clkstim;
//
initial
  begin
  #0  Clrstim = 1'b0;
      tdiStim = 1'b0;
      tmsStim = 1'b0;
  #1  Astim   = 1'b0;
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
  #250
  // Repeat, with scan enabled:
  tmsStim = 1'b1;
  for (i=0; i<5; i = i+1)
    #100 tdiStim = ~tdiStim;
  //
  #230 tmsStim = 1'b0;
  #100
  for (i=0; i<8; i = i+1)
    #50 tdiStim = ~tdiStim;
  //
  #150 $finish;
  end
//
// The instance of the design is named TopNet1:
//
Intro_TopFF TopNet1
  ( .X(Xwatch), .Y(Ywatch), .Z(Zwatch), .tdo(tdoWatch)
  , .A(Astim),  .B(Bstim),  .C(Cstim), .D(Dstim)
  , .Clk(Clkstim), .Clr(Clrstim), .tdi(tdiStim), .tms(tmsStim)
  );
//
endmodule // Intro_TopFF_Tst.
