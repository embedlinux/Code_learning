
module FlipFlops ( Qsimple, Qclear, QpreClear, D, clk1, clk2, clr, pre );
  input D, clk1, clk2, clr, pre;
  output Qsimple, Qclear, QpreClear;
  wire   n15, N2, n1, n2, n6, n8, n10, n12, n13, n14;

  AO22D0 U3 ( .A1(n15), .A2(n1), .B1(clk2), .B2(D), .Z(n2) );
  CKND0 U4 ( .CLK(clk2), .CN(n1) );
  CKND0 U5 ( .CLK(clr), .CN(N2) );
  DFCSNQD1 QpreClearReg_reg ( .D(n2), .CP(clk2), .CDN(clr), .SDN(pre), .Q(n15)
         );
  DFNCND1 QclearReg_reg ( .D(D), .CPN(clk1), .CDN(N2), .QN(n13) );
  DFD1 QsimpleReg_reg ( .D(D), .CP(clk1), .QN(n14) );
  CKBD0 U6 ( .CLK(n14), .C(n6) );
  CKNXD16 U7 ( .I(n6), .ZN(Qsimple) );
  CKBD0 U8 ( .CLK(n13), .C(n8) );
  CKNXD16 U9 ( .I(n8), .ZN(Qclear) );
  CKBD0 U10 ( .CLK(n12), .C(n10) );
  CKNXD16 U11 ( .I(n10), .ZN(QpreClear) );
  CKND0 U12 ( .CLK(n15), .CN(n12) );
endmodule

