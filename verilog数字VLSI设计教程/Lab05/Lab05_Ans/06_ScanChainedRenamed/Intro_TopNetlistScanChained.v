
module Intro_Top ( X, Y, Z, A, B, C, D, ScanOut, ScanMode, ScanIn, ScanClr, 
        ScanClk );
  input A, B, C, D, ScanMode, ScanIn, ScanClr, ScanClk;
  output X, Y, Z, ScanOut;
  wire   n25, n26, qn, ab, bc, FFA_to_A, FFB_to_B, FFC_to_C, q, FFD_to_D,
         X_to_FFX, Y_to_FFY, toD_FFX, fromQ_FFY, toD_FFY, fromQ_FFZ, toD_FFZ,
         fromQ_FFA, toD_FFA, fromQ_FFB, toD_FFB, fromQ_FFC, toD_FFC, fromQ_FFD,
         toD_FFD, n4, n6, n7, n8, n10, n12, n13, n14, n16, n17, n19, n20, n21,
         n22, n23, n24;

  AndOr InputCombo ( .X(ab), .Y(bc), .A(FFA_to_A), .B(FFB_to_B), .C(FFC_to_C)
         );
  SR SRLatch ( .Q(q), .Qn(qn), .S(bc), .R(FFD_to_D) );
  XorNor OutputCombo ( .X(X_to_FFX), .Y(Y_to_FFY), .A(ab), .B(q), .C(qn) );
  FFC_0 FF_X_s07 ( .Q(n26), .Qn(n6), .D(toD_FFX), .Clk(n13), .Clr(n23) );
  FFC_6 FF_Y_s06 ( .Q(fromQ_FFY), .D(toD_FFY), .Clk(n13), .Clr(n23) );
  FFC_5 FF_Z_s05 ( .Q(fromQ_FFZ), .D(toD_FFZ), .Clk(n13), .Clr(n23) );
  FFC_4 FF_A_s04 ( .Q(fromQ_FFA), .Qn(n7), .D(toD_FFA), .Clk(ScanClk), .Clr(
        n23) );
  FFC_3 FF_B_s03 ( .Q(fromQ_FFB), .D(toD_FFB), .Clk(ScanClk), .Clr(n23) );
  FFC_2 FF_C_s02 ( .Q(fromQ_FFC), .D(toD_FFC), .Clk(n13), .Clr(n23) );
  FFC_1 FF_D_s01 ( .Q(fromQ_FFD), .D(toD_FFD), .Clk(ScanClk), .Clr(n23) );
  INVD1 U17 ( .I(n26), .ZN(n22) );
  INVD1 U18 ( .I(n24), .ZN(n4) );
  BUFFD1 U19 ( .I(ScanMode), .Z(n24) );
  AO22D0 U20 ( .A1(n24), .A2(fromQ_FFB), .B1(n4), .B2(B), .Z(FFB_to_B) );
  AO22D0 U21 ( .A1(n24), .A2(fromQ_FFC), .B1(n4), .B2(C), .Z(FFC_to_C) );
  AO22D0 U22 ( .A1(n24), .A2(fromQ_FFD), .B1(n4), .B2(D), .Z(FFD_to_D) );
  BUFFD1 U23 ( .I(n21), .Z(n16) );
  MAOI22D0 U24 ( .A1(n4), .A2(X_to_FFX), .B1(n22), .B2(n4), .ZN(n21) );
  CKBD0 U25 ( .CLK(n16), .C(n8) );
  CKNXD16 U26 ( .I(n8), .ZN(X) );
  CKBD0 U27 ( .CLK(n6), .C(n10) );
  CKNXD16 U28 ( .I(n10), .ZN(ScanOut) );
  INVD0 U29 ( .I(ScanClk), .ZN(n12) );
  INVD0 U30 ( .I(n12), .ZN(n13) );
  CKBD0 U31 ( .CLK(n20), .C(n14) );
  CKNXD16 U32 ( .I(n14), .ZN(Z) );
  IAO22D2 U33 ( .B1(n24), .B2(fromQ_FFZ), .A1(qn), .A2(n24), .ZN(n20) );
  CKBD0 U34 ( .CLK(n19), .C(n17) );
  CKNXD16 U35 ( .I(n17), .ZN(Y) );
  CKND0 U36 ( .CLK(n25), .CN(n19) );
  AO22D0 U37 ( .A1(Y_to_FFY), .A2(n4), .B1(n24), .B2(fromQ_FFY), .Z(n25) );
  BUFFD1 U38 ( .I(ScanClr), .Z(n23) );
  AO22D0 U39 ( .A1(n4), .A2(D), .B1(ScanIn), .B2(n24), .Z(toD_FFD) );
  AO22D0 U40 ( .A1(n4), .A2(C), .B1(n24), .B2(fromQ_FFD), .Z(toD_FFC) );
  AO22D0 U41 ( .A1(n4), .A2(B), .B1(n24), .B2(fromQ_FFC), .Z(toD_FFB) );
  AO22D0 U42 ( .A1(n4), .A2(A), .B1(n24), .B2(fromQ_FFB), .Z(toD_FFA) );
  OAI22D0 U43 ( .A1(n4), .A2(n7), .B1(qn), .B2(n24), .ZN(toD_FFZ) );
  AO22D0 U44 ( .A1(n24), .A2(fromQ_FFY), .B1(n4), .B2(X_to_FFX), .Z(toD_FFX)
         );
  AO22D0 U45 ( .A1(n24), .A2(fromQ_FFA), .B1(n4), .B2(A), .Z(FFA_to_A) );
  AO22D0 U46 ( .A1(n24), .A2(fromQ_FFZ), .B1(n4), .B2(Y_to_FFY), .Z(toD_FFY)
         );
endmodule


module AndOr ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;
  wire   n1, n2;

  AN2D1 U1 ( .A1(B), .A2(A), .Z(X) );
  ND2D1 U2 ( .A1(n1), .A2(n2), .ZN(Y) );
  INVD1 U3 ( .I(C), .ZN(n1) );
  INVD1 U4 ( .I(B), .ZN(n2) );
endmodule


module SR ( Q, Qn, S, R );
  input S, R;
  output Q, Qn;


  CKND2D2 U2 ( .A1(Q), .A2(R), .ZN(Qn) );
  ND2D1 U1 ( .A1(S), .A2(Qn), .ZN(Q) );
endmodule


module XorNor ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;
  wire   n2;

  NR2D1 U1 ( .A1(n2), .A2(C), .ZN(Y) );
  XOR2D1 U2 ( .A1(B), .A2(A), .Z(n2) );
  XOR2D1 U3 ( .A1(B), .A2(A), .Z(X) );
endmodule


module FFC_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
endmodule


module FFC_1 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module FFC_2 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module FFC_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module FFC_4 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module FFC_5 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module FFC_6 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule

