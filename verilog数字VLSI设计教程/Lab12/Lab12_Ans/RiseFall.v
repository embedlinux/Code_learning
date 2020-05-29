// ===========================================================
// RiseFall:  Shows effect of rise-fall delay values.
//
// ------------------------------------------------------------
// 2005-04-19 jmw: 1.1 Added 1-bit outputs.
// 2005-02-03 jmw: 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module RiseFall #(parameter tR=4, tF=3, tZ=5)
      (output[3:0] OutBus, output Out2val, Out3val,
        inout[7:0] DataBus, input Clk);
//
reg[3:0] OutBusReg;
reg[7:0] DataBusReg;
reg Out2valReg, Out3valReg;
//
assign #(tR,tF)    OutBus  = OutBusReg;
assign #(tR,tF,tZ) DataBus = DataBusReg;
assign #(tR,tF)    Out2val = Out2valReg;
assign #(tR,tF,tZ) Out3val = Out3valReg;
//
always@(negedge Clk)
  begin
  OutBusReg  <= 4'bzz01;
  DataBusReg <= 8'b1111_0zzz;
  Out2valReg <= 1'b1;
  Out3valReg <= 1'bz;
  end
always@(posedge Clk)
  begin
  OutBusReg  <= 4'b0101;
  DataBusReg <= 8'b1zzz_0000;
  Out2valReg <= 1'b0;
  Out3valReg <= 1'b0;
  end
  //
endmodule //RiseFall.
//
module RiseFallTst;
//
reg ClkStim;
wire[3:0] OutBusWatch;
wire[7:0] DataBusWatch;
wire Out2Watch, Out3Watch;
//
always@(ClkStim) #10 ClkStim <= ~ClkStim;
//
initial
  begin
  #0 ClkStim = 1'b0;
  #40 $finish;
  end
//
RiseFall U1( .OutBus(OutBusWatch), .Out2val(Out2Watch)
           , .Out3val(Out3Watch)
           , .DataBus(DataBusWatch), .Clk(ClkStim) );
//
endmodule // RiseFallTst.
