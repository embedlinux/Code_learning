
module ArrayIxedBus ( DBusBuf, DBus, QEna, Rst, Clk );
  output [7:0] DBusBuf;
  input [7:0] DBus;
  input [7:0] QEna;
  input Rst, Clk;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n17;
  wire   [7:0] QWire;

  DFFa_7 \FF[0]  ( .Q(QWire[0]), .D(DBus[0]), .Clr(n17), .Clk(Clk) );
  DFFa_6 \FF[1]  ( .Q(QWire[1]), .D(DBus[1]), .Clr(n17), .Clk(Clk) );
  DFFa_5 \FF[2]  ( .Q(QWire[2]), .D(DBus[2]), .Clr(n17), .Clk(Clk) );
  DFFa_4 \FF[3]  ( .Q(QWire[3]), .D(DBus[3]), .Clr(n17), .Clk(Clk) );
  DFFa_3 \FF[4]  ( .Q(QWire[4]), .D(DBus[4]), .Clr(n17), .Clk(Clk) );
  DFFa_2 \FF[5]  ( .Q(QWire[5]), .D(DBus[5]), .Clr(n17), .Clk(Clk) );
  DFFa_1 \FF[6]  ( .Q(QWire[6]), .D(DBus[6]), .Clr(n17), .Clk(Clk) );
  DFFa_0 \FF[7]  ( .Q(QWire[7]), .D(DBus[7]), .Clr(n17), .Clk(Clk) );
  CKND0 U1 ( .CLK(QWire[7]), .CN(n16) );
  CKND0 U2 ( .CLK(QWire[6]), .CN(n15) );
  CKND0 U3 ( .CLK(QWire[5]), .CN(n14) );
  CKND0 U4 ( .CLK(QWire[4]), .CN(n13) );
  CKND0 U5 ( .CLK(QWire[3]), .CN(n12) );
  CKND0 U6 ( .CLK(QWire[2]), .CN(n11) );
  CKND0 U7 ( .CLK(QWire[1]), .CN(n10) );
  CKND0 U8 ( .CLK(QWire[0]), .CN(n9) );
  BUFTD16 \Nuf[7]  ( .I(n16), .OE(QEna[7]), .Z(DBusBuf[7]) );
  BUFTD16 \Nuf[6]  ( .I(n15), .OE(QEna[6]), .Z(DBusBuf[6]) );
  BUFTD16 \Nuf[5]  ( .I(n14), .OE(QEna[5]), .Z(DBusBuf[5]) );
  BUFTD16 \Nuf[4]  ( .I(n13), .OE(QEna[4]), .Z(DBusBuf[4]) );
  BUFTD16 \Nuf[3]  ( .I(n12), .OE(QEna[3]), .Z(DBusBuf[3]) );
  BUFTD16 \Nuf[2]  ( .I(n11), .OE(QEna[2]), .Z(DBusBuf[2]) );
  BUFTD16 \Nuf[1]  ( .I(n10), .OE(QEna[1]), .Z(DBusBuf[1]) );
  BUFTD16 \Nuf[0]  ( .I(n9), .OE(QEna[0]), .Z(DBusBuf[0]) );
  BUFFD1 U9 ( .I(Rst), .Z(n17) );
endmodule


module DFFa_7 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q) );
endmodule


module DFFa_0 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule


module DFFa_1 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule


module DFFa_2 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule


module DFFa_3 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule


module DFFa_4 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule


module DFFa_5 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule


module DFFa_6 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule

