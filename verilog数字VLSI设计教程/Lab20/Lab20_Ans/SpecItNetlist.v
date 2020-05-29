
module SpecIt ( FFQ, BufQn, And, Nor, Ena, Reset );
  input And, Nor, Ena, Reset;
  output FFQ, BufQn;
  wire   n4, Nufo_iD, n1, n3;

  Combo Combo ( .Nufo(Nufo_iD), .iEnaNuf(Ena), .iNor(Nor), .iNand(And) );
  Flipper Flipper ( .Flipo(n4), .Bufo(BufQn), .iD(Nufo_iD), .iClk(And), .iClr(
        Reset) );
  CKBD0 U1 ( .CLK(n3), .C(n1) );
  CKNXD16 U2 ( .I(n1), .ZN(FFQ) );
  CKND0 U3 ( .CLK(n4), .CN(n3) );
endmodule


module Combo ( Nufo, iEnaNuf, iNor, iNand );
  input iEnaNuf, iNor, iNand;
  output Nufo;
  wire   n2;

  BUFTD1 Nuf ( .I(n2), .OE(iEnaNuf), .Z(Nufo) );
  IND2D0 U1 ( .A1(iNor), .B1(iNand), .ZN(n2) );
endmodule


module Flipper ( Flipo, Bufo, iD, iClk, iClr );
  input iD, iClk, iClr;
  output Flipo, Bufo;
  wire   n2, FFn_Buf;

  DFFC FF ( .Q(n2), .Qn(FFn_Buf), .D(iD), .Clk(iClk), .Clr(iClr) );
  BUFTD16 Buf ( .I(FFn_Buf), .OE(iClk), .Z(Bufo) );
  INVD1 U1 ( .I(FFn_Buf), .ZN(Flipo) );
endmodule


module DFFC ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .QN(Qn) );
  INVD1 U4 ( .I(Qn), .ZN(Q) );
endmodule

