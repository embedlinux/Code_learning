
module GenBuffedBus ( DBusBuf, DBus, QEna, Rst, Clk );
  output [7:0] DBusBuf;
  input [7:0] DBus;
  input [7:0] QEna;
  input Rst, Clk;
  wire   \BuffedBus[0].QWire , \BuffedBus[1].QWire , \BuffedBus[2].QWire ,
         \BuffedBus[3].QWire , \BuffedBus[4].QWire , \BuffedBus[5].QWire ,
         \BuffedBus[6].QWire , \BuffedBus[7].QWire , n9, n10, n11, n12, n13,
         n14, n15, n16, n17;

  DFFa_0 \BuffedBus[0].FF  ( .Q(\BuffedBus[0].QWire ), .D(DBus[0]), .Clr(n17), 
        .Clk(Clk) );
  DFFa_7 \BuffedBus[1].FF  ( .Q(\BuffedBus[1].QWire ), .D(DBus[1]), .Clr(n17), 
        .Clk(Clk) );
  DFFa_6 \BuffedBus[2].FF  ( .Q(\BuffedBus[2].QWire ), .D(DBus[2]), .Clr(n17), 
        .Clk(Clk) );
  DFFa_5 \BuffedBus[3].FF  ( .Q(\BuffedBus[3].QWire ), .D(DBus[3]), .Clr(n17), 
        .Clk(Clk) );
  DFFa_4 \BuffedBus[4].FF  ( .Q(\BuffedBus[4].QWire ), .D(DBus[4]), .Clr(n17), 
        .Clk(Clk) );
  DFFa_3 \BuffedBus[5].FF  ( .Q(\BuffedBus[5].QWire ), .D(DBus[5]), .Clr(n17), 
        .Clk(Clk) );
  DFFa_2 \BuffedBus[6].FF  ( .Q(\BuffedBus[6].QWire ), .D(DBus[6]), .Clr(n17), 
        .Clk(Clk) );
  DFFa_1 \BuffedBus[7].FF  ( .Q(\BuffedBus[7].QWire ), .D(DBus[7]), .Clr(n17), 
        .Clk(Clk) );
  CKND0 U1 ( .CLK(\BuffedBus[7].QWire ), .CN(n16) );
  CKND0 U2 ( .CLK(\BuffedBus[6].QWire ), .CN(n15) );
  CKND0 U3 ( .CLK(\BuffedBus[5].QWire ), .CN(n14) );
  CKND0 U4 ( .CLK(\BuffedBus[4].QWire ), .CN(n13) );
  CKND0 U5 ( .CLK(\BuffedBus[3].QWire ), .CN(n12) );
  CKND0 U6 ( .CLK(\BuffedBus[2].QWire ), .CN(n11) );
  CKND0 U7 ( .CLK(\BuffedBus[1].QWire ), .CN(n10) );
  CKND0 U8 ( .CLK(\BuffedBus[0].QWire ), .CN(n9) );
  BUFTD16 \BuffedBus[7].Nuf  ( .I(n16), .OE(QEna[7]), .Z(DBusBuf[7]) );
  BUFTD16 \BuffedBus[6].Nuf  ( .I(n15), .OE(QEna[6]), .Z(DBusBuf[6]) );
  BUFTD16 \BuffedBus[5].Nuf  ( .I(n14), .OE(QEna[5]), .Z(DBusBuf[5]) );
  BUFTD16 \BuffedBus[4].Nuf  ( .I(n13), .OE(QEna[4]), .Z(DBusBuf[4]) );
  BUFTD16 \BuffedBus[3].Nuf  ( .I(n12), .OE(QEna[3]), .Z(DBusBuf[3]) );
  BUFTD16 \BuffedBus[2].Nuf  ( .I(n11), .OE(QEna[2]), .Z(DBusBuf[2]) );
  BUFTD16 \BuffedBus[1].Nuf  ( .I(n10), .OE(QEna[1]), .Z(DBusBuf[1]) );
  BUFTD16 \BuffedBus[0].Nuf  ( .I(n9), .OE(QEna[0]), .Z(DBusBuf[0]) );
  BUFFD1 U9 ( .I(Rst), .Z(n17) );
endmodule


module DFFa_0 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n1;

  INVD1 U3 ( .I(Clr), .ZN(n1) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n1), .Q(Q) );
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


module DFFa_7 ( Q, D, Clr, Clk );
  input D, Clr, Clk;
  output Q;
  wire   n2;

  INVD1 U3 ( .I(Clr), .ZN(n2) );
  DFCNQD1 QReg_reg ( .D(D), .CP(Clk), .CDN(n2), .Q(Q) );
endmodule

