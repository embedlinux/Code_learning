// ================================================
// NandNor.  Switch-level nand and nor; also
// inverted to and and or.
//
// Several modules kept in this one file for
// expository reasons.   Generally, one module per
// file is indicated in a real design (other
// than a component library, of course).
//
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-23 jmw: v. 1.0 implemented
// ================================================
//
`timescale 1ns/100ps
//
module Nand_Nor ( output NandO, NorO, AndO, OrO
               , input In0, In1, In2);
//
Nand NandU(NandO, In0, In1, In2);
Nor  NorU (NorO, In0, In1, In2);
And  AndU (AndO, In0, In1, In2);
Or   OrU  (OrO, In0, In1, In2);
//
endmodule // Nand_Nor.
//
// -------------------------------------
module Nand(output O, input i0, i1, i2);
wire vdd, gnd;
pullup(vdd);
pulldown(gnd);
//
wire OutWire, N0N1, N1N2;
assign #(2,1,2) O = OutWire;
//
pmos P0(OutWire, vdd, i0);
pmos P1(OutWire, vdd, i1);
pmos P2(OutWire, vdd, i2);
nmos N0(OutWire, N0N1, i0);
nmos N1(N0N1, N1N2, i1);
nmos N2(N1N2, gnd, i2);
endmodule // Nand.
//
// -------------------------------------
module Nor(output O, input i0, i1, i2);
wire vdd, gnd;
pullup(vdd);
pulldown(gnd);
//
wire OutWire, P0P1, P1P2;
assign #(1,2,3) O = OutWire;
//
pmos P0(OutWire, P0P1, i0);
pmos P1(P0P1,    P1P2, i1);
pmos P2(P1P2,    vdd,  i2);
nmos N0(OutWire, gnd, i0);
nmos N1(OutWire, gnd, i1);
nmos N2(OutWire, gnd, i2);
endmodule // Nor.
//
// -------------------------------------
module And(output O, input i0, i1, i2);
wire vdd, gnd;
pullup(vdd);
pulldown(gnd);
//
wire OutWire, NoutWire;
assign #(0.5,0.5,0.5) O = OutWire;
//
not #(1,1.3) Not(OutWire, NoutWire);
Nand NandToAnd(NoutWire, i0, i1, i2);
endmodule // And.
//
// -------------------------------------
module Or(output O, input i0, i1, i2);
wire vdd, gnd;
pullup(vdd);
pulldown(gnd);
//
wire OutWire, NoutWire;
assign #(2,3,4) O = OutWire;
//
not #(1,1.3) Not(OutWire, NoutWire);
Nor NorToOr(NoutWire, i0, i1, i2);
endmodule // Or.
//
// -------------------------------------
//
`ifdef DC
`else
module Nand_NorTst;
//
reg[2:0] InStim;
wire NandWatch, NorWatch, AndWatch, OrWatch;
//
always@(InStim) #10 InStim <= InStim + 1;
//
initial
  begin
  #0 InStim = 'b0;
  
  #120 $finish;
  end
//
Nand_Nor U1( .NandO(NandWatch), .NorO(NorWatch)
           , .AndO(AndWatch), .OrO(OrWatch)
           , .In0(InStim[0]), .In1(InStim[1])
           , .In2(InStim[2])
           );
//
endmodule // Nand_NorTst.
`endif
