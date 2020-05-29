// ===========================================================
// FIFOgenNetlist_SpeedRulesTst Testbench extracted from
// FIFO_Top.v, v. 1.3.
// ------------------------------------------------------------
// 2007-11-19 jmw: v. 1.0 Copied.
// ============================================================
//
`timescale 1ns/100ps
//
`ifdef DC
`else
module FIFO_TopTst;
  //
  reg[31:0] DinStim;
  reg       ClockerStim, ReseterStim
          , ReadReqStim, WriteReqStim;
  wire[31:0] DoutWatch;
  integer i;
  //
  always@(ClockerStim) #10 ClockerStim <= ~ClockerStim;
  //
  initial
    begin
    fork
    #0   ReseterStim = 1'b0;
    #1   ReseterStim = 1'b1;
    #10  ReseterStim = 1'b0;
    #3   ClockerStim = 1'b0;
    #4   DinStim = 32'hff77_ee00;
    join
    #10  ReseterStim = 1'b0;
    #10  ReseterStim = 1'b1;
    #100 ReseterStim = 1'b0;
    //
    #1   ReadReqStim  = 1'b1;
    #25  ReadReqStim  = 1'b0;
    for (i=0; i<=15; i = i+1)
      begin
      #01  DinStim = DinStim + 1;
      #20  WriteReqStim = 1'b1;
      #20  WriteReqStim = 1'b0;
      end
    for (i=0; i<=19; i = i+1)
      begin
      #20  ReadReqStim = 1'b1;
      #20  ReadReqStim = 1'b0;
      end
//    #1   ReseterStim = 1'b1;
//    #100  ReseterStim = 1'b0;
    #35  WriteReqStim = 1'b1;
         DinStim = 32'hff77_3300;
    for (i=0; i<=35; i = i+1)
      begin
      #20  DinStim = DinStim + 1;
      end
    #25  WriteReqStim = 1'b0;
    #25  ReadReqStim  = 1'b1;
    for (i=0; i<=35; i = i+1)
      begin
      #20  DinStim = DinStim + 1;
      end
    #35  ReadReqStim = 1'b0;
    #100  $finish;
    end
  //
FIFO_Top FIFO_Netlist
        ( .Dout(DoutWatch), .Din(DinStim)
        , .ReadIn(ReadReqStim), .WriteIn(WriteReqStim)
        , .Clocker(ClockerStim), .Reseter(ReseterStim)
        );

  //
endmodule // FIFO_TopTst.
`endif
