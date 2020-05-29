
module PLLTop ( ClockOut, ClockIn, Reset );
  input ClockIn, Reset;
  output ClockOut;
  wire   n6, SampleWire, CtrCarry, n2, n3, n4, n5;
  wire   [1:0] AdjFreq;

  DEL005 SampleDelay1 ( .I(ClockIn), .Z(SampleWire) );
  ClockComparator Comp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn), 
        .CounterClock(CtrCarry), .Reset(n5) );
  VFO VFO1 ( .ClockOut(n6), .AdjustFreq(AdjFreq), .Sample(SampleWire), .Reset(
        n5) );
  MultiCounter MCntr1 ( .CarryOut(CtrCarry), .Clock(n4), .Reset(n5) );
  CKNXD16 U1 ( .I(n2), .ZN(n3) );
  CKNXD16 U2 ( .I(n2), .ZN(ClockOut) );
  CKND0 U3 ( .CLK(n6), .CN(n2) );
  BUFFD0 U4 ( .I(n3), .Z(n4) );
  BUFFD1 U5 ( .I(Reset), .Z(n5) );
endmodule


module ClockComparator ( AdjustFreq, ClockIn, CounterClock, Reset );
  output [1:0] AdjustFreq;
  input ClockIn, CounterClock, Reset;
  wire   N5, N6, N7, N8, N9, N19, N20, n2, n3, n4, n5, n6, n7;
  wire   [1:0] ClockInN;
  wire   [1:0] CounterClockN;

  MOAI22D1 U5 ( .A1(N8), .A2(n4), .B1(n5), .B2(ClockInN[1]), .ZN(N20) );
  MOAI22D1 U8 ( .A1(CounterClockN[1]), .A2(n6), .B1(n5), .B2(N9), .ZN(N19) );
  DFCND1 \CounterClockN_reg[0]  ( .D(N7), .CP(CounterClock), .CDN(n2), .Q(
        CounterClockN[0]), .QN(N7) );
  DFSNQD1 \AdjustFreq_reg[0]  ( .D(N19), .CP(CounterClock), .SDN(n3), .Q(
        AdjustFreq[0]) );
  DFCNQD1 \CounterClockN_reg[1]  ( .D(N8), .CP(CounterClock), .CDN(n2), .Q(
        CounterClockN[1]) );
  DFCNQD1 \AdjustFreq_reg[1]  ( .D(N20), .CP(CounterClock), .CDN(n3), .Q(
        AdjustFreq[1]) );
  DFCND1 \ClockInN_reg[1]  ( .D(N6), .CP(ClockIn), .CDN(n2), .Q(ClockInN[1]), 
        .QN(n7) );
  DFCND1 \ClockInN_reg[0]  ( .D(N5), .CP(ClockIn), .CDN(n2), .Q(ClockInN[0]), 
        .QN(N5) );
  DFSND1 ZeroCounters_reg ( .D(N9), .CP(ClockIn), .SDN(n3), .QN(n2) );
  INVD1 U3 ( .I(Reset), .ZN(n3) );
  NR2D1 U4 ( .A1(n7), .A2(N5), .ZN(N9) );
  XOR2D1 U6 ( .A1(N5), .A2(n7), .Z(N6) );
  AOI21D1 U7 ( .A1(ClockInN[0]), .A2(n5), .B(N9), .ZN(n4) );
  NR2D1 U9 ( .A1(N7), .A2(N6), .ZN(n6) );
  ND2D1 U10 ( .A1(CounterClockN[1]), .A2(CounterClockN[0]), .ZN(n5) );
  XNR2D1 U11 ( .A1(N7), .A2(CounterClockN[1]), .ZN(N8) );
endmodule


