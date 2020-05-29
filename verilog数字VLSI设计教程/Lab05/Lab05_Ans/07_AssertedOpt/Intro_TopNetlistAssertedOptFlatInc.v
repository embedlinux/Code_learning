
module Intro_Top ( X, Y, Z, A, B, C, D, ScanOut, ScanMode, ScanIn, ScanClr, 
        ScanClk );
  input A, B, C, D, ScanMode, ScanIn, ScanClr, ScanClk;
  output X, Y, Z, ScanOut;
  wire   n25, qn, ab, bc, FFA_to_A, FFB_to_B, FFC_to_C, q, FFD_to_D, X_to_FFX,
         Y_to_FFY, toD_FFX, fromQ_FFY, toD_FFY, fromQ_FFZ, toD_FFZ, fromQ_FFA,
         toD_FFA, fromQ_FFB, toD_FFB, fromQ_FFC, toD_FFC, fromQ_FFD, toD_FFD,
         n8, n10, n12, n13, n14, n15, n16, n17, n19, n20, n21, n23, n24,
         \FF_Y_s06/Qn , \FF_B_s03/Qn , \FF_C_s02/Qn , \FF_D_s01/Qn , n26;

  CKBD0 U19 ( .CLK(n24), .C(n8) );
  CKNXD16 U20 ( .I(n8), .ZN(X) );
  CKBD0 U21 ( .CLK(n23), .C(n10) );
  CKNXD16 U22 ( .I(n10), .ZN(Y) );
  MUX2ND0 U23 ( .I0(Y_to_FFY), .I1(fromQ_FFY), .S(ScanMode), .ZN(n12) );
  MUX2ND0 U24 ( .I0(X_to_FFX), .I1(n25), .S(ScanMode), .ZN(n13) );
  CKBD0 U25 ( .CLK(n14), .C(n17) );
  CKNXD16 U26 ( .I(n17), .ZN(ScanOut) );
  INVD0 U27 ( .I(ScanClk), .ZN(n19) );
  INVD0 U28 ( .I(n19), .ZN(n20) );
  INVD0 U29 ( .I(ScanClr), .ZN(n21) );
  CKBD0 U31 ( .CLK(n12), .C(n23) );
  CKBD0 U32 ( .CLK(n13), .C(n24) );
  MUX2ND0 U33 ( .I0(qn), .I1(n15), .S(ScanMode), .ZN(toD_FFZ) );
  MUX2D0 U34 ( .I0(Y_to_FFY), .I1(fromQ_FFZ), .S(ScanMode), .Z(toD_FFY) );
  MUX2D0 U35 ( .I0(X_to_FFX), .I1(fromQ_FFY), .S(ScanMode), .Z(toD_FFX) );
  MUX2D0 U36 ( .I0(D), .I1(ScanIn), .S(ScanMode), .Z(toD_FFD) );
  MUX2D0 U37 ( .I0(C), .I1(fromQ_FFD), .S(ScanMode), .Z(toD_FFC) );
  MUX2D0 U38 ( .I0(B), .I1(fromQ_FFC), .S(ScanMode), .Z(toD_FFB) );
  MUX2D0 U39 ( .I0(A), .I1(fromQ_FFB), .S(ScanMode), .Z(toD_FFA) );
  MUX2D0 U40 ( .I0(D), .I1(fromQ_FFD), .S(ScanMode), .Z(FFD_to_D) );
  MUX2D0 U41 ( .I0(C), .I1(fromQ_FFC), .S(ScanMode), .Z(FFC_to_C) );
  MUX2D0 U42 ( .I0(B), .I1(fromQ_FFB), .S(ScanMode), .Z(FFB_to_B) );
  MUX2D0 U43 ( .I0(A), .I1(fromQ_FFA), .S(ScanMode), .Z(FFA_to_A) );
  AN2D0 \InputCombo/U2  ( .A1(FFB_to_B), .A2(FFA_to_A), .Z(ab) );
  OR2D0 \InputCombo/U1  ( .A1(FFC_to_C), .A2(FFB_to_B), .Z(bc) );
  CKND2D0 \SRLatch/U1  ( .A1(bc), .A2(qn), .ZN(q) );
  CKND2D2 \SRLatch/U2  ( .A1(q), .A2(FFD_to_D), .ZN(qn) );
  CKXOR2D0 \OutputCombo/U2  ( .A1(q), .A2(ab), .Z(X_to_FFX) );
  NR2D0 \OutputCombo/U1  ( .A1(qn), .A2(X_to_FFX), .ZN(Y_to_FFY) );
  DFCND1 \FF_X_s07/QReg_reg  ( .D(toD_FFX), .CP(n20), .CDN(n21), .Q(n25), .QN(
        n14) );
  DFCND1 \FF_Y_s06/QReg_reg  ( .D(toD_FFY), .CP(n20), .CDN(n21), .Q(fromQ_FFY), 
        .QN(\FF_Y_s06/Qn ) );
  DFCND1 \FF_Z_s05/QReg_reg  ( .D(toD_FFZ), .CP(ScanClk), .CDN(n21), .Q(
        fromQ_FFZ), .QN(n16) );
  DFCND1 \FF_A_s04/QReg_reg  ( .D(toD_FFA), .CP(n20), .CDN(n21), .Q(fromQ_FFA), 
        .QN(n15) );
  DFCND1 \FF_B_s03/QReg_reg  ( .D(toD_FFB), .CP(n20), .CDN(n21), .Q(fromQ_FFB), 
        .QN(\FF_B_s03/Qn ) );
  DFCND1 \FF_C_s02/QReg_reg  ( .D(toD_FFC), .CP(ScanClk), .CDN(n21), .Q(
        fromQ_FFC), .QN(\FF_C_s02/Qn ) );
  DFCND1 \FF_D_s01/QReg_reg  ( .D(toD_FFD), .CP(ScanClk), .CDN(n21), .Q(
        fromQ_FFD), .QN(\FF_D_s01/Qn ) );
  CKMUX2D0 U17 ( .I0(qn), .I1(n16), .S(ScanMode), .Z(n26) );
  CKNXD16 U18 ( .I(n26), .ZN(Z) );
endmodule

