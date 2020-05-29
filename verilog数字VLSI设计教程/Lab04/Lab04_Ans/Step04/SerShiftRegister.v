// ===========================================================
// SerShiftRegister:  Shift register 5 bits wide.
// Asynchronous clear asserted high; posedge clock.
//
// Uses flip-flop submodule, ShiftFlop.  Qn outputs of
// flip-flops are unused.
// Also uses 2-input mux model, Mux2.
//
// The separate testbench module is implemented below the
// shift register model.
//
// ------------------------------------------------------------
// 2007-01-29 jmw: v. 2.0 Uses a mux to enable shift for each
//      flip-flop, rather than a gated clock.
// 2004-12-04 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module SerShiftRegister
      (output QOut, input DIn, ShiftEna, ClkIn, ClrIn);
  //
  wire[3:0] QtoD; // Connects each Q to its mux input 1 (no shift).
                  // Also, connects each Q to the next mux input 2 (shift).
  wire[4:0] ZtoD; // Connects each mux output to its flip-flop input D.
  //
  wire ShOut;  // To schedule a delay on the final output.
  //
  // -------------- End declarations. -------------
  //
  assign #0.5 QOut = ShOut;            // Wire the storage out.
  //
  Mux2 Mux4 ( .Z(ZtoD[4]), .Sel(ShiftEna), .In1(ShOut), .In2(QtoD[3]) );
  ShiftFlop 
    FF4 (.Q(ShOut),   /*Qn*/ .D(ZtoD[4]), .Clk(ClkIn), .Clr(ClrIn) );
  //
  Mux2 Mux3 ( .Z(ZtoD[3]), .Sel(ShiftEna), .In1(QtoD[3]), .In2(QtoD[2]) );
  ShiftFlop
    FF3 (.Q(QtoD[3]), /*Qn*/ .D(ZtoD[3]), .Clk(ClkIn), .Clr(ClrIn) );
  //
  Mux2 Mux2 ( .Z(ZtoD[2]), .Sel(ShiftEna), .In1(QtoD[2]), .In2(QtoD[1]) );
  ShiftFlop
    FF2 (.Q(QtoD[2]), /*Qn*/ .D(ZtoD[2]), .Clk(ClkIn), .Clr(ClrIn) );
  //
  Mux2 Mux1 ( .Z(ZtoD[1]), .Sel(ShiftEna), .In1(QtoD[1]), .In2(QtoD[0]) );
  ShiftFlop
    FF1 (.Q(QtoD[1]), /*Qn*/ .D(ZtoD[1]), .Clk(ClkIn), .Clr(ClrIn) );
  //
  Mux2 Mux0 ( .Z(ZtoD[0]), .Sel(ShiftEna), .In1(QtoD[0]), .In2(DIn) );
  ShiftFlop
    FF0 (.Q(QtoD[0]), /*Qn*/ .D(ZtoD[0]),     .Clk(ClkIn), .Clr(ClrIn) );
  //
endmodule // SerShiftRegister.
//
// -------------------------------------------------
//
`ifdef DC
`else
module ShiftTester; // No I/O's.
  //
  reg  S_D, S_Ena, S_Clk, S_Clr;
  wire S_QOut;
  //
  SerShiftRegister
      SerShifter
      ( .QOut(S_QOut), .DIn(S_D), .ShiftEna(S_Ena)
      , .ClkIn(S_Clk), .ClrIn(S_Clr) );
 
  always@(S_Clk) #5 S_Clk <= ~S_Clk;
  //
  always
    begin
    #10 S_D = 1'b1;  // Test pattern = 5'b11100 = 5'h1c.
    #10 S_D = 1'b1;
    #10 S_D = 1'b1;
    #10 S_D = 1'b0;
    #10 S_D = 1'b0;
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
    #50  S_Ena = 1'b1;
    #90  S_Clr = 1'b1;
    #5   S_Clr = 1'b0;
    #90  S_Ena = 1'b0;
    #30  S_Ena = 1'b1;
    //
    #200 $finish;
    end
  //
endmodule // ShiftTester.
`endif
