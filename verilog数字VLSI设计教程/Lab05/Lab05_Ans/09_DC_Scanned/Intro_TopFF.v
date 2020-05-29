// ===========================================================
// Intro_TopFF:  Intro_Top modifed with D ff's on its outputs.
//
// This module contains the top structure of the design, which
// is made up of three lower-level modules and one inverter gate.
// The structure is represented by module instances.
//
// ------------------------------------------------------------
// 2006-04-19 jmw: v. 1.1 of Intro_Top renamed to Intro_TopFF
//            and modified for DC automatic scan-insertion.
// 2004-12-07 jmw: v. 1.0 of Intro_Top implemented by copying 
//            from Lab01.
// ============================================================
module Intro_TopFF (output X, Y, Z
                   ,       tdo
                   , input A, B, C, D, Clk, Clr
                   ,       tms, tdi
                   );
  //
  wire ab, bc, SRq, SRqn     // Wires for internal connectivity.
     , toFFX_D, toFFY_D, toFFZ_D;
  //
  assign #1 toFFZ_D = ~SRqn; // Inverter.
  //
   AndOr InputCombo  (.X(ab), .Y(bc), .A(A), .B(B), .C(C));
      SR SRLatch     (.Q(SRq), .Qn(SRqn), .S(bc), .R(D));
  XorNor OutputCombo (.X(toFFX_D), .Y(toFFY_D), .A(ab), .B(SRq), .C(SRqn));
  //
  FFC FFX (.Q(X), /*.Qn(),*/ .D(toFFX_D), .Clk(Clk), .Clr(Clr) );
  FFC FFY (.Q(Y), /*.Qn(),*/ .D(toFFY_D), .Clk(Clk), .Clr(Clr) );
  FFC FFZ (.Q(Z), /*.Qn(),*/ .D(toFFZ_D), .Clk(Clk), .Clr(Clr) );
  //
endmodule // Intro_TopFF.
