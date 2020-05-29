// ===========================================================
// FIFOTopTst:  New testbench for FIFOTop design.
// ------------------------------------------------------------
// 2006-05-24 jmw: v. 1.1  Renamed from FIFO_TopTst to FIFOTopTst.
// 2006-05-19 jmw: v. 1.0  Copied out of FIFO_Top.v.   Added
//      AWid & DWid params.
// ===========================================================
//
`include "../Deserial.inc" // timescale.
//
module FIFOTopTst;
  //
  localparam AWid = 5, DWid = 32;
  //
  reg[DWid-1:0] DinStim;
  reg ClockerStim, ReseterStim
    , ReadReqStim, WriteReqStim;
  wire[DWid-1:0] DoutWatch;
  wire FullWatch, EmptyWatch;
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
    #1   ReadReqStim  = 1'b1;
    #25  ReadReqStim  = 1'b0;
    for (i=0; i<=35; i = i+1)
      begin
      #01  DinStim = DinStim + 1;
      #20  WriteReqStim = 1'b1;
      #20  WriteReqStim = 1'b0;
      end
    for (i=0; i<=39; i = i+1)
      begin
      #20  ReadReqStim = 1'b1;
      #20  ReadReqStim = 1'b0;
      end
    #1   ReseterStim = 1'b1;
    #100  ReseterStim = 1'b0;
    // Back-to-back attempt:
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
FIFOTop FIFOTop_U1
        ( .Dout(DoutWatch), .Din(DinStim)
        , .ReadIn(ReadReqStim), .WriteIn(WriteReqStim)
        , .Full(FullWatch), .Empty(EmptyWatch)
        , .ClkR(ClockerStim)
        , .ClkW(ClockerStim)
        , .Reseter(ReseterStim)
        );
  //
endmodule // FIFOTopTst.
