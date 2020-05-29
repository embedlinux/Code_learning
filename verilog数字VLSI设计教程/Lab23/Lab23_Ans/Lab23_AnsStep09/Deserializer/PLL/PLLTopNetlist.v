
module PLLTop ( ClockOut, ClockIn, Reset );
  input ClockIn, Reset;
  output ClockOut;
  wire   n6, SampleWire, CtrCarry, n1, n3, n4, n5;
  wire   [1:0] AdjFreq;

  DEL005 SampleDelay1 ( .I(ClockIn), .Z(SampleWire) );
  ClockComparator Comp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn), 
        .CounterClock(CtrCarry), .Reset(n5) );
  VFO VFO1 ( .ClockOut(n6), .AdjustFreq(AdjFreq), .Sample(SampleWire), .Reset(
        n5) );
  MultiCounter MCntr1 ( .CarryOut(CtrCarry), .Clock(n4), .Reset(n5) );
  INVD1 U1 ( .I(n3), .ZN(n4) );
  DEL4 U2 ( .I(n3), .Z(n1) );
  CKNXD16 U3 ( .I(n1), .ZN(ClockOut) );
  CKND0 U4 ( .CLK(n6), .CN(n3) );
  BUFFD1 U5 ( .I(Reset), .Z(n5) );
endmodule


module ClockComparator ( AdjustFreq, ClockIn, CounterClock, Reset );
  output [1:0] AdjustFreq;
  input ClockIn, CounterClock, Reset;
  wire   N5, N6, N7, N8, N9, N27, N28, n2, n3, n4, n5, n6, n7;
  wire   [1:0] ClockInN;
  wire   [1:0] CounterClockN;

  MOAI22D1 U5 ( .A1(n4), .A2(n5), .B1(n6), .B2(ClockInN[1]), .ZN(N28) );
  MOAI22D1 U8 ( .A1(CounterClockN[1]), .A2(n7), .B1(n6), .B2(N9), .ZN(N27) );
  DFSNQD1 \AdjustFreq_reg[0]  ( .D(N27), .CP(CounterClock), .SDN(n3), .Q(
        AdjustFreq[0]) );
  DFCNQD1 \CounterClockN_reg[1]  ( .D(N8), .CP(CounterClock), .CDN(n2), .Q(
        CounterClockN[1]) );
  DFCNQD1 \AdjustFreq_reg[1]  ( .D(N28), .CP(CounterClock), .CDN(n3), .Q(
        AdjustFreq[1]) );
  DFCNQD1 \CounterClockN_reg[0]  ( .D(N7), .CP(CounterClock), .CDN(n2), .Q(
        CounterClockN[0]) );
  DFCNQD1 \ClockInN_reg[1]  ( .D(N6), .CP(ClockIn), .CDN(n2), .Q(ClockInN[1])
         );
  DFCNQD1 \ClockInN_reg[0]  ( .D(N5), .CP(ClockIn), .CDN(n2), .Q(ClockInN[0])
         );
  DFSND1 ZeroCounters_reg ( .D(N9), .CP(ClockIn), .SDN(n3), .QN(n2) );
  INVD1 U3 ( .I(Reset), .ZN(n3) );
  AN2D1 U4 ( .A1(ClockInN[1]), .A2(ClockInN[0]), .Z(N9) );
  XOR2D1 U6 ( .A1(ClockInN[1]), .A2(ClockInN[0]), .Z(N6) );
  INVD1 U7 ( .I(ClockInN[0]), .ZN(N5) );
  XOR2D1 U9 ( .A1(CounterClockN[1]), .A2(CounterClockN[0]), .Z(n5) );
  AOI21D1 U10 ( .A1(ClockInN[0]), .A2(n6), .B(N9), .ZN(n4) );
  INR3D0 U11 ( .A1(CounterClockN[0]), .B1(ClockInN[1]), .B2(ClockInN[0]), .ZN(
        n7) );
  ND2D1 U12 ( .A1(CounterClockN[1]), .A2(CounterClockN[0]), .ZN(n6) );
  XOR2D1 U13 ( .A1(CounterClockN[1]), .A2(CounterClockN[0]), .Z(N8) );
  INVD1 U14 ( .I(CounterClockN[0]), .ZN(N7) );
