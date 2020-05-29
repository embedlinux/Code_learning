
module Netter ( XYout, Sel );
  input [3:0] Sel;
  output XYout;
  wire   n1, n2, n9, n10, n11, n12, n23, n24, n25, n26, n27, n28, n29, n30;

  NR2D0 U3 ( .A1(n9), .A2(n10), .ZN(n30) );
  NR2D0 U4 ( .A1(n11), .A2(n12), .ZN(n26) );
  NR2D0 U5 ( .A1(Sel[3]), .A2(Sel[2]), .ZN(n27) );
  NR2D0 U6 ( .A1(Sel[1]), .A2(Sel[0]), .ZN(n23) );
  NR2D0 U7 ( .A1(Sel[3]), .A2(n9), .ZN(n28) );
  CKND0 U8 ( .CLK(Sel[2]), .CN(n9) );
  NR2D0 U9 ( .A1(Sel[1]), .A2(n11), .ZN(n24) );
  CKND0 U10 ( .CLK(Sel[0]), .CN(n11) );
  NR2D0 U11 ( .A1(Sel[2]), .A2(n10), .ZN(n29) );
  CKND0 U12 ( .CLK(Sel[3]), .CN(n10) );
  NR2D0 U14 ( .A1(Sel[0]), .A2(n12), .ZN(n25) );
  CKND0 U15 ( .CLK(Sel[1]), .CN(n12) );
  BUFTD16 SupplyBufX ( .I(n1), .OE(n23), .Z(XYout) );
  BUFTD16 StrongBufX ( .I(n1), .OE(n24), .Z(XYout) );
  BUFTD16 PullBufX ( .I(n1), .OE(n25), .Z(XYout) );
  BUFTD16 WeakBufX ( .I(n1), .OE(n26), .Z(XYout) );
  BUFTD16 SupplyBufY ( .I(n2), .OE(n27), .Z(XYout) );
  BUFTD16 StrongBufY ( .I(n2), .OE(n28), .Z(XYout) );
  BUFTD16 PullBufY ( .I(n2), .OE(n29), .Z(XYout) );
  BUFTD16 WeakBufY ( .I(n2), .OE(n30), .Z(XYout) );
  TIEH U25 ( .Z(n2) );
  TIEL U26 ( .ZN(n1) );
endmodule

