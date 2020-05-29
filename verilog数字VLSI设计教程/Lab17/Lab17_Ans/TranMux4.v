// ================================================
// TranMux4.  Shows use of pass-transistor
// switches to implement a 4-to-1 mux.
// The requirement to use only pass transistors
// suggests a tree structure:
// Two 2:1 muxes relay 4 inputs to their 2 outputs.
// A third mux then selects one of the two.
//
//[0]---|---+ Sel = 00
//      |   +--- Out_Bit01 --+
//[1]---|---+ Sel = 01       |
//                           +----|---+ Sel = 10
//                                |   +---------- Out
//                           +----|---+ Sel = 11
//[2]---|---+ Sel = 00       |
//      |   +--- Out_Bit23 --+
//[3]---|---+ Sel = 01
//
// ------------------------------------------------
// 2005-05-03 jmw: v. 1.2 Changed tb for 2 patterns.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-23 jmw: v. 1.0 implemented
// ================================================
//
`timescale 1ns/100ps
//
module TranMux4 (output Chosen
                , input[3:0] InBus
                , input[1:0] Sel
                );
wire Out, Out_Bit01, Out_Bit23;
assign Chosen = Out;
//
tranif0 Bit01_Tranif0(Out_Bit01, InBus[0], Sel[0]);
tranif1 Bit01_Tranif1(Out_Bit01, InBus[1], Sel[0]);
//
tranif0 Bit23_Tranif0(Out_Bit23, InBus[2], Sel[0]);
tranif1 Bit23_Tranif1(Out_Bit23, InBus[3], Sel[0]);
//
tranif0 Bits_Tranif0(Out, Out_Bit01, Sel[1]);
tranif1 Bits_Tranif1(Out, Out_Bit23, Sel[1]);
//
endmodule // TranMux4.
//
// --------------------------------------------------
//
`ifdef DC
`else
module TranMux4Tst;
//
reg[1:0] SelStim;
reg[3:0] InBusStim;
//
always@(SelStim) #5 SelStim <= SelStim + 1;
//
initial
  begin
  #0    SelStim = 1'b0;
      InBusStim = 4'b1100;
  #50 InBusStim = 4'b1010;
  #50 $finish;
  end
//
TranMux4 U1( .Chosen(ChosenWatch)
           , .InBus(InBusStim), .Sel(SelStim) );
//
endmodule // TranMux4Tst.
`endif
