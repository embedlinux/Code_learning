
module Intro_Top ( X, Y, Z, A, B, C, D );
  input A, B, C, D;
  output X, Y, Z;
  wire   n10, qn, q, n2, n3, n4, n5, n6, n7;

  CKND2D2 \SRLatch01/U2  ( .A1(q), .A2(D), .ZN(qn) );
  INVD8 U6 ( .I(n3), .ZN(Z) );
  BUFFD4 U7 ( .I(qn), .Z(n3) );
  CKND2D3 U8 ( .A1(n10), .A2(n4), .ZN(n6) );
  CKNXD16 U9 ( .I(n7), .ZN(X) );
  CKND3 U10 ( .CLK(n5), .CN(n7) );
  CKND0 U11 ( .CLK(n3), .CN(n10) );
  CKXOR2D2 U12 ( .A1(q), .A2(n2), .Z(n4) );
  CKND0 U13 ( .CLK(n4), .CN(n5) );
  OAI21D2 U14 ( .A1(C), .A2(B), .B(n3), .ZN(q) );
  ND2D1 U15 ( .A1(B), .A2(A), .ZN(n2) );
  CKND16 U16 ( .CLK(n6), .CN(Y) );
endmodule

