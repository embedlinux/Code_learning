// ===================================================
// Combo.  A combinational block with an inverter
// (Nand) for timing exercises.
// Instantiated in SpecIt.
//
// 2005-02-07 jmw: v. 1.0 implemented.
// ===================================================
//
module Combo(output Nufo, input iEnaNuf, iNor, iNand); 
//
wire Nando, Nor_Nuf;
//
nand   #3  Nand (Nando, iNand, iNand);
//
nor    #5   Nor (Nor_Nuf, iNor, Nando);
//
notif1 #7 Nuf (Nufo, Nor_Nuf, iEnaNuf);
//
endmodule // Combo.
//
