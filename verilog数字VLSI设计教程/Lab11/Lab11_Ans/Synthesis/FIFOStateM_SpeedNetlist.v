
module FIFOStateM ( ReadAddr, WriteAddr, EmptyFIFO, FullFIFO, ReadCmd, 
        WriteCmd, ReadReq, WriteReq, Clk, Reset );
  output [4:0] ReadAddr;
  output [4:0] WriteAddr;
  input ReadReq, WriteReq, Clk, Reset;
  output EmptyFIFO, FullFIFO, ReadCmd, WriteCmd;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, n125, n126, n127, n128, N45,
         N46, N47, N48, N49, N50, N51, N52, N53, N54, N72, N73, N74, N75, N76,
         N88, N89, N90, N91, N92, N93, N95, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N144, N146,
         N148, N150, N152, N155, N158, N161, N164, N167, N169, N172, N175,
         N178, N181, N184, N186, N187, N190, N191, N200, N201, N202, N211,
         N212, N213, N214, N217, N220, N223, N226, N229, N232, N235, N238,
         N241, n2, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n75, n77, n79, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124;
  wire   [2:0] CurState;
  wire   [2:0] NextState;

  LHQD1 \WriteCount_tri_enable_reg[0]  ( .E(N200), .D(N201), .Q(N9) );
  LHQD1 \NextState_reg[0]  ( .E(N190), .D(N144), .Q(NextState[0]) );
  LHQD1 \WriteCount_reg[1]  ( .E(N200), .D(N155), .Q(N238) );
  LHQD1 \ReadCount_reg[1]  ( .E(N211), .D(N172), .Q(N223) );
  LHQD1 \NextState_reg[1]  ( .E(N190), .D(N146), .Q(NextState[1]) );
  LHQD1 \NextState_reg[2]  ( .E(N190), .D(N148), .Q(NextState[2]) );
  LHQD1 \WriteCount_tri_enable_reg[4]  ( .E(N200), .D(N201), .Q(N5) );
  LHQD1 \WriteCount_tri_enable_reg[2]  ( .E(N200), .D(N201), .Q(N7) );
  LHQD1 \WriteCount_tri_enable_reg[1]  ( .E(N200), .D(N201), .Q(N8) );
  LHQD1 \WriteCount_tri_enable_reg[3]  ( .E(N200), .D(N201), .Q(N6) );
  LHQD1 \ReadCount_tri_enable_reg[4]  ( .E(N211), .D(N212), .Q(N0) );
  LHQD1 \ReadCount_tri_enable_reg[2]  ( .E(N211), .D(N212), .Q(N2) );
  LHQD1 \ReadCount_tri_enable_reg[0]  ( .E(N211), .D(N212), .Q(N4) );
  LHQD1 \ReadCount_tri_enable_reg[1]  ( .E(N211), .D(N212), .Q(N3) );
  LHQD1 \ReadCount_tri_enable_reg[3]  ( .E(N211), .D(N212), .Q(N1) );
  LHQD1 ReadCmdReg_reg ( .E(N187), .D(N186), .Q(n127) );
  LHQD1 \ReadCount_reg[0]  ( .E(N211), .D(N169), .Q(N226) );
  LHQD1 \WriteCount_reg[4]  ( .E(N200), .D(N164), .Q(N229) );
  LHQD1 \WriteCount_reg[3]  ( .E(N200), .D(N161), .Q(N232) );
  LHQD1 \WriteCount_reg[2]  ( .E(N200), .D(N158), .Q(N235) );
  LHQD1 \WriteCount_reg[0]  ( .E(N200), .D(N152), .Q(N241) );
  MOAI22D1 U25 ( .A1(Clk), .A2(n26), .B1(n104), .B2(N213), .ZN(N200) );
  OA21D1 U27 ( .A1(n29), .A2(n21), .B(n30), .Z(n26) );
  AO222D1 U64 ( .A1(n92), .A2(n33), .B1(N50), .B2(n43), .C1(N72), .C2(n52), 
        .Z(N152) );
  FIFOStateM_DW01_inc_0 add_211 ( .A({n2, n98, n102, n100, N102, N101}), .SUM(
        {N111, N110, N109, N108, N107, N106}) );
  FIFOStateM_DW01_inc_1 add_199 ( .A({n2, N76, N75, N74, N73, N72}), .SUM({N93, 
        N92, N91, N90, N89, N88}) );
  FIFOStateM_DW01_inc_2 add_111_C148 ( .A({N45, N46, N47, N48, N49}), .SUM({
        N54, N53, N52, N51, N50}) );
  FIFOStateM_DW01_inc_3 r109 ( .A({n85, n84, n86, n88, n92}), .SUM({N105, N104, 
        N103, N102, N101}) );
  FIFOStateM_DW01_inc_4 r106 ( .A({n90, n96, n95, n87, n91}), .SUM({N76, N75, 
        N74, N73, N72}) );
  BUFTD16 \ReadCount_tri[1]  ( .I(N223), .OE(n64), .Z(ReadAddr[1]) );
  BUFTD16 \WriteCount_tri[1]  ( .I(N238), .OE(n69), .Z(WriteAddr[1]) );
  LHQD2 \ReadCount_reg[3]  ( .E(N211), .D(N178), .Q(N217) );
  LHQD2 \ReadCount_reg[2]  ( .E(N211), .D(N175), .Q(N220) );
  BUFTD16 \WriteCount_tri[3]  ( .I(N232), .OE(n67), .Z(WriteAddr[3]) );
  BUFTD16 \WriteCount_tri[2]  ( .I(N235), .OE(n68), .Z(WriteAddr[2]) );
  BUFTD16 \ReadCount_tri[3]  ( .I(N217), .OE(n62), .Z(ReadAddr[3]) );
  BUFTD16 \ReadCount_tri[2]  ( .I(N220), .OE(n63), .Z(ReadAddr[2]) );
  BUFTD16 \ReadCount_tri[0]  ( .I(N226), .OE(n65), .Z(ReadAddr[0]) );
  BUFTD16 \WriteCount_tri[0]  ( .I(N241), .OE(n70), .Z(WriteAddr[0]) );
  LHQD1 \ReadCount_reg[4]  ( .E(N211), .D(N181), .Q(N214) );
  BUFTD16 \ReadCount_tri[4]  ( .I(N214), .OE(n61), .Z(ReadAddr[4]) );
  BUFTD16 \WriteCount_tri[4]  ( .I(N229), .OE(n66), .Z(WriteAddr[4]) );
  LHQD1 EmptyFIFOReg_reg ( .E(N213), .D(N184), .Q(n125) );
  LHQD1 FullFIFOReg_reg ( .E(N191), .D(N150), .Q(n126) );
  LHQD1 WriteCmdReg_reg ( .E(N202), .D(N167), .Q(n128) );
  DFCND1 \CurState_reg[1]  ( .D(NextState[1]), .CP(Clk), .CDN(n71), .Q(n58), 
        .QN(n72) );
  DFCND1 \CurState_reg[2]  ( .D(NextState[2]), .CP(Clk), .CDN(n71), .Q(
        CurState[2]), .QN(n36) );
  DFCND1 \CurState_reg[0]  ( .D(NextState[0]), .CP(Clk), .CDN(n71), .Q(
        CurState[0]), .QN(n41) );
  OAI22D0 U95 ( .A1(n88), .A2(n108), .B1(n108), .B2(n107), .ZN(n109) );
  INVD1 U96 ( .I(n88), .ZN(n105) );
  AO22D0 U97 ( .A1(n32), .A2(N45), .B1(n98), .B2(n48), .Z(N181) );
  AO22D0 U98 ( .A1(n32), .A2(N48), .B1(N102), .B2(n48), .Z(N172) );
  CKBD0 U99 ( .CLK(n89), .C(n73) );
  CKNXD16 U100 ( .I(n73), .ZN(ReadCmd) );
  CKBD0 U101 ( .CLK(n83), .C(n75) );
  CKNXD16 U102 ( .I(n75), .ZN(EmptyFIFO) );
  CKBD0 U103 ( .CLK(n82), .C(n77) );
  CKNXD16 U104 ( .I(n77), .ZN(FullFIFO) );
  CKBD0 U105 ( .CLK(n81), .C(n79) );
  CKNXD16 U106 ( .I(n79), .ZN(WriteCmd) );
  CKND0 U107 ( .CLK(n128), .CN(n81) );
  CKND0 U108 ( .CLK(n126), .CN(n82) );
  CKND0 U109 ( .CLK(n125), .CN(n83) );
  BUFFD1 U110 ( .I(ReadAddr[3]), .Z(n84) );
  CKND0 U111 ( .CLK(N1), .CN(n62) );
  CKND0 U112 ( .CLK(N7), .CN(n68) );
  CKND0 U113 ( .CLK(N6), .CN(n67) );
  BUFFD1 U114 ( .I(ReadAddr[4]), .Z(n85) );
  AO222D0 U115 ( .A1(n85), .A2(n33), .B1(N54), .B2(n43), .C1(N76), .C2(n52), 
        .Z(N164) );
  BUFFD1 U116 ( .I(ReadAddr[2]), .Z(n86) );
  AO222D0 U117 ( .A1(n86), .A2(n33), .B1(N52), .B2(n43), .C1(N74), .C2(n52), 
        .Z(N158) );
  CKND0 U118 ( .CLK(N2), .CN(n63) );
  BUFFD1 U119 ( .I(WriteAddr[1]), .Z(n87) );
  AO22D0 U120 ( .A1(n104), .A2(N73), .B1(n21), .B2(n87), .Z(N99) );
  CKND0 U121 ( .CLK(N8), .CN(n69) );
  BUFFD1 U122 ( .I(ReadAddr[1]), .Z(n88) );
  CKND0 U123 ( .CLK(N3), .CN(n64) );
  AO222D0 U124 ( .A1(n84), .A2(n33), .B1(N53), .B2(n43), .C1(N75), .C2(n52), 
        .Z(N161) );
  CKND0 U125 ( .CLK(n127), .CN(n89) );
  NR3D0 U126 ( .A1(n41), .A2(n72), .A3(n36), .ZN(n33) );
  NR3D0 U127 ( .A1(CurState[0]), .A2(CurState[2]), .A3(n58), .ZN(n32) );
  BUFFD0 U128 ( .I(WriteAddr[4]), .Z(n90) );
  BUFFD0 U129 ( .I(WriteAddr[0]), .Z(n91) );
  BUFFD0 U130 ( .I(ReadAddr[0]), .Z(n92) );
  INVD1 U131 ( .I(n43), .ZN(n51) );
  INVD1 U132 ( .I(n47), .ZN(n42) );
  NR2D1 U133 ( .A1(n27), .A2(n21), .ZN(n43) );
  OAI21D1 U134 ( .A1(n47), .A2(n46), .B(n51), .ZN(N167) );
  NR2D1 U135 ( .A1(n54), .A2(n46), .ZN(N150) );
  INVD1 U136 ( .I(n25), .ZN(N186) );
  INVD1 U137 ( .I(n53), .ZN(n52) );
  INVD1 U138 ( .I(n50), .ZN(n31) );
  NR2D1 U139 ( .A1(n52), .A2(n50), .ZN(n47) );
  INVD1 U140 ( .I(n38), .ZN(n48) );
  INVD1 U141 ( .I(n23), .ZN(N211) );
  AO22D0 U142 ( .A1(n32), .A2(N49), .B1(N101), .B2(n48), .Z(N169) );
  OAI221D0 U143 ( .A1(n46), .A2(n53), .B1(N112), .B2(n29), .C(n59), .ZN(N144)
         );
  NR2D1 U144 ( .A1(n33), .A2(n50), .ZN(n59) );
  OAI21D1 U145 ( .A1(n46), .A2(n55), .B(n54), .ZN(N148) );
  AOI21D0 U146 ( .A1(N95), .A2(n49), .B(n50), .ZN(n55) );
  ND3D1 U147 ( .A1(n51), .A2(n31), .A3(n56), .ZN(N146) );
  AOI22D0 U148 ( .A1(n49), .A2(n57), .B1(n40), .B2(n39), .ZN(n56) );
  CKND2D0 U149 ( .A1(N95), .A2(n39), .ZN(n57) );
  XNR2D1 U150 ( .A1(n93), .A2(N109), .ZN(n121) );
  AOI22D0 U151 ( .A1(n104), .A2(N75), .B1(n21), .B2(n96), .ZN(n93) );
  AO22D0 U152 ( .A1(n32), .A2(N47), .B1(n100), .B2(n48), .Z(N175) );
  AO22D0 U153 ( .A1(n32), .A2(N46), .B1(n102), .B2(n48), .Z(N178) );
  AO22D0 U154 ( .A1(n104), .A2(N74), .B1(n21), .B2(n95), .Z(N98) );
  INVD1 U155 ( .I(n104), .ZN(n21) );
  INVD1 U156 ( .I(n39), .ZN(n46) );
  AOI21D1 U157 ( .A1(n42), .A2(n46), .B(n33), .ZN(n25) );
  NR2D1 U158 ( .A1(n27), .A2(n104), .ZN(N184) );
  NR3D0 U159 ( .A1(n41), .A2(n58), .A3(n36), .ZN(n50) );
  INVD1 U160 ( .I(n32), .ZN(n27) );
  INVD1 U161 ( .I(n49), .ZN(n29) );
  NR2D1 U162 ( .A1(n40), .A2(n49), .ZN(n53) );
  INVD1 U163 ( .I(n33), .ZN(n54) );
  INR2D1 U164 ( .A1(n95), .B1(n103), .ZN(N47) );
  INR2D1 U165 ( .A1(n96), .B1(n103), .ZN(N46) );
  AN2D1 U166 ( .A1(N150), .A2(n22), .Z(N201) );
  AN2D1 U167 ( .A1(N184), .A2(n22), .Z(N212) );
  INVD1 U168 ( .I(n103), .ZN(n71) );
  NR3D0 U169 ( .A1(n33), .A2(n49), .A3(n50), .ZN(n38) );
  AOI221D0 U170 ( .A1(n42), .A2(n104), .B1(n103), .B2(n32), .C(n43), .ZN(n24)
         );
  OAI21D1 U171 ( .A1(n45), .A2(n32), .B(n22), .ZN(n23) );
  NR2D1 U172 ( .A1(n38), .A2(n39), .ZN(n45) );
  AOI21D1 U173 ( .A1(n103), .A2(n32), .B(n33), .ZN(n30) );
  INVD1 U174 ( .I(n40), .ZN(n28) );
  CKND0 U175 ( .CLK(N4), .CN(n65) );
  CKND0 U176 ( .CLK(N9), .CN(n70) );
  CKND0 U177 ( .CLK(N5), .CN(n66) );
  CKND0 U178 ( .CLK(N0), .CN(n61) );
  CKAN2D0 U179 ( .A1(n91), .A2(n71), .Z(N49) );
  XNR2D1 U180 ( .A1(n94), .A2(N110), .ZN(n123) );
  AOI22D0 U181 ( .A1(n104), .A2(N76), .B1(n21), .B2(n90), .ZN(n94) );
  AO22D0 U182 ( .A1(n21), .A2(n91), .B1(n104), .B2(N72), .Z(N100) );
  INR2XD0 U183 ( .A1(n90), .B1(n103), .ZN(N45) );
  INVD1 U184 ( .I(WriteReq), .ZN(n60) );
  BUFFD1 U185 ( .I(n20), .Z(n104) );
  NR2D1 U186 ( .A1(n60), .A2(ReadReq), .ZN(n20) );
  ND2D1 U187 ( .A1(ReadReq), .A2(n60), .ZN(n39) );
  NR3D0 U188 ( .A1(CurState[2]), .A2(n72), .A3(n41), .ZN(n49) );
  NR3D0 U189 ( .A1(CurState[2]), .A2(n72), .A3(CurState[0]), .ZN(n40) );
  INVD1 U190 ( .I(Clk), .ZN(n22) );
  BUFFD1 U191 ( .I(Reset), .Z(n103) );
  AOI31D0 U192 ( .A1(n24), .A2(n34), .A3(n35), .B(Clk), .ZN(N190) );
  ND2D1 U193 ( .A1(CurState[2]), .A2(n41), .ZN(n34) );
  AOI31D0 U194 ( .A1(n72), .A2(n36), .A3(CurState[0]), .B(n37), .ZN(n35) );
  AOI21D1 U195 ( .A1(n38), .A2(n28), .B(n39), .ZN(n37) );
  AOI21D1 U196 ( .A1(n27), .A2(n28), .B(Clk), .ZN(N213) );
  OAI21D1 U197 ( .A1(Clk), .A2(n44), .B(n23), .ZN(N187) );
  AOI22D0 U198 ( .A1(n104), .A2(n42), .B1(n40), .B2(n46), .ZN(n44) );
  AOI21D1 U199 ( .A1(n30), .A2(n31), .B(Clk), .ZN(N191) );
  AOI21D1 U200 ( .A1(n24), .A2(n25), .B(Clk), .ZN(N202) );
  TIEL U201 ( .ZN(n2) );
  BUFFD0 U202 ( .I(WriteAddr[2]), .Z(n95) );
  BUFFD0 U203 ( .I(WriteAddr[3]), .Z(n96) );
  CKND0 U204 ( .CLK(N105), .CN(n97) );
  INVD1 U205 ( .I(n97), .ZN(n98) );
  CKND0 U206 ( .CLK(N103), .CN(n99) );
  INVD1 U207 ( .I(n99), .ZN(n100) );
  CKND0 U208 ( .CLK(N104), .CN(n101) );
  INVD1 U209 ( .I(n101), .ZN(n102) );
  INR2D1 U210 ( .A1(n87), .B1(n103), .ZN(N48) );
  AO222D0 U211 ( .A1(n88), .A2(n33), .B1(N51), .B2(n43), .C1(N73), .C2(n52), 
        .Z(N155) );
  INR2D0 U212 ( .A1(N88), .B1(n92), .ZN(n106) );
  OAI22D0 U213 ( .A1(n106), .A2(n105), .B1(N89), .B2(n106), .ZN(n110) );
  INR2D0 U214 ( .A1(n92), .B1(N88), .ZN(n108) );
  CKND0 U215 ( .CLK(N89), .CN(n107) );
  IND3D0 U216 ( .A1(N93), .B1(n110), .B2(n109), .ZN(n114) );
  CKXOR2D0 U217 ( .A1(N92), .A2(n85), .Z(n113) );
  CKXOR2D0 U218 ( .A1(N90), .A2(n86), .Z(n112) );
  CKXOR2D0 U219 ( .A1(N91), .A2(n84), .Z(n111) );
  NR4D0 U220 ( .A1(n114), .A2(n113), .A3(n112), .A4(n111), .ZN(N95) );
  INR2D0 U221 ( .A1(N106), .B1(N100), .ZN(n116) );
  CKND0 U222 ( .CLK(N99), .CN(n115) );
  OAI22D0 U223 ( .A1(N107), .A2(n116), .B1(n116), .B2(n115), .ZN(n120) );
  INR2D0 U224 ( .A1(N100), .B1(N106), .ZN(n118) );
  CKND0 U225 ( .CLK(N107), .CN(n117) );
  OAI22D0 U226 ( .A1(n118), .A2(n117), .B1(N99), .B2(n118), .ZN(n119) );
  IND3D0 U227 ( .A1(N111), .B1(n120), .B2(n119), .ZN(n124) );
  CKXOR2D0 U228 ( .A1(N98), .A2(N108), .Z(n122) );
  NR4D0 U229 ( .A1(n124), .A2(n123), .A3(n122), .A4(n121), .ZN(N112) );
