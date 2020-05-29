
module Synch4DFFGates ( CountOut, ClockIn, ClearIn );
  output [3:0] CountOut;
  input ClockIn, ClearIn;
  wire   n29, Qn_wire0, Qn_wire1, OrToFF2, Qn_wire2, wireToD1, wireToD2,
         \FF_Bit0/from_oS2 , \FF_Bit0/from_oR2 , \FF_Bit0/from_oR1 ,
         \FF_Bit1/from_oR2 , \FF_Bit1/from_oR1 , \FF_Bit2/from_oR2 ,
         \FF_Bit2/from_oR1 , \FF_Bit3/from_oS2 , \FF_Bit3/Clrbar ,
         \FF_Bit3/from_oR2 , \FF_Bit3/from_oR1 , \FF_Bit0/*Logic1* ,
         \FF_Bit0/SR1/N0 , \FF_Bit0/SR2/N1 , \FF_Bit0/SR2/N0 ,
         \FF_Bit0/SR3/N0 , \FF_Bit1/SR1/N0 , \FF_Bit1/SR2/N0 ,
         \FF_Bit1/SR3/N0 , \FF_Bit2/SR1/N0 , \FF_Bit2/SR2/N0 ,
         \FF_Bit2/SR3/N0 , \FF_Bit3/SR1/N0 , \FF_Bit3/SR2/N0 ,
         \FF_Bit3/SR3/N1 , n16, n18, n20, n21, n23, n24, n25, n26, n27, n28;

  AN3D4 \FF_Bit3/SR3/BotNand  ( .A1(\FF_Bit3/Clrbar ), .A2(n16), .A3(
        \FF_Bit3/from_oS2 ), .Z(\FF_Bit3/SR3/N1 ) );
  AN3D4 \FF_Bit3/SR2/TopNand  ( .A1(\FF_Bit3/from_oR1 ), .A2(
        \FF_Bit3/from_oR2 ), .A3(ClockIn), .Z(\FF_Bit3/SR2/N0 ) );
  AN3D4 \FF_Bit3/SR1/TopNand  ( .A1(\FF_Bit3/from_oR2 ), .A2(
        \FF_Bit3/from_oR1 ), .A3(\FF_Bit0/*Logic1* ), .Z(\FF_Bit3/SR1/N0 ) );
  AN3D4 \FF_Bit2/SR3/TopNand  ( .A1(\FF_Bit2/from_oR1 ), .A2(Qn_wire2), .A3(
        \FF_Bit0/*Logic1* ), .Z(\FF_Bit2/SR3/N0 ) );
  AN3D4 \FF_Bit2/SR2/TopNand  ( .A1(\FF_Bit2/from_oR1 ), .A2(
        \FF_Bit2/from_oR2 ), .A3(ClockIn), .Z(\FF_Bit2/SR2/N0 ) );
  AN3D4 \FF_Bit2/SR1/TopNand  ( .A1(\FF_Bit2/from_oR2 ), .A2(
        \FF_Bit2/from_oR1 ), .A3(\FF_Bit0/*Logic1* ), .Z(\FF_Bit2/SR1/N0 ) );
  AN3D4 \FF_Bit1/SR3/TopNand  ( .A1(\FF_Bit1/from_oR1 ), .A2(Qn_wire1), .A3(
        \FF_Bit0/*Logic1* ), .Z(\FF_Bit1/SR3/N0 ) );
  AN3D4 \FF_Bit1/SR2/TopNand  ( .A1(\FF_Bit1/from_oR1 ), .A2(
        \FF_Bit1/from_oR2 ), .A3(ClockIn), .Z(\FF_Bit1/SR2/N0 ) );
  AN3D4 \FF_Bit1/SR1/TopNand  ( .A1(\FF_Bit1/from_oR2 ), .A2(
        \FF_Bit1/from_oR1 ), .A3(\FF_Bit0/*Logic1* ), .Z(\FF_Bit1/SR1/N0 ) );
  AN3D4 \FF_Bit0/SR3/TopNand  ( .A1(\FF_Bit0/from_oR1 ), .A2(Qn_wire0), .A3(
        \FF_Bit0/*Logic1* ), .Z(\FF_Bit0/SR3/N0 ) );
  AN3D4 \FF_Bit0/SR2/TopNand  ( .A1(\FF_Bit0/from_oR1 ), .A2(
        \FF_Bit0/from_oR2 ), .A3(ClockIn), .Z(\FF_Bit0/SR2/N0 ) );
  AN3D4 \FF_Bit0/SR2/BotNand  ( .A1(Qn_wire0), .A2(\FF_Bit0/from_oS2 ), .A3(
        \FF_Bit3/Clrbar ), .Z(\FF_Bit0/SR2/N1 ) );
  AN3D4 \FF_Bit0/SR1/TopNand  ( .A1(\FF_Bit0/from_oR2 ), .A2(
        \FF_Bit0/from_oR1 ), .A3(\FF_Bit0/*Logic1* ), .Z(\FF_Bit0/SR1/N0 ) );
  XOR2D2 C13 ( .A1(Qn_wire2), .A2(OrToFF2), .Z(wireToD2) );
  XOR2D2 C12 ( .A1(Qn_wire0), .A2(Qn_wire1), .Z(wireToD1) );
  CKNXD16 U25 ( .I(n21), .ZN(CountOut[3]) );
  IND3D1 U26 ( .A1(n23), .B1(\FF_Bit0/from_oS2 ), .B2(n25), .ZN(OrToFF2) );
  OR3D0 U27 ( .A1(n23), .A2(ClearIn), .A3(\FF_Bit0/SR2/N0 ), .Z(Qn_wire0) );
  OR3D1 U28 ( .A1(n20), .A2(ClearIn), .A3(\FF_Bit2/SR2/N0 ), .Z(Qn_wire2) );
  CKNXD16 U29 ( .I(n23), .ZN(CountOut[0]) );
  CKNXD16 U30 ( .I(n20), .ZN(CountOut[2]) );
  CKNXD16 U31 ( .I(n21), .ZN(n16) );
  IND2D1 U32 ( .A1(\FF_Bit3/SR3/N1 ), .B1(\FF_Bit3/from_oR1 ), .ZN(n29) );
  IND2D1 U33 ( .A1(\FF_Bit3/SR1/N0 ), .B1(n28), .ZN(\FF_Bit3/from_oR1 ) );
  CKBD0 U34 ( .CLK(\FF_Bit2/SR3/N0 ), .C(n20) );
  CKBD0 U35 ( .CLK(\FF_Bit0/SR3/N0 ), .C(n23) );
  CKND0 U36 ( .CLK(n29), .CN(n21) );
  CKBD0 U37 ( .CLK(\FF_Bit1/SR3/N0 ), .C(n18) );
  CKNXD16 U38 ( .I(n18), .ZN(CountOut[1]) );
  TIEH U39 ( .Z(\FF_Bit0/*Logic1* ) );
  CKND0 U40 ( .CLK(n25), .CN(Qn_wire1) );
  ND3D0 U41 ( .A1(\FF_Bit3/Clrbar ), .A2(\FF_Bit3/from_oS2 ), .A3(n26), .ZN(
        \FF_Bit3/from_oR2 ) );
  CKXOR2D0 U42 ( .A1(\FF_Bit3/SR3/N1 ), .A2(n27), .Z(n26) );
  NR3D0 U43 ( .A1(OrToFF2), .A2(\FF_Bit2/SR3/N0 ), .A3(\FF_Bit2/SR2/N0 ), .ZN(
        n27) );
  NR3D0 U44 ( .A1(\FF_Bit1/SR2/N0 ), .A2(\FF_Bit1/SR3/N0 ), .A3(ClearIn), .ZN(
        n25) );
  CKND0 U45 ( .CLK(\FF_Bit3/SR2/N0 ), .CN(\FF_Bit3/from_oS2 ) );
  ND3D0 U46 ( .A1(\FF_Bit3/Clrbar ), .A2(n24), .A3(wireToD2), .ZN(
        \FF_Bit2/from_oR2 ) );
  CKND0 U47 ( .CLK(\FF_Bit2/SR2/N0 ), .CN(n24) );
  IND2D0 U48 ( .A1(\FF_Bit2/SR1/N0 ), .B1(n28), .ZN(\FF_Bit2/from_oR1 ) );
  IND3D0 U49 ( .A1(\FF_Bit1/SR2/N0 ), .B1(\FF_Bit3/Clrbar ), .B2(wireToD1), 
        .ZN(\FF_Bit1/from_oR2 ) );
  CKND0 U50 ( .CLK(ClearIn), .CN(\FF_Bit3/Clrbar ) );
  IND2D0 U51 ( .A1(\FF_Bit1/SR1/N0 ), .B1(n28), .ZN(\FF_Bit1/from_oR1 ) );
  CKND0 U52 ( .CLK(\FF_Bit0/SR2/N0 ), .CN(\FF_Bit0/from_oS2 ) );
  CKND0 U53 ( .CLK(\FF_Bit0/SR2/N1 ), .CN(\FF_Bit0/from_oR2 ) );
  IND2D0 U54 ( .A1(\FF_Bit0/SR1/N0 ), .B1(n28), .ZN(\FF_Bit0/from_oR1 ) );
  INR2D0 U55 ( .A1(ClockIn), .B1(ClearIn), .ZN(n28) );
endmodule

