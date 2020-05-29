
module Counter4 ( CountOut, ClockIn, Clear );
  output [3:0] CountOut;
  input ClockIn, Clear;
  wire   n20, n21, n22, N1, N2, N3, N4, n1, n4, n5, n7, n8, n10, n12, n14, n15,
         n16, n17, n18, n19;

  DFCND1 \CountReg_reg[0]  ( .D(N1), .CP(ClockIn), .CDN(n1), .Q(n4), .QN(N1)
         );
  DFCNQD1 \CountReg_reg[1]  ( .D(N4), .CP(ClockIn), .CDN(n1), .Q(n22) );
  DFCNQD1 \CountReg_reg[2]  ( .D(N2), .CP(ClockIn), .CDN(n1), .Q(n21) );
  DFCNQD1 \CountReg_reg[3]  ( .D(N3), .CP(ClockIn), .CDN(n1), .Q(n20) );
  ND2D1 U9 ( .A1(n4), .A2(n22), .ZN(n19) );
  CKBD0 U10 ( .CLK(n7), .C(n5) );
  CKNXD16 U11 ( .I(n5), .ZN(CountOut[3]) );
  CKBD0 U12 ( .CLK(n15), .C(n7) );
  XNR2D1 U13 ( .A1(n15), .A2(n18), .ZN(N3) );
  CKND0 U14 ( .CLK(n20), .CN(n15) );
  CKBD0 U15 ( .CLK(n17), .C(n8) );
  CKNXD16 U16 ( .I(n8), .ZN(CountOut[2]) );
  CKBD0 U17 ( .CLK(n16), .C(n10) );
  CKNXD16 U18 ( .I(n10), .ZN(CountOut[1]) );
  CKBD0 U19 ( .CLK(n14), .C(n12) );
  CKNXD16 U20 ( .I(n12), .ZN(CountOut[0]) );
  CKBD0 U21 ( .CLK(N1), .C(n14) );
  CKND0 U22 ( .CLK(n22), .CN(n16) );
  CKND0 U23 ( .CLK(n21), .CN(n17) );
  CKND0 U24 ( .CLK(Clear), .CN(n1) );
  XNR2D0 U25 ( .A1(N1), .A2(n22), .ZN(N4) );
  INR2D0 U26 ( .A1(n21), .B1(n19), .ZN(n18) );
  XNR2D0 U27 ( .A1(n19), .A2(n21), .ZN(N2) );
endmodule

