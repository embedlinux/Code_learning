// ================================================
// TranMux2.  Shows use of two tran pass-transistor
// switches to implement a 2-to-1 mux.
//
// 2005-09-09 jmw: v. 1.2 Added more varying InBus.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-23 jmw: v. 1.0 implemented
// ================================================
//
`timescale 1ns/100ps
//
module TranMux2 (output Chosen
                , input[1:0] InBus, input Sel
                );
wire Out;
//
assign Chosen = Out;
//
tranif0 UpperTran(Out, InBus[0], Sel);
tranif1 LowerTran(Out, InBus[1], Sel);
//
endmodule // TranMux2
//
`ifdef DC
`else
module TranMux2Tst;
//
reg SelStim;
reg[1:0] InBusReg;
//
always@(SelStim) #5 SelStim <= ~SelStim;
//
initial
  begin
  #0 SelStim = 1'b0;
  #20 InBusReg  = 2'b00;
  #20 InBusReg  = 2'b10;
  #20 InBusReg  = 2'b01;
  #20 InBusReg  = 2'b0x;
  #20 $finish;
  end
//
TranMux2 U1( .Chosen(ChosenWatch)
           , .InBus(InBusReg), .Sel(SelStim) );
//
endmodule // 
`endif