endmodule


module VFO ( ClockOut, AdjustFreq, Sample, Reset );
  input [1:0] AdjustFreq;
  input Sample, Reset;
  output ClockOut;
  wire   FastClock, N8, N9, N10, N11, N12, N13, N14, N16, N17, N18, N19, N20,
         N21, N29, N30, N31, N32, N33, N34, N35, N37, N38, N39, N40, N41, N42,
         N43, N51, N53, N56, N57, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n1, n2;
  wire   [5:0] WireD;
  wire   [5:0] FastDivvy;
  wire   [5:0] DivideFactor;

  DEL005 \DelayLine[0].Delay83ps  ( .I(WireD[0]), .Z(WireD[1]) );
  DEL005 \DelayLine[1].Delay83ps  ( .I(WireD[1]), .Z(WireD[2]) );
  DEL005 \DelayLine[2].Delay83ps  ( .I(WireD[2]), .Z(WireD[3]) );
  DEL005 \DelayLine[3].Delay83ps  ( .I(WireD[3]), .Z(WireD[4]) );
  DEL005 \DelayLine[4].Delay83ps  ( .I(WireD[4]), .Z(WireD[5]) );
  AO222D1 U4 ( .A1(N38), .A2(n8), .B1(N30), .B2(n9), .C1(DivideFactor[1]), 
        .C2(n10), .Z(n18) );
  AO222D1 U5 ( .A1(N41), .A2(n8), .B1(N33), .B2(n9), .C1(DivideFactor[4]), 
        .C2(n10), .Z(n19) );
  AO222D1 U6 ( .A1(N37), .A2(n8), .B1(N29), .B2(n9), .C1(DivideFactor[0]), 
        .C2(n10), .Z(n21) );
  VFO_DW01_dec_0 \Sampler/sub_185  ( .A(DivideFactor), .SUM({N42, N41, N40, 
        N39, N38, N37}) );
  VFO_DW01_inc_0 \Sampler/add_182  ( .A(DivideFactor), .SUM({N34, N33, N32, 
        N31, N30, N29}) );
  VFO_DW01_inc_1 \ClockOutGen/add_163  ( .A(FastDivvy), .SUM({N14, N13, N12, 
        N11, N10, N9}) );
  VFO_DW01_cmp2_2 \ClockOutGen/lt_162  ( .A(FastDivvy), .B(DivideFactor), 
        .LEQ(1'b0), .TC(1'b0), .LT_LE(N8) );
  DFCNQD1 ClockOutReg_reg ( .D(n17), .CP(FastClock), .CDN(n20), .Q(ClockOut)
         );
  DFCNQD1 \FastDivvy_reg[5]  ( .D(N21), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[5]) );
  ND2D1 U30 ( .A1(WireD[5]), .A2(n20), .ZN(WireD[0]) );
  DFCNQD1 \FastDivvy_reg[2]  ( .D(N18), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[2]) );
  DFCNQD1 \FastDivvy_reg[3]  ( .D(N19), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[3]) );
  DFCNQD1 \FastDivvy_reg[4]  ( .D(N20), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[4]) );
  DFCNQD1 \FastDivvy_reg[0]  ( .D(N16), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[0]) );
  DFCNQD1 \FastDivvy_reg[1]  ( .D(N17), .CP(FastClock), .CDN(n20), .Q(
        FastDivvy[1]) );
  DFSNQD1 \DivideFactor_reg[0]  ( .D(n21), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[0]) );
  DFSNQD1 \DivideFactor_reg[1]  ( .D(n18), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[1]) );
  DFSNQD1 \DivideFactor_reg[4]  ( .D(n19), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[4]) );
  EDFCNQD1 \DivideFactor_reg[5]  ( .D(N57), .E(N56), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[5]) );
  EDFCNQD1 \DivideFactor_reg[2]  ( .D(N51), .E(N56), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[2]) );
  EDFCNQD1 \DivideFactor_reg[3]  ( .D(N53), .E(N56), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[3]) );
  INVD1 U3 ( .I(n10), .ZN(N56) );
  AN2D1 U7 ( .A1(N43), .A2(n12), .Z(n8) );
  AN2D1 U8 ( .A1(N35), .A2(n11), .Z(n9) );
  XNR2D0 U10 ( .A1(ClockOut), .A2(N8), .ZN(n17) );
  NR2D1 U11 ( .A1(n16), .A2(n14), .ZN(n12) );
  INVD1 U12 ( .I(Reset), .ZN(n20) );
  AN2D1 U13 ( .A1(N13), .A2(N8), .Z(N20) );
  AN2D1 U14 ( .A1(N12), .A2(N8), .Z(N19) );
  AN2D1 U15 ( .A1(N11), .A2(N8), .Z(N18) );
  AN2D1 U16 ( .A1(N10), .A2(N8), .Z(N17) );
  OAI21D1 U17 ( .A1(n13), .A2(n14), .B(n15), .ZN(n10) );
  IOA21D1 U18 ( .A1(n16), .A2(N35), .B(n14), .ZN(n15) );
  AN2D1 U19 ( .A1(N43), .A2(AdjustFreq[1]), .Z(n13) );
  AO22D0 U20 ( .A1(N39), .A2(n12), .B1(N31), .B2(n11), .Z(N51) );
  AO22D0 U21 ( .A1(N40), .A2(n12), .B1(N32), .B2(n11), .Z(N53) );
  AO22D0 U22 ( .A1(N42), .A2(n12), .B1(N34), .B2(n11), .Z(N57) );
  INVD1 U23 ( .I(WireD[0]), .ZN(FastClock) );
  INVD1 U24 ( .I(AdjustFreq[0]), .ZN(n14) );
  NR2D1 U25 ( .A1(AdjustFreq[0]), .A2(AdjustFreq[1]), .ZN(n11) );
  INVD1 U26 ( .I(AdjustFreq[1]), .ZN(n16) );
  AN2D1 U27 ( .A1(N14), .A2(N8), .Z(N21) );
  AN2D1 U28 ( .A1(N9), .A2(N8), .Z(N16) );
  ND3D0 U29 ( .A1(DivideFactor[5]), .A2(DivideFactor[4]), .A3(DivideFactor[1]), 
        .ZN(n1) );
  IND3D0 U31 ( .A1(n1), .B1(DivideFactor[2]), .B2(DivideFactor[3]), .ZN(N35)
         );
  AN3D0 U32 ( .A1(DivideFactor[3]), .A2(DivideFactor[2]), .A3(DivideFactor[1]), 
        .Z(n2) );
  OR3D0 U33 ( .A1(DivideFactor[5]), .A2(DivideFactor[4]), .A3(n2), .Z(N43) );
