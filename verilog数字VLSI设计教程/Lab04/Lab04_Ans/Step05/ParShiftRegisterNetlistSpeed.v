
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


module Mux3_4 ( Z, Sel, In1, In2, In3 );
  input [1:0] Sel;
  input In1, In2, In3;
  output Z;
  wire   n1, n2;

  MOAI22D1 U1 ( .A1(Sel[1]), .A2(n2), .B1(Sel[1]), .B2(In3), .ZN(Z) );
  AOI22D0 U2 ( .A1(In1), .A2(n1), .B1(Sel[0]), .B2(In2), .ZN(n2) );
  INVD1 U3 ( .I(Sel[0]), .ZN(n1) );
endmodule


module Mux3_3 ( Z, Sel, In1, In2, In3 );
  input [1:0] Sel;
  input In1, In2, In3;
  output Z;
  wire   n1, n2;

  MOAI22D1 U1 ( .A1(Sel[1]), .A2(n2), .B1(Sel[1]), .B2(In3), .ZN(Z) );
  AOI22D0 U2 ( .A1(In1), .A2(n1), .B1(Sel[0]), .B2(In2), .ZN(n2) );
  INVD1 U3 ( .I(Sel[0]), .ZN(n1) );
endmodule


module Mux3_2 ( Z, Sel, In1, In2, In3 );
  input [1:0] Sel;
  input In1, In2, In3;
  output Z;
  wire   n1, n2;

  MOAI22D1 U1 ( .A1(Sel[1]), .A2(n2), .B1(Sel[1]), .B2(In3), .ZN(Z) );
  AOI22D0 U2 ( .A1(In1), .A2(n1), .B1(Sel[0]), .B2(In2), .ZN(n2) );
  INVD1 U3 ( .I(Sel[0]), .ZN(n1) );
endmodule


module Mux3_1 ( Z, Sel, In1, In2, In3 );
  input [1:0] Sel;
  input In1, In2, In3;
  output Z;
  wire   n1, n2;

  MOAI22D1 U1 ( .A1(Sel[1]), .A2(n2), .B1(Sel[1]), .B2(In3), .ZN(Z) );
  AOI22D0 U2 ( .A1(In1), .A2(n1), .B1(Sel[0]), .B2(In2), .ZN(n2) );
  INVD1 U3 ( .I(Sel[0]), .ZN(n1) );
endmodule


module ShiftFlop_0 ( Q, Qn, D, Clk, Clr );
  input D, Clk, Clr;
  output Q, Qn;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCND1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q), .QN(Qn) );
endmodule


module Mux3_0 ( Z, Sel, In1, In2, In3 );
  input [1:0] Sel;
  input In1, In2, In3;
  output Z;
  wire   n3, n4;

  MOAI22D1 U1 ( .A1(Sel[1]), .A2(n3), .B1(Sel[1]), .B2(In3), .ZN(Z) );
  AOI22D0 U2 ( .A1(In1), .A2(n4), .B1(Sel[0]), .B2(In2), .ZN(n3) );
  INVD1 U3 ( .I(Sel[0]), .ZN(n4) );
endmodule


module ParShiftRegister ( QOut, ParDIn, DIn, ShiftEna, ParLoad, ClkIn, ClrIn
 );
  input [4:0] ParDIn;
  input DIn, ShiftEna, ParLoad, ClkIn, ClrIn;
  output QOut;
  wire   n9, n1, n3, n4, n5, n6, n7, n8;
  wire   [4:0] ZtoD;
  wire   [3:0] QtoD;

  Mux3_0 Mux4 ( .Z(ZtoD[4]), .Sel({n7, n8}), .In1(n5), .In2(QtoD[3]), .In3(
        ParDIn[4]) );
  ShiftFlop_0 FF4 ( .Q(n9), .Qn(n4), .D(ZtoD[4]), .Clk(ClkIn), .Clr(n6) );
  Mux3_4 Mux3 ( .Z(ZtoD[3]), .Sel({n7, n8}), .In1(QtoD[3]), .In2(QtoD[2]), 
        .In3(ParDIn[3]) );
  ShiftFlop_4 FF3 ( .Q(QtoD[3]), .D(ZtoD[3]), .Clk(ClkIn), .Clr(n6) );
  Mux3_3 Mux2 ( .Z(ZtoD[2]), .Sel({n7, n8}), .In1(QtoD[2]), .In2(QtoD[1]), 
        .In3(ParDIn[2]) );
  ShiftFlop_3 FF2 ( .Q(QtoD[2]), .D(ZtoD[2]), .Clk(ClkIn), .Clr(n6) );
  Mux3_2 Mux1 ( .Z(ZtoD[1]), .Sel({n7, n8}), .In1(QtoD[1]), .In2(QtoD[0]), 
        .In3(ParDIn[1]) );
  ShiftFlop_2 FF1 ( .Q(QtoD[1]), .D(ZtoD[1]), .Clk(ClkIn), .Clr(n6) );
  Mux3_1 Mux0 ( .Z(ZtoD[0]), .Sel({n7, n8}), .In1(QtoD[0]), .In2(DIn), .In3(
        ParDIn[0]) );
  ShiftFlop_1 FF0 ( .Q(QtoD[0]), .D(ZtoD[0]), .Clk(ClkIn), .Clr(n6) );
  CKBD0 U1 ( .CLK(n3), .C(n1) );
  CKNXD16 U2 ( .I(n1), .ZN(QOut) );
  CKND0 U3 ( .CLK(n9), .CN(n3) );
  INVD0 U4 ( .I(n4), .ZN(n5) );
  BUFFD1 U5 ( .I(ShiftEna), .Z(n8) );
  BUFFD1 U6 ( .I(ParLoad), .Z(n7) );
  BUFFD1 U7 ( .I(ClrIn), .Z(n6) );
endmodule

