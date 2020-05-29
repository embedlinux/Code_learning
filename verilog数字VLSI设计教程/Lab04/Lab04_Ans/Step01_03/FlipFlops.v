// ===========================================================
// FlipFlops:  Shows three different flip-flop types in
// one module.
//
// There are no module inputs, because the purpose is just
// to simulate the flip-flop blocks.
// ------------------------------------------------------------
// 2005-01-31 jmw: v. 1.2 Instantiated in testbench to drive
//            inputs by vcs.
// 2005-01-27 jmw: v. 1.1 Changed some nonblocking delays for
//            synthesis.
// 2004-12-03 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module FlipFlops ( output Qsimple, Qclear, QpreClear
                 , input D, clk1, clk2, clr, pre);
  //
  wire clr_n, pre_n;            // Derived inputs.
  //
  reg  QsimpleReg, QclearReg, QpreClearReg; // Storage.
  //
  // ========= End declarations. =====================
  //
  assign clr_n = clr;  // Rename these to conform with
  assign pre_n = pre;  // their assertion state.
  //
  assign #2 Qsimple   = QsimpleReg; // Put outputs on I/O's.
  assign #3 Qclear    = QclearReg;
  assign #4 QpreClear = QpreClearReg;
  //
  // ----------------------------------
  always@(posedge clk1) QsimpleReg <= D;
  //
  // ----------------------------------
  always@(negedge clk1, posedge clr)
     begin
     if (clr == 1'b1)
          QclearReg <= 1'b0;
     else QclearReg <= D;
     end
  //
  // ----------------------------------
  always@(posedge clk2, negedge pre_n, negedge clr_n)
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
    if      (clr_n == 1'b0) 
             QpreClearReg <= 1'b0; // clear has priority.
    else if (pre_n == 1'b0) 
             QpreClearReg <= 1'b1;
    else if ( clk2 == 1'b1) 
             QpreClearReg <= D;
    end
  //
  // ========= End behavior models. =====================
  //
endmodule // FlipFlops.
//
`ifdef DC
`else
module FlipFlopsTst; // Testbench.
//
reg D, clk1, clk2, clr, pre;
//
  always@(clk1) 
                #5 clk1 <= ~clk1;
  always@(clk2) 
                #5 clk2 <= ~clk2;
  //
  initial
    begin 
    // Notice how many cases would have to be
    // simulated to check this simple design
    // exhaustively by simulation alone:
    //
    #0    D = 1'b0; // The only time EVER to use '#0'
       clk1 = 1'b0; // without deep doubts!
        clr = 1'b0;
        pre = 1'b0;
    //
    #2.5
        clk2 = 1'b0; // Establish phase difference.
    //
    #2.5
           D = 1'b1;
    #10  clr = 1'b1;
    #10  clr = 1'b0;
    #10  clr = 1'b1;
    #10  clr = 1'b0;
    #04    D = 1'b0;
    #01  pre = 1'b1;
    #10  pre = 1'b0;
    #10  pre = 1'b0;
    #10  clr = 1'b1;
    #10  pre = 1'b0;
    #10  clr = 1'b0;
    #10  pre = 1'b1;
    #10  clr = 1'b1;
    #04    D = 1'b1;
    #01  pre = 1'b1;
    #10  pre = 1'b0;
    #10  pre = 1'b0;
    #10  clr = 1'b1;
    #10  pre = 1'b0;
    #10  clr = 1'b0;
    #10  pre = 1'b1;
    #10  clr = 1'b1;
    //
    #15 $finish;
    end
//
FlipFlops FFs_U1 ( .Qsimple(Qsimple), .Qclear(Qclear), .QpreClear(QpreClear)
                 , .D(D), .clk1(clk1), .clk2(clk2), .clr(clr), .pre(pre)
                 );
endmodule // FlipFlopsTst.
`endif
