
module PLL ( ClockOut, ClockIn, Reset );
  input ClockIn, Reset;
  output ClockOut;
  wire   n5, CkInWire, n2, n3, n4;
  wire   [1:0] AdjFreq;

  DEL005 CkInDelay1 ( .I(ClockIn), .Z(CkInWire) );
  Comparator Comp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn), .PLLClock(n4), 
        .Reset(Reset) );
  VFO VFO1 ( .ClockOut(n5), .AdjustFreq(AdjFreq), .ClockIn(CkInWire), .Reset(
        Reset) );
  CKNXD16 U1 ( .I(n2), .ZN(n3) );
  CKNXD16 U2 ( .I(n2), .ZN(ClockOut) );
  CKND0 U3 ( .CLK(n5), .CN(n2) );
  BUFFD0 U4 ( .I(n3), .Z(n4) );
endmodule


module Comparator ( AdjustFreq, ClockIn, PLLClock, Reset );
  output [1:0] AdjustFreq;
  input ClockIn, PLLClock, Reset;
  wire   N5, N6, N7, N8, N9, N19, N20, n2, n3, n4, n5, n6, n7;
  wire   [1:0] ClockInN;
  wire   [1:0] PLLClockN;

  MOAI22D1 U5 ( .A1(N8), .A2(n4), .B1(n5), .B2(ClockInN[1]), .ZN(N20) );
  MOAI22D1 U8 ( .A1(PLLClockN[1]), .A2(n6), .B1(n5), .B2(N9), .ZN(N19) );
  DFCND1 \PLLClockN_reg[0]  ( .D(N7), .CP(PLLClock), .CDN(n2), .Q(PLLClockN[0]), .QN(N7) );
  DFSNQD1 \AdjustFreq_reg[0]  ( .D(N19), .CP(PLLClock), .SDN(n3), .Q(
        AdjustFreq[0]) );
  DFCNQD1 \PLLClockN_reg[1]  ( .D(N8), .CP(PLLClock), .CDN(n2), .Q(
        PLLClockN[1]) );
  DFCNQD1 \AdjustFreq_reg[1]  ( .D(N20), .CP(PLLClock), .CDN(n3), .Q(
        AdjustFreq[1]) );
  DFCND1 \ClockInN_reg[1]  ( .D(N6), .CP(ClockIn), .CDN(n2), .Q(ClockInN[1]), 
        .QN(n7) );
  DFCND1 \ClockInN_reg[0]  ( .D(N5), .CP(ClockIn), .CDN(n2), .Q(ClockInN[0]), 
        .QN(N5) );
  DFSND1 ZeroCounters_reg ( .D(N9), .CP(ClockIn), .SDN(n3), .QN(n2) );
  NR2D1 U3 ( .A1(n7), .A2(N5), .ZN(N9) );
  XOR2D1 U4 ( .A1(N5), .A2(n7), .Z(N6) );
  INVD1 U6 ( .I(Reset), .ZN(n3) );
  AOI21D1 U7 ( .A1(ClockInN[0]), .A2(n5), .B(N9), .ZN(n4) );
  NR2D1 U9 ( .A1(N7), .A2(N6), .ZN(n6) );
  ND2D1 U10 ( .A1(PLLClockN[1]), .A2(PLLClockN[0]), .ZN(n5) );
  XNR2D1 U11 ( .A1(N7), .A2(PLLClockN[1]), .ZN(N8) );
endmodule


