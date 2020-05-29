
module CondGenerate ( Result, ArgA, ArgB, Sel, Enable );
  output [31:0] Result;
  input [31:0] ArgA;
  input [31:0] ArgB;
  input Sel, Enable;
  wire   n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n1, n3, n5, n7,
         n9, n11, n13, n15, n17, n19, n21, n23, n25, n27, n29, n31, n33, n35,
         n37, n39, n41, n43, n45, n47, n49, n51, n53, n55, n57, n59, n61, n63,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96;

  Mux32BitL Mux1 ( .Out({n97, n98, n99, n100, n101, n102, n103, n104, n105, 
        n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, 
        n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128}), 
        .A(ArgA), .B(ArgB), .Sel(Sel), .Ena(Enable) );
  CKBD0 U1 ( .CLK(n81), .C(n1) );
  CKNXD16 U2 ( .I(n1), .ZN(Result[16]) );
  CKBD0 U3 ( .CLK(n82), .C(n3) );
  CKNXD16 U4 ( .I(n3), .ZN(Result[17]) );
  CKBD0 U5 ( .CLK(n80), .C(n5) );
  CKNXD16 U6 ( .I(n5), .ZN(Result[15]) );
  CKBD0 U7 ( .CLK(n83), .C(n7) );
  CKNXD16 U8 ( .I(n7), .ZN(Result[18]) );
  CKBD0 U9 ( .CLK(n79), .C(n9) );
  CKNXD16 U10 ( .I(n9), .ZN(Result[14]) );
  CKBD0 U11 ( .CLK(n84), .C(n11) );
  CKNXD16 U12 ( .I(n11), .ZN(Result[19]) );
  CKBD0 U13 ( .CLK(n78), .C(n13) );
  CKNXD16 U14 ( .I(n13), .ZN(Result[13]) );
  CKBD0 U15 ( .CLK(n85), .C(n15) );
  CKNXD16 U16 ( .I(n15), .ZN(Result[20]) );
  CKBD0 U17 ( .CLK(n77), .C(n17) );
  CKNXD16 U18 ( .I(n17), .ZN(Result[12]) );
  CKBD0 U19 ( .CLK(n86), .C(n19) );
  CKNXD16 U20 ( .I(n19), .ZN(Result[21]) );
  CKBD0 U21 ( .CLK(n76), .C(n21) );
  CKNXD16 U22 ( .I(n21), .ZN(Result[11]) );
  CKBD0 U23 ( .CLK(n87), .C(n23) );
  CKNXD16 U24 ( .I(n23), .ZN(Result[22]) );
  CKBD0 U25 ( .CLK(n75), .C(n25) );
  CKNXD16 U26 ( .I(n25), .ZN(Result[10]) );
  CKBD0 U27 ( .CLK(n88), .C(n27) );
  CKNXD16 U28 ( .I(n27), .ZN(Result[23]) );
  CKBD0 U29 ( .CLK(n74), .C(n29) );
  CKNXD16 U30 ( .I(n29), .ZN(Result[9]) );
  CKBD0 U31 ( .CLK(n89), .C(n31) );
  CKNXD16 U32 ( .I(n31), .ZN(Result[24]) );
  CKBD0 U33 ( .CLK(n73), .C(n33) );
  CKNXD16 U34 ( .I(n33), .ZN(Result[8]) );
  CKBD0 U35 ( .CLK(n90), .C(n35) );
  CKNXD16 U36 ( .I(n35), .ZN(Result[25]) );
  CKBD0 U37 ( .CLK(n72), .C(n37) );
  CKNXD16 U38 ( .I(n37), .ZN(Result[7]) );
  CKBD0 U39 ( .CLK(n91), .C(n39) );
  CKNXD16 U40 ( .I(n39), .ZN(Result[26]) );
  CKBD0 U41 ( .CLK(n71), .C(n41) );
  CKNXD16 U42 ( .I(n41), .ZN(Result[6]) );
  CKBD0 U43 ( .CLK(n92), .C(n43) );
  CKNXD16 U44 ( .I(n43), .ZN(Result[27]) );
  CKBD0 U45 ( .CLK(n70), .C(n45) );
  CKNXD16 U46 ( .I(n45), .ZN(Result[5]) );
  CKBD0 U47 ( .CLK(n93), .C(n47) );
  CKNXD16 U48 ( .I(n47), .ZN(Result[28]) );
  CKBD0 U49 ( .CLK(n69), .C(n49) );
  CKNXD16 U50 ( .I(n49), .ZN(Result[4]) );
  CKBD0 U51 ( .CLK(n94), .C(n51) );
  CKNXD16 U52 ( .I(n51), .ZN(Result[29]) );
  CKBD0 U53 ( .CLK(n68), .C(n53) );
  CKNXD16 U54 ( .I(n53), .ZN(Result[3]) );
  CKBD0 U55 ( .CLK(n95), .C(n55) );
  CKNXD16 U56 ( .I(n55), .ZN(Result[30]) );
  CKBD0 U57 ( .CLK(n67), .C(n57) );
  CKNXD16 U58 ( .I(n57), .ZN(Result[2]) );
  CKBD0 U59 ( .CLK(n65), .C(n59) );
  CKNXD16 U60 ( .I(n59), .ZN(Result[0]) );
  CKBD0 U61 ( .CLK(n66), .C(n61) );
  CKNXD16 U62 ( .I(n61), .ZN(Result[1]) );
  CKBD0 U63 ( .CLK(n96), .C(n63) );
  CKNXD16 U64 ( .I(n63), .ZN(Result[31]) );
  CKND0 U65 ( .CLK(n128), .CN(n65) );
  CKND0 U66 ( .CLK(n127), .CN(n66) );
  CKND0 U67 ( .CLK(n126), .CN(n67) );
  CKND0 U68 ( .CLK(n125), .CN(n68) );
  CKND0 U69 ( .CLK(n124), .CN(n69) );
  CKND0 U70 ( .CLK(n123), .CN(n70) );
  CKND0 U71 ( .CLK(n122), .CN(n71) );
  CKND0 U72 ( .CLK(n121), .CN(n72) );
  CKND0 U73 ( .CLK(n120), .CN(n73) );
  CKND0 U74 ( .CLK(n119), .CN(n74) );
  CKND0 U75 ( .CLK(n118), .CN(n75) );
  CKND0 U76 ( .CLK(n117), .CN(n76) );
  CKND0 U77 ( .CLK(n116), .CN(n77) );
  CKND0 U78 ( .CLK(n115), .CN(n78) );
  CKND0 U79 ( .CLK(n114), .CN(n79) );
  CKND0 U80 ( .CLK(n113), .CN(n80) );
  CKND0 U81 ( .CLK(n112), .CN(n81) );
  CKND0 U82 ( .CLK(n111), .CN(n82) );
  CKND0 U83 ( .CLK(n110), .CN(n83) );
  CKND0 U84 ( .CLK(n109), .CN(n84) );
  CKND0 U85 ( .CLK(n108), .CN(n85) );
  CKND0 U86 ( .CLK(n107), .CN(n86) );
  CKND0 U87 ( .CLK(n106), .CN(n87) );
  CKND0 U88 ( .CLK(n105), .CN(n88) );
  CKND0 U89 ( .CLK(n104), .CN(n89) );
  CKND0 U90 ( .CLK(n103), .CN(n90) );
  CKND0 U91 ( .CLK(n102), .CN(n91) );
  CKND0 U92 ( .CLK(n101), .CN(n92) );
  CKND0 U93 ( .CLK(n100), .CN(n93) );
  CKND0 U94 ( .CLK(n99), .CN(n94) );
  CKND0 U95 ( .CLK(n98), .CN(n95) );
  CKND0 U96 ( .CLK(n97), .CN(n96) );
