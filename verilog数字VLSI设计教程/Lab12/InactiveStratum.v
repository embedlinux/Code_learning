// ===========================================================
// InactiveStratum:  Shows the effect of events put into the
//                   inactive stratum by #0.
// ------------------------------------------------------------
// 2009-09-21 jmw: 1.0 Implemented.
//                 In Case 1, the final values are:
//                 VCS: A=0, Z=1, Zin=1.
//                 QS:  A=0, Z=0, Zin=0.
//                 In Case 2, the final values are:
//                 VCS: A=0, Z=x, Zin=0.
//                 QS:  A=0, Z=0, Zin=0.
// ============================================================
//
//`define Case1
//
`timescale 1ns/100ps
//
module InactiveStratum;
//
reg Clk, A, Z, Zin;
//
always@(posedge Clk)
  begin
      A = 1'b1;
   #0 A = 1'b0;
  end
// 
`ifdef Case1
// Case 1:  Z inactive:
always@(A) #0 Z = Zin;  always@(A) Zin = A;
//
`else
// Case 2:  Zin inactive:
always@(A) Z = Zin;  always@(A) #0 Zin = A;
// 
`endif
//
initial
  begin
  #50 Clk = 1'bz;
  #50 Clk = 1'b0;
  #50 Clk = 1'b1;
  #50 $finish;
  end
//
endmodule // InactiveStratum.
//