endmodule


module MultiCounter ( CarryOut, Clock, Reset );
  input Clock, Reset;
  output CarryOut;
  wire   \Ctr[3] , \Ctr[2] , \Ctr[1] , \Ctr[0] , N1, N2, N3, N4, N5, n1;

  MultiCounter_DW01_inc_0 add_16 ( .A({CarryOut, \Ctr[3] , \Ctr[2] , \Ctr[1] , 
        \Ctr[0] }), .SUM({N4, N5, N3, N2, N1}) );
  DFCNQD1 \Ctr_reg[1]  ( .D(N2), .CP(Clock), .CDN(n1), .Q(\Ctr[1] ) );
  DFCNQD1 \Ctr_reg[2]  ( .D(N3), .CP(Clock), .CDN(n1), .Q(\Ctr[2] ) );
  DFCNQD1 \Ctr_reg[3]  ( .D(N5), .CP(Clock), .CDN(n1), .Q(\Ctr[3] ) );
  DFCNQD1 \Ctr_reg[0]  ( .D(N1), .CP(Clock), .CDN(n1), .Q(\Ctr[0] ) );
  DFCNQD1 \Ctr_reg[4]  ( .D(N4), .CP(Clock), .CDN(n1), .Q(CarryOut) );
  INVD1 U3 ( .I(Reset), .ZN(n1) );
