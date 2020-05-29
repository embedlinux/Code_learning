
module Synch4DFFGates ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   n34, n35, Qn_wire0, Qn_wire2, wireToD1, wireToD2, \FF_Bit0/from_oS2 ,
         \FF_Bit0/from_oR2 , \FF_Bit0/from_oR1 , \FF_Bit1/from_oR2 ,
         \FF_Bit1/from_oR1 , \FF_Bit2/from_oR2 , \FF_Bit2/from_oR1 ,
         \FF_Bit3/from_oS2 , \FF_Bit3/Clrbar , \FF_Bit3/from_oR2 ,
         \FF_Bit3/from_oR1 , \FF_Bit0/*Logic1* , \FF_Bit0/SR1/N0 ,
         \FF_Bit0/SR2/N1 , \FF_Bit0/SR2/N0 , \FF_Bit0/SR3/N0 ,
         \FF_Bit1/SR1/N0 , \FF_Bit1/SR2/N0 , \FF_Bit1/SR3/N0 ,
         \FF_Bit2/SR1/N0 , \FF_Bit2/SR2/N0 , \FF_Bit2/SR3/N0 ,
         \FF_Bit3/SR1/N0 , \FF_Bit3/SR2/N0 , \FF_Bit3/SR3/N1 , n10, n12, n14,
         n15, n16, n17, n18, n19, n21, n23, n25, n26, n28, n29, n30, n31, n32,
         n33;

  AN3D4 \FF_Bit3/SR3/BotNand  ( .A1(\FF_Bit3/Clrbar ), .A2(n26), .A3(
        \FF_Bit3/from_oS2 ), .Z(\FF_Bit3/SR3/N1 ) );
  AN3D4 \FF_Bit3/SR2/TopNand  ( .A1(\FF_Bit3/from_oR1 ), .A2(
        \FF_Bit3/from_oR2 ), .A3(ClockIn), .Z(\FF_Bit3/SR2/N0 ) );
  AN3D4 \FF_Bit3/SR1/TopNand  ( .A1(\FF_Bit3/from_oR2 ), .A2(
        \FF_Bit3/from_oR1 ), .A3(\FF_Bit0/*Logic1* ), .Z(\FF_Bit3/SR1/N0 ) );
  AN3D4 \FF_Bit2/SR3/TopNand  ( .A1(n33), .A2(Qn_wire2), .A3(
        \FF_Bit0/*Logic1* ), .Z(\FF_Bit2/SR3/N0 ) );
  AN3D4 \FF_Bit2/SR2/TopNand  ( .A1(\FF_Bit2/from_oR1 ), .A2(
        \FF_Bit2/from_oR2 ), .A3(ClockIn), .Z(\FF_Bit2/SR2/N0 ) );
  AN3D4 \FF_Bit2/SR1/TopNand  ( .A1(\FF_Bit2/from_oR2 ), .A2(n33), .A3(
        \FF_Bit0/*Logic1* ), .Z(\FF_Bit2/SR1/N0 ) );
  AN3D4 \FF_Bit1/SR3/TopNand  ( .A1(\FF_Bit1/from_oR1 ), .A2(n15), .A3(
        \FF_Bit0/*Logic1* ), .Z(\FF_Bit1/SR3/N0 ) );
  AN3D4 \FF_Bit1/SR2/TopNand  ( .A1(\FF_Bit1/from_oR1 ), .A2(
        \FF_Bit1/from_oR2 ), .A3(ClockIn), .Z(\FF_Bit1/SR2/N0 ) );
  AN3D4 \FF_Bit1/SR1/TopNand  ( .A1(\FF_Bit1/from_oR2 ), .A2(
        \FF_Bit1/from_oR1 ), .A3(\FF_Bit0/*Logic1* ), .Z(\FF_Bit1/SR1/N0 ) );
  AN3D4 \FF_Bit0/SR3/TopNand  ( .A1(\FF_Bit0/from_oR1 ), .A2(Qn_wire0), .A3(
        \FF_Bit0/*Logic1* ), .Z(\FF_Bit0/SR3/N0 ) );
  AN3D4 \FF_Bit0/SR2/TopNand  ( .A1(\FF_Bit0/from_oR1 ), .A2(n32), .A3(ClockIn), .Z(\FF_Bit0/SR2/N0 ) );
  AN3D4 \FF_Bit0/SR2/BotNand  ( .A1(Qn_wire0), .A2(\FF_Bit0/from_oS2 ), .A3(
        \FF_Bit3/Clrbar ), .Z(\FF_Bit0/SR2/N1 ) );
  AN3D4 \FF_Bit0/SR1/TopNand  ( .A1(\FF_Bit0/from_oR2 ), .A2(
        \FF_Bit0/from_oR1 ), .A3(\FF_Bit0/*Logic1* ), .Z(\FF_Bit0/SR1/N0 ) );
  XOR2D2 C13 ( .A1(Qn_wire2), .A2(n16), .Z(wireToD2) );
  XOR2D2 C12 ( .A1(Qn_wire0), .A2(n15), .Z(wireToD1) );
  INVD1 U25 ( .I(\FF_Bit0/SR3/N0 ), .ZN(n28) );
  IND2D1 U26 ( .A1(\FF_Bit0/SR1/N0 ), .B1(n14), .ZN(\FF_Bit0/from_oR1 ) );
  IND3D1 U27 ( .A1(\FF_Bit1/SR2/N0 ), .B1(\FF_Bit3/Clrbar ), .B2(wireToD1), 
        .ZN(\FF_Bit1/from_oR2 ) );
  IND2D1 U28 ( .A1(\FF_Bit1/SR1/N0 ), .B1(n14), .ZN(\FF_Bit1/from_oR1 ) );
  IND2D1 U29 ( .A1(\FF_Bit2/SR1/N0 ), .B1(n14), .ZN(\FF_Bit2/from_oR1 ) );
  BUFFD1 U30 ( .I(\FF_Bit2/from_oR1 ), .Z(n33) );
  ND3D1 U31 ( .A1(\FF_Bit3/Clrbar ), .A2(\FF_Bit3/from_oS2 ), .A3(n12), .ZN(
        \FF_Bit3/from_oR2 ) );
  IND2D1 U32 ( .A1(\FF_Bit3/SR1/N0 ), .B1(n14), .ZN(\FF_Bit3/from_oR1 ) );
  INVD1 U33 ( .I(n25), .ZN(n26) );
  OR2D1 U34 ( .A1(\FF_Bit1/SR3/N0 ), .A2(n18), .Z(n15) );
  OR3D1 U35 ( .A1(\FF_Bit0/SR2/N0 ), .A2(n29), .A3(n15), .Z(n16) );
  OR3D1 U36 ( .A1(\FF_Bit2/SR2/N0 ), .A2(\FF_Bit2/SR3/N0 ), .A3(n16), .Z(n17)
         );
  INVD1 U37 ( .I(ClearIn), .ZN(\FF_Bit3/Clrbar ) );
  OR2D1 U38 ( .A1(\FF_Bit1/SR2/N0 ), .A2(ClearIn), .Z(n18) );
  CKBD0 U39 ( .CLK(\FF_Bit0/SR3/N0 ), .C(n19) );
  CKNXD16 U40 ( .I(n19), .ZN(CountOut[0]) );
  CKBD0 U41 ( .CLK(\FF_Bit1/SR3/N0 ), .C(n21) );
  CKNXD16 U42 ( .I(n21), .ZN(CountOut[1]) );
  CKBD0 U43 ( .CLK(\FF_Bit2/SR3/N0 ), .C(n23) );
  CKNXD16 U44 ( .I(n23), .ZN(CountOut[2]) );
  CKND0 U45 ( .CLK(n28), .CN(n29) );
  CKBD0 U46 ( .CLK(n30), .C(n25) );
  CKNXD16 U47 ( .I(n25), .ZN(CountOut[3]) );
  CKND0 U48 ( .CLK(n34), .CN(n30) );
  IND2D1 U49 ( .A1(\FF_Bit3/SR3/N1 ), .B1(\FF_Bit3/from_oR1 ), .ZN(n34) );
  OR3D0 U50 ( .A1(n29), .A2(\FF_Bit0/SR2/N0 ), .A3(ClearIn), .Z(Qn_wire0) );
  INVD0 U51 ( .I(\FF_Bit2/SR3/N0 ), .ZN(n35) );
  INR2D1 U52 ( .A1(ClockIn), .B1(ClearIn), .ZN(n14) );
  IND3D1 U53 ( .A1(ClearIn), .B1(n10), .B2(wireToD2), .ZN(\FF_Bit2/from_oR2 )
         );
  INVD1 U54 ( .I(\FF_Bit2/SR2/N0 ), .ZN(n10) );
  CKND0 U55 ( .CLK(\FF_Bit3/SR2/N0 ), .CN(\FF_Bit3/from_oS2 ) );
  TIEH U56 ( .Z(\FF_Bit0/*Logic1* ) );
  INVD0 U57 ( .I(\FF_Bit0/SR2/N0 ), .ZN(\FF_Bit0/from_oS2 ) );
  INVD0 U58 ( .I(\FF_Bit0/SR2/N1 ), .ZN(\FF_Bit0/from_oR2 ) );
  INVD0 U59 ( .I(\FF_Bit0/from_oR2 ), .ZN(n31) );
  INVD1 U60 ( .I(n31), .ZN(n32) );
  XNR2D1 U61 ( .A1(n17), .A2(\FF_Bit3/SR3/N1 ), .ZN(n12) );
  ND3D1 U62 ( .A1(n10), .A2(n35), .A3(\FF_Bit3/Clrbar ), .ZN(Qn_wire2) );
endmodule