endmodule


module FIFOStateM_DW01_inc_0 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(SUM[5]), .S(SUM[4]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  CKND0 U1 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module FIFOStateM_DW01_inc_1 ( A, SUM );
  input [5:0] A;
  output [5:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_4 ( .A(A[4]), .B(\carry[4] ), .CO(SUM[5]), .S(SUM[4]) );
  CKND0 U1 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module FIFOStateM_DW01_inc_2 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  CKXOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module FIFOStateM_DW01_inc_3 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  XOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule


module FIFOStateM_DW01_inc_4 ( A, SUM );
  input [4:0] A;
  output [4:0] SUM;
  wire   \carry[4] , \carry[3] , \carry[2] ;

  HA1D0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(\carry[2] ), .S(SUM[1]) );
  HA1D0 U1_1_3 ( .A(A[3]), .B(\carry[3] ), .CO(\carry[4] ), .S(SUM[3]) );
  HA1D0 U1_1_2 ( .A(A[2]), .B(\carry[2] ), .CO(\carry[3] ), .S(SUM[2]) );
  CKXOR2D0 U1 ( .A1(\carry[4] ), .A2(A[4]), .Z(SUM[4]) );
  CKND0 U2 ( .CLK(A[0]), .CN(SUM[0]) );
endmodule

