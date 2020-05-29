// ===========================================================
// MemBIST_Tst: Lab25 testbench for Mem.
//
// ------------------------------------------------------------
// 2006-06-12 jmw: v. 1.1 Replaced AdrHi param with AWid.
//      Changed DHi refs to DWid-1.
// 2005-03-12 jmw: v. 1.0 implemented for test before BIST. 
// ============================================================
//
`timescale 1ns/100ps
//
module MemBIST_Tst; localparam AWid = 5, DWid = 32;
//
localparam MemHi = (1<<AWid) - 1;
//
wire[DWid-1:0] DataOWatch;
wire DreadyWatch, ParityWatch 
   , ClkRStim, ClkWStim;
//
reg[DWid-1:0] DataIStim;
reg[AWid-1:0] AddrRStim, AddrWStim;
reg ChipEnaStim, ClockStim
  , ReadStim, WriteStim, ResetStim;
//
assign ClkRStim = ClockStim;
assign ClkWStim = ClockStim;
//
always@(ClockStim)
  begin : ClockGen
  #21 ClockStim <= ~ClockStim;
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
  #4    ChipEnaStim = 1'b1;
        ResetStim   = 1'b1;
  #3    WriteStim   = 1'b1;
        ResetStim   = 1'b0;
  #2    for (i=0; i<=MemHi; i = i+1)
          begin : FirstWriteBlock
          #35 AddrWStim = i;
          #5  DataIStim = $random;
          end
  #55   WriteStim   = 1'b0;
  #25   ReadStim    = 1'b1;
  #2    for (i=0; i<=MemHi; i = i+1)
          begin : FirstReadBlock
          #40 AddrRStim = i;
          end

  #120  $finish;
  end
//
// -------------- Instantiation: ------------------------------
//
Mem #( .AWid(AWid), .DWid(DWid) )
 Mem_U1 ( .Dready(DreadyWatch), .ParityErr(ParityWatch)
        , .DataO(DataOWatch), .DataI(DataIStim), .AddrR(AddrRStim)
        , .AddrW(AddrWStim), .ClkR(ClkRStim), .ClkW(ClkWStim)
        , .ChipEna(ChipEnaStim), .Read(ReadStim), .Write(WriteStim)
        , .Reset(ResetStim)
        ); 
//
endmodule // MemBIST_Tst.
