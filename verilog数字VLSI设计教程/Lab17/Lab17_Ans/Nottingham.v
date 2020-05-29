// ================================================
// Nottingham.  Switch-level vs verilog primitive
// inverters.
//
// 2005-05-03 jmw: v. 1.2 Explicitly declared tb
//            *Watch wires.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-23 jmw: v. 1.0 implemented
// ================================================
//
`timescale 1ns/100ps
//
module Nottingham (output Tran, Notter, input In);
wire TranWire, NotterWire;
wire vdd, gnd;

pullup(vdd);
pulldown(gnd);

assign Tran = TranWire;

pmos #(2, 3, 5) (TranWire, vdd, In);
nmos #(1, 2, 2) (TranWire, gnd, In);

not #(1.2, 1.3) NotInst(Notter, In);
//
endmodule // Nottingham.
//
// -----------------------------------
//
`ifdef DC
`else
module NottinghamTst;
//
reg InStim;
wire TranWatch, NotterWatch;
//
always@(InStim) #5 InStim <= ~InStim;
//
initial
  begin
  #0 InStim = 1'b0;
  
  #50 $finish;
  end
//
Nottingham U1(.Tran(TranWatch), .Notter(NotterWatch), .In(InStim));
//
endmodule // NottinghamTst.
`endif
