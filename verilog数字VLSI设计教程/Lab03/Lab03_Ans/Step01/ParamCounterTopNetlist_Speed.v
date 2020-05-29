
module Counter_pHi7_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   \carry[7] , \carry[6] , \carry[5] , \carry[4] , \carry[3] ,
         \carry[2] ;

  HA1D0 U1_1_6 ( .A(A[6]), .B(\carry[6] ), .CO(\carry[7] ), .S(SUM[6]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(\carry[5] ), .S(SUM[4]) );
  HA1D0 U1_1_5 ( .A(A[5]), .B(\carry[5] ), .CO(\carry[6] ), .S(SUM[5]) );
  CKXOR2D0 U1 ( .A1(\carry[7] ), .A2(A[7]), .Z(SUM[7]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module Converter_pHi7_pPad5 ( OutBus, InBus, Enable );
  output [12:0] OutBus;
  input [7:0] InBus;
  input Enable;
  wire   n3, n1, n2, n4, n5;

  BUFTD16 \OutBusGate_tri[6]  ( .I(InBus[6]), .OE(n1), .Z(OutBus[6]) );
  BUFTD16 \OutBusGate_tri[8]  ( .I(n3), .OE(n1), .Z(OutBus[8]) );
  BUFTD16 \OutBusGate_tri[1]  ( .I(InBus[1]), .OE(n4), .Z(OutBus[1]) );
  BUFTD16 \OutBusGate_tri[3]  ( .I(InBus[3]), .OE(n2), .Z(OutBus[3]) );
  BUFTD16 \OutBusGate_tri[4]  ( .I(InBus[4]), .OE(n4), .Z(OutBus[4]) );
  BUFTD16 \OutBusGate_tri[2]  ( .I(InBus[2]), .OE(n2), .Z(OutBus[2]) );
  BUFTD16 \OutBusGate_tri[7]  ( .I(InBus[7]), .OE(n2), .Z(OutBus[7]) );
  BUFTD16 \OutBusGate_tri[12]  ( .I(n3), .OE(n4), .Z(OutBus[12]) );
  BUFTD16 \OutBusGate_tri[9]  ( .I(n3), .OE(n4), .Z(OutBus[9]) );
  BUFTD16 \OutBusGate_tri[0]  ( .I(InBus[0]), .OE(n1), .Z(OutBus[0]) );
  BUFTD16 \OutBusGate_tri[5]  ( .I(InBus[5]), .OE(n1), .Z(OutBus[5]) );
  BUFTD16 \OutBusGate_tri[11]  ( .I(n3), .OE(n1), .Z(OutBus[11]) );
  BUFTD16 \OutBusGate_tri[10]  ( .I(n3), .OE(n2), .Z(OutBus[10]) );
  BUFFD8 U2 ( .I(n5), .Z(n1) );
  BUFFD6 U3 ( .I(n5), .Z(n4) );
  BUFFD6 U4 ( .I(n5), .Z(n2) );
  TIEL U5 ( .ZN(n3) );
  BUFFD3 U6 ( .I(Enable), .Z(n5) );
endmodule


module Counter_pHi7 ( Count, Clock, CountEnable, CountReset );
  output [7:0] Count;
  input Clock, CountEnable, CountReset;
  wire   ClockWire, N4, N5, N6, N7, N8, N9, N10, N11, n2;

  Counter_pHi7_DW01_inc_0 add_40 ( .A(Count), .SUM({N11, N10, N9, N8, N7, N6, 
        N5, N4}) );
  DFCNQD1 \CountReg_reg[7]  ( .D(N11), .CP(ClockWire), .CDN(n2), .Q(Count[7])
         );
  DFCNQD1 \CountReg_reg[1]  ( .D(N5), .CP(ClockWire), .CDN(n2), .Q(Count[1])
         );
  DFCNQD1 \CountReg_reg[2]  ( .D(N6), .CP(ClockWire), .CDN(n2), .Q(Count[2])
         );
  DFCNQD1 \CountReg_reg[3]  ( .D(N7), .CP(ClockWire), .CDN(n2), .Q(Count[3])
         );
  DFCNQD1 \CountReg_reg[4]  ( .D(N8), .CP(ClockWire), .CDN(n2), .Q(Count[4])
         );
  DFCNQD1 \CountReg_reg[5]  ( .D(N9), .CP(ClockWire), .CDN(n2), .Q(Count[5])
         );
  DFCNQD1 \CountReg_reg[6]  ( .D(N10), .CP(ClockWire), .CDN(n2), .Q(Count[6])
         );
  DFCNQD1 \CountReg_reg[0]  ( .D(N4), .CP(ClockWire), .CDN(n2), .Q(Count[0])
         );
  INVD1 U3 ( .I(CountReset), .ZN(n2) );
  AN2D1 U4 ( .A1(CountEnable), .A2(Clock), .Z(ClockWire) );
endmodule


module ParamCounterTop ( Count, Clock, CountEnable, CountReset, OutEnable );
  output [12:0] Count;
  input Clock, CountEnable, CountReset, OutEnable;

  wire   [7:0] Xfer;

  Counter_pHi7 Counter01 ( .Count(Xfer), .Clock(Clock), .CountEnable(
        CountEnable), .CountReset(CountReset) );
  Converter_pHi7_pPad5 Converter01 ( .OutBus(Count), .InBus(Xfer), .Enable(
        OutEnable) );
endmodule

