
module Intro_Top ( X, Y, Z, A, B, C, D, ScanOut, ScanMode, ScanIn, ScanClr, 
        ScanClk );
  input A, B, C, D, ScanMode, ScanIn, ScanClr, ScanClk;
  output X, Y, Z, ScanOut;
  wire   qn, Z_to_FFZ, ab, bc, FFA_to_A, FFB_to_B, FFC_to_C, q, FFD_to_D,
         X_to_FFX, Y_to_FFY, fromQ_FFX, fromQ_FFY, fromQ_FFZ, fromQ_FFA,
         fromQ_FFB, fromQ_FFC, fromQ_FFD, n4, n5, n6, n7, n8, n9, n10, n12,
         n13, n15, n16, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32;

  AndOr InputCombo ( .X(ab), .Y(bc), .A(FFA_to_A), .B(FFB_to_B), .C(FFC_to_C)
         );
  SR SRLatch ( .Q(q), .Qn(qn), .S(bc), .R(FFD_to_D) );
  XorNor OutputCombo ( .X(X_to_FFX), .Y(Y_to_FFY), .A(ab), .B(q), .C(qn) );
  FFC_0 FF_X ( .Q(fromQ_FFX), .Qn(n5), .D(X_to_FFX), .Clk(n9), .Clr(n31) );
  FFC_6 FF_Y ( .Q(fromQ_FFY), .Qn(n6), .D(n27), .Clk(n9), .Clr(n31) );
  FFC_5 FF_Z ( .Q(fromQ_FFZ), .Qn(n7), .D(Z_to_FFZ), .Clk(n9), .Clr(n31) );
  FFC_4 FF_A ( .Q(fromQ_FFA), .D(A), .Clk(n9), .Clr(n31) );
  FFC_3 FF_B ( .Q(fromQ_FFB), .D(B), .Clk(ScanClk), .Clr(n31) );
  FFC_2 FF_C ( .Q(fromQ_FFC), .D(C), .Clk(ScanClk), .Clr(n31) );
  FFC_1 FF_D ( .Q(fromQ_FFD), .D(D), .Clk(ScanClk), .Clr(n31) );
  BUFFD1 U10 ( .I(ScanMode), .Z(n32) );
  INVD0 U11 ( .I(ScanClk), .ZN(n8) );
  INVD0 U12 ( .I(n8), .ZN(n9) );
  CKBD0 U13 ( .CLK(n12), .C(n10) );
  CKNXD16 U14 ( .I(n10), .ZN(X) );
  CKBD0 U15 ( .CLK(n26), .C(n12) );
  CKBD0 U16 ( .CLK(n15), .C(n13) );
  CKNXD16 U17 ( .I(n13), .ZN(Z) );
  CKBD0 U18 ( .CLK(n23), .C(n15) );
  CKBD0 U19 ( .CLK(n18), .C(n16) );
  CKNXD16 U20 ( .I(n16), .ZN(Y) );
  CKBD0 U21 ( .CLK(n19), .C(n18) );
  INVD1 U22 ( .I(Y_to_FFY), .ZN(n20) );
  NR2D1 U23 ( .A1(n32), .A2(n20), .ZN(n21) );
  NR2D0 U24 ( .A1(n6), .A2(n4), .ZN(n22) );
  NR2XD0 U25 ( .A1(n21), .A2(n22), .ZN(n19) );
  NR2D0 U26 ( .A1(n4), .A2(n7), .ZN(n24) );
  NR2D0 U27 ( .A1(qn), .A2(n32), .ZN(n25) );
  NR2XD0 U28 ( .A1(n24), .A2(n25), .ZN(n23) );
  OA22D0 U29 ( .A1(n5), .A2(n4), .B1(n30), .B2(n32), .Z(n26) );
  INVD1 U30 ( .I(X_to_FFX), .ZN(n30) );
  INVD0 U31 ( .I(qn), .ZN(Z_to_FFZ) );
  INVD1 U32 ( .I(n32), .ZN(n4) );
  AO22D0 U33 ( .A1(fromQ_FFB), .A2(n32), .B1(n4), .B2(B), .Z(FFB_to_B) );
  AO22D0 U34 ( .A1(fromQ_FFD), .A2(n32), .B1(D), .B2(n4), .Z(FFD_to_D) );
  BUFFD1 U35 ( .I(ScanClr), .Z(n31) );
  BUFFD0 U36 ( .I(Y_to_FFY), .Z(n27) );
  CKND2D0 U37 ( .A1(fromQ_FFC), .A2(n32), .ZN(n28) );
  CKND2D0 U38 ( .A1(C), .A2(n4), .ZN(n29) );
  ND2D1 U39 ( .A1(n28), .A2(n29), .ZN(FFC_to_C) );
  AO22D0 U40 ( .A1(fromQ_FFA), .A2(n32), .B1(A), .B2(n4), .Z(FFA_to_A) );
endmodule


module AndOr ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;


  OR2D1 U1 ( .A1(C), .A2(B), .Z(Y) );
  AN2D1 U2 ( .A1(B), .A2(A), .Z(X) );
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


  NR2D0 U1 ( .A1(C), .A2(X), .ZN(Y) );
  XOR2D1 U2 ( .A1(B), .A2(A), .Z(X) );
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

