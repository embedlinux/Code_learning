// ===================================================
// Flipper.  A sequential block containing a flip-flop
// and gated clock for timing exercises.
//
// Instantiated in SpecIt.
//
// For convenience, the flip-flop module is included in
// this file (below).
//
// 2005-12-27 jmw: v. 1.3 removed DFFC Clk check
//                    which synthesized combinational.
// 2005-05-12 jmw: v. 1.2 Removed DFFC Clr double neg;
//            added `defines.
// 2005-02-07 jmw: v. 1.0 implemented.
// ===================================================
//
// Uncomment one at a time:
//
`define Step4A 1
// `define Step4B 1
// `define Step4C 1
// `define Step4D 1
// `define Step4E 1
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
specify
  specparam tClkQR=5, tClkQF=8, dBuf=1, tClr=2;
  //
  `ifdef Step4A
  (posedge iClk => Flipo) = (tClkQR, tClkQF);
  (posedge iClk => Bufo)  = (tClkQR+dBuf, tClkQF+dBuf);
  `endif
  `ifdef Step4B
  (posedge iClk => Flipo) = (tClkQR, tClkQF);
  (posedge iClk => Bufo)  = (tClkQR+dBuf, tClkQF+dBuf);
  (negedge iClk => Bufo)  =  dBuf;
  `endif
  `ifdef Step4C
  (posedge iClk => Flipo) = (tClkQR, tClkQF);
  (posedge iClk => Bufo)  = (tClkQR+dBuf, tClkQF+dBuf);
  (negedge iClk => Bufo)  =  dBuf;
  (iClr => Flipo) =  tClr;
  (iClr => Bufo)  = (tClr+dBuf);
  `endif
  `ifdef Step4D
  (posedge iClk => Flipo) = (tClkQR, tClkQF);
  (posedge iClk => Bufo)  = (tClkQR+dBuf, tClkQF+dBuf);
  (negedge iClk => Bufo)  =  dBuf;
  (iClr => Flipo) =  tClr;
  (iClr => Bufo)  = (tClr+dBuf);
  (iClk *> Flipo, Bufo) = 30;
  `endif
  `ifdef Step4E
  (posedge iClk => Flipo) = (tClkQR, tClkQF);
  (posedge iClk => Bufo)  = (tClkQR+dBuf, tClkQF+dBuf);
  (negedge iClk => Bufo)  =  dBuf;
  (iClr => Flipo) =  tClr;
  (iClr => Bufo)  = (tClr+dBuf);
  (iClk *> Flipo, Bufo) = 0;
  `endif
  //
endspecify
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
