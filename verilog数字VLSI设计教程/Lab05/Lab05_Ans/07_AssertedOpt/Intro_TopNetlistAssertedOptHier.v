
module Intro_Top ( X, Y, Z, A, B, C, D, ScanOut, ScanMode, ScanIn, ScanClr, 
        ScanClk );
  input A, B, C, D, ScanMode, ScanIn, ScanClr, ScanClk;
  output X, Y, Z, ScanOut;
  wire   n25, qn, ab, bc, FFA_to_A, FFB_to_B, FFC_to_C, q, FFD_to_D, X_to_FFX,
         Y_to_FFY, toD_FFX, fromQ_FFY, toD_FFY, fromQ_FFZ, toD_FFZ, fromQ_FFA,
         toD_FFA, fromQ_FFB, toD_FFB, fromQ_FFC, toD_FFC, fromQ_FFD, toD_FFD,
         n6, n8, n10, n12, n13, n14, n15, n16, n17, n19, n20, n21, n22, n23,
         n24;

  AndOr InputCombo ( .X(ab), .Y(bc), .A(FFA_to_A), .B(FFB_to_B), .C(FFC_to_C)
         );
  SR SRLatch ( .Q(q), .Qn(qn), .S(bc), .R(FFD_to_D) );
  XorNor OutputCombo ( .X(X_to_FFX), .Y(Y_to_FFY), .A(ab), .B(q), .C(qn) );
  FFC_0 FF_X_s07 ( .Q(n25), .Qn(n14), .D(toD_FFX), .Clk(n20), .Clr(ScanClr) );
  FFC_6 FF_Y_s06 ( .Q(fromQ_FFY), .D(toD_FFY), .Clk(n20), .Clr(ScanClr) );
  FFC_5 FF_Z_s05 ( .Q(fromQ_FFZ), .Qn(n16), .D(toD_FFZ), .Clk(ScanClk), .Clr(
        n22) );
  FFC_4 FF_A_s04 ( .Q(fromQ_FFA), .Qn(n15), .D(toD_FFA), .Clk(n20), .Clr(n22)
         );
  FFC_3 FF_B_s03 ( .Q(fromQ_FFB), .D(toD_FFB), .Clk(n20), .Clr(n22) );
  FFC_2 FF_C_s02 ( .Q(fromQ_FFC), .D(toD_FFC), .Clk(ScanClk), .Clr(n22) );
  FFC_1 FF_D_s01 ( .Q(fromQ_FFD), .D(toD_FFD), .Clk(ScanClk), .Clr(ScanClr) );
  CKMUX2D0 U17 ( .I0(qn), .I1(n16), .S(ScanMode), .Z(n6) );
  CKNXD16 U18 ( .I(n6), .ZN(Z) );
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
  INVD0 U30 ( .I(n21), .ZN(n22) );
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
endmodule


module AndOr ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;


  OR2D0 U1 ( .A1(C), .A2(B), .Z(Y) );
  AN2D0 U2 ( .A1(B), .A2(A), .Z(X) );
endmodule


module SR ( Q, Qn, S, R );
  input S, R;
  output Q, Qn;


  CKND2D2 U2 ( .A1(Q), .A2(R), .ZN(Qn) );
  CKND2D0 U1 ( .A1(S), .A2(Qn), .ZN(Q) );
endmodule


module XorNor ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;


  NR2D0 U1 ( .A1(C), .A2(X), .ZN(Y) );
  CKXOR2D0 U2 ( .A1(B), .A2(A), .Z(X) );
endmodule


module FFC_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n1) );
endmodule


module FFC_1 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n2) );
endmodule


module FFC_2 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n2) );
endmodule


module FFC_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n2) );
endmodule


module FFC_4 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n2) );
endmodule


module FFC_5 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n2) );
endmodule


module FFC_6 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
  CKND0 U3 ( .CLK(Clr), .CN(n2) );
endmodule

