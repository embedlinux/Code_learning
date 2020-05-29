
module SyncClearFlipFlop ( Q, D, clk, clr );
  input D, clk, clr;
  output Q;
  wire   n3, n5, n6;

  SDFQND0 QReg_reg ( .D(D), .SI(n5), .SE(clr), .CP(clk), .QN(n6) );
  TIEL U4 ( .ZN(n5) );
  CKBD0 U5 ( .CLK(n6), .C(n3) );
  CKNXD16 U6 ( .I(n3), .ZN(Q) );
endmodule

