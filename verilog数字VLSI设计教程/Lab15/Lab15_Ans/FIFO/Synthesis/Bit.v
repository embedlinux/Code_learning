// ==================================================
// Bit.   DFF memory cell model for use with 
//        Mem1kx32gen.
//
// 2005-01-13 jmw v. 1.0 implemented.
// --------------------------------------------------
module Bit(output Q, input D, Clk);
reg QReg;
//
assign #1 Q = QReg;
//
always@(posedge Clk) QReg <= D;
//
endmodule //Bit.
