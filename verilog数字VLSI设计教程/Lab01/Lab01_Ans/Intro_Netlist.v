
module XorNor ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;
  wire   n5, n1, n3, n4;

  INVD1 U1 ( .I(n3), .ZN(n4) );
  INVD4 U2 ( .I(n4), .ZN(n1) );
  CKND16 U3 ( .CLK(n1), .CN(X) );
  NR2D2 U4 ( .A1(C), .A2(n5), .ZN(Y) );
  XNR2D2 U5 ( .A1(B), .A2(A), .ZN(n3) );
  XOR2D2 U6 ( .A1(B), .A2(A), .Z(n5) );
endmodule


module SR ( Q, Qn, S, R );
  input S, R;
  output Q, Qn;


  CKND2D2 U2 ( .A1(Q), .A2(R), .ZN(Qn) );
  ND2D2 U1 ( .A1(S), .A2(Qn), .ZN(Q) );
endmodule


module AndOr ( X, Y, A, B, C );
  input A, B, C;
  output X, Y;


  OR2D1 U1 ( .A1(C), .A2(B), .Z(Y) );
  AN2D1 U2 ( .A1(B), .A2(A), .Z(X) );
endmodule


module Intro_Top ( X, Y, Z, A, B, C, D );
  input A, B, C, D;
  output X, Y, Z;
  wire   n5, qn, ab, bc, q, n2;

  AndOr InputCombo01 ( .X(ab), .Y(bc), .A(A), .B(B), .C(C) );
  SR SRLatch01 ( .Q(q), .Qn(qn), .S(bc), .R(D) );
  XorNor OutputCombo01 ( .X(X), .Y(n5), .A(ab), .B(q), .C(qn) );
  CKNXD16 U2 ( .I(n2), .ZN(Y) );
  INVD4 U3 ( .I(n5), .ZN(n2) );
  INVD10 U4 ( .I(qn), .ZN(Z) );
endmodule

