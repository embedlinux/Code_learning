`timescale 1ns/1ps

module PLLTop ( ClockOut, ClockIn, Reset );
  input ClockIn, Reset;
  output ClockOut;
  wire   n6, SampleWire, CtrCarry, n2, n3, n4, n5;
  wire   [1:0] AdjFreq;

  initial $sdf_annotate("PLLTopNetlist.sdf");

  DEL005 SampleDelay1 ( .I(ClockIn), .Z(SampleWire) );
  ClockComparator Comp1 ( .AdjustFreq(AdjFreq), .ClockIn(ClockIn), 
        .CounterClock(CtrCarry), .Reset(n5) );
  VFO VFO1 ( .ClockOut(n6), .AdjustFreq(AdjFreq), .Sample(SampleWire), .Reset(
        n5) );
  MultiCounter MCntr1 ( .CarryOut(CtrCarry), .Clock(n4), .Reset(n5) );
  CKNXD16 U1 ( .I(n2), .ZN(ClockOut) );
  CKNXD16 U2 ( .I(n2), .ZN(n3) );
  CKND0 U3 ( .CLK(n6), .CN(n2) );
  BUFFD0 U4 ( .I(n3), .Z(n4) );
  BUFFD1 U5 ( .I(Reset), .Z(n5) );
endmodule


module ClockComparator ( AdjustFreq, ClockIn, CounterClock, Reset );
  output [1:0] AdjustFreq;
  input ClockIn, CounterClock, Reset;
  wire   \ClockInN[0] , N5, N6, \CounterClockN[0] , N7, N8, N9, N19, N20, n5,
         n6, n7, n8, n9, n1, n2, n3, n4, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38;

  AO211D1 U8 ( .A1(n7), .A2(n8), .B(N8), .C(N5), .Z(n9) );
  DFCND1 \CounterClockN_reg[1]  ( .D(N8), .CP(CounterClock), .CDN(n5), .QN(N19) );
  DFCND1 \CounterClockN_reg[0]  ( .D(N7), .CP(CounterClock), .CDN(n5), .Q(
        \CounterClockN[0] ), .QN(N7) );
  DFSNQD1 \AdjustFreq_reg[0]  ( .D(N19), .CP(CounterClock), .SDN(n6), .Q(
        AdjustFreq[0]) );
  DFCNQD1 \AdjustFreq_reg[1]  ( .D(N20), .CP(CounterClock), .CDN(n6), .Q(
        AdjustFreq[1]) );
  DFCND1 \ClockInN_reg[0]  ( .D(n1), .CP(ClockIn), .CDN(n5), .Q(\ClockInN[0] ), 
        .QN(N5) );
  DFCND1 \ClockInN_reg[1]  ( .D(n2), .CP(ClockIn), .CDN(n5), .QN(n7) );
  DFSND1 ZeroCounters_reg ( .D(N9), .CP(ClockIn), .SDN(n6), .QN(n5) );
  BUFFD0 U3 ( .I(n38), .Z(n1) );
  BUFFD0 U4 ( .I(n4), .Z(n2) );
  BUFFD0 U5 ( .I(N5), .Z(n3) );
  BUFFD0 U6 ( .I(n11), .Z(n4) );
  BUFFD0 U7 ( .I(n3), .Z(n10) );
  BUFFD0 U9 ( .I(n13), .Z(n11) );
  BUFFD0 U10 ( .I(n10), .Z(n12) );
  BUFFD0 U11 ( .I(n15), .Z(n13) );
  BUFFD0 U12 ( .I(n12), .Z(n14) );
  BUFFD0 U13 ( .I(n17), .Z(n15) );
  BUFFD0 U14 ( .I(n14), .Z(n16) );
  BUFFD0 U15 ( .I(n19), .Z(n17) );
  BUFFD0 U16 ( .I(n16), .Z(n18) );
  BUFFD0 U17 ( .I(n21), .Z(n19) );
  BUFFD0 U18 ( .I(n18), .Z(n20) );
  BUFFD0 U19 ( .I(n23), .Z(n21) );
  BUFFD0 U20 ( .I(n20), .Z(n22) );
  BUFFD0 U21 ( .I(n25), .Z(n23) );
  BUFFD0 U22 ( .I(n22), .Z(n24) );
  BUFFD0 U23 ( .I(n27), .Z(n25) );
  BUFFD0 U24 ( .I(n24), .Z(n26) );
  BUFFD0 U25 ( .I(n29), .Z(n27) );
  BUFFD0 U26 ( .I(n26), .Z(n28) );
  BUFFD0 U27 ( .I(n31), .Z(n29) );
  BUFFD0 U28 ( .I(n28), .Z(n30) );
  BUFFD0 U29 ( .I(n33), .Z(n31) );
  BUFFD0 U30 ( .I(n30), .Z(n32) );
  BUFFD0 U31 ( .I(n35), .Z(n33) );
  BUFFD0 U32 ( .I(n32), .Z(n34) );
  BUFFD0 U33 ( .I(N6), .Z(n35) );
  BUFFD0 U34 ( .I(n34), .Z(n36) );
  BUFFD0 U35 ( .I(\ClockInN[0] ), .Z(n37) );
  XNR2D0 U36 ( .A1(n37), .A2(n7), .ZN(N6) );
  CKBD0 U37 ( .CLK(n36), .C(n38) );
  INVD1 U38 ( .I(Reset), .ZN(n6) );
  NR2D1 U39 ( .A1(n4), .A2(n38), .ZN(N9) );
  OAI21D1 U40 ( .A1(n8), .A2(n7), .B(n9), .ZN(N20) );
  NR2D1 U41 ( .A1(N19), .A2(N7), .ZN(n8) );
  XNR2D1 U42 ( .A1(N19), .A2(\CounterClockN[0] ), .ZN(N8) );
endmodule


module VFO ( ClockOut, AdjustFreq, Sample, Reset );
  input [1:0] AdjustFreq;
  input Sample, Reset;
  output ClockOut;
  wire   FastClock, N9, N10, N11, N12, N13, N14, N16, N17, N18, N19, N20, N21,
         N27, N28, N29, N30, N31, N32, N35, N36, N37, N38, N39, N40, N49, N51,
         N54, N55, n17, n18, n19, n20, n21, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124;
  wire   [5:0] WireD;
  wire   [5:0] FastDivvy;
  wire   [5:0] DivideFactor;

  DEL005 \DelayLine[0].Delay85ps  ( .I(WireD[0]), .Z(WireD[1]) );
  DEL005 \DelayLine[1].Delay85ps  ( .I(WireD[1]), .Z(WireD[2]) );
  DEL005 \DelayLine[2].Delay85ps  ( .I(WireD[2]), .Z(WireD[3]) );
  DEL005 \DelayLine[3].Delay85ps  ( .I(WireD[3]), .Z(WireD[4]) );
  DEL005 \DelayLine[4].Delay85ps  ( .I(WireD[4]), .Z(WireD[5]) );
  VFO_DW01_dec_0 \Sampler/sub_192  ( .A({n43, n70, n45, n13, n84, n99}), .SUM(
        {N40, N39, N38, N37, N36, N35}) );
  VFO_DW01_inc_0 \Sampler/add_189  ( .A({n43, n70, n45, n13, n84, n99}), .SUM(
        {N32, N31, N30, N29, N28, N27}) );
  VFO_DW01_inc_1 \ClockOutGen/add_170  ( .A(FastDivvy), .SUM({N14, N13, N12, 
        N11, N10, N9}) );
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
  EDFCND1 \DivideFactor_reg[3]  ( .D(n1), .E(n48), .CP(Sample), .CDN(n20), .Q(
        DivideFactor[3]), .QN(n117) );
  EDFCND1 \DivideFactor_reg[2]  ( .D(n14), .E(n48), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[2]) );
  EDFCND1 \DivideFactor_reg[5]  ( .D(n31), .E(n48), .CP(Sample), .CDN(n20), 
        .Q(DivideFactor[5]), .QN(n107) );
  DFSND1 \DivideFactor_reg[4]  ( .D(n57), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[4]), .QN(n112) );
  DFSND1 \DivideFactor_reg[1]  ( .D(n71), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[1]), .QN(n124) );
  DFSND1 \DivideFactor_reg[0]  ( .D(n86), .CP(Sample), .SDN(n20), .Q(
        DivideFactor[0]), .QN(n122) );
  DFCNQD1 ClockOutReg_reg ( .D(n17), .CP(FastClock), .CDN(n20), .Q(ClockOut)
         );
  BUFFD0 U3 ( .I(n2), .Z(n1) );
  BUFFD0 U4 ( .I(n3), .Z(n2) );
  BUFFD0 U5 ( .I(n4), .Z(n3) );
  BUFFD0 U6 ( .I(n5), .Z(n4) );
  BUFFD0 U7 ( .I(n6), .Z(n5) );
  BUFFD0 U8 ( .I(n7), .Z(n6) );
  BUFFD0 U9 ( .I(n8), .Z(n7) );
  BUFFD0 U10 ( .I(n9), .Z(n8) );
  BUFFD0 U11 ( .I(n10), .Z(n9) );
  BUFFD0 U12 ( .I(N51), .Z(n10) );
  BUFFD0 U13 ( .I(DivideFactor[3]), .Z(n11) );
  BUFFD0 U14 ( .I(n11), .Z(n12) );
  BUFFD0 U15 ( .I(n30), .Z(n13) );
  BUFFD0 U16 ( .I(n15), .Z(n14) );
  BUFFD0 U17 ( .I(n16), .Z(n15) );
  BUFFD0 U18 ( .I(n22), .Z(n16) );
  BUFFD0 U19 ( .I(n23), .Z(n22) );
  BUFFD0 U20 ( .I(n24), .Z(n23) );
  BUFFD0 U21 ( .I(n25), .Z(n24) );
  BUFFD0 U22 ( .I(n26), .Z(n25) );
  BUFFD0 U23 ( .I(n27), .Z(n26) );
  BUFFD0 U24 ( .I(n28), .Z(n27) );
  BUFFD0 U25 ( .I(N49), .Z(n28) );
  BUFFD0 U26 ( .I(DivideFactor[2]), .Z(n29) );
  CKBD0 U27 ( .CLK(n29), .C(n30) );
  BUFFD0 U28 ( .I(n32), .Z(n31) );
  BUFFD0 U29 ( .I(n33), .Z(n32) );
  BUFFD0 U30 ( .I(n34), .Z(n33) );
  BUFFD0 U31 ( .I(n35), .Z(n34) );
  BUFFD0 U32 ( .I(n36), .Z(n35) );
  BUFFD0 U33 ( .I(n37), .Z(n36) );
  BUFFD0 U34 ( .I(n38), .Z(n37) );
  BUFFD0 U35 ( .I(n39), .Z(n38) );
  BUFFD0 U36 ( .I(n40), .Z(n39) );
  BUFFD0 U37 ( .I(n41), .Z(n40) );
  BUFFD0 U38 ( .I(n42), .Z(n41) );
  BUFFD0 U39 ( .I(N55), .Z(n42) );
  BUFFD0 U40 ( .I(n44), .Z(n43) );
  BUFFD0 U41 ( .I(DivideFactor[5]), .Z(n44) );
  CKBD0 U42 ( .CLK(n107), .C(n73) );
  ND2D1P5 U43 ( .A1(AdjustFreq[1]), .A2(n105), .ZN(n111) );
  CKBD0 U44 ( .CLK(n12), .C(n45) );
  BUFFD0 U45 ( .I(N54), .Z(n46) );
  BUFFD0 U46 ( .I(n46), .Z(n47) );
  BUFFD0 U47 ( .I(n49), .Z(n48) );
  BUFFD0 U48 ( .I(n50), .Z(n49) );
  BUFFD0 U49 ( .I(n51), .Z(n50) );
  BUFFD0 U50 ( .I(n52), .Z(n51) );
  BUFFD0 U51 ( .I(n53), .Z(n52) );
  BUFFD0 U52 ( .I(n54), .Z(n53) );
  BUFFD0 U53 ( .I(n55), .Z(n54) );
  BUFFD0 U54 ( .I(n56), .Z(n55) );
  BUFFD0 U55 ( .I(n47), .Z(n56) );
  BUFFD0 U56 ( .I(n58), .Z(n57) );
  BUFFD0 U57 ( .I(n59), .Z(n58) );
  BUFFD0 U58 ( .I(n60), .Z(n59) );
  BUFFD0 U59 ( .I(n61), .Z(n60) );
  BUFFD0 U60 ( .I(n62), .Z(n61) );
  BUFFD0 U61 ( .I(n63), .Z(n62) );
  BUFFD0 U62 ( .I(n64), .Z(n63) );
  BUFFD0 U63 ( .I(n65), .Z(n64) );
  BUFFD0 U64 ( .I(n66), .Z(n65) );
  BUFFD0 U65 ( .I(n67), .Z(n66) );
  BUFFD0 U66 ( .I(n68), .Z(n67) );
  BUFFD0 U67 ( .I(n69), .Z(n68) );
  BUFFD0 U68 ( .I(n19), .Z(n69) );
  BUFFD0 U69 ( .I(DivideFactor[4]), .Z(n70) );
  BUFFD0 U70 ( .I(n72), .Z(n71) );
  BUFFD0 U71 ( .I(n74), .Z(n72) );
  BUFFD0 U72 ( .I(n75), .Z(n74) );
  BUFFD0 U73 ( .I(n76), .Z(n75) );
  BUFFD0 U74 ( .I(n77), .Z(n76) );
  BUFFD0 U75 ( .I(n78), .Z(n77) );
  BUFFD0 U76 ( .I(n79), .Z(n78) );
  BUFFD0 U77 ( .I(n80), .Z(n79) );
  BUFFD0 U78 ( .I(n81), .Z(n80) );
  BUFFD0 U79 ( .I(n82), .Z(n81) );
  BUFFD0 U80 ( .I(n83), .Z(n82) );
  BUFFD0 U81 ( .I(n18), .Z(n83) );
  BUFFD0 U82 ( .I(n85), .Z(n84) );
  BUFFD0 U83 ( .I(DivideFactor[1]), .Z(n85) );
  BUFFD0 U84 ( .I(n88), .Z(n86) );
  BUFFD0 U85 ( .I(n21), .Z(n87) );
  BUFFD0 U86 ( .I(n89), .Z(n88) );
  BUFFD0 U87 ( .I(n90), .Z(n89) );
  BUFFD0 U88 ( .I(n91), .Z(n90) );
  BUFFD0 U89 ( .I(n92), .Z(n91) );
  BUFFD0 U90 ( .I(n93), .Z(n92) );
  BUFFD0 U91 ( .I(n94), .Z(n93) );
  BUFFD0 U92 ( .I(n95), .Z(n94) );
  BUFFD0 U93 ( .I(n96), .Z(n95) );
  BUFFD0 U94 ( .I(n97), .Z(n96) );
  BUFFD0 U95 ( .I(n87), .Z(n97) );
  BUFFD0 U96 ( .I(DivideFactor[0]), .Z(n98) );
  CKBXD0 U97 ( .I(n98), .Z(n99) );
  XOR2D0 U98 ( .A1(ClockOut), .A2(n109), .Z(n17) );
  INVD1 U99 ( .I(Reset), .ZN(n20) );
  AO222D0 U100 ( .A1(N27), .A2(n101), .B1(N35), .B2(n102), .C1(n99), .C2(n103), 
        .Z(n21) );
  AO222D0 U101 ( .A1(N31), .A2(n101), .B1(N39), .B2(n102), .C1(n70), .C2(n103), 
        .Z(n19) );
  AO222D0 U102 ( .A1(N28), .A2(n101), .B1(N36), .B2(n102), .C1(n84), .C2(n103), 
        .Z(n18) );
  CKND0 U103 ( .CLK(N54), .CN(n103) );
  AN2D0 U104 ( .A1(n104), .A2(n105), .Z(n102) );
  AN3D0 U105 ( .A1(n106), .A2(n73), .A3(n108), .Z(n101) );
  AO22D0 U106 ( .A1(N32), .A2(n108), .B1(N40), .B2(n104), .Z(N55) );
  MUX2ND0 U107 ( .I0(n110), .I1(n111), .S(AdjustFreq[0]), .ZN(N54) );
  ND3D0 U108 ( .A1(n112), .A2(n73), .A3(n113), .ZN(n105) );
  ND4D0 U109 ( .A1(DivideFactor[3]), .A2(DivideFactor[2]), .A3(n84), .A4(n99), 
        .ZN(n113) );
  IND3D0 U110 ( .A1(AdjustFreq[1]), .B1(n73), .B2(n106), .ZN(n110) );
  CKND2D0 U111 ( .A1(n70), .A2(n45), .ZN(n106) );
  AO22D0 U112 ( .A1(N30), .A2(n108), .B1(N38), .B2(n104), .Z(N51) );
  AO22D0 U113 ( .A1(N29), .A2(n108), .B1(N37), .B2(n104), .Z(N49) );
  AN2D0 U114 ( .A1(AdjustFreq[1]), .A2(AdjustFreq[0]), .Z(n104) );
  NR2D0 U115 ( .A1(AdjustFreq[0]), .A2(AdjustFreq[1]), .ZN(n108) );
  INR2D0 U116 ( .A1(N14), .B1(n109), .ZN(N21) );
  INR2D0 U117 ( .A1(N13), .B1(n109), .ZN(N20) );
  INR2D0 U118 ( .A1(N12), .B1(n109), .ZN(N19) );
  INR2D0 U119 ( .A1(N11), .B1(n109), .ZN(N18) );
  INR2D0 U120 ( .A1(N10), .B1(n109), .ZN(N17) );
  INR2D0 U121 ( .A1(N9), .B1(n109), .ZN(N16) );
  OA21D0 U122 ( .A1(FastDivvy[5]), .A2(n107), .B(n114), .Z(n109) );
  IOA22D0 U123 ( .B1(n115), .B2(n116), .A1(n107), .A2(FastDivvy[5]), .ZN(n114)
         );
  AOI221D0 U124 ( .A1(FastDivvy[4]), .A2(n112), .B1(FastDivvy[3]), .B2(n117), 
        .C(n118), .ZN(n116) );
  AOI221D0 U125 ( .A1(DivideFactor[3]), .A2(n119), .B1(DivideFactor[2]), .B2(
        n120), .C(n121), .ZN(n118) );
  IAO21D0 U126 ( .A1(n120), .A2(DivideFactor[2]), .B(FastDivvy[2]), .ZN(n121)
         );
  OAI32D0 U127 ( .A1(n122), .A2(FastDivvy[0]), .A3(n123), .B1(FastDivvy[1]), 
        .B2(n124), .ZN(n120) );
  AN2D0 U128 ( .A1(FastDivvy[1]), .A2(n124), .Z(n123) );
  CKND0 U129 ( .CLK(FastDivvy[3]), .CN(n119) );
  NR2D0 U130 ( .A1(FastDivvy[4]), .A2(n112), .ZN(n115) );
  CKND0 U131 ( .CLK(WireD[0]), .CN(FastClock) );
  CKND2D0 U132 ( .A1(WireD[5]), .A2(n20), .ZN(WireD[0]) );
endmodule


module MultiCounter ( CarryOut, Clock, Reset );
  input Clock, Reset;
  output CarryOut;
  wire   N1, N2, N3, N4, N5, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37;
  wire   [3:0] Ctr;

  MultiCounter_DW01_inc_0 add_16 ( .A({n36, n37, n18, n2, n19}), .SUM({N5, N4, 
        N3, N2, N1}) );
  DFCNQD1 \Ctr_reg[1]  ( .D(N2), .CP(Clock), .CDN(n1), .Q(Ctr[1]) );
  DFCNQD1 \Ctr_reg[2]  ( .D(N3), .CP(Clock), .CDN(n1), .Q(Ctr[2]) );
  DFCNQD1 \Ctr_reg[3]  ( .D(N4), .CP(Clock), .CDN(n1), .Q(Ctr[3]) );
  DFCNQD1 \Ctr_reg[0]  ( .D(N1), .CP(Clock), .CDN(n1), .Q(Ctr[0]) );
  DFCNQD1 \Ctr_reg[4]  ( .D(N5), .CP(Clock), .CDN(n1), .Q(CarryOut) );
  BUFFD0 U3 ( .I(n3), .Z(n2) );
  BUFFD0 U4 ( .I(n4), .Z(n3) );
  BUFFD0 U5 ( .I(n5), .Z(n4) );
  BUFFD0 U6 ( .I(n6), .Z(n5) );
  BUFFD0 U7 ( .I(n7), .Z(n6) );
  BUFFD0 U8 ( .I(n8), .Z(n7) );
  BUFFD0 U9 ( .I(n9), .Z(n8) );
  BUFFD0 U10 ( .I(n10), .Z(n9) );
  BUFFD0 U11 ( .I(n11), .Z(n10) );
  BUFFD0 U12 ( .I(n12), .Z(n11) );
  BUFFD0 U13 ( .I(n13), .Z(n12) );
  BUFFD0 U14 ( .I(n14), .Z(n13) );
  BUFFD0 U15 ( .I(n15), .Z(n14) );
  BUFFD0 U16 ( .I(n16), .Z(n15) );
  BUFFD0 U17 ( .I(n17), .Z(n16) );
  CKBD0 U18 ( .CLK(Ctr[2]), .C(n18) );
  BUFFD0 U19 ( .I(Ctr[1]), .Z(n17) );
  CKBD0 U20 ( .CLK(Ctr[3]), .C(n37) );
  CKBD0 U21 ( .CLK(Ctr[0]), .C(n35) );
  BUFFD0 U22 ( .I(n20), .Z(n19) );
  BUFFD0 U23 ( .I(n21), .Z(n20) );
  BUFFD0 U24 ( .I(n22), .Z(n21) );
  BUFFD0 U25 ( .I(n23), .Z(n22) );
  BUFFD0 U26 ( .I(n24), .Z(n23) );
  BUFFD0 U27 ( .I(n25), .Z(n24) );
  BUFFD0 U28 ( .I(n26), .Z(n25) );
  BUFFD0 U29 ( .I(n27), .Z(n26) );
  BUFFD0 U30 ( .I(n28), .Z(n27) );
  BUFFD0 U31 ( .I(n29), .Z(n28) );
  BUFFD0 U32 ( .I(n30), .Z(n29) );
  BUFFD0 U33 ( .I(n31), .Z(n30) );
  BUFFD0 U34 ( .I(n32), .Z(n31) );
  BUFFD0 U35 ( .I(n33), .Z(n32) );
  BUFFD0 U36 ( .I(n34), .Z(n33) );
  BUFFD0 U37 ( .I(n35), .Z(n34) );
  BUFFD0 U38 ( .I(CarryOut), .Z(n36) );
  INVD1 U39 ( .I(Reset), .ZN(n1) );
endmodule


module MultiCounter_DW01_inc_0 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   n55, n56, n57, n58, \carry[4] , \carry[3] , \carry[2] , n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(n56) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(n58) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(n57) );
  BUFFD0 U1 ( .I(n58), .Z(SUM[1]) );
  BUFFD0 U2 ( .I(n3), .Z(SUM[2]) );
  BUFFD0 U3 ( .I(n4), .Z(n3) );
  BUFFD0 U4 ( .I(n5), .Z(n4) );
  BUFFD0 U5 ( .I(n6), .Z(n5) );
  BUFFD0 U6 ( .I(n7), .Z(n6) );
  BUFFD0 U7 ( .I(n8), .Z(n7) );
  BUFFD0 U8 ( .I(n9), .Z(n8) );
  BUFFD0 U9 ( .I(n10), .Z(n9) );
  BUFFD0 U10 ( .I(n11), .Z(n10) );
  BUFFD0 U11 ( .I(n12), .Z(n11) );
  BUFFD0 U12 ( .I(n13), .Z(n12) );
  BUFFD0 U13 ( .I(n14), .Z(n13) );
  BUFFD0 U14 ( .I(n15), .Z(n14) );
  BUFFD0 U15 ( .I(n16), .Z(n15) );
  BUFFD0 U16 ( .I(n17), .Z(n16) );
  BUFFD0 U17 ( .I(n18), .Z(n17) );
  BUFFD0 U18 ( .I(n19), .Z(n18) );
  BUFFD0 U19 ( .I(n57), .Z(n19) );
  BUFFD0 U20 ( .I(n21), .Z(SUM[3]) );
  BUFFD0 U21 ( .I(n22), .Z(n21) );
  BUFFD0 U22 ( .I(n23), .Z(n22) );
  BUFFD0 U23 ( .I(n24), .Z(n23) );
  BUFFD0 U24 ( .I(n25), .Z(n24) );
  BUFFD0 U25 ( .I(n26), .Z(n25) );
  BUFFD0 U26 ( .I(n27), .Z(n26) );
  BUFFD0 U27 ( .I(n28), .Z(n27) );
  BUFFD0 U28 ( .I(n29), .Z(n28) );
  BUFFD0 U29 ( .I(n30), .Z(n29) );
  BUFFD0 U30 ( .I(n31), .Z(n30) );
  BUFFD0 U31 ( .I(n32), .Z(n31) );
  BUFFD0 U32 ( .I(n33), .Z(n32) );
  BUFFD0 U33 ( .I(n34), .Z(n33) );
  BUFFD0 U34 ( .I(n35), .Z(n34) );
  BUFFD0 U35 ( .I(n36), .Z(n35) );
  BUFFD0 U36 ( .I(n37), .Z(n36) );
  BUFFD0 U37 ( .I(n56), .Z(n37) );
  BUFFD0 U38 ( .I(n39), .Z(SUM[4]) );
  BUFFD0 U39 ( .I(n40), .Z(n39) );
  BUFFD0 U40 ( .I(n41), .Z(n40) );
  BUFFD0 U41 ( .I(n42), .Z(n41) );
  BUFFD0 U42 ( .I(n43), .Z(n42) );
  BUFFD0 U43 ( .I(n44), .Z(n43) );
  BUFFD0 U44 ( .I(n45), .Z(n44) );
  BUFFD0 U45 ( .I(n46), .Z(n45) );
  BUFFD0 U46 ( .I(n47), .Z(n46) );
  BUFFD0 U47 ( .I(n48), .Z(n47) );
  BUFFD0 U48 ( .I(n49), .Z(n48) );
  BUFFD0 U49 ( .I(n50), .Z(n49) );
  BUFFD0 U50 ( .I(n51), .Z(n50) );
  BUFFD0 U51 ( .I(n52), .Z(n51) );
  BUFFD0 U52 ( .I(n53), .Z(n52) );
  BUFFD0 U53 ( .I(n54), .Z(n53) );
  BUFFD0 U54 ( .I(n55), .Z(n54) );
  XOR2D0 U55 ( .A1(\carry[4] ), .A2(A[4]), .Z(n55) );
  CKND0 U56 ( .CLK(A[0]), .CN(SUM[0]) );
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
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
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