endmodule


module Mux32BitL ( Out, A, B, Sel, Ena );
  output [31:0] Out;
  input [31:0] A;
  input [31:0] B;
  input Sel, Ena;
  wire   n4, n1, n2, n3;

  AO222D1 U1 ( .A1(A[0]), .A2(n1), .B1(B[0]), .B2(n2), .C1(Out[0]), .C2(n3), 
        .Z(Out[0]) );
  AO222D1 U2 ( .A1(A[1]), .A2(n1), .B1(B[1]), .B2(n2), .C1(Out[1]), .C2(n3), 
        .Z(Out[1]) );
  AO222D1 U3 ( .A1(A[2]), .A2(n1), .B1(B[2]), .B2(n2), .C1(Out[2]), .C2(n3), 
        .Z(Out[2]) );
  AO222D1 U4 ( .A1(A[3]), .A2(n1), .B1(B[3]), .B2(n2), .C1(Out[3]), .C2(n3), 
        .Z(Out[3]) );
  AO222D1 U5 ( .A1(A[4]), .A2(n1), .B1(B[4]), .B2(n2), .C1(Out[4]), .C2(n3), 
        .Z(Out[4]) );
  AO222D1 U6 ( .A1(A[5]), .A2(n1), .B1(B[5]), .B2(n2), .C1(Out[5]), .C2(n3), 
        .Z(Out[5]) );
  AO222D1 U7 ( .A1(A[6]), .A2(n1), .B1(B[6]), .B2(n2), .C1(Out[6]), .C2(n3), 
        .Z(Out[6]) );
  AO222D1 U8 ( .A1(A[7]), .A2(n1), .B1(B[7]), .B2(n2), .C1(Out[7]), .C2(n3), 
        .Z(Out[7]) );
  AO222D1 U9 ( .A1(A[8]), .A2(n1), .B1(B[8]), .B2(n2), .C1(Out[8]), .C2(n3), 
        .Z(Out[8]) );
  AO222D1 U10 ( .A1(A[9]), .A2(n1), .B1(B[9]), .B2(n2), .C1(Out[9]), .C2(n3), 
        .Z(Out[9]) );
  AO222D1 U11 ( .A1(A[10]), .A2(n1), .B1(B[10]), .B2(n2), .C1(Out[10]), .C2(n3), .Z(Out[10]) );
  AO222D1 U12 ( .A1(A[11]), .A2(n1), .B1(B[11]), .B2(n2), .C1(Out[11]), .C2(n3), .Z(Out[11]) );
  AO222D1 U13 ( .A1(A[12]), .A2(n1), .B1(B[12]), .B2(n2), .C1(Out[12]), .C2(n3), .Z(Out[12]) );
  AO222D1 U14 ( .A1(A[13]), .A2(n1), .B1(B[13]), .B2(n2), .C1(Out[13]), .C2(n3), .Z(Out[13]) );
  AO222D1 U15 ( .A1(A[14]), .A2(n1), .B1(B[14]), .B2(n2), .C1(Out[14]), .C2(n3), .Z(Out[14]) );
  AO222D1 U16 ( .A1(A[15]), .A2(n1), .B1(B[15]), .B2(n2), .C1(Out[15]), .C2(n3), .Z(Out[15]) );
  AO222D1 U17 ( .A1(A[16]), .A2(n1), .B1(B[16]), .B2(n2), .C1(Out[16]), .C2(n3), .Z(Out[16]) );
  AO222D1 U18 ( .A1(A[17]), .A2(n1), .B1(B[17]), .B2(n2), .C1(Out[17]), .C2(n3), .Z(Out[17]) );
  AO222D1 U19 ( .A1(A[18]), .A2(n1), .B1(B[18]), .B2(n2), .C1(Out[18]), .C2(n3), .Z(Out[18]) );
  AO222D1 U20 ( .A1(A[19]), .A2(n1), .B1(B[19]), .B2(n2), .C1(Out[19]), .C2(n3), .Z(Out[19]) );
  AO222D1 U21 ( .A1(A[20]), .A2(n1), .B1(B[20]), .B2(n2), .C1(Out[20]), .C2(n3), .Z(Out[20]) );
  AO222D1 U22 ( .A1(A[21]), .A2(n1), .B1(B[21]), .B2(n2), .C1(Out[21]), .C2(n3), .Z(Out[21]) );
  AO222D1 U23 ( .A1(A[22]), .A2(n1), .B1(B[22]), .B2(n2), .C1(Out[22]), .C2(n3), .Z(Out[22]) );
  AO222D1 U24 ( .A1(A[23]), .A2(n1), .B1(B[23]), .B2(n2), .C1(Out[23]), .C2(n3), .Z(Out[23]) );
  AO222D1 U25 ( .A1(A[24]), .A2(n1), .B1(B[24]), .B2(n2), .C1(Out[24]), .C2(n3), .Z(Out[24]) );
  AO222D1 U26 ( .A1(A[25]), .A2(n1), .B1(B[25]), .B2(n2), .C1(Out[25]), .C2(n3), .Z(Out[25]) );
  AO222D1 U27 ( .A1(A[26]), .A2(n1), .B1(B[26]), .B2(n2), .C1(Out[26]), .C2(n3), .Z(Out[26]) );
  AO222D1 U28 ( .A1(A[27]), .A2(n1), .B1(B[27]), .B2(n2), .C1(Out[27]), .C2(n3), .Z(Out[27]) );
  AO222D1 U29 ( .A1(A[28]), .A2(n1), .B1(B[28]), .B2(n2), .C1(Out[28]), .C2(n3), .Z(Out[28]) );
  AO222D1 U30 ( .A1(A[29]), .A2(n1), .B1(B[29]), .B2(n2), .C1(Out[29]), .C2(n3), .Z(Out[29]) );
  AO222D1 U31 ( .A1(A[30]), .A2(n1), .B1(B[30]), .B2(n2), .C1(Out[30]), .C2(n3), .Z(Out[30]) );
  AO222D1 U32 ( .A1(A[31]), .A2(n1), .B1(B[31]), .B2(n2), .C1(Out[31]), .C2(n3), .Z(Out[31]) );
  AN2D1 U33 ( .A1(Sel), .A2(Ena), .Z(n1) );
  INVD1 U34 ( .I(Ena), .ZN(n3) );
  BUFFD1 U35 ( .I(n4), .Z(n2) );
  NR2D1 U36 ( .A1(n3), .A2(Sel), .ZN(n4) );
endmodule

