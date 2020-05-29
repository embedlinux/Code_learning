
module Intro_Top ( X, Y, Z, A, B, C, D, ScanOut, ScanMode, ScanIn, ScanClr, 
        ScanClk );
  input A, B, C, D, ScanMode, ScanIn, ScanClr, ScanClk;
  output X, Y, Z, ScanOut;
  wire   n12, n13, n14, qn, Z_to_FFZ, ab, bc, FFA_to_A, FFB_to_B, FFC_to_C, q,
         FFD_to_D, X_to_FFX, Y_to_FFY, n2, n3, n4, n5, n7, n9, n11;

  AndOr InputCombo ( .X(ab), .Y(bc), .A(FFA_to_A), .B(FFB_to_B), .C(FFC_to_C)
         );
  SR SRLatch ( .Q(q), .Qn(qn), .S(bc), .R(FFD_to_D) );
  XorNor OutputCombo ( .X(X_to_FFX), .Y(Y_to_FFY), .A(ab), .B(q), .C(qn) );
  FFC_0 FF_X ( .Q(n12), .Qn(n4), .D(X_to_FFX), .Clk(ScanClk), .Clr(n11) );
  FFC_6 FF_Y ( .Q(n13), .Qn(n3), .D(Y_to_FFY), .Clk(ScanClk), .Clr(n11) );
  FFC_5 FF_Z ( .Q(n14), .Qn(n2), .D(Z_to_FFZ), .Clk(ScanClk), .Clr(n11) );
  FFC_4 FF_A ( .Q(FFA_to_A), .D(A), .Clk(ScanClk), .Clr(n11) );
  FFC_3 FF_B ( .Q(FFB_to_B), .D(B), .Clk(ScanClk), .Clr(n11) );
  FFC_2 FF_C ( .Q(FFC_to_C), .D(C), .Clk(ScanClk), .Clr(n11) );
  FFC_1 FF_D ( .Q(FFD_to_D), .D(D), .Clk(ScanClk), .Clr(n11) );
  CKBD0 U2 ( .CLK(n4), .C(n5) );
  CKNXD16 U3 ( .I(n5), .ZN(X) );
  CKBD0 U4 ( .CLK(n2), .C(n7) );
  CKNXD16 U5 ( .I(n7), .ZN(Z) );
  CKBD0 U6 ( .CLK(n3), .C(n9) );
  CKNXD16 U7 ( .I(n9), .ZN(Y) );
  INVD1 U8 ( .I(qn), .ZN(Z_to_FFZ) );
  BUFFD1 U9 ( .I(ScanClr), .Z(n11) );
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


  XOR2D1 U1 ( .A1(B), .A2(A), .Z(X) );
  NR2D1 U2 ( .A1(C), .A2(X), .ZN(Y) );
endmodule


module FFC_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .QN(Qn) );
  INVD1 U4 ( .I(Qn), .ZN(Q) );
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
  wire   n5;

  INVD1 U3 ( .I(Clr), .ZN(n5) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n5), .QN(Qn) );
  INVD1 U4 ( .I(Qn), .ZN(Q) );
endmodule


module FFC_6 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n4;

  INVD1 U3 ( .I(Clr), .ZN(n4) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n4), .Q(Q), .QN(Qn) );
endmodule

