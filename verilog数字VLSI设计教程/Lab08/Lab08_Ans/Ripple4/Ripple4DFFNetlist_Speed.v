
module DFFC_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND2 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module DFFC_2 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  INVD1 U3 ( .I(Clr), .ZN(n3) );
  DFCND2 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
endmodule


module DFFC_1 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND2 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module DFFC_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCND2 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
endmodule


module Ripple4DFF ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   Qn_wire0, Qn_wire1, Qn_wire2, Qn_wire3, n1, n3, n5, n7, n9;

  DFFC_0 FF_Bit0 ( .Qn(Qn_wire0), .D(Qn_wire0), .Clk(ClockIn), .Clr(n9) );
  DFFC_3 FF_Bit1 ( .Qn(Qn_wire1), .D(Qn_wire1), .Clk(Qn_wire0), .Clr(n9) );
  DFFC_2 FF_Bit2 ( .Qn(Qn_wire2), .D(Qn_wire2), .Clk(Qn_wire1), .Clr(n9) );
  DFFC_1 FF_Bit3 ( .Qn(Qn_wire3), .D(Qn_wire3), .Clk(Qn_wire2), .Clr(n9) );
  DEL4 U1 ( .I(Qn_wire1), .Z(n1) );
  CKNXD16 U2 ( .I(n1), .ZN(CountOut[1]) );
  DEL4 U3 ( .I(Qn_wire0), .Z(n3) );
  CKNXD16 U4 ( .I(n3), .ZN(CountOut[0]) );
  DEL4 U5 ( .I(Qn_wire3), .Z(n5) );
  CKNXD16 U6 ( .I(n5), .ZN(CountOut[3]) );
  DEL4 U7 ( .I(Qn_wire2), .Z(n7) );
  CKNXD16 U8 ( .I(n7), .ZN(CountOut[2]) );
  BUFFD1 U9 ( .I(ClearIn), .Z(n9) );
endmodule

