// ===========================================================
// Intro_Top:  Top level of a simple design.
//
// This module contains the top structure of the design, which
// is made up of three lower-level modules and one inverter gate.
// The structure is represented by module instances.
//
// ------------------------------------------------------------
// 2006-04-18 jmw: v. 1.2 Muxes inserted to short-circuit the
//            flip-flops when ScanMode is 0.
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
// Dummy wire, to assign unknowns to flag work yet to
// be done at this Step:
wire   UNK;
assign UNK = 1'bx;
//
// Muxed wires to the FF D inputs:
wire toD_FFX, toD_FFY, toD_FFZ
   , toD_FFA, toD_FFB, toD_FFC, toD_FFD;
//
// Wires from the FF Q outputs to muxes:
wire fromQ_FFX, fromQ_FFY, fromQ_FFZ
   , fromQ_FFA, fromQ_FFB, fromQ_FFC, fromQ_FFD;
//
AndOr InputCombo  (.X(ab), .Y(bc), .A(FFA_to_A), .B(FFB_to_B), .C(FFC_to_C));
   SR SRLatch     (.Q(q), .Qn(qn), .S(bc), .R(FFD_to_D));
XorNor OutputCombo (.X(X_to_FFX), .Y(Y_to_FFY), .A(ab), .B(q), .C(qn));
//
// The new muxes which drive a FF D input with an unknown
// in scan mode, or with its normal driver in normal mode:
assign #1 toD_FFX = (ScanMode==1'b0)? X_to_FFX : UNK;
assign #1 toD_FFY = (ScanMode==1'b0)? Y_to_FFY : UNK;
assign #1 toD_FFZ = (ScanMode==1'b0)? Z_to_FFZ : UNK;
assign #1 toD_FFA = (ScanMode==1'b0)?        A : UNK;
assign #1 toD_FFB = (ScanMode==1'b0)?        B : UNK;
assign #1 toD_FFC = (ScanMode==1'b0)?        C : UNK;
assign #1 toD_FFD = (ScanMode==1'b0)?        D : UNK;
//
// The new muxes which are driven by a FF Q output in scan mode,
// or by the other mux in normal mode:
assign #1        X = (ScanMode==1'b0)? toD_FFX: fromQ_FFX;
assign #1        Y = (ScanMode==1'b0)? toD_FFY: fromQ_FFY;
assign #1        Z = (ScanMode==1'b0)? toD_FFZ: fromQ_FFZ;
assign #1 FFA_to_A = (ScanMode==1'b0)? toD_FFA: fromQ_FFA;
assign #1 FFB_to_B = (ScanMode==1'b0)? toD_FFB: fromQ_FFB;
assign #1 FFC_to_C = (ScanMode==1'b0)? toD_FFC: fromQ_FFC;
assign #1 FFD_to_D = (ScanMode==1'b0)? toD_FFD: fromQ_FFD;
//
// Each FF now is connected to a mux on its data input and output:
//
FFC FF_X(.Q(fromQ_FFX), .D(toD_FFX), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_Y(.Q(fromQ_FFY), .D(toD_FFY), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_Z(.Q(fromQ_FFZ), .D(toD_FFZ), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_A(.Q(fromQ_FFA), .D(toD_FFA), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_B(.Q(fromQ_FFB), .D(toD_FFB), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_C(.Q(fromQ_FFC), .D(toD_FFC), .Clk(ScanClk), .Clr(ScanClr));
FFC FF_D(.Q(fromQ_FFD), .D(toD_FFD), .Clk(ScanClk), .Clr(ScanClr));
//
endmodule // Intro_Top.
