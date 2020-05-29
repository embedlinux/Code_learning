// ========================================================================
// tpdn90g18tc_3PAD   Verilog library of pad wrappers.
//
// 2006-09-08 jmw:  This library contains a list of component simulation
// models based on those in the Synopsys TSMC 90-nm tpdn90g18tc pad cell
// library.   The TSMC cells are referenced only for synthesis.
// ===========================================================================
//
// DO NOT USE THIS LIBRARY IN DESIGN WORK!
//
// It is intended for training use, only, in conjunction
// with the "Digital VLSI Design with Verilog" textbook.
//
// ===========================================================================
//
// These comments Copyright 2006, by John Michael Williams.
//                    All rights reserved.
//
// ===========================================================================
`ifdef DC
//
// Synthesis model wrappers:
//
module PDC0204CDG_18_Out (output PAD, input I); 
  PDC0204CDG_18 OutputPAD (/*.C(),*/ .PAD(PAD), .I(I)
                , .DS(1'b1), .OEN(1'b0), .PS(1'b0), .PE(1'b1), .IE(1'b0));
endmodule
//
module PDC0204CDG_18_Tri (output PAD, input I, OEN); 
  wire OENnot;
  not TriInverter (OENnot, OEN);
  PDC0204CDG_18 ThreePAD (/*.C(),*/ .PAD(PAD), .I(I), .DS(1'b1), .OEN(OENnot)
                , .PS(1'b0), .PE(1'b1), .IE(1'b0));
  //synopsys dc_tcl_script_begin
  // set_dont_touch OENnot
  //synopsys dc_tcl_script_end
endmodule
//
module PDC0204CDG_18_In (output C, input PAD);
  PDC0204CDG_18 InputPAD (.C(C), .PAD(PAD)
                , .I(1'b0), .DS(1'b1), .OEN(1'b1), .PS(1'b0), .PE(1'b1), .IE(1'b1));
endmodule
//
`else
//
// Simulation model wrappers (delays are very approximate):
//
module PDC0204CDG_18_Out (output PADo, input I); 
  buf #(8, 6) OutputPAD (PADo, I);
endmodule
//
module PDC0204CDG_18_Tri (output PADo, input I, OEN); 
  bufif1 #( 8, 6, 0.6) ThreePAD (PADo, I, OEN);
endmodule
//
module PDC0204CDG_18_In (output Co, input PADi);
  buf #(0.1, 0.5) InputPAD (Co, PADi);
endmodule
//
// Power and ground models:
//
module PVDD1CDG_18 (VDD);
inout   VDD;
supply1 VDD;
endmodule
//
module PVSS1CDG_18 (VSS);
inout   VSS;
supply0 VSS;
endmodule
//
`endif
//
