// ===================================================
// SpecIt_tb. Testbench for the SpecIt timing exercise
// design.
//
// 2005-05-12 jmw: v. 1.1 removed irrelevant comments.
// 2005-02-07 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module SpecIt_tb; // no I/O in a testbench.
//
wire      FFQWatch, BufQnWatch;
wire[3:0] CountStimWire;
reg       TstClk;
reg[3:0]  CountReg;
//
initial
  begin
  #0    TstClk    = 1'b0;
  #0    CountReg  =  'b0;

  #2500 $finish;
  end
//
assign CountStimWire = CountReg;
//
always@(TstClk) #50 TstClk <= ~TstClk;
//
always@(posedge TstClk)
  CountReg = CountReg + 1;
//
SpecIt U1 ( .FFQ(FFQWatch), .BufQn(BufQnWatch)
          , .And(  CountStimWire[0] )
          , .Nor(  CountStimWire[1] )
          , .Ena(  CountStimWire[2] )
          , .Reset(CountStimWire[3] ) // as required.
          ); 
//
endmodule // SpecIt_tb.
//
