// ===========================================================
// Intro_TopFF:  Top level of a simple design.
//
// This module contains the top structure of the design, which
// is made up of three lower-level modules and one inverter gate.
// The structure is represented by module instances.
//
// ------------------------------------------------------------
// 2006-06-12 jmw: v. 2.1 Added TAP ports for internal scan
//      insertion in Lab25.
// 2005-02-09 jmw: v. 2.0 of Intro_Top renamed to Intro_TopFF
//            and modified for DC automatic scan-insertion.
// 2004-12-07 jmw: v. 1.0 of Intro_Top implemented by copying 
//            from Lab01.
// 2004-11-25 jmw: v. 1.0 of Introductory_Top01 implemented.
// ============================================================
module Intro_TopFF (output X, Y, Z
                   , input A, B, C, D, Clk, Clr
                     // For scan:
                   , input  tms, tdi
                   , output tdo
                   );
  //
  wire ab, bc, SRq, SRqn     // Wires for internal connectivity.
     , toXFF_D, toYFF_D, toZFF_D;
  //
  assign #1 toZFF_D = ~SRqn; // Inverter.
  //
   AndOr InputCombo  (.X(ab), .Y(bc), .A(A), .B(B), .C(C));
      SR SRLatch     (.Q(SRq), .Qn(SRqn), .S(bc), .R(D));
  XorNor OutputCombo (.X(toXFF_D), .Y(toYFF_D), .A(ab), .B(SRq), .C(SRqn));
  //
  FFC FF_X (.Q(X), /*.Qn(),*/ .D(toXFF_D), .Clk(Clk), .Clr(Clr) );
  FFC FF_Y (.Q(Y), /*.Qn(),*/ .D(toYFF_D), .Clk(Clk), .Clr(Clr) );
  FFC FF_Z (.Q(Z), /*.Qn(),*/ .D(toZFF_D), .Clk(Clk), .Clr(Clr) );
  //
endmodule // Intro_TopFF.
