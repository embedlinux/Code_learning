
module EventCtl ( a, b, c, xPart, yPart, xOnly, yOnly, xOnePort, xLatch, 
        yLatch );
  input a, b, c;
  output xPart, yPart, xOnly, yOnly, xOnePort, xLatch, yLatch;
  wire   n1, n2, n3;

  EventCtlLatch Latch_U5 ( .xLatch(xLatch), .yLatch(yLatch), .a(n3), .b(n2), 
        .c(n1) );
  EventCtlPart Part_U2 ( .xPart(xPart), .yPart(yPart), .a(n3), .b(n2), .c(n1)
         );
  EventCtlOnly Only_U3 ( .xOnly(xOnly), .yOnly(yOnly), .a(n3), .b(n2), .c(n1)
         );
  EventCtlOnePort OnePort_U4 ( .xOnePort(xOnePort), .a(n3), .b(n2), .c(n1) );
  BUFFD3 U1 ( .I(b), .Z(n2) );
  BUFFD3 U2 ( .I(c), .Z(n1) );
  BUFFD3 U3 ( .I(a), .Z(n3) );
endmodule


module EventCtlLatch ( xLatch, yLatch, a, b, c );
  input a, b, c;
  output xLatch, yLatch;
  wire   n8, n9, N0, N1, n1, n2, n3, n4, n6;

  LHQD1 xReg_reg ( .E(a), .D(N0), .Q(n8) );
  LHQD2 yReg_reg ( .E(b), .D(N1), .Q(n9) );
  INVD1 U2 ( .I(n9), .ZN(n4) );
  INVD1 U3 ( .I(n8), .ZN(n6) );
  NR2D1 U4 ( .A1(n3), .A2(n2), .ZN(N0) );
  ND2D1 U5 ( .A1(n2), .A2(n3), .ZN(n1) );
  INVD0 U6 ( .I(c), .ZN(n2) );
  INVD0 U7 ( .I(b), .ZN(n3) );
  INVD16 U8 ( .I(n4), .ZN(yLatch) );
  XOR2D0 U9 ( .A1(a), .A2(n1), .Z(N1) );
  INVD16 U10 ( .I(n6), .ZN(xLatch) );
endmodule


module EventCtlPart ( xPart, yPart, a, b, c );
  input a, b, c;
  output xPart, yPart;
  wire   n6, n7, n1, n2, n4;

  INVD1 U1 ( .I(n6), .ZN(n2) );
  INVD1 U2 ( .I(n7), .ZN(n4) );
  NR2XD2 U3 ( .A1(b), .A2(c), .ZN(n1) );
  XNR2D2 U4 ( .A1(n1), .A2(a), .ZN(n7) );
  INVD16 U5 ( .I(n2), .ZN(xPart) );
  AN3D1 U6 ( .A1(b), .A2(c), .A3(a), .Z(n6) );
  INVD16 U7 ( .I(n4), .ZN(yPart) );
endmodule


module EventCtlOnly ( xOnly, yOnly, a, b, c );
  input a, b, c;
  output xOnly, yOnly;
  wire   n6, n7, n1, n2, n4;

  INVD1 U1 ( .I(n7), .ZN(n4) );
  INVD1 U2 ( .I(n6), .ZN(n2) );
  XNR2D2 U3 ( .A1(n1), .A2(a), .ZN(n7) );
  NR2XD2 U4 ( .A1(b), .A2(c), .ZN(n1) );
  INVD16 U5 ( .I(n2), .ZN(xOnly) );
  AN3D1 U6 ( .A1(c), .A2(a), .A3(b), .Z(n6) );
  INVD16 U7 ( .I(n4), .ZN(yOnly) );
endmodule


module EventCtlOnePort ( xOnePort, a, b, c );
  input a, b, c;
  output xOnePort;
  wire   n3, n1;

  INVD1 U1 ( .I(n3), .ZN(n1) );
  INVD16 U2 ( .I(n1), .ZN(xOnePort) );
  AN3D1 U3 ( .A1(c), .A2(a), .A3(b), .Z(n3) );
endmodule

