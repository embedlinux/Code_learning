// ===================================================
// Combo.  A combinational block with an inverter
// (Nand) for timing exercises.
// Instantiated in SpecIt.
//
// 2005-05-12 jmw: v. 1.1 Added `defines.
// 2005-02-07 jmw: v. 1.0 implemented.
// ===================================================
// 
// Uncomment one at a time:
`define Step3A 1
// `define Step3B 1
// `define Step3C 1
// `define Step3D 1
//
module Combo(output Nufo, input iEnaNuf, iNor, iNand); 
//
`ifdef Step3C
localparam InstTime=25;
`endif
`ifdef Step3D
localparam InstTime=25;
localparam tZ=30;
`endif

wire Nando, Nor_Nuf;
//
`ifdef Step3A
nand   #3 Nand (Nando, iNand, iNand);
nor    #5  Nor (Nor_Nuf, iNor, Nando);
notif1 #7  Nuf (Nufo, Nor_Nuf, iEnaNuf);
`endif
`ifdef Step3B
nand   #3 Nand (Nando, iNand, iNand);
nor    #5  Nor (Nor_Nuf, iNor, Nando);
notif1 #7  Nuf (Nufo, Nor_Nuf, iEnaNuf);
`endif
`ifdef Step3C
nand   #InstTime Nand (Nando, iNand, iNand);
nor    #InstTime  Nor (Nor_Nuf, iNor, Nando);
notif1 #InstTime  Nuf (Nufo, Nor_Nuf, iEnaNuf);
`endif
`ifdef Step3D
nand   #InstTime Nand (Nando, iNand, iNand);
nor    #InstTime  Nor (Nor_Nuf, iNor, Nando);
notif1 #InstTime  Nuf (Nufo, Nor_Nuf, iEnaNuf);
`endif
//
specify
  `ifdef Step3D
  specparam tAll=10, tAllR=20, tAllF=21, tAllZ=tZ;
  `else
  specparam tAll=10, tAllR=20, tAllF=21, tAllZ=22;
  `endif
  //
  `ifdef Step3A
  (iEnaNuf, iNor, iNand *> Nufo) = tAll;
  `endif
  `ifdef Step3B
  (iEnaNuf, iNor, iNand *> Nufo) = (tAllR, tAllF, tAllZ);
  `endif
  `ifdef Step3C
  (iEnaNuf, iNor, iNand *> Nufo) = (tAllR, tAllF, tAllZ);
  `endif
  `ifdef Step3D
  // Step3E:
  // (iEnaNuf, iNor, iNand => Nufo) = (tAllR, tAllF, tAllZ);
  iEnaNuf, iNor, iNand *> Nufo) = (tAllR, tAllF, tAllZ);
  `endif
  //
endspecify
//
endmodule // Combo.
//
