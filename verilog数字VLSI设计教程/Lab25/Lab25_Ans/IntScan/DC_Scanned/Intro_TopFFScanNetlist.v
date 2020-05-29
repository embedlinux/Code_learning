
module Intro_TopFF ( X, Y, Z, A, B, C, D, Clk, Clr, tms, tdi, tdo );
  input A, B, C, D, Clk, Clr, tms, tdi;
  output X, Y, Z, tdo;
  wire   n19, n20, n21, toZFF_D, SRq, toXFF_D, toYFF_D, n3, n5, n6, n10, n12,
         n14, n16, n17, n18, n22, n23, n24, n27, n28;

  AN2D2 \SRLatch/C10  ( .A1(D), .A2(SRq), .Z(toZFF_D) );
  SDFCNQD0 \FF_X/QReg_reg  ( .D(toXFF_D), .SI(tdi), .SE(tms), .CP(Clk), .CDN(
        n3), .Q(n19) );
  SDFCNQD0 \FF_Y/QReg_reg  ( .D(toYFF_D), .SI(n28), .SE(tms), .CP(Clk), .CDN(
        n3), .Q(n20) );
  SDFCNQD0 \FF_Z/QReg_reg  ( .D(toZFF_D), .SI(n27), .SE(tms), .CP(Clk), .CDN(
        n3), .Q(n21) );
  INVD1 U3 ( .I(Clr), .ZN(n3) );
  CKNXD16 U10 ( .I(n24), .ZN(n27) );
  CKNXD16 U11 ( .I(n12), .ZN(tdo) );
  CKNXD16 U12 ( .I(n23), .ZN(n28) );
  CKNXD16 U13 ( .I(n14), .ZN(X) );
  CKBD0 U14 ( .CLK(n16), .C(n14) );
  CKNXD16 U15 ( .I(n10), .ZN(Y) );
  CKBD0 U16 ( .CLK(n17), .C(n10) );
  CKNXD16 U17 ( .I(n22), .ZN(Z) );
  CKBD0 U18 ( .CLK(n18), .C(n12) );
  NR2D1 U19 ( .A1(toXFF_D), .A2(n5), .ZN(toYFF_D) );
  OAI21D1 U20 ( .A1(B), .A2(C), .B(n5), .ZN(SRq) );
  XNR2D1 U21 ( .A1(SRq), .A2(n6), .ZN(toXFF_D) );
  ND2D1 U22 ( .A1(B), .A2(A), .ZN(n6) );
  INVD1 U23 ( .I(toZFF_D), .ZN(n5) );
  CKND0 U25 ( .CLK(n19), .CN(n16) );
  CKND0 U26 ( .CLK(n20), .CN(n17) );
  CKND0 U27 ( .CLK(n21), .CN(n18) );
  CKBD0 U24 ( .CLK(n18), .C(n22) );
  BUFFD0 U28 ( .I(n14), .Z(n23) );
  BUFFD0 U29 ( .I(n10), .Z(n24) );
endmodule

