
module ShiftFlop_4 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module ShiftFlop_3 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module ShiftFlop_2 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module ShiftFlop_1 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q), .QN(Qn) );
endmodule


module Mux2_4 ( Z, Sel, In1, In2 );
  input Sel, In1, In2;
  output Z;
  wire   n1;

  AO22D0 U1 ( .A1(In1), .A2(n1), .B1(Sel), .B2(In2), .Z(Z) );
  INVD1 U2 ( .I(Sel), .ZN(n1) );
endmodule


module Mux2_3 ( Z, Sel, In1, In2 );
  input Sel, In1, In2;
  output Z;
  wire   n1;

  AO22D0 U1 ( .A1(In1), .A2(n1), .B1(Sel), .B2(In2), .Z(Z) );
  INVD1 U2 ( .I(Sel), .ZN(n1) );
endmodule


module Mux2_2 ( Z, Sel, In1, In2 );
  input Sel, In1, In2;
  output Z;
  wire   n1;

  AO22D0 U1 ( .A1(In1), .A2(n1), .B1(Sel), .B2(In2), .Z(Z) );
  INVD1 U2 ( .I(Sel), .ZN(n1) );
endmodule


module Mux2_1 ( Z, Sel, In1, In2 );
  input Sel, In1, In2;
  output Z;
  wire   n1;

  AO22D0 U1 ( .A1(In1), .A2(n1), .B1(Sel), .B2(In2), .Z(Z) );
  INVD1 U2 ( .I(Sel), .ZN(n1) );
endmodule


module ShiftFlop_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
endmodule


module Mux2_0 ( Z, Sel, In1, In2 );
  input Sel, In1, In2;
  output Z;
  wire   n3;

  AO22D0 U1 ( .A1(In1), .A2(n3), .B1(Sel), .B2(In2), .Z(Z) );
  INVD1 U2 ( .I(Sel), .ZN(n3) );
endmodule


module SerShiftRegister ( QOut, DIn, ShiftEna, ClkIn, ClrIn );
  input DIn, ShiftEna, ClkIn, ClrIn;
  output QOut;
  wire   n8, n1, n3, n4, n5, n6, n7;
  wire   [4:0] ZtoD;
  wire   [3:0] QtoD;

  Mux2_0 Mux4 ( .Z(ZtoD[4]), .Sel(n7), .In1(n5), .In2(QtoD[3]) );
  ShiftFlop_0 FF4 ( .Q(n8), .Qn(n4), .D(ZtoD[4]), .Clk(ClkIn), .Clr(n6) );
  Mux2_4 Mux3 ( .Z(ZtoD[3]), .Sel(n7), .In1(QtoD[3]), .In2(QtoD[2]) );
  ShiftFlop_4 FF3 ( .Q(QtoD[3]), .D(ZtoD[3]), .Clk(ClkIn), .Clr(n6) );
  Mux2_3 Mux2 ( .Z(ZtoD[2]), .Sel(n7), .In1(QtoD[2]), .In2(QtoD[1]) );
  ShiftFlop_3 FF2 ( .Q(QtoD[2]), .D(ZtoD[2]), .Clk(ClkIn), .Clr(n6) );
  Mux2_2 Mux1 ( .Z(ZtoD[1]), .Sel(n7), .In1(QtoD[1]), .In2(QtoD[0]) );
  ShiftFlop_2 FF1 ( .Q(QtoD[1]), .D(ZtoD[1]), .Clk(ClkIn), .Clr(n6) );
  Mux2_1 Mux0 ( .Z(ZtoD[0]), .Sel(n7), .In1(QtoD[0]), .In2(DIn) );
  ShiftFlop_1 FF0 ( .Q(QtoD[0]), .D(ZtoD[0]), .Clk(ClkIn), .Clr(n6) );
  CKBD0 U1 ( .CLK(n3), .C(n1) );
  CKNXD16 U2 ( .I(n1), .ZN(QOut) );
  CKND0 U3 ( .CLK(n8), .CN(n3) );
  INVD0 U4 ( .I(n4), .ZN(n5) );
  BUFFD1 U5 ( .I(ShiftEna), .Z(n7) );
  BUFFD1 U6 ( .I(ClrIn), .Z(n6) );
endmodule