module VFO ( ClockOut, AdjustFreq, Sample, Reset );
  input [1:0] AdjustFreq;
  input Sample, Reset;
  output ClockOut;
  wire   FastClock, N9, N10, N11, N12, N13, N14, N16, N17, N18, N19, N20, N21,
         N27, N28, N29, N30, N31, N32, N35, N36, N37, N38, N39, N40, N49, N51,
         N54, N55, n17, n18, n19, n20, n21, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31;
  wire   [5:0] WireD;
  wire   [5:0] FastDivvy;
  wire   [5:0] DivideFactor;

  DEL005 \DelayLine[0].Delay83ps  ( .I(WireD[0]), .Z(WireD[1]) );
  DEL005 \DelayLine[1].Delay83ps  ( .I(WireD[1]), .Z(WireD[2]) );
  DEL005 \DelayLine[2].Delay83ps  ( .I(WireD[2]), .Z(WireD[3]) );
  DEL005 \DelayLine[3].Delay83ps  ( .I(WireD[3]), .Z(WireD[4]) );
  DEL005 \DelayLine[4].Delay83ps  ( .I(WireD[4]), .Z(WireD[5]) );
  VFO_DW01_dec_0 \Sampler/sub_185  ( .A(DivideFactor), .SUM({N40, N39, N38, 
        N37, N36, N35}) );
  VFO_DW01_inc_0 \Sampler/add_182  ( .A(DivideFactor), .SUM({N32, N31, N30, 
        N29, N28, N27}) );
  VFO_DW01_inc_1 \ClockOutGen/add_163  ( .A(FastDivvy), .SUM({N14, N13, N12, 
        N11, N10, N9}) );
  DFCNQD1 ClockOutReg_reg ( .D(n17), .CP(FastClock), .CDN(n20), .Q(ClockOut)
         );
  DFCNQD1 \FastDivvy_reg[5]  ( .D(N21), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[5]) );
  DFCNQD1 \FastDivvy_reg[2]  ( .D(N18), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[2]) );
  DFCNQD1 \FastDivvy_reg[0]  ( .D(N16), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[0]) );
  DFCNQD1 \FastDivvy_reg[1]  ( .D(N17), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[1]) );
  DFCNQD1 \FastDivvy_reg[4]  ( .D(N20), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[4]) );
  DFCNQD1 \FastDivvy_reg[3]  ( .D(N19), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[3]) );
  EDFCND1 \DivideFactor_reg[3]  ( .D(N51), .E(N54), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[3]), .QN(n16) );
  EDFCND1 \DivideFactor_reg[2]  ( .D(N49), .E(N54), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[2]) );
  EDFCND1 \DivideFactor_reg[5]  ( .D(N55), .E(N54), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[5]), .QN(n13) );
  DFSND1 \DivideFactor_reg[4]  ( .D(n19), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[4]), .QN(n12) );
  DFSND1 \DivideFactor_reg[1]  ( .D(n18), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[1]), .QN(n22) );
  DFSND1 \DivideFactor_reg[0]  ( .D(n21), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[0]), .QN(n30) );
  XOR2D0 U3 ( .A1(ClockOut), .A2(n9), .Z(n17) );
  INVD1 U4 ( .I(Reset), .ZN(n20) );
  AO222D0 U5 ( .A1(N35), .A2(n2), .B1(N27), .B2(n3), .C1(DivideFactor[0]), 
        .C2(n4), .Z(n21) );
  AO222D0 U6 ( .A1(N39), .A2(n2), .B1(N31), .B2(n3), .C1(DivideFactor[4]), 
        .C2(n4), .Z(n19) );
  AO222D0 U7 ( .A1(N36), .A2(n2), .B1(N28), .B2(n3), .C1(DivideFactor[1]), 
        .C2(n4), .Z(n18) );
  CKND0 U8 ( .CLK(N54), .CN(n4) );
  AN2D0 U9 ( .A1(n5), .A2(n6), .Z(n3) );
  AN2D0 U10 ( .A1(n7), .A2(n8), .Z(n2) );
  AO22D0 U11 ( .A1(N40), .A2(n7), .B1(N32), .B2(n5), .Z(N55) );
  MUX2ND0 U12 ( .I0(n10), .I1(n11), .S(AdjustFreq[0]), .ZN(N54) );
  CKND2D0 U13 ( .A1(AdjustFreq[1]), .A2(n8), .ZN(n11) );
  ND3D0 U14 ( .A1(n12), .A2(n13), .A3(n14), .ZN(n8) );
  ND3D0 U15 ( .A1(DivideFactor[2]), .A2(DivideFactor[1]), .A3(DivideFactor[3]), 
        .ZN(n14) );
  IND2D0 U16 ( .A1(AdjustFreq[1]), .B1(n6), .ZN(n10) );
  ND3D0 U17 ( .A1(DivideFactor[5]), .A2(DivideFactor[4]), .A3(n15), .ZN(n6) );
  INR3D0 U18 ( .A1(DivideFactor[2]), .B1(n16), .B2(n22), .ZN(n15) );
  AO22D0 U19 ( .A1(N38), .A2(n7), .B1(N30), .B2(n5), .Z(N51) );
  AO22D0 U20 ( .A1(N37), .A2(n7), .B1(N29), .B2(n5), .Z(N49) );
  NR2D0 U21 ( .A1(AdjustFreq[0]), .A2(AdjustFreq[1]), .ZN(n5) );
  AN2D0 U22 ( .A1(AdjustFreq[1]), .A2(AdjustFreq[0]), .Z(n7) );
  INR2D0 U23 ( .A1(N14), .B1(n9), .ZN(N21) );
  INR2D0 U24 ( .A1(N13), .B1(n9), .ZN(N20) );
  INR2D0 U25 ( .A1(N12), .B1(n9), .ZN(N19) );
  INR2D0 U26 ( .A1(N11), .B1(n9), .ZN(N18) );
  INR2D0 U27 ( .A1(N10), .B1(n9), .ZN(N17) );
  INR2D0 U28 ( .A1(N9), .B1(n9), .ZN(N16) );
  OA21D0 U29 ( .A1(FastDivvy[5]), .A2(n13), .B(n23), .Z(n9) );
  IOA22D0 U30 ( .B1(n24), .B2(n25), .A1(n13), .A2(FastDivvy[5]), .ZN(n23) );
  AOI221D0 U31 ( .A1(FastDivvy[4]), .A2(n12), .B1(FastDivvy[3]), .B2(n16), .C(
        n26), .ZN(n25) );
  AOI221D0 U32 ( .A1(DivideFactor[3]), .A2(n27), .B1(DivideFactor[2]), .B2(n28), .C(n29), .ZN(n26) );
  IAO21D0 U33 ( .A1(n28), .A2(DivideFactor[2]), .B(FastDivvy[2]), .ZN(n29) );
  OAI32D0 U34 ( .A1(n30), .A2(FastDivvy[0]), .A3(n31), .B1(FastDivvy[1]), .B2(
        n22), .ZN(n28) );
  AN2D0 U35 ( .A1(FastDivvy[1]), .A2(n22), .Z(n31) );
  CKND0 U36 ( .CLK(FastDivvy[3]), .CN(n27) );
  NR2D0 U37 ( .A1(FastDivvy[4]), .A2(n12), .ZN(n24) );
  CKND0 U38 ( .CLK(WireD[0]), .CN(FastClock) );
  CKND2D0 U39 ( .A1(WireD[5]), .A2(n20), .ZN(WireD[0]) );
