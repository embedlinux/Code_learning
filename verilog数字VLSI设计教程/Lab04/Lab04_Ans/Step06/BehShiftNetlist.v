
module BehShift ( QOut, DIn, ShiftEna, ClkIn, ClrIn );
  input DIn, ShiftEna, ClkIn, ClrIn;
  output QOut;
  wire   n1, n3, n9;
  wire   [3:0] QReg;

  INVD1 U2 ( .I(ClrIn), .ZN(n1) );
  EDFCND1 \QReg_reg[3]  ( .D(QReg[2]), .E(ShiftEna), .CP(ClkIn), .CDN(n1), .Q(
        QReg[3]) );
  EDFCND1 \QReg_reg[2]  ( .D(QReg[1]), .E(ShiftEna), .CP(ClkIn), .CDN(n1), .Q(
        QReg[2]) );
  EDFCND1 \QReg_reg[1]  ( .D(QReg[0]), .E(ShiftEna), .CP(ClkIn), .CDN(n1), .Q(
        QReg[1]) );
  EDFCND1 \QReg_reg[0]  ( .D(DIn), .E(ShiftEna), .CP(ClkIn), .CDN(n1), .Q(
        QReg[0]) );
  EDFCND1 \QReg_reg[4]  ( .D(QReg[3]), .E(ShiftEna), .CP(ClkIn), .CDN(n1), 
        .QN(n9) );
  CKBD0 U3 ( .CLK(n9), .C(n3) );
  CKNXD16 U4 ( .I(n3), .ZN(QOut) );
endmodule

