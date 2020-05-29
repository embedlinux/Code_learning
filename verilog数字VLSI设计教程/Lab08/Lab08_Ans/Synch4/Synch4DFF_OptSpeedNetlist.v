
module DFFC_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  INVD1 U3 ( .I(Clr), .ZN(n3) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
endmodule


module DFFC_2 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  INVD1 U3 ( .I(Clr), .ZN(n3) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
endmodule


module DFFC_1 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  INVD1 U3 ( .I(Clr), .ZN(n3) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
endmodule


module DFFC_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
endmodule


module Synch4DFF ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   n16, n17, n18, n19, Qn_wire0, Qn_wire1, Qn_wire2, wireToD1, wireToD2,
         Qn_wire3, wireToD3, n1, n2, n3, n5, n7, n9, n11, n12, n13, n14, n15;

  DFFC_0 FF_Bit0 ( .Q(n19), .Qn(Qn_wire0), .D(Qn_wire0), .Clk(ClockIn), .Clr(
        n15) );
  DFFC_3 FF_Bit1 ( .Q(n18), .Qn(Qn_wire1), .D(wireToD1), .Clk(ClockIn), .Clr(
        n15) );
  DFFC_2 FF_Bit2 ( .Q(n17), .Qn(Qn_wire2), .D(wireToD2), .Clk(ClockIn), .Clr(
        n15) );
  DFFC_1 FF_Bit3 ( .Q(n16), .Qn(Qn_wire3), .D(wireToD3), .Clk(ClockIn), .Clr(
        n15) );
  CKBD0 U6 ( .CLK(n12), .C(n3) );
  CKNXD16 U7 ( .I(n3), .ZN(CountOut[1]) );
  CKBD0 U8 ( .CLK(n14), .C(n5) );
  CKNXD16 U9 ( .I(n5), .ZN(CountOut[0]) );
  CKBD0 U10 ( .CLK(n13), .C(n7) );
  CKNXD16 U11 ( .I(n7), .ZN(CountOut[3]) );
  CKBD0 U12 ( .CLK(n11), .C(n9) );
  CKNXD16 U13 ( .I(n9), .ZN(CountOut[2]) );
  CKND0 U14 ( .CLK(n17), .CN(n11) );
  CKND0 U15 ( .CLK(n18), .CN(n12) );
  CKND0 U16 ( .CLK(n16), .CN(n13) );
  CKND0 U17 ( .CLK(n19), .CN(n14) );
  NR2D1 U18 ( .A1(Qn_wire1), .A2(Qn_wire0), .ZN(n2) );
  XOR2D1 U19 ( .A1(Qn_wire1), .A2(Qn_wire0), .Z(wireToD1) );
  XOR2D1 U20 ( .A1(Qn_wire3), .A2(n1), .Z(wireToD3) );
  IND2D1 U21 ( .A1(Qn_wire2), .B1(n2), .ZN(n1) );
  XNR2D1 U22 ( .A1(n2), .A2(Qn_wire2), .ZN(wireToD2) );
  BUFFD1 U23 ( .I(ClearIn), .Z(n15) );
endmodule

