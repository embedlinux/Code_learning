// ===========================================================
// ConCurrent:  Shows cancellation of one assignment by
//              a concurrent one, until the input delay
//  becomes long enough.  Eventually, the last line read,
//  which is an inverted input, is the only one executed.
//
// ------------------------------------------------------------
// 2005-12-20 jmw: 1.1 Added this file-comment header.   Renamed
//            the module and tb to match the file name.
// 2005-01-03 jmw: 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module ConCurrent(output Out, input In);
//
reg OutReg;
//
assign Out = OutReg;
//
always@(In)
  begin
   #2 OutReg <=  In;
   #2 OutReg <= ~In;
  end
//
endmodule // ConCurrent.
//
module ConCurrentTst;
wire OutWire;
reg InReg;

initial
  begin
  #0  InReg = 1'b0;
  #1  InReg = 1'b1;
  #2  InReg = 1'b0;
  #3  InReg = 1'b1;
  #4  InReg = 1'b0;
  #4  InReg = 1'b1;
  #4  InReg = 1'b0;
  #4  InReg = 1'b1;
  #10  InReg = 1'b0;
  #10  InReg = 1'b1;
  #10  InReg = 1'b0;
  #10  InReg = 1'b1;
  #10  InReg = 1'b0;
  #10  InReg = 1'b1;
  #10  InReg = 1'b0;
  #10  InReg = 1'b1;
  #10 $finish;
  end

ConCurrent U1 (.Out(OutWire), .In(InReg) );

endmodule // ConCurrentTst.
