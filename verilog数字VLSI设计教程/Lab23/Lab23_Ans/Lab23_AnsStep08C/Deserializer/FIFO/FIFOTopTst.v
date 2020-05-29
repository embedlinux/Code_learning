// ===========================================================
// FIFOTopTst:  New testbench for FIFOTop design.
// ------------------------------------------------------------
// 2006-05-29 jmw: v. 1.3  Changed pulsed timing to read & write
//      once per data input change.
// 2006-05-26 jmw: v. 1.2  Revised tb entirely, to have pulsed
//      accesses, then back-to-back, then concurrent.  Increased
//      clock period to normal SerDes.  Separated read & write 
//      clocks but kept 0 phase shift.
// 2006-05-24 jmw: v. 1.1  Renamed from FIFO_TopTst to FIFOTopTst.
// 2006-05-19 jmw: v. 1.0  Copied out of FIFO_Top.v.   Added
//      AWid & DWid params.
// ===========================================================
//
`include "../Deserial.inc" // timescale.
`define WMUL 4.0
`define RMUL 4.0
//
module FIFOTopTst;
  //
  localparam AWid = 5, DWid = 32;
  //
  reg[DWid-1:0] DinStim;
  reg ClkRStim, ClkWStim, ReseterStim
    , ReadReqStim, WriteReqStim;
  wire[DWid-1:0] DoutWatch;
  wire FullWatch, EmptyWatch;
  integer i;
  //
  always@(ClkRStim) #`HalfPeriod32BitBus ClkRStim <= ~ClkRStim;
  always@(ClkWStim) #`HalfPeriod32BitBus ClkWStim <= ~ClkWStim;
  //
  initial
    begin
    ReseterStim  = 1'b0;
    ClkRStim     = 1'b0;
    ClkWStim     = 1'b0;
    #10   ReseterStim  = 1'b1;
    #300  ReseterStim  = 1'b0;
    #200  WriteReqStim = 1'b0;
    #200  WriteReqStim = 1'b0;
    #25   ReadReqStim  = 1'b1;
    #200  ReadReqStim  = 1'b0;
    #200  ReseterStim  = 1'b1;
    #5000 ReseterStim  = 1'b0;
    //
    // Pulsed:
    #50  DinStim       = 32'hff11_0100;
    for (i=0; i<=75; i = i+1)
      begin
      #0                           WriteReqStim = 1'b1;
      #(`HalfPeriod32BitBus*`WMUL) WriteReqStim = 1'b0;
      #0 DinStim = DinStim + 1;
      end
    #50   DinStim      = 32'hff33_0300;
    for (i=0; i<=50; i = i+1)
      begin
      #0                           ReadReqStim = 1'b1;
      #(`HalfPeriod32BitBus*`RMUL) ReadReqStim = 1'b0;
      #0 DinStim = DinStim + 1;
      end
    #1   ReseterStim = 1'b1;
    #(`HalfPeriod32BitBus*10)  ReseterStim = 1'b0;
    //
    // Back-to-back:
    #350 WriteReqStim = 1'b1;
         DinStim      = 32'hff77_0700;
    for (i=0; i<=35; i = i+1)
      begin
      #(`HalfPeriod32BitBus*`WMUL)  DinStim = DinStim + 1;
      end
    #250 WriteReqStim = 1'b0;
    #250 ReadReqStim  = 1'b1;
         DinStim      = 32'hffff_0f00;
    for (i=0; i<=35; i = i+1)
      begin
      #(`HalfPeriod32BitBus*`RMUL) DinStim = DinStim + 1;
      end
    #350 ReadReqStim = 1'b0;
    //
    // Mixed; concurrent:
    #100  DinStim     = 32'hff01_7000;
    //
    #250  WriteReqStim = 1'b1;
    #350  ReadReqStim  = 1'b0;
    for (i=0; i<=7; i = i+1)
      begin
      #(`HalfPeriod32BitBus*`WMUL) DinStim = DinStim + 1;
      end
    #350    ReadReqStim  = 1'b1;
    #250    WriteReqStim = 1'b1;
    #100  DinStim     = 32'hff02_7000;
    for (i=0; i<=35; i = i+1)
      begin
      #(`HalfPeriod32BitBus*`RMUL) DinStim = DinStim + 1;
      end
    #100  DinStim     = 32'hff03_7000;
    for (i=0; i<=35; i = i+1)
      begin
      #(`HalfPeriod32BitBus*`RMUL) DinStim = DinStim + 1;
      end
    #30000  ReadReqStim  = 1'b0;
    #100  DinStim     = 32'hff04_7000;
    fork
    for (i=0; i<=35; i = i+1)
      begin
      #(`HalfPeriod32BitBus*`WMUL) DinStim = DinStim + 1;
      end
    #5000   WriteReqStim = 1'b0;
    #50000  ReadReqStim  = 1'b1;
    join
    #40000  $finish;
    end
  //
FIFOTop FIFOTop_U1
        ( .Dout(DoutWatch), .Din(DinStim)
        , .ReadIn(ReadReqStim), .WriteIn(WriteReqStim)
        , .Full(FullWatch), .Empty(EmptyWatch)
        , .ClkR(ClkRStim)
        , .ClkW(ClkWStim)
        , .Reseter(ReseterStim)
        );
  //
endmodule // FIFOTopTst.
