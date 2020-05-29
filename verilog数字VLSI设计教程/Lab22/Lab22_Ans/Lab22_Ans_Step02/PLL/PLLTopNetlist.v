
module PLLTop ( ClockOut, ClockIn, Sample, Reset );
  input ClockIn, Sample, Reset;
  output ClockOut;
  wire   n6, ClockFromCounter, n2, n3, n4, n5;
  wire   [1:0] AdjFreq;

  ClockComparator PLLComp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn), 
        .CounterClock(ClockFromCounter), .Reset(n5) );
  VFO PLLVFO1 ( .ClockOut(n6), .AdjustFreq(AdjFreq), .SampleCmd(Sample), 
        .Reset(n5) );
  MultiCounter PLLCntr1 ( .CarryOut(ClockFromCounter), .Clock(n3), .Reset(n5)
         );
  CKNXD16 U1 ( .I(n2), .ZN(n3) );
  CKNXD16 U2 ( .I(n2), .ZN(ClockOut) );
  CKBD0 U3 ( .CLK(n4), .C(n2) );
  BUFFD1 U4 ( .I(Reset), .Z(n5) );
  CKND0 U5 ( .CLK(n6), .CN(n4) );
endmodule


module ClockComparator ( AdjustFreq, ClockIn, CounterClock, Reset );
  output [1:0] AdjustFreq;
  input ClockIn, CounterClock, Reset;
  wire   N15, N16, N17, \VarClockCount[1] , \VarClockCount[0] , n2, n3, n4;

  LHQD1 \AdjustFreq_reg[1]  ( .E(N16), .D(N17), .Q(AdjustFreq[1]) );
  LHQD1 \AdjustFreq_reg[0]  ( .E(N16), .D(N15), .Q(AdjustFreq[0]) );
  OAI21D2 U3 ( .A1(\VarClockCount[0] ), .A2(n2), .B(n3), .ZN(
        \VarClockCount[0] ) );
  XOR2D2 U7 ( .A1(\VarClockCount[0] ), .A2(\VarClockCount[1] ), .Z(n4) );
  INVD1 U4 ( .I(Reset), .ZN(n3) );
  INR2D1 U5 ( .A1(n4), .B1(N16), .ZN(\VarClockCount[1] ) );
  NR4D0 U6 ( .A1(Reset), .A2(CounterClock), .A3(\VarClockCount[1] ), .A4(n4), 
        .ZN(N17) );
  ND2D1 U8 ( .A1(CounterClock), .A2(n3), .ZN(N16) );
  OAI21D1 U9 ( .A1(\VarClockCount[1] ), .A2(CounterClock), .B(n3), .ZN(N15) );
  INVD1 U10 ( .I(CounterClock), .ZN(n2) );
endmodule


module VFO ( ClockOut, AdjustFreq, SampleCmd, Reset );
  input [1:0] AdjustFreq;
  input SampleCmd, Reset;
  output ClockOut;


  NR2XD2 U3 ( .A1(ClockOut), .A2(Reset), .ZN(ClockOut) );
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

