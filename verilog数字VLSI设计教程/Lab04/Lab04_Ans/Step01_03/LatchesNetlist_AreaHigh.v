
module Latches ( Qsimple, Qclear, QpreClear, D, ena1, ena2, clr, pre );
  input D, ena1, ena2, clr, pre;
  output Qsimple, Qclear, QpreClear;
  wire   n13, n14, n15, N6, N7, n2, n3, n4, n6, n8, n10, n11, n12;

  LHQD1 QsimpleReg_reg ( .E(ena1), .D(D), .Q(n13) );
  LHQD1 QpreClearReg_reg ( .E(N6), .D(N7), .Q(n15) );
  LNCNQD1 QclearReg_reg ( .D(D), .EN(ena1), .CDN(n3), .Q(n14) );
  CKBD0 U7 ( .CLK(n12), .C(n4) );
  CKNXD16 U8 ( .I(n4), .ZN(Qsimple) );
  CKBD0 U9 ( .CLK(n11), .C(n6) );
  CKNXD16 U10 ( .I(n6), .ZN(QpreClear) );
  CKBD0 U11 ( .CLK(n10), .C(n8) );
  CKNXD16 U12 ( .I(n8), .ZN(Qclear) );
  AOI21D1 U13 ( .A1(pre), .A2(n2), .B(n3), .ZN(N7) );
  ND2D1 U14 ( .A1(ena2), .A2(D), .ZN(n2) );
  INVD1 U15 ( .I(clr), .ZN(n3) );
  IND3D1 U16 ( .A1(ena2), .B1(pre), .B2(clr), .ZN(N6) );
  CKND0 U17 ( .CLK(n14), .CN(n10) );
  CKND0 U18 ( .CLK(n15), .CN(n11) );
  CKND0 U19 ( .CLK(n13), .CN(n12) );
endmodule

