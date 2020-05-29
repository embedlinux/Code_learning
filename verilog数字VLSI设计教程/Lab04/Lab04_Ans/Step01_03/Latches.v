// ===========================================================
// Latches:  Shows three different latch types in
// one module.
//
// ------------------------------------------------------------
// 2007-09-24 jmw: v. 1.5 Added ena sensitivity for true 
//            transparent latches.
// 2005-11-17 jmw: v. 1.4 Fixed missing ena2 assign and misplaced
//            `endif.
// 2005-11-02 jmw: v. 1.3 Minor indentation change.
// 2005-02-14 jmw: v. 1.2 Added separate testbench module.
// 2005-01-27 jmw: v. 1.1 Changed some nonblocking delays for
//            synthesis.
// 2004-12-04 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Latches (output Qsimple, Qclear, QpreClear
               , input D, ena1, ena2, clr, pre);
  //
  wire clr_n, pre_n, ena1_n;    // Derived inputs.
  //
  reg  QsimpleReg, QclearReg, QpreClearReg; // Storage.
  //
  // ========= End declarations. =====================
  //
  assign clr_n  = clr;  // Rename these to conform with
  assign pre_n  = pre;  // their assertion state.
  assign ena1_n = ena1;
  //
  assign #1 Qsimple   = QsimpleReg; // Storage to I/O's.
  assign #2 Qclear    = QclearReg;
  assign #2 QpreClear = QpreClearReg;
  //
  // ----------------------------------
  always@(D, ena1) if (ena1==1'b1) QsimpleReg <= D;
  //
  // ----------------------------------
  always@(D, ena1_n, clr)
     begin
     if (clr == 1'b1)
          QclearReg <= 1'b0;
     else if (ena1_n==1'b0)
          QclearReg <= D;
     end
  //
  // ----------------------------------
  // Here, clear has priority over preset:
  //
  always@(D, pre_n, clr_n, ena2)
    begin
    // Put the assertion local to the device that it 
    // is intended to check:
    `ifdef DC
    `else
    if (pre_n==1'b0 && clr_n==1'b0)
      $strobe("\n***Time=%04d.  pre_n=%01b and clr_n=%01b asserted.\n"
             , $time, pre_n, clr_n);
    `endif
    //
    if      (clr_n == 1'b0) QpreClearReg <= 1'b0;
    else if (pre_n == 1'b0) QpreClearReg <= 1'b1;
    else if ( ena2 == 1'b1) QpreClearReg <= D;
    end
endmodule // Latches.
  //
  // ========= End behavior models. =====================
  //
  `ifdef DC
  `else
module LatchesTst; // Testbench.
  wire QsimpleW, QclearW, QpreClearW, D, ena1, clr, pre;
  reg DReg, ena1Reg, ena2Reg, clrReg, preReg;
  //
  assign D    = DReg;
  assign ena1 = ena1Reg;
  assign ena2 = ena2Reg;
  assign clr  = clrReg;
  assign pre  = preReg;
  //
  always@(DReg)    #15    DReg <= ~DReg;
  always@(ena2Reg) #10 ena2Reg <= ~ena2Reg;
  //
  initial
    begin 
    // Notice how many cases would have to be
    // simulated to check this simple design
    // exhaustively by simulation alone:
    //
    #0    DReg = 1'b0; // The only time EVER to use '#0'
       ena1Reg = 1'b0; // without deep doubts!
        clrReg = 1'b0;
        preReg = 1'b0;
    //
    #2.5
        ena2Reg = 1'b0; // Establish phase difference.
    //
    #2.5
        ena1Reg = 1'b1;
    #10  clrReg = 1'b1;
    #10  clrReg = 1'b0;
    #10  clrReg = 1'b1;
    #10  clrReg = 1'b0;
    #04  ena1Reg = 1'b0;
    #03  preReg = 1'b1;
    #10  preReg = 1'b0;
    #10  preReg = 1'b0;
    #10  clrReg = 1'b1;
    #10  preReg = 1'b0;
    #10  clrReg = 1'b0;
    #10  preReg = 1'b1;
    #10  clrReg = 1'b1;
    #04  ena1Reg = 1'b1;
    #01  preReg = 1'b1;
    #10  preReg = 1'b0;
    #10  preReg = 1'b0;
    #10  clrReg = 1'b1;
    #10  preReg = 1'b0;
    #10  clrReg = 1'b0;
    #10  preReg = 1'b1;
    #10  clrReg = 1'b1;
    //
    #20 $finish;
    end
    Latches LatchesInst1
            ( .Qsimple(QsimpleW), .Qclear(QclearW), .QpreClear(QpreClearW)
            , .D(D), .ena1(ena1), .ena2(ena2)
            , .clr(clr), .pre(pre)
            );
  //
endmodule // LatchesTst.
  `endif
