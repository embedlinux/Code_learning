// ===========================================================
// MemBIST_TopTst: Lab25 testbench for MemBIST_Top.
//
// ------------------------------------------------------------
// 2006-06-12 jmw: v. 1.1 Replaced AdrHi param with AWid.
//      Changed DHi refs to DWid-1.
// 2005-03-12 jmw: v. 1.0 Adapted from MemBIST_Tst with trivial
//      changes. 
// ============================================================
//
`timescale 1ns/100ps
//
module MemBIST_TopTst; localparam AWid = 5, DWid = 32;
//
localparam MemHi = (1<<AWid) - 1;
localparam   DHi = DWid-1;
//
wire[DHi:0] DataOWatch;
wire DreadyWatch, ParityWatch 
   , TestingWatch, TestOKWatch
   , ClkRStim, ClkWStim;
//
reg[DHi:0]    DataIStim;
reg[AWid-1:0] AddrRStim, AddrWStim;
reg ChipEnaStim, DoSelfTestStim, ClockStim
  , ReadStim, WriteStim, ResetStim;
//
assign ClkRStim = ClockStim;
assign ClkWStim = ClockStim;
//
always@(ClockStim)
  begin : ClockGen
  #20 ClockStim <= ~ClockStim;
  end
//
integer i;
initial
  begin
  #0    ClockStim   = 1'b0;
  #1    DataIStim   =  'b0;
        AddrRStim   =  'b0;
        AddrWStim   =  'b0;
        ReadStim    = 1'b0;
        ChipEnaStim = 1'b0;
        ResetStim   = 1'b0;
        DoSelfTestStim = 1'b0;
  #4    ChipEnaStim = 1'b1;
        ResetStim   = 1'b1;
  #3    WriteStim   = 1'b1;
        ResetStim   = 1'b0;
  #2    for (i=0; i<=MemHi; i = i+1)
          begin : FirstWriteBlock
          #35 AddrWStim = i;
          #5  DataIStim = $random;
          end
  #20   WriteStim   = 1'b0;
  #20   ReadStim    = 1'b1;
  #2    for (i=0; i<=MemHi; i = i+1)
          begin : FirstReadBlock
          #40 AddrRStim = i;
          end
  #100   DoSelfTestStim = 1'b1;
  #12000 DoSelfTestStim = 1'b0;
  #1000  WriteStim   = 1'b1;
  #2     for (i=0; i<=MemHi; i = i+1)
           begin : SecondWriteBlock
           #35 AddrWStim = i;
           #5  DataIStim = $random;
           end
  #20    WriteStim   = 1'b0;
  #20    ReadStim    = 1'b1;
  #2     for (i=0; i<=MemHi; i = i+1)
           begin : SecondReadBlock
           #40 AddrRStim = i;
           end

  #250    $finish;
  end
//
// -------------- Instantiation: ------------------------------
//
MemBIST_Top #( .AWid(AWid), .DWid(DWid) )
  MemTop_U1
        ( .Dready(DreadyWatch), .ParityErr(ParityWatch)
        , .Testing(TestingWatch), .TestOK(TestOKWatch)
        , .DataO(DataOWatch), .DataI(DataIStim), .AddrR(AddrRStim)
        , .AddrW(AddrWStim), .ClkR(ClkRStim), .ClkW(ClkWStim)
        , .ChipEna(ChipEnaStim), .DoSelfTest(DoSelfTestStim)
        , .Read(ReadStim), .Write(WriteStim), .Reset(ResetStim)
        ); 
//
endmodule // MemBIST_Tst.
