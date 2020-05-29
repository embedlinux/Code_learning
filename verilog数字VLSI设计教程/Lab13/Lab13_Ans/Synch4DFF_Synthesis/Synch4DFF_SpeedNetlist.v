
module Synch4DFF ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   n16, n17, n18, n19, Qn_wire0, wireToD1, wireToD2, wireToD3, n1, n2,
         n3, n4, n6, n8, n10, n12, n13, n14, n15;

  INVD1 U1 ( .I(ClearIn), .ZN(n1) );
  DFCND1 \FF_Bit0/QReg_reg  ( .D(Qn_wire0), .CP(ClockIn), .CDN(n1), .Q(n19), 
        .QN(Qn_wire0) );
  DFCND1 \FF_Bit1/QReg_reg  ( .D(wireToD1), .CP(ClockIn), .CDN(n1), .Q(n18), 
        .QN(n14) );
  DFCND1 \FF_Bit2/QReg_reg  ( .D(wireToD2), .CP(ClockIn), .CDN(n1), .Q(n17), 
        .QN(n13) );
  DFCND1 \FF_Bit3/QReg_reg  ( .D(wireToD3), .CP(ClockIn), .CDN(n1), .Q(n16), 
        .QN(n15) );
  NR2D1 U7 ( .A1(n13), .A2(n3), .ZN(n2) );
  CKBD0 U8 ( .CLK(n15), .C(n4) );
  CKNXD16 U9 ( .I(n4), .ZN(CountOut[3]) );
  CKBD0 U10 ( .CLK(n14), .C(n6) );
  CKNXD16 U11 ( .I(n6), .ZN(CountOut[1]) );
  CKBD0 U12 ( .CLK(n13), .C(n8) );
  CKNXD16 U13 ( .I(n8), .ZN(CountOut[2]) );
  CKBD0 U14 ( .CLK(n12), .C(n10) );
  CKNXD16 U15 ( .I(n10), .ZN(CountOut[0]) );
  CKND0 U16 ( .CLK(n19), .CN(n12) );
  XNR2D1 U17 ( .A1(n18), .A2(Qn_wire0), .ZN(wireToD1) );
  XOR2D1 U18 ( .A1(n16), .A2(n2), .Z(wireToD3) );
  XNR2D1 U19 ( .A1(n3), .A2(n17), .ZN(wireToD2) );
  CKND2D0 U20 ( .A1(n18), .A2(n19), .ZN(n3) );
endmodule

