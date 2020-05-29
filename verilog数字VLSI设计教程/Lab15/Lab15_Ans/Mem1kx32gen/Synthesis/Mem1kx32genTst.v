// ===========================================================
// Mem1kx32genTst:  Testbench copied from Mem1kx32gen.v.
// 2007-11-19 jmw: v. 1.0 Copied.
// ============================================================
//
`timescale 1ns/100ps
//
//
// `ifdef COMMENTED_OUT
`ifdef DC
`else
module Mem1kTest;
//                          // 1 & 7 work for Silos demo version:
localparam AdrHiParam = 4;  // 4 --> 32 addr's.
localparam DatHiParam = 31; // 31 --> 31 addressable bits/word.
//
localparam AdrWid = AdrHiParam+1;  // Sizing requires Silos cmd
localparam DatWid = DatHiParam+1;  // line: -"!control .ext=psize"
//
// VCS cannot accept parameter sizing:
`define VCS
//
wire DreadyWatch, ParityErrWatch;
wire[DatHiParam:0] DataOWatch;
 reg[DatHiParam:0] DataStim;
reg [AdrHiParam:0] AddrStim;
reg ClockInStim
  , ChipEnaStim
  , ReadStim
  , WriteStim;
//
// Design instance:
//
Mem1kx32gen #( .AdrHi(AdrHiParam), .DatHi(DatHiParam) ) U1
             ( .Dready(DreadyWatch)
             , .ParityErr(ParityErrWatch)
             , .DataO(DataOWatch)
             , .DataI(DataStim)
             , .Addr(AddrStim)
             , .ClockIn(ClockInStim)
             , .ChipEna(ChipEnaStim)
             , .Read(ReadStim)
             , .Write(WriteStim)
             );
//
always@(ClockInStim) #10 ClockInStim <= ~ClockInStim;
//
initial
  begin // Widths sized too narrow will get low-order bits:
  #0   ClockInStim = 1'b0;
  #0   ChipEnaStim = 1'b1;
  #0   ReadStim    = 1'b0;
  #0   WriteStim   = 1'b0;
  #0   AddrStim    =  'b0;
                        `ifdef VCS
  #5   DataStim    = 32'h2;
                        `else
  #5   DataStim    = DatWid'h2;
                        `endif
  #1   WriteStim   = 1'b1;
  #30  WriteStim   = 1'b0;
  #1   DataStim    =  'bz;
  #15  ChipEnaStim = 1'b0;
  #35  ChipEnaStim = 1'b1;
  //
  #0   DataStim    = 'bz;
                        `ifdef VCS
  #0   AddrStim    =  5'h1;
  #5   DataStim    = 32'h3;
                        `else
  #0   AddrStim    = AdrWid'h1;
  #5   DataStim    = DatWid'h3;
                        `endif
  #1   WriteStim   = 1'b1;
  #30  WriteStim   = 1'b0;
  #0   DataStim    =  'bz;
  #0   AddrStim    =  'b0;
  #3   ReadStim    = 1'b1;
  #39  ReadStim    = 1'b0;
  #0   DataStim    =  'bz;
  //
                        `ifdef VCS
  #0   AddrStim    =  5'h2;
  #5   DataStim    = 32'h4;
                        `else
  #0   AddrStim    = AdrWid'h2;
  #5   DataStim    = DatWid'h4;
                        `endif
  #1   WriteStim   = 1'b1;
  #30  WriteStim   = 1'b0;
  #0   DataStim    =  'bz;
                        `ifdef VCS
  #0   AddrStim    =  5'h1;
                        `else
  #0   AddrStim    = AdrWid'h1;
                        `endif
  #0   DataStim    =  'bz;
  #3   ReadStim    = 1'b1;
  #39  ReadStim    = 1'b0;
  //
  #0   DataStim    =  'bz;
                        `ifdef VCS
  #0   AddrStim    =  5'h3;
  #5   DataStim    = 32'h5;
                        `else
  #0   AddrStim    = AdrWid'h3;
  #5   DataStim    = DatWid'h5;
                        `endif
  #1   WriteStim   = 1'b1;
  #30  WriteStim   = 1'b0;
  #3   ReadStim    = 1'b1;
  #0   DataStim    =  'bz;
                        `ifdef VCS
  #0   AddrStim    =  5'h0;
  #5   DataStim    = 32'h6;
                        `else
  #0   AddrStim    =  5'h0;
  #5   DataStim    = DatWid'h6;
                        `endif
  #1   WriteStim   = 1'b1;
  #30  WriteStim   = 1'b0;
  #0   DataStim    =  'bz;
                        `ifdef VCS
  #0   AddrStim    =  5'h3;
                        `else
  #0   AddrStim    =  5'h3;
                        `endif
  #3   ReadStim    = 1'b1;
  #39  ReadStim    = 1'b0;
  #20 $finish;
  end
`undef VCS
endmodule  // Mem1kTest.
`endif
// `endif