module VFO ( ClockOut, AdjustFreq, ClockIn, Reset );
  input [1:0] AdjustFreq;
  input ClockIn, Reset;
  output ClockOut;
  wire   n30, FastClock, N9, N10, N11, N12, N13, N15, N16, N17, N18, N19, N25,
         N26, N27, N28, N29, N32, N33, N34, N35, N36, N41, N43, N45, N47, N48,
         n16, n17, n18, n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29;
  wire   [3:0] WireD;
  wire   [4:0] ProgClk;
  wire   [4:0] DivideFactor;

  DEL005 \DelayLine[0].Delay85ps  ( .I(WireD[0]), .Z(WireD[1]) );
  DEL005 \DelayLine[1].Delay85ps  ( .I(WireD[1]), .Z(WireD[2]) );
  DEL005 \DelayLine[2].Delay85ps  ( .I(WireD[2]), .Z(WireD[3]) );
  INVD0 Inv75ps ( .I(FastClock), .ZN(WireD[0]) );
  VFO_DW01_dec_0 \FreqAdj/sub_162  ( .A(DivideFactor), .SUM({N36, N35, N34, 
        N33, N32}) );
  VFO_DW01_inc_0 \FreqAdj/add_159  ( .A(DivideFactor), .SUM({N29, N28, N27, 
        N26, N25}) );
  VFO_DW01_inc_1 \ClockOutGen/add_140  ( .A(ProgClk), .SUM({N13, N12, N11, N10, 
        N9}) );
  DFCNQD1 \ProgClk_reg[4]  ( .D(N19), .CP(FastClock), .CDN(n18), .Q(ProgClk[4]) );
  DFCNQD1 \ProgClk_reg[2]  ( .D(N17), .CP(FastClock), .CDN(n18), .Q(ProgClk[2]) );
  DFCNQD1 \ProgClk_reg[0]  ( .D(N15), .CP(FastClock), .CDN(n18), .Q(ProgClk[0]) );
  DFCNQD1 \ProgClk_reg[3]  ( .D(N18), .CP(FastClock), .CDN(n18), .Q(ProgClk[3]) );
  DFCNQD1 \ProgClk_reg[1]  ( .D(N16), .CP(FastClock), .CDN(n18), .Q(ProgClk[1]) );
  EDFCND1 \DivideFactor_reg[3]  ( .D(N47), .E(N48), .CP(ClockIn), .CDN(n4), 
        .Q(DivideFactor[3]), .QN(n21) );
  EDFCND1 \DivideFactor_reg[2]  ( .D(N45), .E(N48), .CP(ClockIn), .CDN(n4), 
        .Q(DivideFactor[2]), .QN(n26) );
  EDFCND1 \DivideFactor_reg[1]  ( .D(N43), .E(N48), .CP(ClockIn), .CDN(n4), 
        .Q(DivideFactor[1]), .QN(n15) );
  EDFCND1 \DivideFactor_reg[0]  ( .D(N41), .E(N48), .CP(ClockIn), .CDN(n4), 
        .Q(DivideFactor[0]), .QN(n14) );
  DFSND1 \DivideFactor_reg[4]  ( .D(n17), .CP(ClockIn), .SDN(n4), .Q(
        DivideFactor[4]), .QN(n6) );
  DFCNQD4 ClockOutReg_reg ( .D(n16), .CP(FastClock), .CDN(n18), .Q(n30) );
  INVD0 U3 ( .I(ClockOut), .ZN(n1) );
  CKND2 U4 ( .CLK(n5), .CN(ClockOut) );
  INVD3 U5 ( .I(n30), .ZN(n5) );
  INVD0 U6 ( .I(n1), .ZN(n3) );
  INVD1 U7 ( .I(Reset), .ZN(n4) );
  CKND0 U8 ( .CLK(Reset), .CN(n18) );
  OAI21D0 U9 ( .A1(N48), .A2(n6), .B(n7), .ZN(n17) );
  AOI32D0 U10 ( .A1(n8), .A2(n9), .A3(N36), .B1(N29), .B2(n10), .ZN(n7) );
  XNR2D0 U11 ( .A1(n3), .A2(n11), .ZN(n16) );
  MUX2ND0 U12 ( .I0(n12), .I1(n13), .S(AdjustFreq[0]), .ZN(N48) );
  CKND2D0 U13 ( .A1(AdjustFreq[1]), .A2(n9), .ZN(n13) );
  ND3D0 U14 ( .A1(n14), .A2(n15), .A3(n19), .ZN(n9) );
  NR3D0 U15 ( .A1(DivideFactor[2]), .A2(DivideFactor[4]), .A3(DivideFactor[3]), 
        .ZN(n19) );
  OAI31D0 U16 ( .A1(n20), .A2(n21), .A3(n6), .B(n22), .ZN(n12) );
  CKND0 U17 ( .CLK(AdjustFreq[1]), .CN(n22) );
  ND3D0 U18 ( .A1(DivideFactor[1]), .A2(DivideFactor[0]), .A3(DivideFactor[2]), 
        .ZN(n20) );
  AO22D0 U19 ( .A1(N35), .A2(n8), .B1(N28), .B2(n10), .Z(N47) );
  AO22D0 U20 ( .A1(N34), .A2(n8), .B1(N27), .B2(n10), .Z(N45) );
  AO22D0 U21 ( .A1(N33), .A2(n8), .B1(N26), .B2(n10), .Z(N43) );
  AO22D0 U22 ( .A1(N32), .A2(n8), .B1(N25), .B2(n10), .Z(N41) );
  NR2D0 U23 ( .A1(AdjustFreq[0]), .A2(AdjustFreq[1]), .ZN(n10) );
  AN2D0 U24 ( .A1(AdjustFreq[0]), .A2(AdjustFreq[1]), .Z(n8) );
  AN2D0 U25 ( .A1(N13), .A2(n11), .Z(N19) );
  AN2D0 U26 ( .A1(N12), .A2(n11), .Z(N18) );
  AN2D0 U27 ( .A1(N11), .A2(n11), .Z(N17) );
  AN2D0 U28 ( .A1(N10), .A2(n11), .Z(N16) );
  AN2D0 U29 ( .A1(N9), .A2(n11), .Z(N15) );
  OAI21D0 U30 ( .A1(ProgClk[4]), .A2(n6), .B(n23), .ZN(n11) );
  AO221D0 U31 ( .A1(n21), .A2(ProgClk[3]), .B1(n6), .B2(ProgClk[4]), .C(n24), 
        .Z(n23) );
  OA222D0 U32 ( .A1(n25), .A2(n26), .B1(ProgClk[2]), .B2(n27), .C1(ProgClk[3]), 
        .C2(n21), .Z(n24) );
  NR2D0 U33 ( .A1(DivideFactor[2]), .A2(n28), .ZN(n27) );
  CKND0 U34 ( .CLK(n28), .CN(n25) );
  OAI32D0 U35 ( .A1(n14), .A2(ProgClk[0]), .A3(n29), .B1(ProgClk[1]), .B2(n15), 
        .ZN(n28) );
  INR2D0 U36 ( .A1(ProgClk[1]), .B1(DivideFactor[1]), .ZN(n29) );
  INR2D0 U37 ( .A1(WireD[3]), .B1(Reset), .ZN(FastClock) );
endmodule


module VFO_DW01_dec_0 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   n1, n2, n3, n4;

  CKXOR2D0 U1 ( .A1(A[4]), .A2(n1), .Z(SUM[4]) );
  NR2D0 U2 ( .A1(A[3]), .A2(n2), .ZN(n1) );
  XNR2D0 U3 ( .A1(n2), .A2(A[3]), .ZN(SUM[3]) );
  OAI21D0 U4 ( .A1(n3), .A2(n4), .B(n2), .ZN(SUM[2]) );
  CKND2D0 U5 ( .A1(n3), .A2(n4), .ZN(n2) );
  CKND0 U6 ( .CLK(A[2]), .CN(n4) );
  AO21D0 U7 ( .A1(A[0]), .A2(A[1]), .B(n3), .Z(SUM[1]) );
  NR2D0 U8 ( .A1(A[1]), .A2(A[0]), .ZN(n3) );
  CKND0 U9 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_inc_0 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  CKXOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_inc_1 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  CKXOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule

