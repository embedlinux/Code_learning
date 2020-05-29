
module DFFC_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .QN(Qn) );
  INVD1 U3 ( .I(Qn), .ZN(Q) );
  CKND0 U4 ( .CLK(Clr), .CN(n3) );
endmodule


module DFFC_2 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .QN(Qn) );
  INVD1 U3 ( .I(Qn), .ZN(Q) );
  CKND0 U4 ( .CLK(Clr), .CN(n3) );
endmodule


module DFFC_1 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .QN(Qn) );
  INVD1 U3 ( .I(Qn), .ZN(Q) );
  CKND0 U4 ( .CLK(Clr), .CN(n3) );
endmodule


module DFFC_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n1) );
endmodule


module Ripple4DFF ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   Qn_wire0, Qn_wire1, Qn_wire2, Qn_wire3, n1, n3, n5, n7;

  DFFC_0 FF_Bit0 ( .Qn(Qn_wire0), .D(Qn_wire0), .Clk(ClockIn), .Clr(ClearIn)
         );
  DFFC_3 FF_Bit1 ( .Qn(Qn_wire1), .D(Qn_wire1), .Clk(Qn_wire0), .Clr(ClearIn)
         );
  DFFC_2 FF_Bit2 ( .Qn(Qn_wire2), .D(Qn_wire2), .Clk(Qn_wire1), .Clr(ClearIn)
         );
  DFFC_1 FF_Bit3 ( .Qn(Qn_wire3), .D(Qn_wire3), .Clk(Qn_wire2), .Clr(ClearIn)
         );
  DEL4 U1 ( .I(Qn_wire1), .Z(n1) );
  CKNXD16 U2 ( .I(n1), .ZN(CountOut[1]) );
  DEL4 U3 ( .I(Qn_wire0), .Z(n3) );
  CKNXD16 U4 ( .I(n3), .ZN(CountOut[0]) );
  DEL4 U5 ( .I(Qn_wire3), .Z(n5) );
  CKNXD16 U6 ( .I(n5), .ZN(CountOut[3]) );
  DEL4 U7 ( .I(Qn_wire2), .Z(n7) );
  CKNXD16 U8 ( .I(n7), .ZN(CountOut[2]) );
endmodule

