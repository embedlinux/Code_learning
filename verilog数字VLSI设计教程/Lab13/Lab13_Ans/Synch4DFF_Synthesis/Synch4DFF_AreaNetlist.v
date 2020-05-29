
module Synch4DFF ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   n20, n21, n22, Qn_wire0, wireToD1, wireToD2, wireToD3, n1, n4, n5, n7,
         n8, n10, n12, n14, n15, n16, n17, n18, n19;

  DFCND1 \FF_Bit0/QReg_reg  ( .D(Qn_wire0), .CP(ClockIn), .CDN(n1), .Q(n4), 
        .QN(Qn_wire0) );
  DFCNQD1 \FF_Bit1/QReg_reg  ( .D(wireToD1), .CP(ClockIn), .CDN(n1), .Q(n22)
         );
  DFCNQD1 \FF_Bit2/QReg_reg  ( .D(wireToD2), .CP(ClockIn), .CDN(n1), .Q(n21)
         );
  DFCNQD1 \FF_Bit3/QReg_reg  ( .D(wireToD3), .CP(ClockIn), .CDN(n1), .Q(n20)
         );
  ND2D1 U7 ( .A1(n4), .A2(n22), .ZN(n19) );
  CKBD0 U8 ( .CLK(n7), .C(n5) );
  CKNXD16 U9 ( .I(n5), .ZN(CountOut[3]) );
  CKBD0 U10 ( .CLK(n15), .C(n7) );
  XNR2D1 U11 ( .A1(n15), .A2(n18), .ZN(wireToD3) );
  CKND0 U12 ( .CLK(n20), .CN(n15) );
  CKBD0 U13 ( .CLK(n17), .C(n8) );
  CKNXD16 U14 ( .I(n8), .ZN(CountOut[2]) );
  CKBD0 U15 ( .CLK(n16), .C(n10) );
  CKNXD16 U16 ( .I(n10), .ZN(CountOut[1]) );
  CKBD0 U17 ( .CLK(n14), .C(n12) );
  CKNXD16 U18 ( .I(n12), .ZN(CountOut[0]) );
  CKBD0 U19 ( .CLK(Qn_wire0), .C(n14) );
  CKND0 U20 ( .CLK(n22), .CN(n16) );
  CKND0 U21 ( .CLK(n21), .CN(n17) );
  INR2D0 U22 ( .A1(n21), .B1(n19), .ZN(n18) );
  XNR2D0 U23 ( .A1(n19), .A2(n21), .ZN(wireToD2) );
  XNR2D0 U24 ( .A1(Qn_wire0), .A2(n22), .ZN(wireToD1) );
  CKND0 U25 ( .CLK(ClearIn), .CN(n1) );
endmodule

