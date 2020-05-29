// ===========================================================
// Netter:  Demonstrates result of drive strength contention,
// using buf primitives with instantiation at different 
// strengths.
//
// ------------------------------------------------------------
// 2005-09-07 jmw: v. 1.3 Removed unused Xwire and Ywire.
// 2005-05-04 jmw: v. 1.2 Blocking assigns for combinational
//                 logic.
// 2005-04-12 jmw: v. 1.1 Added `ifdef to run DC.
// 2004-12-26 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Netter (output XYout, input[3:0] Sel);
  //
  wire XYwire, Xin, Yin;
  wire SupplyOutX, StrongOutX, PullOutX, WeakOutX;
  wire SupplyOutY, StrongOutY, PullOutY, WeakOutY;
  wire[3:0] xChoice, yChoice;  // To activate the bufif1's.
  //
  reg[3:0] xReg, yReg;         // To use a case.
  //
  // ---------------------------------------------------- 
  // Declare the buffers of different strengths.  The
  // X and Y will be assigned to contend with each other
  // in all possible combinations.   Notice the mnemonic
  // naming of the wires and buffers:
  //
  bufif1 (supply1, supply0) SupplyBufX(SupplyOutX, Xin, xChoice[0]);
  bufif1 (strong1, strong0) StrongBufX(StrongOutX, Xin, xChoice[1]);
  bufif1 (pull1, pull0)     PullBufX  (PullOutX,   Xin, xChoice[2]);
  bufif1 (weak1, weak0)     WeakBufX  (WeakOutX,   Xin, xChoice[3]);
  //
  bufif1 (supply1, supply0) SupplyBufY(SupplyOutY, Yin, yChoice[0]);
  bufif1 (strong1, strong0) StrongBufY(StrongOutY, Yin, yChoice[1]);
  bufif1 (pull1, pull0)     PullBufY  (PullOutY,   Yin, yChoice[2]);
  bufif1 (weak1, weak0)     WeakBufY  (WeakOutY,   Yin, yChoice[3]);
  //
  assign Xin = 1'b0;
  assign Yin = 1'b1;
  //
  // ---------------------------------------------------- 
  // Convert the input count to a 1-hot, decoded count:
  // The X count comes from the low-order 2 bits in Sel;
  // the Y count comes from the high-order 2.  This
  // could be done without declaring a reg, by using
  // nested conditionals, but a case is much easier
  // to read and maintain:
  //
  always@(Sel)
    begin
    case (Sel[1:0])
      2'b00: xReg = 4'b0001;
      2'b01: xReg = 4'b0010;
      2'b10: xReg = 4'b0100;
      2'b11: xReg = 4'b1000;
    default: xReg = 'bx; // To handle an 'x' in.
    endcase
    //
    case (Sel[3:2])
      2'b00: yReg = 4'b0001;
      2'b01: yReg = 4'b0010;
      2'b10: yReg = 4'b0100;
      2'b11: yReg = 4'b1000;
    default: yReg = 'bx; // To handle an 'x' in.
    endcase
    end
  assign #1 xChoice = xReg;  // Let a count pick all
  assign #1 yChoice = yReg;  // possible combinations.
  //
  // ---------------------------------------------------- 
  // Wire the contending values:
  //
  assign XYwire = SupplyOutX;
  assign XYwire = StrongOutX;
  assign XYwire = PullOutX;
  assign XYwire = WeakOutX;
  assign XYwire = SupplyOutY;
  assign XYwire = StrongOutY;
  assign XYwire = PullOutY;
  assign XYwire = WeakOutY;
  //
  assign XYout = XYwire;  // Drive the module output.
  //
endmodule // Netter.
//
`ifdef DC
`else
module NetterTst;
  //
  wire ContendWatch;
  reg[3:0] CountStim;
  reg      ClockStim;
  //
  always@(ClockStim) #10 ClockStim <= ~ClockStim;
  always@(ClockStim) #1 CountStim <= CountStim + 1;
  //
  initial
    begin
    #00   CountStim = 4'b1111;
    #00   ClockStim = 1'b0;

    #170 $finish;
    end
  //
  Netter NetterInst1( .XYout(ContendWatch), .Sel(CountStim) );
  //
endmodule //NetterTst.
`endif