endmodule


module MultiCounter_DW01_inc_0 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  CKXOR2D0 U5 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U6 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_dec_0 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[5] , \carry[4] , \carry[3] , \carry[2] , \carry[1] ;
  assign \carry[1]  = A[0];

  OR2D1 U1_B_4 ( .A1(A[4]), .A2(\carry[4] ), .Z(\carry[5] ) );
  OR2D1 U1_B_3 ( .A1(A[3]), .A2(\carry[3] ), .Z(\carry[4] ) );
  OR2D1 U1_B_2 ( .A1(A[2]), .A2(\carry[2] ), .Z(\carry[3] ) );
  OR2D1 U1_B_1 ( .A1(A[1]), .A2(\carry[1] ), .Z(\carry[2] ) );
  XNR2D1 U1_A_5 ( .A1(A[5]), .A2(\carry[5] ), .ZN(SUM[5]) );
  XNR2D1 U1_A_3 ( .A1(A[3]), .A2(\carry[3] ), .ZN(SUM[3]) );
  XNR2D1 U1_A_2 ( .A1(A[2]), .A2(\carry[2] ), .ZN(SUM[2]) );
  XNR2D1 U1_A_4 ( .A1(A[4]), .A2(\carry[4] ), .ZN(SUM[4]) );
  XNR2D1 U1_A_1 ( .A1(A[1]), .A2(\carry[1] ), .ZN(SUM[1]) );
  CKND0 U6 ( .CLK(\carry[1] ), .CN(SUM[0]) );
endmodule


module VFO_DW01_inc_0 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[5] , \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(\carry[5] ), .S(SUM[4]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  CKXOR2D0 U5 ( .A1(\carry[5] ), .A2(A[5]), .Z(SUM[5]) );
  CKND0 U6 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_inc_1 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[5] , \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(\carry[5] ), .S(SUM[4]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  CKXOR2D0 U5 ( .A1(\carry[5] ), .A2(A[5]), .Z(SUM[5]) );
  CKND0 U6 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module VFO_DW01_cmp2_2 ( A, B, LEQ, TC, LT_LE, GE_GT );
  input [5:0] A;
  input [5:0] B;
  input LEQ, TC;
  output LT_LE, GE_GT;
  wire   n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26;

  OAI21D0 U6 ( .A1(A[5]), .A2(n15), .B(n16), .ZN(LT_LE) );
  IOA21D0 U7 ( .A1(n15), .A2(A[5]), .B(n17), .ZN(n16) );
  IOA21D0 U8 ( .A1(n18), .A2(B[4]), .B(n19), .ZN(n17) );
  OAI221D0 U9 ( .A1(B[3]), .A2(n20), .B1(B[4]), .B2(n18), .C(n21), .ZN(n19) );
  AO221D0 U10 ( .A1(n22), .A2(B[2]), .B1(n20), .B2(B[3]), .C(n23), .Z(n21) );
  OA222D0 U11 ( .A1(n24), .A2(n25), .B1(B[1]), .B2(n26), .C1(B[2]), .C2(n22), 
        .Z(n23) );
  INR2D0 U12 ( .A1(n24), .B1(A[1]), .ZN(n26) );
  CKND0 U13 ( .CLK(A[1]), .CN(n25) );
  INR2D0 U14 ( .A1(B[0]), .B1(A[0]), .ZN(n24) );
  CKND0 U15 ( .CLK(A[2]), .CN(n22) );
  CKND0 U16 ( .CLK(A[3]), .CN(n20) );
  CKND0 U17 ( .CLK(A[4]), .CN(n18) );
  CKND0 U18 ( .CLK(B[5]), .CN(n15) );
endmodule

