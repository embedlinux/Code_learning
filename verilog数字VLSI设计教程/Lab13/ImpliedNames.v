// ===========================================================
// ImpliedNames:  Shows how a module can be wired with
// implied net names, only.
//
// ------------------------------------------------------------
// 2005-04-21 jmw: 1.01 Minor rewording of comments.
// 2005-01-05 jmw: 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module ImpliedNames (output Xout, input Ain, Bin);
//
and #1 and01(Xout, Ain, Bin);
//
endmodule // ImpliedNames.

module Tester;
//
wire Xwire;
//
// Can't do anything without using a reg somewhere.
// If the next are wires, nothing can be changed 
// procedurally during simulation, and there won't be anything
// to hold a value.   By putting the reg's in the port map, they
// are associated with implied input wires of their same name.
// Xwire is not allowed to be a reg, because it is associated with
// an output.
//
reg Areg, Breg;
//
initial
  begin
  #0 Areg = 1'b0;
  #1 Breg = 1'b0;
  #3 Areg = 1'b1;
  #3 Breg = 1'b1;
  #2 $finish;
  end
//
ImpliedNames Implied1(.Xout(Xwire), .Ain(Areg), .Bin(Breg) );
//
endmodule // Tester.
