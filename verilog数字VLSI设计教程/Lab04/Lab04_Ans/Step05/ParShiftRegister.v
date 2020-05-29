// ===========================================================
// ParShiftRegister:  Shift register 5 bits wide.
// Asynchronous clear asserted high; posedge clock.
// Parallel load.
//
// Uses flip-flop submodule, ShiftFlop.  Qn outputs of
// flip-flops are unused.
//
// The separate testbench module is implemented below the
// shift register model.
//
// Modified from the Step 4 design by adding a parallel-load
// input bus and using a new, 3-input mux.
// The default in the mux model means that if both ShiftEna
// and ParLoad both should be asserted, a parallel-load will
// occur.
// ------------------------------------------------------------
// 2007-01-30 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module ParShiftRegister
      (output QOut, input[4:0] ParDIn
      , input DIn, ShiftEna, ParLoad, ClkIn, ClrIn
      );
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
Mux3 Mux4 ( .Z(ZtoD[4]), .Sel({ParLoad,ShiftEna}), .In1(ShOut), .In2(QtoD[3]), .In3(ParDIn[4]) );
ShiftFlop 
  FF4 (.Q(ShOut),   .D(ZtoD[4]), .Clk(ClkIn), .Clr(ClrIn) );
//
Mux3 Mux3 ( .Z(ZtoD[3]), .Sel({ParLoad,ShiftEna}), .In1(QtoD[3]), .In2(QtoD[2]), .In3(ParDIn[3]) );
ShiftFlop
  FF3 (.Q(QtoD[3]), .D(ZtoD[3]), .Clk(ClkIn), .Clr(ClrIn) );
//
Mux3 Mux2 ( .Z(ZtoD[2]), .Sel({ParLoad,ShiftEna}), .In1(QtoD[2]), .In2(QtoD[1]), .In3(ParDIn[2]) );
ShiftFlop
  FF2 (.Q(QtoD[2]), .D(ZtoD[2]), .Clk(ClkIn), .Clr(ClrIn) );
//
Mux3 Mux1 ( .Z(ZtoD[1]), .Sel({ParLoad,ShiftEna}), .In1(QtoD[1]), .In2(QtoD[0]), .In3(ParDIn[1]) );
ShiftFlop
  FF1 (.Q(QtoD[1]), .D(ZtoD[1]), .Clk(ClkIn), .Clr(ClrIn) );
//
Mux3 Mux0 ( .Z(ZtoD[0]), .Sel({ParLoad,ShiftEna}), .In1(QtoD[0]), .In2(DIn), .In3(ParDIn[0]) );
ShiftFlop
  FF0 (.Q(QtoD[0]), .D(ZtoD[0]),     .Clk(ClkIn), .Clr(ClrIn) );
//
endmodule // ParShiftRegister.
//
// -------------------------------------------------
// This testbench is copied from the one used for the
// serial-load design, with minor changes and addition
// of tests for parallel loading of data.
//
`ifdef DC
`else
module ParShiftTester; // No I/O's.
  //
  reg  S_D, S_Ena, S_Clk, S_Clr, S_ParLoad;
  reg[4:0] S_ParDIn;
  wire QOut_Watch;
  //
  ParShiftRegister
      ParShifter
      ( .QOut(QOut_Watch), .DIn(S_D), .ShiftEna(S_Ena)
      , .ClkIn(S_Clk), .ClrIn(S_Clr), .ParDIn(S_ParDIn)
      , .ParLoad(S_ParLoad)
      );
 
  always@(S_Clk) #5 S_Clk <= ~S_Clk;
  //
  always
    begin
    #10 S_D = 1'b1;  // Serial test pattern = 5'b11100 = 5'h1c.
    #10 S_D = 1'b1;
    #10 S_D = 1'b1;
    #10 S_D = 1'b0;
    #10 S_D = 1'b0;
    end
  //
  initial
    begin 
       S_D       = 1'b0;
       S_Clr     = 1'b1;  // Start off cleared.
       S_Ena     = 1'b0;
       S_ParDIn  = 5'b11010; // Parallel test pattern = 5'h1a.
       S_ParLoad = 1'b0;
    //
    #0.5 S_Clk = 1'b0;  // Setup lag.
    //
    #3.0 S_Clr = 1'b0;
    #50  S_Ena = 1'b1;
    #190 S_Clr = 1'b1;
    #5   S_Clr = 1'b0;
    #70  S_Ena = 1'b0;
    #30  S_Ena = 1'b1;
    // Here, enable parallel load & repeat:
    #103 S_ParLoad = 1'b1;
    #10  S_ParLoad = 1'b0;
    #190 S_Clr = 1'b1;
    #5   S_Clr = 1'b0;
    #170 S_Ena = 1'b0;
    #30  S_Ena = 1'b1;
    #200 $finish;
    end
  //
endmodule // ParShiftTester.
`endif
