// ===========================================================
// Intro_Top:  Top level of a simple design.
//
// This module contains the top structure of the design, which
// is made up of three lower-level modules and one inverter gate.
// The structure is represented by module instances.
//
// ------------------------------------------------------------
// 2007-03-19 jmw: v. 1.1 Removed FF's to conform with WB Lab05
//            instructions:  JTAG port added for Step1.
// 2004-12-08 jmw: v. 1.0 of Intro_Top implemented by copying 
//            from Lab01.
// ============================================================
module Intro_Top ( output X, Y, Z, input A, B, C, D
                 , output ScanOut
                 ,  input ScanMode, ScanIn, ScanClr, ScanClk
                 );
  wire ab, bc, q, qn;  // Wires for internal connectivity.
  //
  assign #1 Z = ~qn; // Inverter by continuous assignment statement.
  //
   AndOr InputCombo  (.X(ab), .Y(bc), .A(A), .B(B), .C(C));
      SR SRLatch     (.Q(q), .Qn(qn), .S(bc), .R(D));
  XorNor OutputCombo (.X(X), .Y(Y), .A(ab), .B(q), .C(qn));
  //
endmodule // Intro_Top.
