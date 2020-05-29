
module Intro_TopFF ( X, Y, Z, tdo, A, B, C, D, Clk, Clr, tms, tdi );
  input A, B, C, D, Clk, Clr, tms, tdi;
  output X, Y, Z, tdo;
  wire   n19, n20, n21, toFFZ_D, SRq, toFFX_D, toFFY_D, n3, n5, n6, n10, n12,
         n14, n16, n17, n18, n22, n23, n24, n27, n28;

  AN2D2 \SRLatch/C10  ( .A1(D), .A2(SRq), .Z(toFFZ_D) );
  INVD1 U3 ( .I(Clr), .ZN(n3) );
  SDFCNQD0 \FFX/QReg_reg  ( .D(toFFX_D), .SI(tdi), .SE(tms), .CP(Clk), .CDN(n3), .Q(n19) );
  SDFCNQD0 \FFZ/QReg_reg  ( .D(toFFZ_D), .SI(n27), .SE(tms), .CP(Clk), .CDN(n3), .Q(n21) );
  SDFCNQD0 \FFY/QReg_reg  ( .D(toFFY_D), .SI(n28), .SE(tms), .CP(Clk), .CDN(n3), .Q(n20) );
  CKNXD16 U10 ( .I(n23), .ZN(n28) );
  CKNXD16 U11 ( .I(n24), .ZN(n27) );
  CKNXD16 U12 ( .I(n12), .ZN(tdo) );
  CKNXD16 U13 ( .I(n22), .ZN(Z) );
  CKBD0 U14 ( .CLK(n18), .C(n12) );
  CKNXD16 U15 ( .I(n14), .ZN(X) );
  CKBD0 U16 ( .CLK(n16), .C(n14) );
  CKNXD16 U17 ( .I(n10), .ZN(Y) );
  CKBD0 U18 ( .CLK(n17), .C(n10) );
  NR2D1 U19 ( .A1(toFFX_D), .A2(n5), .ZN(toFFY_D) );
  CKNXD0 U20 ( .I(n19), .ZN(n16) );
  CKNXD0 U21 ( .I(n20), .ZN(n17) );
  CKNXD0 U22 ( .I(n21), .ZN(n18) );
  OAI21D1 U23 ( .A1(B), .A2(C), .B(n5), .ZN(SRq) );
  XNR2D1 U24 ( .A1(SRq), .A2(n6), .ZN(toFFX_D) );
  ND2D1 U25 ( .A1(B), .A2(A), .ZN(n6) );
  INVD1 U26 ( .I(toFFZ_D), .ZN(n5) );
  CKBD0 U27 ( .CLK(n18), .C(n22) );
  BUFFD0 U28 ( .I(n14), .Z(n23) );
  BUFFD0 U29 ( .I(n10), .Z(n24) );
endmodule

