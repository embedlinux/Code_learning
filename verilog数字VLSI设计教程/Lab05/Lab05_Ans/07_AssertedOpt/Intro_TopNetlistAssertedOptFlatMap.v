
module Intro_Top ( X, Y, Z, A, B, C, D, ScanOut, ScanMode, ScanIn, ScanClr, 
        ScanClk );
  input A, B, C, D, ScanMode, ScanIn, ScanClr, ScanClk;
  output X, Y, Z, ScanOut;
  wire   qn, q, FFD_to_D, toD_FFX, toD_FFY, toD_FFZ, toD_FFA, toD_FFB, toD_FFC,
         toD_FFD, n15, n86, n20, n21, n49, n51, n52, n53, n55, n57, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n69, n70, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85;
  assign n20 = ScanClk;

  CKND2D2 \SRLatch/U2  ( .A1(q), .A2(FFD_to_D), .ZN(qn) );
  DFCND1 \FF_Y_s06/QReg_reg  ( .D(toD_FFY), .CP(n66), .CDN(n21), .QN(n49) );
  DFCND1 \FF_A_s04/QReg_reg  ( .D(toD_FFA), .CP(n66), .CDN(n21), .QN(n15) );
  DFCND1 \FF_B_s03/QReg_reg  ( .D(toD_FFB), .CP(n66), .CDN(n21), .Q(n63), .QN(
        n52) );
  DFCND1 \FF_C_s02/QReg_reg  ( .D(toD_FFC), .CP(n66), .CDN(n21), .Q(n62), .QN(
        n51) );
  DFCND1 \FF_D_s01/QReg_reg  ( .D(toD_FFD), .CP(n66), .CDN(n21), .Q(n61) );
  DFCND1 \FF_Z_s05/QReg_reg  ( .D(toD_FFZ), .CP(n66), .CDN(n21), .QN(n65) );
  DFCND1 \FF_X_s07/QReg_reg  ( .D(toD_FFX), .CP(n66), .CDN(n21), .Q(n86), .QN(
        n74) );
  CKBD0 U39 ( .CLK(n64), .C(n53) );
  CKNXD16 U40 ( .I(n53), .ZN(Z) );
  CKBD0 U41 ( .CLK(n70), .C(n55) );
  CKNXD16 U42 ( .I(n55), .ZN(Y) );
  CKMUX2D0 U43 ( .I0(n74), .I1(n78), .S(n75), .Z(n57) );
  CKNXD16 U44 ( .I(n57), .ZN(X) );
  INVD6 U45 ( .I(n60), .ZN(n70) );
  INVD6 U46 ( .I(n59), .ZN(n64) );
  OAI21D1 U47 ( .A1(n65), .A2(n75), .B(n76), .ZN(n59) );
  OAI21D1 U48 ( .A1(n49), .A2(n75), .B(n77), .ZN(n60) );
  MUX2D0 U49 ( .I0(C), .I1(n61), .S(ScanMode), .Z(toD_FFC) );
  MUX2D0 U50 ( .I0(D), .I1(n61), .S(ScanMode), .Z(FFD_to_D) );
  NR2D1 U51 ( .A1(n62), .A2(n63), .ZN(n84) );
  BUFFD0 U52 ( .I(n20), .Z(n66) );
  CKBD0 U53 ( .CLK(n69), .C(n67) );
  CKNXD16 U54 ( .I(n67), .ZN(ScanOut) );
  CKND0 U55 ( .CLK(n86), .CN(n69) );
  OAI21D0 U56 ( .A1(n75), .A2(n15), .B(n76), .ZN(toD_FFZ) );
  OAI21D0 U57 ( .A1(n75), .A2(n65), .B(n77), .ZN(toD_FFY) );
  MUX2ND0 U58 ( .I0(n49), .I1(n78), .S(n75), .ZN(toD_FFX) );
  MUX2D0 U59 ( .I0(ScanIn), .I1(D), .S(n75), .Z(toD_FFD) );
  MUX2ND0 U60 ( .I0(n51), .I1(n79), .S(n75), .ZN(toD_FFB) );
  MUX2ND0 U61 ( .I0(n52), .I1(n80), .S(n75), .ZN(toD_FFA) );
  CKND0 U62 ( .CLK(ScanClr), .CN(n21) );
  CKND0 U63 ( .CLK(n81), .CN(n76) );
  CKND2D0 U64 ( .A1(n81), .A2(n78), .ZN(n77) );
  NR2D0 U65 ( .A1(ScanMode), .A2(qn), .ZN(n81) );
  XNR2D0 U66 ( .A1(n82), .A2(q), .ZN(n78) );
  CKND2D0 U67 ( .A1(n83), .A2(qn), .ZN(q) );
  MUX2ND0 U68 ( .I0(n84), .I1(n85), .S(n75), .ZN(n83) );
  NR2D0 U69 ( .A1(C), .A2(B), .ZN(n85) );
  NR2D0 U70 ( .A1(n80), .A2(n79), .ZN(n82) );
  CKND0 U71 ( .CLK(B), .CN(n79) );
  CKND0 U72 ( .CLK(A), .CN(n80) );
  CKND0 U73 ( .CLK(ScanMode), .CN(n75) );
endmodule

