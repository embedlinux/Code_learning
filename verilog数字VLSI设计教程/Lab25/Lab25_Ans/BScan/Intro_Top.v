// ===========================================================
// Intro_Top:  Top level of a simple design using
// verilog blocking assignments ("=").
//
// This module contains the top structure of the design, which
// is made up of three lower-level modules and one inverter gate.
// The structure is represented by module instances.
//
// ------------------------------------------------------------
// 2006-10-25 jmw: v. 3.2 Added dont_touch directive (required).
// 2006-10-24 jmw: v. 3.1 Added ScanRst for trst port.
// 2005-12-05 jmw: v. 3.0 Replaced class.lib I/O cells with TSMC
//            cells PDC0204CDG_18.   These are multipurpose
//            I/O pad cells configurable as output, bidirectional,
//            or input.
// 2005-03-14 jmw: v. 2.0 Copied to Lab25 dir.  Added scan ports
//           (as in Lab05) but no FFs.
//           Added IBUF4 and OBUF2 instances on respective in and
//           out ports, after finding these as pads in class lib.
//           Created an output, 3-state buffer TROUT in class.db
//           because TDO has to be 3-state.
//           Homemade verilog models are below.
// 2004-11-25 jmw: v. 1.0 implemented.
// ============================================================
module Intro_Top (output X, Y, Z, ScanOut
                 , input A, B, C, D
                 , ScanIn, ScanMode, ScanClk, ScanRst
                 );
wire ab, bc, q, qn;  // Wires for internal connectivity.
//
// Wires for Lab24 pads:
wire toX, toY, toZ, fromA, fromB, fromC, fromD;
//
assign #1 toZ = ~qn;
//
 AndOr InputCombo01  (.X(ab), .Y(bc), .A(fromA), .B(fromB), .C(fromC));
	 SR SRLatch01     (.Q(q), .Qn(qn), .S(bc), .R(fromD));
XorNor OutputCombo01 (.X(toX), .Y(toY), .A(ab), .B(q), .C(qn));
//
// Design I/O pads:
//
//synopsys dc_tcl_script_begin
// set_dont_touch *pad*;
//synopsys dc_tcl_script_end
//
// Configured as output:
PDC0204CDG_18_Out Xpad1( .PAD(X), .I(toX) );
PDC0204CDG_18_Out Ypad1( .PAD(Y), .I(toY) );
PDC0204CDG_18_Out Zpad1( .PAD(Z), .I(toZ) );
// Configured as input:
PDC0204CDG_18_In padA1( .PAD(A), .C(fromA) );
PDC0204CDG_18_In padB1( .PAD(B), .C(fromB) );
PDC0204CDG_18_In padC1( .PAD(C), .C(fromC) );
PDC0204CDG_18_In padD1( .PAD(D), .C(fromD) );
// 
// TAP I/O pads (Boundary scan wiring will be synthesized):
//
// Output ports to be synthesized may
// be omitted from the port map:
//
// TDO must be three-state:
PDC0204CDG_18_Tri TDOpad1( .PAD(ScanOut) ); //.I(), .OEN() left dangling for synthesizer.
//
// Others are simple inputs:
PDC0204CDG_18_In padTMS1 ( .PAD(ScanMode) ); // .C() left dangling for synthesizer.
PDC0204CDG_18_In padTDI1 ( .PAD(ScanIn)   ); // .C() left dangling for synthesizer.
PDC0204CDG_18_In padTCK1 ( .PAD(ScanClk)  ); // .C() left dangling for synthesizer.
PDC0204CDG_18_In padTRST1( .PAD(ScanRst)  ); // .C() left dangling for synthesizer.
//
endmodule // Intro_Top.
//
