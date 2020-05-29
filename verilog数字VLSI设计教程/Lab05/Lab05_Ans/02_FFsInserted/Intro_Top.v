// ===========================================================
// Intro_Top:  Top level of a simple design.
//
// This module contains the top structure of the design, which
// is made up of three lower-level modules and one inverter gate.
// The structure is represented by module instances.
//
// ------------------------------------------------------------
// 2006-04-18 jmw: v. 1.1 JTAG port and FF's added for Lab05,
//            through Step3.
// 2004-12-08 jmw: v. 1.0 of Intro_Top implemented by copying 
//            from Lab01.
// ============================================================
module Intro_Top ( output X, Y, Z, input A, B, C, D
                 , output ScanOut
                 ,  input ScanMode, ScanIn, ScanClr, ScanClk
                 );
wire ab, bc, q, qn;  // Wires for internal connectivity.
//
// New FF wires:
wire X_to_FFX, Y_to_FFY, Z_to_FFZ
   , FFA_to_A, FFB_to_B, FFC_to_C, FFD_to_D;
//
assign #1 Z_to_FFZ = ~qn; // Inverter by continuous assignment statement.
//
AndOr InputCombo  (.X(ab), .Y(bc), .A(FFA_to_A), .B(FFB_to_B), .C(FFC_to_C));
   SR SRLatch     (.Q(q), .Qn(qn), .S(bc), .R(FFD_to_D));
XorNor OutputCombo (.X(X_to_FFX), .Y(Y_to_FFY), .A(ab), .B(q), .C(qn));
//
// New FF's:
// The FFC model has a Qn output, but unconnected outputs
// simply may be omitted.
FFC FF_X(.Q(X), .D(X_to_FFX), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_Y(.Q(Y), .D(Y_to_FFY), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_Z(.Q(Z), .D(Z_to_FFZ), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_A(.Q(FFA_to_A), .D(A), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_B(.Q(FFB_to_B), .D(B), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_C(.Q(FFC_to_C), .D(C), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_D(.Q(FFD_to_D), .D(D), .Clk(ScanClk), .Clr(ScanClr));
//
endmodule // Intro_Top.
