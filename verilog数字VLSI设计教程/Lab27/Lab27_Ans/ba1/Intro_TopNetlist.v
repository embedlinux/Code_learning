
module Intro_Top ( X, Y, Z, A, B, C, D );
  input A, B, C, D;
  output X, Y, Z;
  wire   qn, ab, bc, q;

initial $sdf_annotate("Intro_TopNetlist.sdf");

  AndOr InputCombo01 ( .X(ab), .Y(bc), .A(A), .B(B), .C(C) );
  SR SRLatch01 ( .Q(q), .Qn(qn), .S(bc), .R(D) );
  XorNor OutputCombo01 ( .X(X), .Y(Y), .A(ab), .B(q), .C(qn) );
  INVD16 U2 ( .I(qn), .ZN(Z) );
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
  wire   n1, n3;

  OR2D0 U1 ( .A1(C), .A2(X), .Z(n1) );
  INVD16 U2 ( .I(n1), .ZN(Y) );
  XNR2D0 U3 ( .A1(B), .A2(A), .ZN(n3) );
  INVD16 U4 ( .I(n3), .ZN(X) );
endmodule

