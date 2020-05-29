// ===========================================================
// SyncClearFlipFlop:  Shows a flip-flop with synchronous
// clear.
//
// ------------------------------------------------------------
// 2005-02-14 jmw: v. 1.2 Added separate testbench module.
// 2005-01-27 jmw: v. 1.1 Changed some nonblocking delays for
//            synthesis.
// 2004-12-03 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module SyncClearFlipFlop (output Q, input D, clk, clr);
  //
  reg  QReg;        // Storage.
  //
  // ========= End declarations. =====================
  //
  assign #1 Q = QReg; // Put stored value on I/O.
  //
  // ----------------------------------
  // Just remove the clr sensitivity:
  //
  always@(posedge clk)
     begin
     if (clr == 1'b1)
          QReg <= 1'b0;
     else QReg <= D;
     end
  //
endmodule // SyncClearFlipFlop.
  // ========= End behavior. =========================
  //
  `ifdef DC
  `else
module SyncClearTst;
//
 wire QWire;
  reg clk, D, clr;
  //
  always@(clk) #5 clk <= ~clk;
  //
  initial
    begin 
    //
    #0    D = 1'b0;
        clr = 1'b0;
    #02 clk = 1'b0; // Start clock shift vs other changes.
    //
    #03    D = 1'b1;
    #05    D = 1'b0;
    #10  clr = 1'b1;
    #10  clr = 1'b0;
    #05    D = 1'b1;
    #10  clr = 1'b1;
    #10  clr = 1'b0;
    //
    #15 $finish;
    end
SyncClearFlipFlop SC_FF1 ( .Q(QWire), .D(D), .clk(clk), .clr(clr) );
  //
endmodule // SyncClearTst.
  `endif
