// ===================================================
// CondGenerate.   Shows use of a conditional 
// generate statement to implement a multiplexer which 
// either has latched or unlatched outputs.
// 
// The simulation testbench simulates both conditions
// at the same time.
// To synthesize, each condition is separate:
// Change the first default parameter in the design to
// Latch = 0 or Latch = 1.
//
// The three submodules involved are kept together
// in this one file, for illustration.
//
// 2006-10-05 jmw:  v. 1.3 Clarified comments above.
// 2005-12-20 jmw:  v. 1.2 Changed to two instances, to
//            show both conditions in one simulation.
// 2005-02-24 jmw:  v. 1.1 Added `DC switch.
// 2005-01-12 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module CondGenerate
      #( parameter Latch = 1 )
       ( output[31:0] Result, input[31:0] ArgA, ArgB
       , input Sel, Enable
       );
wire[31:0] OutBus;
assign #1 Result = OutBus;
//
  generate
  if (Latch==1) 
       Mux32BitL Mux1(OutBus, ArgA, ArgB, Sel, Enable);
  else Mux32Bit  Mux1(OutBus, ArgA, ArgB, Sel, Enable);
  endgenerate
endmodule // CondGenerate.
//
// --------------
module Mux32BitL(output[31:0] Out 
                , input[31:0] A, B, input Sel, Ena);
//
assign #1 Out = (Ena==1'b1)? ( (Sel==1'b1)? A: B ) : Out;
endmodule
// --------------
module Mux32Bit(output[31:0] Out 
               , input[31:0] A, B, input Sel, unused);
assign #1 Out = (Sel==1'b1)? A: B;
endmodule
//
// --------------
`ifdef DC
`else
module CondGenerateTst;
//
wire[31:0] ResultLatched, ResultUnLatched;
reg[31:0] ArgAStim, ArgBStim;
//
reg SelStim, EnaStim;
always@(SelStim) #15 SelStim <= ~SelStim;
//
initial
  begin
  #0   ArgAStim =  'b0;
  #0   ArgBStim =  'b0;
  #0   SelStim  = 1'b0;
  #0   EnaStim  = 1'b1;
  #0   ArgBStim = 32'hb000_0000;
  #15  ArgAStim = 32'h0000_aaaa;
  #30  ArgBStim = 32'h0000_bbbb;
  #30  ArgAStim = 32'haaaa_0000;
  #30  ArgBStim = 32'h0100_bbbb;
  #0   EnaStim  = 1'b0;
  #30  ArgAStim = 32'h00aa_0f00;
  #30  ArgBStim = 32'h00bb_0000;
  #40  $finish;
  end
//
CondGenerate #( .Latch(1) ) U_Latched
   ( .Result(ResultLatched), .ArgA(ArgAStim)
   , .ArgB(ArgBStim), .Sel(SelStim), .Enable(EnaStim));
//
CondGenerate #( .Latch(0) ) U_UnLatched
   ( .Result(ResultUnLatched), .ArgA(ArgAStim)
   , .ArgB(ArgBStim), .Sel(SelStim), .Enable(EnaStim));
//
endmodule // CondGenerateTst.
`endif
