
module SerFrameEnc ( FrameOut, BusIn, DoFrame );
  output [63:0] FrameOut;
  input [31:0] BusIn;
  input DoFrame;
  wire   n33, n35, n37, n39, n41, n43, n45, n47, n49, n51, n53, n55, n57, n59,
         n61, n63, n65, n67, n69, n71, n73, n75, n77, n79, n81, n83, n85, n87,
         n89, n91, n93, n95, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128;

  DFD1 \FrameReg_reg[63]  ( .D(BusIn[31]), .CP(DoFrame), .QN(n128) );
  DFD1 \FrameReg_reg[62]  ( .D(BusIn[30]), .CP(DoFrame), .QN(n127) );
  DFD1 \FrameReg_reg[61]  ( .D(BusIn[29]), .CP(DoFrame), .QN(n126) );
  DFD1 \FrameReg_reg[60]  ( .D(BusIn[28]), .CP(DoFrame), .QN(n125) );
  DFD1 \FrameReg_reg[59]  ( .D(BusIn[27]), .CP(DoFrame), .QN(n124) );
  DFD1 \FrameReg_reg[58]  ( .D(BusIn[26]), .CP(DoFrame), .QN(n123) );
  DFD1 \FrameReg_reg[57]  ( .D(BusIn[25]), .CP(DoFrame), .QN(n122) );
  DFD1 \FrameReg_reg[56]  ( .D(BusIn[24]), .CP(DoFrame), .QN(n121) );
  DFD1 \FrameReg_reg[47]  ( .D(BusIn[23]), .CP(DoFrame), .QN(n120) );
  DFD1 \FrameReg_reg[46]  ( .D(BusIn[22]), .CP(DoFrame), .QN(n119) );
  DFD1 \FrameReg_reg[45]  ( .D(BusIn[21]), .CP(DoFrame), .QN(n118) );
  DFD1 \FrameReg_reg[44]  ( .D(BusIn[20]), .CP(DoFrame), .QN(n117) );
  DFD1 \FrameReg_reg[43]  ( .D(BusIn[19]), .CP(DoFrame), .QN(n116) );
  DFD1 \FrameReg_reg[42]  ( .D(BusIn[18]), .CP(DoFrame), .QN(n115) );
  DFD1 \FrameReg_reg[41]  ( .D(BusIn[17]), .CP(DoFrame), .QN(n114) );
  DFD1 \FrameReg_reg[40]  ( .D(BusIn[16]), .CP(DoFrame), .QN(n113) );
  DFD1 \FrameReg_reg[31]  ( .D(BusIn[15]), .CP(DoFrame), .QN(n112) );
  DFD1 \FrameReg_reg[30]  ( .D(BusIn[14]), .CP(DoFrame), .QN(n111) );
  DFD1 \FrameReg_reg[29]  ( .D(BusIn[13]), .CP(DoFrame), .QN(n110) );
  DFD1 \FrameReg_reg[28]  ( .D(BusIn[12]), .CP(DoFrame), .QN(n109) );
  DFD1 \FrameReg_reg[27]  ( .D(BusIn[11]), .CP(DoFrame), .QN(n108) );
  DFD1 \FrameReg_reg[26]  ( .D(BusIn[10]), .CP(DoFrame), .QN(n107) );
  DFD1 \FrameReg_reg[25]  ( .D(BusIn[9]), .CP(DoFrame), .QN(n106) );
  DFD1 \FrameReg_reg[24]  ( .D(BusIn[8]), .CP(DoFrame), .QN(n105) );
  DFD1 \FrameReg_reg[15]  ( .D(BusIn[7]), .CP(DoFrame), .QN(n104) );
  DFD1 \FrameReg_reg[14]  ( .D(BusIn[6]), .CP(DoFrame), .QN(n103) );
  DFD1 \FrameReg_reg[13]  ( .D(BusIn[5]), .CP(DoFrame), .QN(n102) );
  DFD1 \FrameReg_reg[12]  ( .D(BusIn[4]), .CP(DoFrame), .QN(n101) );
  DFD1 \FrameReg_reg[11]  ( .D(BusIn[3]), .CP(DoFrame), .QN(n100) );
  DFD1 \FrameReg_reg[10]  ( .D(BusIn[2]), .CP(DoFrame), .QN(n99) );
  DFD1 \FrameReg_reg[9]  ( .D(BusIn[1]), .CP(DoFrame), .QN(n98) );
  DFD1 \FrameReg_reg[8]  ( .D(BusIn[0]), .CP(DoFrame), .QN(n97) );
  CKBD0 U35 ( .CLK(n113), .C(n33) );
  CKNXD16 U36 ( .I(n33), .ZN(FrameOut[40]) );
  CKBD0 U37 ( .CLK(n114), .C(n35) );
  CKNXD16 U38 ( .I(n35), .ZN(FrameOut[41]) );
  CKBD0 U39 ( .CLK(n112), .C(n37) );
  CKNXD16 U40 ( .I(n37), .ZN(FrameOut[31]) );
  CKBD0 U41 ( .CLK(n115), .C(n39) );
  CKNXD16 U42 ( .I(n39), .ZN(FrameOut[42]) );
  CKBD0 U43 ( .CLK(n111), .C(n41) );
  CKNXD16 U44 ( .I(n41), .ZN(FrameOut[30]) );
  CKBD0 U45 ( .CLK(n116), .C(n43) );
  CKNXD16 U46 ( .I(n43), .ZN(FrameOut[43]) );
  CKBD0 U47 ( .CLK(n110), .C(n45) );
  CKNXD16 U48 ( .I(n45), .ZN(FrameOut[29]) );
  CKBD0 U49 ( .CLK(n117), .C(n47) );
  CKNXD16 U50 ( .I(n47), .ZN(FrameOut[44]) );
  CKBD0 U51 ( .CLK(n109), .C(n49) );
  CKNXD16 U52 ( .I(n49), .ZN(FrameOut[28]) );
  CKBD0 U53 ( .CLK(n118), .C(n51) );
  CKNXD16 U54 ( .I(n51), .ZN(FrameOut[45]) );
  CKBD0 U55 ( .CLK(n108), .C(n53) );
  CKNXD16 U56 ( .I(n53), .ZN(FrameOut[27]) );
  CKBD0 U57 ( .CLK(n119), .C(n55) );
  CKNXD16 U58 ( .I(n55), .ZN(FrameOut[46]) );
  CKBD0 U59 ( .CLK(n107), .C(n57) );
  CKNXD16 U60 ( .I(n57), .ZN(FrameOut[26]) );
  CKBD0 U61 ( .CLK(n120), .C(n59) );
  CKNXD16 U62 ( .I(n59), .ZN(FrameOut[47]) );
  CKBD0 U63 ( .CLK(n106), .C(n61) );
  CKNXD16 U64 ( .I(n61), .ZN(FrameOut[25]) );
  CKBD0 U65 ( .CLK(n121), .C(n63) );
  CKNXD16 U66 ( .I(n63), .ZN(FrameOut[56]) );
  CKBD0 U67 ( .CLK(n105), .C(n65) );
  CKNXD16 U68 ( .I(n65), .ZN(FrameOut[24]) );
  CKBD0 U69 ( .CLK(n122), .C(n67) );
  CKNXD16 U70 ( .I(n67), .ZN(FrameOut[57]) );
  CKBD0 U71 ( .CLK(n104), .C(n69) );
  CKNXD16 U72 ( .I(n69), .ZN(FrameOut[15]) );
  CKBD0 U73 ( .CLK(n123), .C(n71) );
  CKNXD16 U74 ( .I(n71), .ZN(FrameOut[58]) );
  CKBD0 U75 ( .CLK(n103), .C(n73) );
  CKNXD16 U76 ( .I(n73), .ZN(FrameOut[14]) );
  CKBD0 U77 ( .CLK(n124), .C(n75) );
  CKNXD16 U78 ( .I(n75), .ZN(FrameOut[59]) );
  CKBD0 U79 ( .CLK(n102), .C(n77) );
  CKNXD16 U80 ( .I(n77), .ZN(FrameOut[13]) );
  CKBD0 U81 ( .CLK(n125), .C(n79) );
  CKNXD16 U82 ( .I(n79), .ZN(FrameOut[60]) );
  CKBD0 U83 ( .CLK(n101), .C(n81) );
  CKNXD16 U84 ( .I(n81), .ZN(FrameOut[12]) );
  CKBD0 U85 ( .CLK(n126), .C(n83) );
  CKNXD16 U86 ( .I(n83), .ZN(FrameOut[61]) );
  CKBD0 U87 ( .CLK(n100), .C(n85) );
  CKNXD16 U88 ( .I(n85), .ZN(FrameOut[11]) );
  CKBD0 U89 ( .CLK(n127), .C(n87) );
  CKNXD16 U90 ( .I(n87), .ZN(FrameOut[62]) );
  CKBD0 U91 ( .CLK(n99), .C(n89) );
  CKNXD16 U92 ( .I(n89), .ZN(FrameOut[10]) );
  CKBD0 U93 ( .CLK(n97), .C(n91) );
  CKNXD16 U94 ( .I(n91), .ZN(FrameOut[8]) );
  CKBD0 U95 ( .CLK(n98), .C(n93) );
  CKNXD16 U96 ( .I(n93), .ZN(FrameOut[9]) );
  CKBD0 U97 ( .CLK(n128), .C(n95) );
  CKNXD16 U98 ( .I(n95), .ZN(FrameOut[63]) );
  TIEL U99 ( .ZN(FrameOut[0]) );
  TIEL U100 ( .ZN(FrameOut[1]) );
  TIEL U101 ( .ZN(FrameOut[2]) );
  TIEL U102 ( .ZN(FrameOut[3]) );
  TIEL U103 ( .ZN(FrameOut[4]) );
  TIEL U104 ( .ZN(FrameOut[5]) );
  TIEL U105 ( .ZN(FrameOut[6]) );
  TIEL U106 ( .ZN(FrameOut[7]) );
  TIEL U107 ( .ZN(FrameOut[16]) );
  TIEL U108 ( .ZN(FrameOut[17]) );
  TIEL U109 ( .ZN(FrameOut[18]) );
  TIEH U110 ( .Z(FrameOut[19]) );
  TIEL U111 ( .ZN(FrameOut[20]) );
  TIEL U112 ( .ZN(FrameOut[21]) );
  TIEL U113 ( .ZN(FrameOut[22]) );
  TIEL U114 ( .ZN(FrameOut[23]) );
  TIEL U115 ( .ZN(FrameOut[32]) );
  TIEL U116 ( .ZN(FrameOut[33]) );
  TIEL U117 ( .ZN(FrameOut[34]) );
  TIEL U118 ( .ZN(FrameOut[35]) );
  TIEH U119 ( .Z(FrameOut[36]) );
  TIEL U120 ( .ZN(FrameOut[37]) );
  TIEL U121 ( .ZN(FrameOut[38]) );
  TIEL U122 ( .ZN(FrameOut[39]) );
  TIEL U123 ( .ZN(FrameOut[48]) );
  TIEL U124 ( .ZN(FrameOut[49]) );
  TIEL U125 ( .ZN(FrameOut[50]) );
  TIEH U126 ( .Z(FrameOut[51]) );
  TIEH U127 ( .Z(FrameOut[52]) );
  TIEL U128 ( .ZN(FrameOut[53]) );
  TIEL U129 ( .ZN(FrameOut[54]) );
  TIEL U130 ( .ZN(FrameOut[55]) );
endmodule