endmodule


module MultiCounter ( CarryOut, Clock, Reset );
  input Clock, Reset;
  output CarryOut;
  wire   N1, N2, N3, N4, N5, n1;
  wire   [3:0] Ctr;

  MultiCounter_DW01_inc_0 add_16 ( .A({CarryOut, Ctr}), .SUM({N5, N4, N3, N2, 
        N1}) );
  DFCNQD1 \Ctr_reg[1]  ( .D(N2), .CP(Clock), .CDN(n1), .Q(Ctr[1]) );
  DFCNQD1 \Ctr_reg[2]  ( .D(N3), .CP(Clock), .CDN(n1), .Q(Ctr[2]) );
  DFCNQD1 \Ctr_reg[3]  ( .D(N4), .CP(Clock), .CDN(n1), .Q(Ctr[3]) );
  DFCNQD1 \Ctr_reg[0]  ( .D(N1), .CP(Clock), .CDN(n1), .Q(Ctr[0]) );
  DFCNQD1 \Ctr_reg[4]  ( .D(N5), .CP(Clock), .CDN(n1), .Q(CarryOut) );
  INVD1 U3 ( .I(Reset), .ZN(n1) );
endmodule


module MultiCounter_DW01_inc_0 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  CKXOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_dec_0 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   n1, n2, n3, n4, n5;

  CKXOR2D0 U1 ( .A1(A[5]), .A2(n1), .Z(SUM[5]) );
  NR2D0 U2 ( .A1(A[4]), .A2(n2), .ZN(n1) );
  XNR2D0 U3 ( .A1(n2), .A2(A[4]), .ZN(SUM[4]) );
  OAI21D0 U4 ( .A1(n3), .A2(n4), .B(n2), .ZN(SUM[3]) );
  CKND2D0 U5 ( .A1(n3), .A2(n4), .ZN(n2) );
  CKND0 U6 ( .CLK(A[3]), .CN(n4) );
  AO21D0 U7 ( .A1(n5), .A2(A[2]), .B(n3), .Z(SUM[2]) );
  NR2D0 U8 ( .A1(n5), .A2(A[2]), .ZN(n3) );
  IOA21D0 U9 ( .A1(A[0]), .A2(A[1]), .B(n5), .ZN(SUM[1]) );
  IND2D0 U10 ( .A1(A[1]), .B1(SUM[0]), .ZN(n5) );
  CKND0 U11 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_inc_0 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[5] , \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(\carry[5] ), .S(SUM[4]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  CKXOR2D0 U1 ( .A1(\carry[5] ), .A2(A[5]), .Z(SUM[5]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_inc_1 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[5] , \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(\carry[5] ), .S(SUM[4]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  CKXOR2D0 U1 ( .A1(\carry[5] ), .A2(A[5]), .Z(SUM[5]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule

