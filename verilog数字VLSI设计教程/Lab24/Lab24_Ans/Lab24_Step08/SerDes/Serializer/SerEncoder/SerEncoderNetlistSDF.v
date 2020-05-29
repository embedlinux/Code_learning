`timescale 1ns/1ps

module SerEncoder ( SerOut, SerValid, FIFO_ReadReq, ParIn, F_Empty, ParClk, 
        SerClk, ParValid, Reset );
  input [31:0] ParIn;
  input F_Empty, ParClk, SerClk, ParValid, Reset;
  output SerOut, SerValid, FIFO_ReadReq;
  wire   N2, N3, N4, N5, N6, n201, n202, HalfParClkr, \Sh_N[5] , N8, N9, N10,
         N11, N12, N13, N23, N24, N25, N26, N27, N28, N29, N31, N53, N54, N55,
         N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, N67, N68, N69,
         N70, N71, N72, N73, N74, N75, N76, N77, N78, N79, N80, N81, N82, N83,
         N84, N85, n34, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         n156, n158, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200;
  wire   [31:0] InBuf;

initial $sdf_annotate("SerEncoderNetlist.sdf");

  SerEncoder_DW01_dec_0 \ShifterBlock/sub_130  ( .A({n66, n79, n100, n101, 
        n112, n125}), .SUM({N13, N12, N11, N10, N9, N8}) );
  DFCNQD1 HalfParClkr_reg ( .D(n51), .CP(ParClk), .CDN(n172), .Q(HalfParClkr)
         );
  DFCNQD1 SerValidr_reg ( .D(n176), .CP(n179), .CDN(n172), .Q(n202) );
  DFCNQD1 \InBuf_reg[30]  ( .D(N83), .CP(n181), .CDN(n173), .Q(InBuf[30]) );
  DFCNQD1 \InBuf_reg[29]  ( .D(N82), .CP(n181), .CDN(n172), .Q(InBuf[29]) );
  DFCNQD1 \InBuf_reg[26]  ( .D(N79), .CP(n181), .CDN(n173), .Q(InBuf[26]) );
  DFCNQD1 \InBuf_reg[25]  ( .D(N78), .CP(n181), .CDN(n34), .Q(InBuf[25]) );
  DFCNQD1 \InBuf_reg[22]  ( .D(N75), .CP(n181), .CDN(n173), .Q(InBuf[22]) );
  DFCNQD1 \InBuf_reg[21]  ( .D(N74), .CP(n181), .CDN(n34), .Q(InBuf[21]) );
  DFCNQD1 \InBuf_reg[18]  ( .D(N71), .CP(n180), .CDN(n173), .Q(InBuf[18]) );
  DFCNQD1 \InBuf_reg[17]  ( .D(N70), .CP(n180), .CDN(n34), .Q(InBuf[17]) );
  DFCNQD1 \InBuf_reg[14]  ( .D(N67), .CP(n180), .CDN(n173), .Q(InBuf[14]) );
  DFCNQD1 \InBuf_reg[13]  ( .D(N66), .CP(n180), .CDN(n172), .Q(InBuf[13]) );
  DFCNQD1 \InBuf_reg[10]  ( .D(N63), .CP(n180), .CDN(n172), .Q(InBuf[10]) );
  DFCNQD1 \InBuf_reg[9]  ( .D(N62), .CP(n179), .CDN(n173), .Q(InBuf[9]) );
  DFCNQD1 \InBuf_reg[6]  ( .D(N59), .CP(n179), .CDN(n173), .Q(InBuf[6]) );
  DFCNQD1 \InBuf_reg[5]  ( .D(N58), .CP(n179), .CDN(n173), .Q(InBuf[5]) );
  DFCNQD1 \InBuf_reg[2]  ( .D(N55), .CP(n179), .CDN(n173), .Q(InBuf[2]) );
  DFCNQD1 \InBuf_reg[1]  ( .D(N54), .CP(n179), .CDN(n172), .Q(InBuf[1]) );
  DFCNQD1 \InBuf_reg[31]  ( .D(N84), .CP(n181), .CDN(n34), .Q(InBuf[31]) );
  DFCNQD1 \InBuf_reg[28]  ( .D(N81), .CP(n181), .CDN(n34), .Q(InBuf[28]) );
  DFCNQD1 \InBuf_reg[27]  ( .D(N80), .CP(n181), .CDN(n34), .Q(InBuf[27]) );
  DFCNQD1 \InBuf_reg[24]  ( .D(N77), .CP(n181), .CDN(n34), .Q(InBuf[24]) );
  DFCNQD1 \InBuf_reg[23]  ( .D(N76), .CP(n181), .CDN(n34), .Q(InBuf[23]) );
  DFCNQD1 \InBuf_reg[20]  ( .D(N73), .CP(n180), .CDN(n173), .Q(InBuf[20]) );
  DFCNQD1 \InBuf_reg[19]  ( .D(N72), .CP(n180), .CDN(n173), .Q(InBuf[19]) );
  DFCNQD1 \InBuf_reg[16]  ( .D(N69), .CP(n180), .CDN(n173), .Q(InBuf[16]) );
  DFCNQD1 \InBuf_reg[15]  ( .D(N68), .CP(n180), .CDN(n173), .Q(InBuf[15]) );
  DFCNQD1 \InBuf_reg[12]  ( .D(N65), .CP(n180), .CDN(n173), .Q(InBuf[12]) );
  DFCNQD1 \InBuf_reg[11]  ( .D(N64), .CP(n180), .CDN(n173), .Q(InBuf[11]) );
  DFCNQD1 \InBuf_reg[8]  ( .D(N61), .CP(n179), .CDN(n173), .Q(InBuf[8]) );
  DFCNQD1 \InBuf_reg[7]  ( .D(N60), .CP(n179), .CDN(n173), .Q(InBuf[7]) );
  DFCNQD1 \InBuf_reg[4]  ( .D(N57), .CP(n179), .CDN(n173), .Q(InBuf[4]) );
  DFCNQD1 \InBuf_reg[3]  ( .D(N56), .CP(n179), .CDN(n173), .Q(InBuf[3]) );
  DFCNQD1 \InBuf_reg[0]  ( .D(N53), .CP(n179), .CDN(n172), .Q(InBuf[0]) );
  DFCNQD1 \Sh_N_reg[5]  ( .D(N13), .CP(SerClk), .CDN(n34), .Q(\Sh_N[5] ) );
  DFCNQD1 \Sh_N_reg[4]  ( .D(N12), .CP(SerClk), .CDN(n34), .Q(N6) );
  DFCNQD1 \Sh_N_reg[3]  ( .D(N11), .CP(SerClk), .CDN(n34), .Q(N5) );
  DFCNQD1 \Sh_N_reg[2]  ( .D(N10), .CP(SerClk), .CDN(n34), .Q(N4) );
  DFCNQD1 \Sh_N_reg[1]  ( .D(N9), .CP(SerClk), .CDN(n34), .Q(N3) );
  DFCNQD1 \Sh_N_reg[0]  ( .D(N8), .CP(SerClk), .CDN(n172), .Q(N2) );
  DFCNQD1 SerOutr_reg ( .D(n138), .CP(SerClk), .CDN(n34), .Q(n201) );
  MUX2ND0 U69 ( .I0(n166), .I1(n167), .S(n150), .ZN(n47) );
  MUX2ND0 U70 ( .I0(n162), .I1(n163), .S(n150), .ZN(n48) );
  CKND0 U71 ( .CLK(n65), .CN(n178) );
  MUX2ND0 U72 ( .I0(n164), .I1(n165), .S(n150), .ZN(n49) );
  MUX2ND0 U73 ( .I0(n160), .I1(n161), .S(n150), .ZN(n50) );
  INVD0 U74 ( .I(n178), .ZN(n177) );
  BUFFD0 U75 ( .I(n53), .Z(n51) );
  BUFFD0 U76 ( .I(n177), .Z(n52) );
  BUFFD0 U77 ( .I(n55), .Z(n53) );
  BUFFD0 U78 ( .I(n52), .Z(n54) );
  BUFFD0 U79 ( .I(n57), .Z(n55) );
  BUFFD0 U80 ( .I(n54), .Z(n56) );
  BUFFD0 U81 ( .I(n59), .Z(n57) );
  BUFFD0 U82 ( .I(HalfParClkr), .Z(n58) );
  BUFFD0 U83 ( .I(n61), .Z(n59) );
  BUFFD0 U84 ( .I(n56), .Z(n60) );
  BUFFD0 U85 ( .I(n182), .Z(n61) );
  BUFFD0 U86 ( .I(n60), .Z(n62) );
  BUFFD0 U87 ( .I(n58), .Z(n63) );
  BUFFD0 U88 ( .I(n62), .Z(n64) );
  BUFFD0 U89 ( .I(n63), .Z(n65) );
  BUFFD0 U90 ( .I(n67), .Z(n66) );
  BUFFD0 U91 ( .I(n68), .Z(n67) );
  BUFFD0 U92 ( .I(n69), .Z(n68) );
  BUFFD0 U93 ( .I(n70), .Z(n69) );
  BUFFD0 U94 ( .I(n71), .Z(n70) );
  BUFFD0 U95 ( .I(n72), .Z(n71) );
  BUFFD0 U96 ( .I(n73), .Z(n72) );
  BUFFD0 U97 ( .I(n75), .Z(n73) );
  BUFFD0 U98 ( .I(\Sh_N[5] ), .Z(n74) );
  BUFFD0 U99 ( .I(n76), .Z(n75) );
  BUFFD0 U100 ( .I(n78), .Z(n76) );
  BUFFD0 U101 ( .I(n74), .Z(n77) );
  BUFFD0 U102 ( .I(n152), .Z(n78) );
  CKBD0 U103 ( .CLK(n80), .C(n81) );
  BUFFD0 U104 ( .I(n84), .Z(n79) );
  BUFFD0 U105 ( .I(N6), .Z(n80) );
  BUFFD0 U106 ( .I(n81), .Z(n82) );
  BUFFD0 U107 ( .I(n82), .Z(n83) );
  BUFFD0 U108 ( .I(n86), .Z(n84) );
  BUFFD0 U109 ( .I(n83), .Z(n85) );
  BUFFD0 U110 ( .I(n87), .Z(n86) );
  BUFFD0 U111 ( .I(n89), .Z(n87) );
  BUFFD0 U112 ( .I(n85), .Z(n88) );
  BUFFD0 U113 ( .I(n151), .Z(n89) );
  BUFFD0 U114 ( .I(N5), .Z(n90) );
  BUFFD0 U115 ( .I(n90), .Z(n91) );
  BUFFD0 U116 ( .I(n91), .Z(n92) );
  BUFFD0 U117 ( .I(n92), .Z(n93) );
  BUFFD0 U118 ( .I(n93), .Z(n94) );
  BUFFD0 U119 ( .I(n94), .Z(n95) );
  BUFFD0 U120 ( .I(n95), .Z(n96) );
  BUFFD0 U121 ( .I(n96), .Z(n97) );
  BUFFD0 U122 ( .I(n97), .Z(n98) );
  BUFFD0 U123 ( .I(n98), .Z(n99) );
  BUFFD0 U124 ( .I(n153), .Z(n100) );
  CKBD0 U125 ( .CLK(n107), .C(n110) );
  BUFFD0 U126 ( .I(n102), .Z(n101) );
  BUFFD0 U127 ( .I(n103), .Z(n102) );
  BUFFD0 U128 ( .I(n104), .Z(n103) );
  BUFFD0 U129 ( .I(n106), .Z(n104) );
  BUFFD0 U130 ( .I(N4), .Z(n105) );
  BUFFD0 U131 ( .I(n108), .Z(n106) );
  BUFFD0 U132 ( .I(n105), .Z(n107) );
  BUFFD0 U133 ( .I(n109), .Z(n108) );
  BUFFD0 U134 ( .I(n111), .Z(n109) );
  BUFFD0 U135 ( .I(n150), .Z(n111) );
  CKBXD0 U136 ( .I(n110), .Z(n150) );
  BUFFD0 U137 ( .I(n113), .Z(n112) );
  BUFFD0 U138 ( .I(n114), .Z(n113) );
  BUFFD0 U139 ( .I(n115), .Z(n114) );
  BUFFD0 U140 ( .I(n116), .Z(n115) );
  BUFFD0 U141 ( .I(n117), .Z(n116) );
  BUFFD0 U142 ( .I(n118), .Z(n117) );
  BUFFD0 U143 ( .I(n119), .Z(n118) );
  BUFFD0 U144 ( .I(n120), .Z(n119) );
  BUFFD0 U145 ( .I(n121), .Z(n120) );
  BUFFD0 U146 ( .I(n122), .Z(n121) );
  BUFFD0 U147 ( .I(n123), .Z(n122) );
  BUFFD0 U148 ( .I(n124), .Z(n123) );
  BUFFD0 U149 ( .I(N3), .Z(n124) );
  BUFFD0 U150 ( .I(n126), .Z(n125) );
  BUFFD0 U151 ( .I(n127), .Z(n126) );
  BUFFD0 U152 ( .I(n128), .Z(n127) );
  BUFFD0 U153 ( .I(n129), .Z(n128) );
  BUFFD0 U154 ( .I(n130), .Z(n129) );
  BUFFD0 U155 ( .I(n131), .Z(n130) );
  BUFFD0 U156 ( .I(n132), .Z(n131) );
  BUFFD0 U157 ( .I(n133), .Z(n132) );
  BUFFD0 U158 ( .I(n134), .Z(n133) );
  BUFFD0 U159 ( .I(n135), .Z(n134) );
  BUFFD0 U160 ( .I(n136), .Z(n135) );
  BUFFD0 U161 ( .I(n137), .Z(n136) );
  BUFFD0 U162 ( .I(N2), .Z(n137) );
  BUFFD0 U163 ( .I(n140), .Z(n138) );
  BUFFD0 U164 ( .I(N31), .Z(n139) );
  BUFFD0 U165 ( .I(n141), .Z(n140) );
  BUFFD0 U166 ( .I(n142), .Z(n141) );
  BUFFD0 U167 ( .I(n143), .Z(n142) );
  BUFFD0 U168 ( .I(n144), .Z(n143) );
  BUFFD0 U169 ( .I(n145), .Z(n144) );
  BUFFD0 U170 ( .I(n146), .Z(n145) );
  BUFFD0 U171 ( .I(n147), .Z(n146) );
  BUFFD0 U172 ( .I(n148), .Z(n147) );
  BUFFD0 U173 ( .I(n149), .Z(n148) );
  BUFFD0 U174 ( .I(n139), .Z(n149) );
  CKBXD0 U175 ( .I(n88), .Z(n151) );
  CKBD0 U176 ( .CLK(n77), .C(n152) );
  CKBD0 U177 ( .CLK(n99), .C(n153) );
  CKBD0 U178 ( .CLK(n174), .C(n154) );
  CKNXD16 U179 ( .I(n154), .ZN(SerValid) );
  CKBD0 U180 ( .CLK(n175), .C(n156) );
  CKNXD16 U181 ( .I(n156), .ZN(SerOut) );
  ND3D0 U182 ( .A1(N85), .A2(n172), .A3(HalfParClkr), .ZN(n158) );
  INVD1 U183 ( .I(Reset), .ZN(n173) );
  CKND16 U184 ( .CLK(n158), .CN(FIFO_ReadReq) );
  INVD1 U185 ( .I(Reset), .ZN(n172) );
  INVD1 U186 ( .I(n182), .ZN(n179) );
  INVD1 U187 ( .I(n184), .ZN(n183) );
  INVD1 U188 ( .I(n64), .ZN(n182) );
  INVD1 U189 ( .I(n178), .ZN(n180) );
  INVD1 U190 ( .I(n178), .ZN(n181) );
  BUFFD1 U191 ( .I(N85), .Z(n176) );
  INR2D1 U192 ( .A1(ParValid), .B1(F_Empty), .ZN(N85) );
  ND2D1 U193 ( .A1(N3), .A2(N2), .ZN(n185) );
  AN2D1 U194 ( .A1(n150), .A2(n183), .Z(N26) );
  MUX4ND0 U195 ( .I0(InBuf[8]), .I1(InBuf[9]), .I2(InBuf[10]), .I3(InBuf[11]), 
        .S0(N2), .S1(N3), .ZN(n160) );
  MUX4ND0 U196 ( .I0(InBuf[12]), .I1(InBuf[13]), .I2(InBuf[14]), .I3(InBuf[15]), .S0(N2), .S1(N3), .ZN(n161) );
  MUX4ND0 U197 ( .I0(InBuf[16]), .I1(InBuf[17]), .I2(InBuf[18]), .I3(InBuf[19]), .S0(N2), .S1(N3), .ZN(n162) );
  MUX4ND0 U198 ( .I0(InBuf[20]), .I1(InBuf[21]), .I2(InBuf[22]), .I3(InBuf[23]), .S0(N2), .S1(N3), .ZN(n163) );
  MUX4ND0 U199 ( .I0(InBuf[24]), .I1(InBuf[25]), .I2(InBuf[26]), .I3(InBuf[27]), .S0(N2), .S1(N3), .ZN(n164) );
  MUX4ND0 U200 ( .I0(InBuf[28]), .I1(InBuf[29]), .I2(InBuf[30]), .I3(InBuf[31]), .S0(N2), .S1(N3), .ZN(n165) );
  MUX4ND0 U201 ( .I0(InBuf[0]), .I1(InBuf[1]), .I2(InBuf[2]), .I3(InBuf[3]), 
        .S0(N2), .S1(N3), .ZN(n166) );
  MUX4ND0 U202 ( .I0(InBuf[4]), .I1(InBuf[5]), .I2(InBuf[6]), .I3(InBuf[7]), 
        .S0(N2), .S1(N3), .ZN(n167) );
  NR2D1 U203 ( .A1(n185), .A2(n150), .ZN(N24) );
  MUX2ND0 U204 ( .I0(n168), .I1(n169), .S(n151), .ZN(N29) );
  MUX2ND0 U205 ( .I0(n170), .I1(n171), .S(n151), .ZN(N27) );
  MUX2ND0 U206 ( .I0(n169), .I1(n168), .S(n151), .ZN(N25) );
  MUX2ND0 U207 ( .I0(n171), .I1(n170), .S(n151), .ZN(N23) );
  MUX2ND0 U208 ( .I0(n48), .I1(n49), .S(n153), .ZN(n169) );
  MUX2ND0 U209 ( .I0(n47), .I1(n50), .S(n153), .ZN(n168) );
  MUX2ND0 U210 ( .I0(n49), .I1(n47), .S(n153), .ZN(n171) );
  MUX2ND0 U211 ( .I0(n50), .I1(n48), .S(n153), .ZN(n170) );
  CKND0 U212 ( .CLK(n202), .CN(n174) );
  CKND0 U213 ( .CLK(n201), .CN(n175) );
  OR2D1 U214 ( .A1(N2), .A2(N3), .Z(n184) );
  MUX2ND0 U215 ( .I0(n185), .I1(n184), .S(n150), .ZN(N28) );
  CKND0 U216 ( .CLK(Reset), .CN(n34) );
  AN2D0 U217 ( .A1(ParIn[31]), .A2(N85), .Z(N84) );
  AN2D0 U218 ( .A1(ParIn[30]), .A2(n176), .Z(N83) );
  AN2D0 U219 ( .A1(ParIn[29]), .A2(n176), .Z(N82) );
  AN2D0 U220 ( .A1(ParIn[28]), .A2(n176), .Z(N81) );
  AN2D0 U221 ( .A1(ParIn[27]), .A2(n176), .Z(N80) );
  AN2D0 U222 ( .A1(ParIn[26]), .A2(n176), .Z(N79) );
  AN2D0 U223 ( .A1(ParIn[25]), .A2(n176), .Z(N78) );
  AN2D0 U224 ( .A1(ParIn[24]), .A2(n176), .Z(N77) );
  AN2D0 U225 ( .A1(ParIn[23]), .A2(n176), .Z(N76) );
  AN2D0 U226 ( .A1(ParIn[22]), .A2(n176), .Z(N75) );
  AN2D0 U227 ( .A1(ParIn[21]), .A2(n176), .Z(N74) );
  AN2D0 U228 ( .A1(ParIn[20]), .A2(n176), .Z(N73) );
  AN2D0 U229 ( .A1(ParIn[19]), .A2(N85), .Z(N72) );
  AN2D0 U230 ( .A1(ParIn[18]), .A2(n176), .Z(N71) );
  AN2D0 U231 ( .A1(ParIn[17]), .A2(n176), .Z(N70) );
  AN2D0 U232 ( .A1(ParIn[16]), .A2(n176), .Z(N69) );
  AN2D0 U233 ( .A1(ParIn[15]), .A2(N85), .Z(N68) );
  AN2D0 U234 ( .A1(ParIn[14]), .A2(N85), .Z(N67) );
  AN2D0 U235 ( .A1(ParIn[13]), .A2(N85), .Z(N66) );
  AN2D0 U236 ( .A1(ParIn[12]), .A2(N85), .Z(N65) );
  AN2D0 U237 ( .A1(ParIn[11]), .A2(N85), .Z(N64) );
  AN2D0 U238 ( .A1(ParIn[10]), .A2(N85), .Z(N63) );
  AN2D0 U239 ( .A1(ParIn[9]), .A2(N85), .Z(N62) );
  AN2D0 U240 ( .A1(ParIn[8]), .A2(N85), .Z(N61) );
  AN2D0 U241 ( .A1(ParIn[7]), .A2(N85), .Z(N60) );
  AN2D0 U242 ( .A1(ParIn[6]), .A2(N85), .Z(N59) );
  AN2D0 U243 ( .A1(ParIn[5]), .A2(N85), .Z(N58) );
  AN2D0 U244 ( .A1(ParIn[4]), .A2(N85), .Z(N57) );
  AN2D0 U245 ( .A1(ParIn[3]), .A2(N85), .Z(N56) );
  AN2D0 U246 ( .A1(ParIn[2]), .A2(N85), .Z(N55) );
  AN2D0 U247 ( .A1(ParIn[1]), .A2(N85), .Z(N54) );
  AN2D0 U248 ( .A1(ParIn[0]), .A2(n176), .Z(N53) );
  IND2D0 U249 ( .A1(n186), .B1(n187), .ZN(N31) );
  OAI21D0 U250 ( .A1(N23), .A2(n188), .B(n189), .ZN(n187) );
  MUX2ND0 U251 ( .I0(n190), .I1(n191), .S(n188), .ZN(n189) );
  MUX3ND0 U252 ( .I0(N25), .I1(n192), .I2(N24), .S0(n152), .S1(n193), .ZN(n191) );
  NR2D0 U253 ( .A1(n152), .A2(n153), .ZN(n193) );
  MUX2D0 U254 ( .I0(n194), .I1(N26), .S(n195), .Z(n192) );
  NR2D0 U255 ( .A1(n151), .A2(n153), .ZN(n195) );
  INR2D0 U256 ( .A1(N27), .B1(n151), .ZN(n194) );
  CKND0 U257 ( .CLK(n153), .CN(n190) );
  CKND2D0 U258 ( .A1(n196), .A2(n197), .ZN(n188) );
  MUX2ND0 U259 ( .I0(n198), .I1(n199), .S(n153), .ZN(n186) );
  CKND2D0 U260 ( .A1(N29), .A2(n200), .ZN(n199) );
  CKND2D0 U261 ( .A1(N28), .A2(n200), .ZN(n198) );
  NR2D0 U262 ( .A1(n197), .A2(n196), .ZN(n200) );
  CKND0 U263 ( .CLK(n151), .CN(n196) );
  CKND0 U264 ( .CLK(n152), .CN(n197) );
endmodule


module SerEncoder_DW01_dec_0 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   n11, n12, n13, n14, n4, n6, n7, n8, n9, n10;

  BUFFD0 U1 ( .I(n11), .Z(SUM[5]) );
  XOR2D0 U2 ( .A1(A[5]), .A2(n6), .Z(n11) );
  BUFFD0 U3 ( .I(n12), .Z(SUM[3]) );
  BUFFD0 U4 ( .I(n4), .Z(SUM[1]) );
  BUFFD0 U5 ( .I(n13), .Z(n4) );
  BUFFD0 U6 ( .I(n14), .Z(SUM[0]) );
  NR2D0 U7 ( .A1(A[4]), .A2(n7), .ZN(n6) );
  XNR2D0 U8 ( .A1(n7), .A2(A[4]), .ZN(SUM[4]) );
  OAI21D0 U9 ( .A1(n8), .A2(n9), .B(n7), .ZN(n12) );
  CKND2D0 U10 ( .A1(n8), .A2(n9), .ZN(n7) );
  CKND0 U11 ( .CLK(A[3]), .CN(n9) );
  AO21D0 U12 ( .A1(n10), .A2(A[2]), .B(n8), .Z(SUM[2]) );
  NR2D0 U13 ( .A1(n10), .A2(A[2]), .ZN(n8) );
  IOA21D0 U14 ( .A1(A[0]), .A2(A[1]), .B(n10), .ZN(n13) );
  IND2D0 U15 ( .A1(A[1]), .B1(SUM[0]), .ZN(n10) );
  CKND0 U16 ( .CLK(A[0]), .CN(n14) );
endmodule

