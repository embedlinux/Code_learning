
module DFFC_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n3) );
endmodule


module DFFC_2 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n3) );
endmodule


module DFFC_1 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n3) );
endmodule


module DFFC_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n1) );
endmodule


module Synch4DFFWor ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   n17, n18, n19, n20, Qn_wire0, Qn_wire1, Qn_wire2, wireToD1, wireToD2,
         Qn_wire3, wireToD3, n3, n5, n7, n9, n11, n12, n13, n14, n15, n16;

  DFFC_0 FF_Bit0 ( .Q(n20), .Qn(Qn_wire0), .D(Qn_wire0), .Clk(ClockIn), .Clr(
        ClearIn) );
  DFFC_3 FF_Bit1 ( .Q(n19), .Qn(Qn_wire1), .D(wireToD1), .Clk(ClockIn), .Clr(
        ClearIn) );
  DFFC_2 FF_Bit2 ( .Q(n18), .Qn(Qn_wire2), .D(wireToD2), .Clk(ClockIn), .Clr(
        ClearIn) );
  DFFC_1 FF_Bit3 ( .Q(n17), .Qn(Qn_wire3), .D(wireToD3), .Clk(ClockIn), .Clr(
        ClearIn) );
  CKBD0 U6 ( .CLK(n12), .C(n3) );
  CKNXD16 U7 ( .I(n3), .ZN(CountOut[1]) );
  CKBD0 U8 ( .CLK(n14), .C(n5) );
  CKNXD16 U9 ( .I(n5), .ZN(CountOut[0]) );
  CKBD0 U10 ( .CLK(n13), .C(n7) );
  CKNXD16 U11 ( .I(n7), .ZN(CountOut[3]) );
  CKBD0 U12 ( .CLK(n11), .C(n9) );
  CKNXD16 U13 ( .I(n9), .ZN(CountOut[2]) );
  CKND0 U14 ( .CLK(n18), .CN(n11) );
  CKND0 U15 ( .CLK(n19), .CN(n12) );
  CKND0 U16 ( .CLK(n17), .CN(n13) );
  CKND0 U17 ( .CLK(n20), .CN(n14) );
  CKXOR2D0 U18 ( .A1(Qn_wire3), .A2(n15), .Z(wireToD3) );
  IND2D0 U19 ( .A1(Qn_wire2), .B1(n16), .ZN(n15) );
  XNR2D0 U20 ( .A1(n16), .A2(Qn_wire2), .ZN(wireToD2) );
  NR2D0 U21 ( .A1(Qn_wire1), .A2(Qn_wire0), .ZN(n16) );
  CKXOR2D0 U22 ( .A1(Qn_wire1), .A2(Qn_wire0), .Z(wireToD1) );
endmodule

