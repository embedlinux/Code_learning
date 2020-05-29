
module FIFOStateM ( ReadAddr, WriteAddr, EmptyFIFO, FullFIFO, ReadCmd, 
        WriteCmd, ReadReq, WriteReq, Clk, Reset );
  output [4:0] ReadAddr;
  output [4:0] WriteAddr;
  input ReadReq, WriteReq, Clk, Reset;
  output EmptyFIFO, FullFIFO, ReadCmd, WriteCmd;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, n192, n193, n194, n195,
         \CurState[1] , N72, N73, N74, N75, N76, N88, N89, N90, N91, N92, N93,
         N106, N107, N108, N109, N110, N111, N124, N125, N126, N127, N128,
         N144, N146, N148, N150, N152, N155, N158, N161, N164, N167, N169,
         N172, N175, N178, N181, N184, N186, N187, N190, N191, N200, N201,
         N202, N211, N212, N213, N214, N217, N220, N223, N226, N229, N232,
         N235, N238, N241, n2, \U3/U1/Z_0 , \U3/U1/Z_1 , \U3/U1/Z_2 ,
         \U3/U1/Z_3 , \U3/U1/Z_4 , n87, n88, n89, n90, n91, n92, n93, n94, n95,
         n96, n97, n100, n101, n103, n105, n107, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n154, n155, n156, n157, n158,
         n159, n160, n161, n162, n163, n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191;
  wire   [2:0] NextState;

  LHQD1 \WriteCount_tri_enable_reg[0]  ( .E(N200), .D(N201), .Q(N9) );
  LHQD1 \NextState_reg[0]  ( .E(N190), .D(N144), .Q(NextState[0]) );
  LHQD1 \WriteCount_reg[1]  ( .E(N200), .D(N155), .Q(N238) );
  LHQD1 \ReadCount_reg[1]  ( .E(N211), .D(N172), .Q(N223) );
  LHQD1 \WriteCount_reg[4]  ( .E(N200), .D(N164), .Q(N229) );
  LHQD1 \ReadCount_reg[4]  ( .E(N211), .D(N181), .Q(N214) );
  LHQD1 \NextState_reg[1]  ( .E(N190), .D(N146), .Q(NextState[1]) );
  LHQD1 \NextState_reg[2]  ( .E(N190), .D(N148), .Q(NextState[2]) );
  LHQD1 \ReadCount_tri_enable_reg[4]  ( .E(N211), .D(N212), .Q(N0) );
  LHQD1 \ReadCount_tri_enable_reg[2]  ( .E(N211), .D(N212), .Q(N2) );
  LHQD1 \ReadCount_tri_enable_reg[0]  ( .E(N211), .D(N212), .Q(N4) );
  LHQD1 \ReadCount_tri_enable_reg[1]  ( .E(N211), .D(N212), .Q(N3) );
  LHQD1 \ReadCount_tri_enable_reg[3]  ( .E(N211), .D(N212), .Q(N1) );
  LHQD1 \WriteCount_tri_enable_reg[4]  ( .E(N200), .D(N201), .Q(N5) );
  LHQD1 \WriteCount_tri_enable_reg[2]  ( .E(N200), .D(N201), .Q(N7) );
  LHQD1 \WriteCount_tri_enable_reg[1]  ( .E(N200), .D(N201), .Q(N8) );
  LHQD1 \WriteCount_tri_enable_reg[3]  ( .E(N200), .D(N201), .Q(N6) );
  LHQD1 \ReadCount_reg[2]  ( .E(N211), .D(N175), .Q(N220) );
  LHQD1 \WriteCount_reg[2]  ( .E(N200), .D(N158), .Q(N235) );
  LHQD1 \WriteCount_reg[3]  ( .E(N200), .D(N161), .Q(N232) );
  LHQD1 \ReadCount_reg[3]  ( .E(N211), .D(N178), .Q(N217) );
  LHQD1 \ReadCount_reg[0]  ( .E(N211), .D(N169), .Q(N226) );
  LHQD1 \WriteCount_reg[0]  ( .E(N200), .D(N152), .Q(N241) );
  FIFOStateM_DW01_inc_0 add_199 ( .A({n2, N76, N75, N74, N73, N72}), .SUM({N93, 
        N92, N91, N90, N89, N88}) );
  FIFOStateM_DW01_inc_1 r147 ( .A({n113, n116, n121, n114, n122}), .SUM({N76, 
        N75, N74, N73, N72}) );
  FIFOStateM_DW01_inc_2 add_211 ( .A({n2, N128, N127, N126, N125, N124}), 
        .SUM({N111, N110, N109, N108, N107, N106}) );
  FIFOStateM_DW01_inc_3 r133 ( .A({\U3/U1/Z_4 , \U3/U1/Z_3 , \U3/U1/Z_2 , 
        \U3/U1/Z_1 , \U3/U1/Z_0 }), .SUM({N128, N127, N126, N125, N124}) );
  DFCNQD1 \CurState_reg[1]  ( .D(NextState[1]), .CP(Clk), .CDN(n97), .Q(
        \CurState[1] ) );
  DFCND1 \CurState_reg[2]  ( .D(NextState[2]), .CP(Clk), .CDN(n97), .Q(n190), 
        .QN(n100) );
  DFCND1 \CurState_reg[0]  ( .D(NextState[0]), .CP(Clk), .CDN(n97), .Q(n191)
         );
  BUFTD16 \WriteCount_tri[0]  ( .I(N241), .OE(n96), .Z(WriteAddr[0]) );
  BUFTD16 \WriteCount_tri[2]  ( .I(N235), .OE(n94), .Z(WriteAddr[2]) );
  BUFTD16 \ReadCount_tri[4]  ( .I(N214), .OE(n87), .Z(ReadAddr[4]) );
  BUFTD16 \ReadCount_tri[0]  ( .I(N226), .OE(n91), .Z(ReadAddr[0]) );
  BUFTD16 \ReadCount_tri[3]  ( .I(N217), .OE(n88), .Z(ReadAddr[3]) );
  BUFTD16 \ReadCount_tri[2]  ( .I(N220), .OE(n89), .Z(ReadAddr[2]) );
  BUFTD16 \WriteCount_tri[3]  ( .I(N232), .OE(n93), .Z(WriteAddr[3]) );
  BUFTD16 \ReadCount_tri[1]  ( .I(N223), .OE(n90), .Z(ReadAddr[1]) );
  BUFTD16 \WriteCount_tri[1]  ( .I(N238), .OE(n95), .Z(WriteAddr[1]) );
  BUFTD16 \WriteCount_tri[4]  ( .I(N229), .OE(n92), .Z(WriteAddr[4]) );
  LHQD2 EmptyFIFOReg_reg ( .E(N213), .D(N184), .Q(n192) );
  LHQD2 WriteCmdReg_reg ( .E(N202), .D(N167), .Q(n195) );
  LHQD2 FullFIFOReg_reg ( .E(N191), .D(N150), .Q(n193) );
  LHQD2 ReadCmdReg_reg ( .E(N187), .D(N186), .Q(n194) );
  AOI31D0 U116 ( .A1(n154), .A2(n173), .A3(n139), .B(n152), .ZN(n126) );
  ND3D1 U117 ( .A1(n100), .A2(n191), .A3(\CurState[1] ), .ZN(n173) );
  OAI21D1 U118 ( .A1(n175), .A2(n137), .B(n158), .ZN(n157) );
  INVD1 U119 ( .I(N8), .ZN(n95) );
  INVD1 U120 ( .I(N6), .ZN(n93) );
  INVD1 U121 ( .I(N7), .ZN(n94) );
  CKBD0 U122 ( .CLK(n110), .C(n101) );
  CKNXD16 U123 ( .I(n101), .ZN(FullFIFO) );
  CKBD0 U124 ( .CLK(n112), .C(n103) );
  CKNXD16 U125 ( .I(n103), .ZN(EmptyFIFO) );
  CKBD0 U126 ( .CLK(n111), .C(n105) );
  CKNXD16 U127 ( .I(n105), .ZN(WriteCmd) );
  CKBD0 U128 ( .CLK(n109), .C(n107) );
  CKNXD16 U129 ( .I(n107), .ZN(ReadCmd) );
  CKND0 U130 ( .CLK(n194), .CN(n109) );
  CKND0 U131 ( .CLK(n193), .CN(n110) );
  CKND0 U132 ( .CLK(n195), .CN(n111) );
  CKND0 U133 ( .CLK(n192), .CN(n112) );
  CKND0 U134 ( .CLK(N4), .CN(n91) );
  CKND0 U135 ( .CLK(N2), .CN(n89) );
  BUFFD0 U136 ( .I(WriteAddr[4]), .Z(n113) );
  INVD0 U137 ( .I(n113), .ZN(n125) );
  AOI21D1 U138 ( .A1(n133), .A2(n142), .B(Clk), .ZN(N211) );
  BUFFD1 U139 ( .I(WriteAddr[1]), .Z(n114) );
  INVD0 U140 ( .I(n114), .ZN(n129) );
  BUFFD1 U141 ( .I(ReadAddr[1]), .Z(n115) );
  BUFFD1 U142 ( .I(WriteAddr[3]), .Z(n116) );
  INVD0 U143 ( .I(n116), .ZN(n127) );
  BUFFD1 U144 ( .I(ReadAddr[2]), .Z(n117) );
  BUFFD1 U145 ( .I(ReadAddr[3]), .Z(n118) );
  BUFFD1 U146 ( .I(ReadAddr[0]), .Z(n119) );
  XOR2D0 U147 ( .A1(n119), .A2(N88), .Z(n181) );
  BUFFD1 U148 ( .I(ReadAddr[4]), .Z(n120) );
  XOR2D0 U149 ( .A1(n120), .A2(N92), .Z(n180) );
  BUFFD1 U150 ( .I(WriteAddr[2]), .Z(n121) );
  XOR2D0 U151 ( .A1(n121), .A2(N108), .Z(n186) );
  INVD0 U152 ( .I(n121), .ZN(n128) );
  BUFFD1 U153 ( .I(WriteAddr[0]), .Z(n122) );
  XOR2D0 U154 ( .A1(n122), .A2(N106), .Z(n185) );
  INVD0 U155 ( .I(n122), .ZN(n130) );
  TIEL U156 ( .ZN(n2) );
  CKND0 U157 ( .CLK(N9), .CN(n96) );
  CKND0 U158 ( .CLK(N5), .CN(n92) );
  CKND0 U159 ( .CLK(N3), .CN(n90) );
  CKND0 U160 ( .CLK(N1), .CN(n88) );
  CKND0 U161 ( .CLK(N0), .CN(n87) );
  IOA22D0 U162 ( .B1(n124), .B2(n125), .A1(n126), .A2(n120), .ZN(\U3/U1/Z_4 )
         );
  IOA22D0 U163 ( .B1(n124), .B2(n127), .A1(n126), .A2(n118), .ZN(\U3/U1/Z_3 )
         );
  IOA22D0 U164 ( .B1(n124), .B2(n128), .A1(n126), .A2(n117), .ZN(\U3/U1/Z_2 )
         );
  IOA22D0 U165 ( .B1(n124), .B2(n129), .A1(n126), .A2(n115), .ZN(\U3/U1/Z_1 )
         );
  IOA22D0 U166 ( .B1(n124), .B2(n130), .A1(n126), .A2(n119), .ZN(\U3/U1/Z_0 )
         );
  CKND2D0 U167 ( .A1(n131), .A2(n97), .ZN(n124) );
  AOI21D0 U168 ( .A1(n132), .A2(n133), .B(Clk), .ZN(N213) );
  INR2D0 U169 ( .A1(N184), .B1(Clk), .ZN(N212) );
  AOI31D0 U170 ( .A1(n134), .A2(n135), .A3(n136), .B(Clk), .ZN(N202) );
  CKND0 U171 ( .CLK(N186), .CN(n135) );
  CKND2D0 U172 ( .A1(n137), .A2(n138), .ZN(n134) );
  INR2D0 U173 ( .A1(N150), .B1(Clk), .ZN(N201) );
  AOI21D0 U174 ( .A1(n136), .A2(n139), .B(Clk), .ZN(N200) );
  AOI21D0 U175 ( .A1(n140), .A2(n141), .B(Clk), .ZN(N191) );
  AOI31D0 U176 ( .A1(n136), .A2(n142), .A3(n143), .B(Clk), .ZN(N190) );
  NR2D0 U177 ( .A1(n144), .A2(n145), .ZN(n143) );
  MUX2ND0 U178 ( .I0(n146), .I1(n191), .S(n190), .ZN(n145) );
  CKND2D0 U179 ( .A1(n191), .A2(n147), .ZN(n146) );
  INR3D0 U180 ( .A1(n141), .B1(n148), .B2(n131), .ZN(n136) );
  CKND2D0 U181 ( .A1(n149), .A2(Reset), .ZN(n141) );
  IND2D0 U182 ( .A1(N211), .B1(n150), .ZN(N187) );
  OAI21D0 U183 ( .A1(n148), .A2(n144), .B(n151), .ZN(n150) );
  CKND0 U184 ( .CLK(Clk), .CN(n151) );
  OAI22D0 U185 ( .A1(n152), .A2(n132), .B1(n153), .B2(n154), .ZN(n144) );
  NR2D0 U186 ( .A1(n153), .A2(n155), .ZN(n148) );
  CKND0 U187 ( .CLK(n126), .CN(n142) );
  ND3D0 U188 ( .A1(n156), .A2(n139), .A3(n157), .ZN(N186) );
  NR2D0 U189 ( .A1(n133), .A2(n138), .ZN(N184) );
  CKND0 U190 ( .CLK(n149), .CN(n133) );
  OAI22D0 U191 ( .A1(n159), .A2(n160), .B1(n125), .B2(n161), .ZN(N181) );
  CKND0 U192 ( .CLK(N128), .CN(n160) );
  OAI22D0 U193 ( .A1(n159), .A2(n162), .B1(n127), .B2(n161), .ZN(N178) );
  CKND0 U194 ( .CLK(N127), .CN(n162) );
  OAI22D0 U195 ( .A1(n159), .A2(n163), .B1(n128), .B2(n161), .ZN(N175) );
  CKND0 U196 ( .CLK(N126), .CN(n163) );
  OAI22D0 U197 ( .A1(n159), .A2(n164), .B1(n129), .B2(n161), .ZN(N172) );
  CKND0 U198 ( .CLK(N125), .CN(n164) );
  OAI22D0 U199 ( .A1(n159), .A2(n165), .B1(n130), .B2(n161), .ZN(N169) );
  CKND2D0 U200 ( .A1(n149), .A2(n97), .ZN(n161) );
  CKND0 U201 ( .CLK(Reset), .CN(n97) );
  CKND0 U202 ( .CLK(N124), .CN(n165) );
  INR2D0 U203 ( .A1(n140), .B1(n166), .ZN(n159) );
  OAI21D0 U204 ( .A1(n158), .A2(n167), .B(n168), .ZN(N167) );
  NR2D0 U205 ( .A1(n137), .A2(n169), .ZN(n167) );
  AO222D0 U206 ( .A1(n120), .A2(n170), .B1(N128), .B2(n131), .C1(N76), .C2(
        n169), .Z(N164) );
  AO222D0 U207 ( .A1(n118), .A2(n170), .B1(N127), .B2(n131), .C1(N75), .C2(
        n169), .Z(N161) );
  AO222D0 U208 ( .A1(n117), .A2(n170), .B1(N126), .B2(n131), .C1(N74), .C2(
        n169), .Z(N158) );
  AO222D0 U209 ( .A1(n115), .A2(n170), .B1(N125), .B2(n131), .C1(N73), .C2(
        n169), .Z(N155) );
  AO222D0 U210 ( .A1(n119), .A2(n170), .B1(N124), .B2(n131), .C1(N72), .C2(
        n169), .Z(N152) );
  CKND0 U211 ( .CLK(n168), .CN(n131) );
  NR2D0 U212 ( .A1(n139), .A2(n158), .ZN(N150) );
  OAI21D0 U213 ( .A1(n158), .A2(n171), .B(n139), .ZN(N148) );
  IAO21D0 U214 ( .A1(n172), .A2(n173), .B(n137), .ZN(n171) );
  ND4D0 U215 ( .A1(n156), .A2(n154), .A3(n168), .A4(n174), .ZN(N146) );
  AOI22D0 U216 ( .A1(n166), .A2(n172), .B1(n175), .B2(n152), .ZN(n174) );
  CKND0 U217 ( .CLK(n158), .CN(n152) );
  ND4D0 U218 ( .A1(n176), .A2(n177), .A3(n178), .A4(n179), .ZN(n172) );
  NR3D0 U219 ( .A1(n180), .A2(N93), .A3(n181), .ZN(n179) );
  XNR2D0 U220 ( .A1(N90), .A2(n117), .ZN(n178) );
  XNR2D0 U221 ( .A1(N91), .A2(n118), .ZN(n177) );
  XNR2D0 U222 ( .A1(N89), .A2(n115), .ZN(n176) );
  CKND2D0 U223 ( .A1(n138), .A2(n149), .ZN(n168) );
  NR3D0 U224 ( .A1(n191), .A2(n190), .A3(\CurState[1] ), .ZN(n149) );
  CKND0 U225 ( .CLK(n153), .CN(n138) );
  CKND2D0 U226 ( .A1(WriteReq), .A2(n182), .ZN(n153) );
  CKND2D0 U227 ( .A1(n158), .A2(n166), .ZN(n156) );
  CKND0 U228 ( .CLK(n173), .CN(n166) );
  OAI221D0 U229 ( .A1(n183), .A2(n173), .B1(n158), .B2(n155), .C(n140), .ZN(
        N144) );
  NR2D0 U230 ( .A1(n170), .A2(n137), .ZN(n140) );
  CKND0 U231 ( .CLK(n154), .CN(n137) );
  ND3D0 U232 ( .A1(n191), .A2(n147), .A3(n190), .ZN(n154) );
  CKND0 U233 ( .CLK(n139), .CN(n170) );
  ND3D0 U234 ( .A1(n191), .A2(\CurState[1] ), .A3(n190), .ZN(n139) );
  CKND0 U235 ( .CLK(n169), .CN(n155) );
  CKND2D0 U236 ( .A1(n132), .A2(n173), .ZN(n169) );
  CKND0 U237 ( .CLK(n175), .CN(n132) );
  NR3D0 U238 ( .A1(n191), .A2(n190), .A3(n147), .ZN(n175) );
  CKND0 U239 ( .CLK(\CurState[1] ), .CN(n147) );
  NR2D0 U240 ( .A1(n182), .A2(WriteReq), .ZN(n158) );
  CKND0 U241 ( .CLK(ReadReq), .CN(n182) );
  NR4D0 U242 ( .A1(n184), .A2(n185), .A3(N111), .A4(n186), .ZN(n183) );
  ND3D0 U243 ( .A1(n187), .A2(n188), .A3(n189), .ZN(n184) );
  CKXOR2D0 U244 ( .A1(N110), .A2(n125), .Z(n189) );
  CKXOR2D0 U245 ( .A1(N107), .A2(n129), .Z(n188) );
  CKXOR2D0 U246 ( .A1(N109), .A2(n127), .Z(n187) );
endmodule


module FIFOStateM_DW01_inc_0 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(SUM[5]), .S(SUM[4]) );
  CKND0 U1 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module FIFOStateM_DW01_inc_1 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  INVD0 U1 ( .I(A[0]), .ZN(SUM[0]) );
  CKXOR2D0 U2 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
endmodule


module FIFOStateM_DW01_inc_2 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(SUM[5]), .S(SUM[4]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  CKND0 U1 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module FIFOStateM_DW01_inc_3 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  CKXOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule

