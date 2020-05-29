
module Counter4 ( CountOut, ClockIn, Clear );
  output [3:0] CountOut;
  input ClockIn, Clear;
  wire   n16, n17, n18, n19, N1, N2, N3, N4, n1, n2, n3, n4, n6, n8, n10, n12,
         n13, n14, n15;

  DFCND1 \CountReg_reg[0]  ( .D(N1), .CP(ClockIn), .CDN(n1), .Q(n19), .QN(N1)
         );
  DFCND1 \CountReg_reg[2]  ( .D(N2), .CP(ClockIn), .CDN(n1), .Q(n17), .QN(n13)
         );
  DFCND1 \CountReg_reg[1]  ( .D(N4), .CP(ClockIn), .CDN(n1), .Q(n18), .QN(n14)
         );
  DFCND1 \CountReg_reg[3]  ( .D(N3), .CP(ClockIn), .CDN(n1), .Q(n16), .QN(n15)
         );
  ND2D1 U9 ( .A1(n18), .A2(n19), .ZN(n3) );
  INVD1 U10 ( .I(Clear), .ZN(n1) );
  CKBD0 U11 ( .CLK(n15), .C(n4) );
  CKNXD16 U12 ( .I(n4), .ZN(CountOut[3]) );
  CKBD0 U13 ( .CLK(n14), .C(n6) );
  CKNXD16 U14 ( .I(n6), .ZN(CountOut[1]) );
  CKBD0 U15 ( .CLK(n13), .C(n8) );
  CKNXD16 U16 ( .I(n8), .ZN(CountOut[2]) );
  CKBD0 U17 ( .CLK(n12), .C(n10) );
  CKNXD16 U18 ( .I(n10), .ZN(CountOut[0]) );
  CKND0 U19 ( .CLK(n19), .CN(n12) );
  XNR2D0 U20 ( .A1(n18), .A2(N1), .ZN(N4) );
  XOR2D1 U21 ( .A1(n2), .A2(n16), .Z(N3) );
  INR2XD1 U22 ( .A1(n17), .B1(n3), .ZN(n2) );
  XNR2D1 U23 ( .A1(n17), .A2(n3), .ZN(N2) );
endmodule

