// ===========================================================
// Intro_Top:  Top level of a simple design.
//
// This module contains the top structure of the design, which
// is made up of three lower-level modules and one inverter gate.
// The structure is represented by module instances.
//
// ------------------------------------------------------------
// 2004-12-08 jmw: v. 1.0 of Intro_Top implemented by copying 
//            from Lab01.
// 2004-11-25 jmw: v. 1.0 of Introductory_Top01 implemented.
// ============================================================
module Intro_Top (output X, Y, Z, input A, B, C, D);
  //
  wire ab, bc, q, qn;  // Wires for internal connectivity.
  //
  assign #1 Z = ~qn; // Inverter by continuous assignment statement.
  //
   AndOr InputCombo  (.X(ab), .Y(bc), .A(A), .B(B), .C(C));
      SR SRLatch     (.Q(q), .Qn(qn), .S(bc), .R(D));
  XorNor OutputCombo (.X(X), .Y(Y), .A(ab), .B(q), .C(qn));
  //
endmodule // Intro_Top.
