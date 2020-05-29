// ===========================================================
// FIFO_Top:  A complete FIFO assembled from FIFOStateM of
// Lab10 and Mem1kx32 of Lab07.
//
// Data width defaults of 32 bits and depth of 32 are taken
// without passing parameter values.
//
// ------------------------------------------------------------
// 2006-05-15 jmw: v. 1.3  Changed mem type to Mem1kx32gen.
// 2006-05-13 jmw: v. 1.2  Modified tb for final back-to-back
//      writes & reads.
// 2005-09-07 jmw: v. 1.1 Removed unused tb variables
//            ReadInStim, WriteInStim.
// 2005-01-01 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module FIFO_Top
        ( output[31:0] Dout, input[31:0]  Din
        , input ReadIn, WriteIn, Clocker, Reseter
        );
  //
  wire SM_MemReadCmd, SM_MemWriteCmd
       , ReadWire, WriteWire;
  wire[4:0] SM_MemAddr, SM_ReadAddr, SM_WriteAddr;
  wire Mem_Enable, E_FIFO, F_FIFO
       , MemReadOK, MemERROR
       , ResetFIFO;
  //
  assign SM_MemAddr = ({SM_MemReadCmd,SM_MemWriteCmd}==2'b10)?
                             SM_ReadAddr: SM_WriteAddr;
  assign Mem_Enable = ~(SM_MemReadCmd && SM_MemWriteCmd)
                               && ~E_FIFO && ~F_FIFO;
  assign ReadWire  =  SM_MemReadCmd;
  assign WriteWire =  SM_MemWriteCmd;
  assign ResetFIFO =  Reseter;
  //
  FIFOStateM 
  FIFO_SM1( .ReadAddr(SM_ReadAddr), .WriteAddr(SM_WriteAddr)
          , .EmptyFIFO(E_FIFO), .FullFIFO(F_FIFO)
          , .ReadCmd(SM_MemReadCmd)
          , .WriteCmd(SM_MemWriteCmd)
          , .ReadReq(ReadIn), .WriteReq(WriteIn)
          , .Clk(Clocker), .Reset(ResetFIFO)
          );
  //
  Mem1kx32gen
  RegFile1(  .Dready(MemReadOK), .ParityErr(MemERROR)
           , .DataO(Dout), .DataI(Din)
           , .Addr(SM_MemAddr),  .ClockIn(~Clocker)
           , .ChipEna(Mem_Enable), .Read(ReadWire)
           , .Write(WriteWire)
           );

  //
endmodule // FIFO_Top.
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
    // Optionally, initialize the memory:
    // for (i=0; i<=32; i = i + 1)
    //   #1 FIFO_Top1.RegFile1.Storage[i] <= 'b0;
    join
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
FIFO_Top FIFO_Top1
        ( .Dout(DoutWatch), .Din(DinStim)
        , .ReadIn(ReadReqStim), .WriteIn(WriteReqStim)
        , .Clocker(ClockerStim), .Reseter(ReseterStim)
        );

  //
endmodule // FIFO_TopTst.
`endif
