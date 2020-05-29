// ===========================================================
// BehShift:  Shift register 5 bits wide.
// Asynchronous clear asserted high; posedge clock.
//
// Uses behavioral always block instead of structural
// flip-flops and muxes.
//
// The separate testbench module is implemented below the
// shift register model.
//
// This is a synthesizable version, with delays in the
// procedural code switched out for synthesis.
// ------------------------------------------------------------
// 2007-11-19 jmw: v. 2.1 Doubled clock period for better VCS
//      wave display.  Slower tb, too.
// 2007-09-26 jmw: v. 2.0 Removed procedural delays to suit
//      VCS-MX.
// 2007-01-30 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module BehShift
      (output QOut, input DIn, ShiftEna, ClkIn, ClrIn);
  //
  reg[4:0] QReg;            // The shift-register storage.
  //
  assign #0.5 QOut = QReg[4]; // Wire the storage out.
  //
  always@(posedge ClkIn, posedge ClrIn)
    if (ClrIn==1'b1)
         QReg <= 'b0;
    else begin
         QReg[0] <= (ShiftEna==1'b1)? DIn     : QReg[0];
         QReg[1] <= (ShiftEna==1'b1)? QReg[0] : QReg[1];
         QReg[2] <= (ShiftEna==1'b1)? QReg[1] : QReg[2];
         QReg[3] <= (ShiftEna==1'b1)? QReg[2] : QReg[3];
         QReg[4] <= (ShiftEna==1'b1)? QReg[3] : QReg[4];
         end
  //
endmodule // BehShift.
//
// -------------------------------------------------
// Testbench slightly modified, because of different
// timing in the behavioral model:
//
`ifdef DC
`else
module ShiftTester; // No I/O's.
  //
  reg  S_D, S_Ena, S_Clk, S_Clr;
  wire S_QOut;
  //
  BehShift SerShifter
      ( .QOut(S_QOut), .DIn(S_D), .ShiftEna(S_Ena)
      , .ClkIn(S_Clk), .ClrIn(S_Clr) );
 
  always@(S_Clk) #10 S_Clk <= ~S_Clk;
  //
  always
    begin
    #20 S_D = 1'b1;  // Test pattern = 5'b11100 = 5'h1c.
    #20 S_D = 1'b1;
    #20 S_D = 1'b1;
    #20 S_D = 1'b0;
    #20 S_D = 1'b0;
    end
  //
  initial
    begin 
    #0   S_D = 1'b0; // The only time EVER to use '#0'
       S_Clr = 1'b1; // without deep doubts!
       S_Ena = 1'b1;
    //
    #1.5 S_Clk = 1'b0; // Establish phase difference.
    //
    #3.5 S_Clr = 1'b0;
    #80  S_Ena = 1'b1;
    #190 S_Clr = 1'b1;
    #35  S_Clr = 1'b0;
    #150 S_Ena = 1'b0;
    #80  S_Ena = 1'b1;
    //
    #200 $finish;
    end
  //
endmodule // ShiftTester.
`endif
