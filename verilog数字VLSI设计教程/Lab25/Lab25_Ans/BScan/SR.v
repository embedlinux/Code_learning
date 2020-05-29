// ===========================================================
// SR:  An S-R Latch using ~ and &.
// This module represents the functionality of a simple latch,
// which is a sequential logic device, using combinational 
// ~AND expressions connected to feed back on each other.
//
// ANSI module header.
// ------------------------------------------------------------
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
module SR (output Q, Qn, input S, R);
  wire q, qn;  // An output port can't be read, otherwise.
  //
  assign #1 Q  = q;
  assign #1 Qn = qn;
  //
  assign #10 q  = ~(S & qn);
  assign #10 qn = ~(R & q );
  //
endmodule // SR
