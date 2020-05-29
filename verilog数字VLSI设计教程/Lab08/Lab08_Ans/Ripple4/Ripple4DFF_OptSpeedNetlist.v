
module DFFC_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n3;

  INVD1 U3 ( .I(Clr), .ZN(n3) );
  DFCND2 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
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
  wire   n3;

  INVD1 U3 ( .I(Clr), .ZN(n3) );
  DFCND2 QReg_reg ( .D(D), .CP(Clk), .CDN(n3), .Q(Q), .QN(Qn) );
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
  wire   n14, n15, n16, n17, Qn_wire0, Qn_wire1, Qn_wire2, Qn_wire3, n1, n3,
         n5, n7, n9, n10, n11, n12, n13;

  DFFC_0 FF_Bit0 ( .Q(n17), .Qn(Qn_wire0), .D(Qn_wire0), .Clk(ClockIn), .Clr(
        n13) );
  DFFC_3 FF_Bit1 ( .Q(n16), .Qn(Qn_wire1), .D(Qn_wire1), .Clk(Qn_wire0), .Clr(
        n13) );
  DFFC_2 FF_Bit2 ( .Q(n15), .Qn(Qn_wire2), .D(Qn_wire2), .Clk(Qn_wire1), .Clr(
        n13) );
  DFFC_1 FF_Bit3 ( .Q(n14), .Qn(Qn_wire3), .D(Qn_wire3), .Clk(Qn_wire2), .Clr(
        n13) );
  CKBD0 U1 ( .CLK(n10), .C(n1) );
  CKNXD16 U2 ( .I(n1), .ZN(CountOut[1]) );
  CKBD0 U3 ( .CLK(n12), .C(n3) );
  CKNXD16 U4 ( .I(n3), .ZN(CountOut[0]) );
  CKBD0 U5 ( .CLK(n11), .C(n5) );
  CKNXD16 U6 ( .I(n5), .ZN(CountOut[3]) );
  CKBD0 U7 ( .CLK(n9), .C(n7) );
  CKNXD16 U8 ( .I(n7), .ZN(CountOut[2]) );
  CKND0 U9 ( .CLK(n15), .CN(n9) );
  CKND0 U10 ( .CLK(n16), .CN(n10) );
  CKND0 U11 ( .CLK(n14), .CN(n11) );
  CKND0 U12 ( .CLK(n17), .CN(n12) );
  BUFFD1 U13 ( .I(ClearIn), .Z(n13) );
endmodule

