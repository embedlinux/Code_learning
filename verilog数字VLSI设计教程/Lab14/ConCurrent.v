// ===================================================
// Concurrent.   Illustrates concurrency, precedence,
// and inertial delay of nonblocking assignments.
//
// ---------------------------------------------------
// 2005-04-28 jmw: v. 1.0 implemented.
// ---------------------------------------------------
`timescale 1ns/100ps
//
module Concurrent(output OutDirect, OutInvert
                 , OutDirFork, input In);
//
reg OutDirectReg, OutInvertReg, OutDirForkReg;
//
assign OutDirect = OutDirectReg;
assign OutInvert = OutInvertReg;
assign OutDirFork = OutDirForkReg;
//
always@(In)
  begin
   #2 OutInvertReg <= ~In;
   #2 OutInvertReg <=  In;
  end
//
always@(In)
  begin
   #2 OutDirectReg <=  In;
   #2 OutDirectReg <= ~In;
  end
//
always@(In)
  begin
   fork
   #2 OutDirForkReg <=  In;
   #2 OutDirForkReg <= ~In;
   join
  end
//
endmodule // Concurrent.
//
module ConcurrentTst;
wire OutDirectWire, OutInvertWire, OutDirForkWire;
reg InReg;
//
initial
  begin
  #0  InReg = 1'b0;
  #1  InReg = 1'b1;
  #2  InReg = 1'b0;
  #2  InReg = 1'b1;
  #2  InReg = 1'b0;
  #2  InReg = 1'b1;
  #3  InReg = 1'b0;
  #3  InReg = 1'b1;
  #3  InReg = 1'b0;
  #3  InReg = 1'b1;
  #4  InReg = 1'b0;
  #4  InReg = 1'b1;
  #4  InReg = 1'b0;
  #4  InReg = 1'b1;
  #10 InReg = 1'b0;
  #10 InReg = 1'b1;
  #10 InReg = 1'b0;
  #10 InReg = 1'b1;
  #10 InReg = 1'b0;
  #10 InReg = 1'b1;
  #10 InReg = 1'b0;
  #10 InReg = 1'b1;
  #10 $finish;
  end
//
Concurrent U1 (.OutDirect(OutDirectWire)
              , .OutInvert(OutInvertWire)
              , .OutDirFork(OutDirForkWire), .In(InReg)
              );
endmodule // ConcurrentTst.
