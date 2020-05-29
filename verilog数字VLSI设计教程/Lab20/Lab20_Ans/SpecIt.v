// ===================================================
// SpecIt.  Top level of a design for doing various
// verilog timing exercises.
//
// 2005-02-07 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module SpecIt
( output FFQ, BufQn, input And, Nor, Ena, Reset); 
//
wire Nufo_iD;
//
Combo Combo
(.Nufo(Nufo_iD), .iEnaNuf(Ena), .iNor(Nor), .iNand(And));
//
Flipper Flipper
( .Flipo(FFQ), .Bufo(BufQn), .iD(Nufo_iD)
, .iClk(And), .iClr(Reset)
);
//
endmodule // SpecIt.
//
