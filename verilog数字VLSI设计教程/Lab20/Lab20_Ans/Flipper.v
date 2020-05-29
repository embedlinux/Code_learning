// ===================================================
// Flipper.  A sequential block containing a flip-flop
// and gated clock for timing exercises.
//
// Instantiated in SpecIt.
//
// For convenience, the flip-flop module is included in
// this file (below).
//
// 2005-12-27 jmw: v. 1.2 removed DFFC Clk check
//                    which synthesized combinational.
// 2005-05-12 jmw: v. 1.1 DFF Clr removed double neg.
// 2005-02-07 jmw: v. 1.0 implemented.
// ===================================================
//
module 
Flipper(output Flipo, Bufo, input iD, iClk, iClr); 
//
wire FFn_Buf;
//
DFFC FF( .Q(Flipo), .Qn(FFn_Buf), .D(iD)
       , .Clk(iClk), .Clr(iClr));
//
bufif1 Buf (Bufo, FFn_Buf, iClk);
//
endmodule // Flipper.
//
//----------------------------------------------------
//
module DFFC(output Q, Qn, input D, Clk, Clr);
reg QReg;
//
assign Q  = QReg;
assign Qn = ~QReg;
//
always@(posedge Clk, posedge Clr)
  if (Clr==1'b1)
       QReg <= 1'b0;
  else QReg <= D;
//
endmodule // DFFC.
