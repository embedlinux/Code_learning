//
// ===========================================================================
// 2008-01-09 jmw:  Fixed some wire declarations and Wrapped_DFF model.
// 2008-01-05 jmw:  This library contains a list of component simulation
// models named after a subset of those in the Synopsys TSMC 90-nm 
// tcbn90ghp core cell library.
//
// It is based on the verilog model library delivered by Synopsys with
// the TSMC front-end, but it has been modified to remove all proprietary
// TSMC information.
//
// All TSMC parameters have been removed, the module headers have been
// replaced with headers in verilog-2001 format, and timing has been
// included which is not accurate but reasonably approximates actual
// cell timing.   All models are synthesizable by DC, but D latch models
// may not simulate correctly.
// ===========================================================================
//
// DO NOT USE THIS LIBRARY IN DESIGN WORK!
//
// It is intended for training use, only, in conjunction
// with the "Digital VLSI Design with Verilog" textbook.
//
// ===========================================================================
//
// These comments Copyright 2006, by John Michael Williams.
//                    All rights reserved.
//
// ===========================================================================
`timescale 1ns/10ps

`celldefine
module AN2D0 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.103,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN2D1 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.104,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN2D2 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.104,0.071);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN2D4 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.105,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN2D8 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.109,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN2XD1 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.099,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN3D0 (output Z, input A1, A2, A3);
    assign Z = A1 && A2 && A3;
    specify
    (A1, A2, A3 *> Z) = (0.114,0.074);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN3D1 (output Z, input A1, A2, A3);
    assign Z = A1 && A2 && A3;
    specify
    (A1, A2, A3 *> Z) = (0.115,0.079);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN3D2 (output Z, input A1, A2, A3);
    assign Z = A1 && A2 && A3;
    specify
    (A1, A2, A3 *> Z) = (0.112,0.081);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN3D4 (output Z, input A1, A2, A3);
    assign Z = A1 && A2 && A3;
    specify
    (A1, A2, A3 *> Z) = (0.113,0.073);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN3D8 (output Z, input A1, A2, A3);
    assign Z = A1 && A2 && A3;
    specify
    (A1, A2, A3 *> Z) = (0.119,0.082);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN3XD1 (output Z, input A1, A2, A3);
    assign Z = A1 && A2 && A3;
    specify
    (A1, A2, A3 *> Z) = (0.108,0.069);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN4D0 (output Z, input A1, A2, A3, A4);
    assign Z = A1 && A2 && A3 && A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.126,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN4D1 (output Z, input A1, A2, A3, A4);
    assign Z = A1 && A2 && A3 && A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.129,0.083);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN4D2 (output Z, input A1, A2, A3, A4);
    assign Z = A1 && A2 && A3 && A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.125,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN4D4 (output Z, input A1, A2, A3, A4);
    assign Z = A1 && A2 && A3 && A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.124,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN4D8 (output Z, input A1, A2, A3, A4);
    assign Z = A1 && A2 && A3 && A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.133,0.082);
    endspecify
endmodule
`endcelldefine

`celldefine
module AN4XD1 (output Z, input A1, A2, A3, A4);
    assign Z = A1 && A2 && A3 && A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.117,0.072);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO211D0 (output Z, input A1, A2, B, C);
    assign Z = (A1 && A2) || B || C;
    specify
    (A1, A2, B, C *> Z) = (0.108,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO211D1 (output Z, input A1, A2, B, C);
    assign Z = (A1 && A2) || B || C;
    specify
    (A1, A2, B, C *> Z) = (0.102,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO211D2 (output Z, input A1, A2, B, C);
    assign Z = (A1 && A2) || B || C;
    specify
    (A1, A2, B, C *> Z) = (0.105,0.124);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO211D4 (output Z, input A1, A2, B, C);
    assign Z = (A1 && A2) || B || C;
    specify
    (A1, A2, B, C *> Z) = (0.104,0.121);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO21D0 (output Z, input A1, A2, B);
    assign Z = (A1 && A2) || B;
    specify
    (A1, A2, B *> Z) = (0.104,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO21D1 (output Z, input A1, A2, B);
    assign Z = (A1 && A2) || B;
    specify
    (A1, A2, B *> Z) = (0.099,0.084);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO21D2 (output Z, input A1, A2, B);
    assign Z = (A1 && A2) || B;
    specify
    (A1, A2, B *> Z) = (0.103,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO21D4 (output Z, input A1, A2, B);
    assign Z = (A1 && A2) || B;
    specify
    (A1, A2, B *> Z) = (0.105,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO221D0 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 && A2) || (B1 && B2) || C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.116,0.136);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO221D1 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 && A2) || (B1 && B2) || C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.106,0.116);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO221D2 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 && A2) || (B1 && B2) || C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.110,0.130);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO221D4 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 && A2) || (B1 && B2) || C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.110,0.133);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO222D0 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 && A2) || (B1 && B2) || (C1 && C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.115,0.144);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO222D1 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 && A2) || (B1 && B2) || (C1 && C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.111,0.125);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO222D2 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 && A2) || (B1 && B2) || (C1 && C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.116,0.140);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO222D4 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 && A2) || (B1 && B2) || (C1 && C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.114,0.141);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO22D0 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 && A2) || (B1 && B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.113,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO22D1 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 && A2) || (B1 && B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.102,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO22D2 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 && A2) || (B1 && B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.108,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO22D4 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 && A2) || (B1 && B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.109,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO31D0 (output Z, input A1, A2, A3, B);
    assign Z = (A1 && A2 && A3) || B;
    specify
    (A1, A2, A3, B *> Z) = (0.113,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO31D1 (output Z, input A1, A2, A3, B);
    assign Z = (A1 && A2 && A3) || B;
    specify
    (A1, A2, A3, B *> Z) = (0.107,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO31D2 (output Z, input A1, A2, A3, B);
    assign Z = (A1 && A2 && A3) || B;
    specify
    (A1, A2, A3, B *> Z) = (0.113,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO31D4 (output Z, input A1, A2, A3, B);
    assign Z = (A1 && A2 && A3) || B;
    specify
    (A1, A2, A3, B *> Z) = (0.113,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO32D0 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 && A2 && A3) || (B1 && B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.115,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO32D1 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 && A2 && A3) || (B1 && B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.108,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO32D2 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 && A2 && A3) || (B1 && B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.114,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO32D4 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 && A2 && A3) || (B1 && B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.117,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO33D0 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 && A2 && A3) || (B1 && B2 && B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.127,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO33D1 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 && A2 && A3) || (B1 && B2 && B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.120,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO33D2 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 && A2 && A3) || (B1 && B2 && B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.127,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module AO33D4 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 && A2 && A3) || (B1 && B2 && B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.124,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211D0 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.295,0.074);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211D1 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.278,0.073);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211D2 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.283,0.071);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211D4 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.288,0.072);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211XD0 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.157,0.079);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211XD1 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.160,0.078);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211XD2 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.162,0.080);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI211XD4 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 && A2) || B || C );
    specify
    (A1, A2, B, C *> ZN) = (0.165,0.079);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI21D0 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 && A2) || B );
    specify
    (A1, A2, B *> ZN) = (0.184,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI21D1 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 && A2) || B );
    specify
    (A1, A2, B *> ZN) = (0.182,0.074);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI21D2 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 && A2) || B );
    specify
    (A1, A2, B *> ZN) = (0.185,0.072);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI21D4 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 && A2) || B );
    specify
    (A1, A2, B *> ZN) = (0.186,0.074);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI221D0 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 && A2) || (B1 && B2) || C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.315,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI221D1 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 && A2) || (B1 && B2) || C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.289,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI221D2 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 && A2) || (B1 && B2) || C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.304,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI221D4 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 && A2) || (B1 && B2) || C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.160,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI221XD4 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 && A2) || (B1 && B2) || C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.308,0.087);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI222D0 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 && A2) || (B1 && B2) || (C1 && C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.338,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI222D1 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 && A2) || (B1 && B2) || (C1 && C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.305,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI222D2 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 && A2) || (B1 && B2) || (C1 && C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.313,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI222D4 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 && A2) || (B1 && B2) || (C1 && C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.169,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI222XD4 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 && A2) || (B1 && B2) || (C1 && C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.325,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI22D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 && A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.188,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI22D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 && A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.196,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI22D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 && A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.196,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI22D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 && A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.199,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI31D0 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 && A2 && A3) || B );
    specify
    (A1, A2, A3, B *> ZN) = (0.201,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI31D1 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 && A2 && A3) || B );
    specify
    (A1, A2, A3, B *> ZN) = (0.192,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI31D2 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 && A2 && A3) || B );
    specify
    (A1, A2, A3, B *> ZN) = (0.209,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI31D4 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 && A2 && A3) || B );
    specify
    (A1, A2, A3, B *> ZN) = (0.197,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI32D0 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.194,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI32D1 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.205,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI32D2 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.220,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI32D4 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.143,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI32XD4 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.211,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI33D0 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2 && B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.224,0.132);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI33D1 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2 && B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.213,0.128);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI33D2 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2 && B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.233,0.137);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI33D4 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2 && B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.151,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module AOI33XD4 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 && A2 && A3) || (B1 && B2 && B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.220,0.136);
    endspecify
endmodule
`endcelldefine

`celldefine
module BENCD1 (output X2, A, S, input M0, M1, M2);
    assign X2 = !(M1^M0);
    assign A  = !( (M0||M1) && !M2);
    assign S  = !( M2 && (!M0 || !M1) );
    specify
    (M0, M1, M2 *> X2, A, S) = (0.128,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module BENCD2 (output X2, A, S, input M0, M1, M2);
    assign X2 = !(M1^M0);
    assign A  = !( (M0||M1) && !M2);
    assign S  = !( M2 && (!M0 || !M1) );
    specify
    (M0, M1, M2 *> X2, A, S) = (0.137,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module BENCD4 (output X2, A, S, input M0, M1, M2);
    assign X2 = !(M1^M0);
    assign A  = !( (M0||M1) && !M2);
    assign S  = !( M2 && (!M0 || !M1) );
    specify
    (M0, M1, M2 *> X2, A, S) = (0.142,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module BHD (inout Z);
    wire z;
    assign (weak0,weak1) Z = z;
    assign z = Z;
endmodule
`endcelldefine

`celldefine
module BMLD1 (output PP, input X2, A, S, M0, M1);
    WrappedBoothMux LibU1 (PP, X2, A, S, M0, M1);
    specify
    (X2, A, S, M0, M1 *> PP) = (0.125,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module BMLD2 (output PP, input X2, A, S, M0, M1);
    WrappedBoothMux LibU1 (PP, X2, A, S, M0, M1);
    specify
    (X2, A, S, M0, M1 *> PP) = (0.132,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module BMLD4 (output PP, input X2, A, S, M0, M1);
    WrappedBoothMux LibU1 (PP, X2, A, S, M0, M1);
    specify
    (X2, A, S, M0, M1 *> PP) = (0.136,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD0 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.096,0.067);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD1 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.096,0.071);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD1P5 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.095,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD2 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.096,0.068);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD2P5 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.099,0.072);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD3 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.101,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD4 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.097,0.066);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD5 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.100,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD6 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.102,0.073);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD8 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.101,0.071);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD10 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.101,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD12 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.103,0.073);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD16 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.105,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD20 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.105,0.076);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFFD24 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.105,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD0 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.085,0.068);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD1 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.093,0.068);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD2 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.092,0.073);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD3 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.096,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD4 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.098,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD6 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.099,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD8 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.102,0.082);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD12 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.109,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD16 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.113,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD20 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.109,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module BUFTD24 (output Z, input I, OE);
    assign Z = (OE==1'b1)? I: 1'bz;
    specify
    (I, OE *> Z) = (0.114,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKAN2D0 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.061,0.059);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKAN2D1 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.067,0.066);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKAN2D2 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.073,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKAN2D4 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.090,0.083);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKAN2D8 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.088,0.082);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD0 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.053,0.052);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD1 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.059,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD2 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.064,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD3 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.061,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD4 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.063,0.063);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD6 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.063,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD8 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.066,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD12 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.064,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD16 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.065,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD20 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.065,0.063);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBD24 (output C, input CLK);
    assign C = CLK;
    specify
    (CLK *> C) = (0.068,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD0 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.053,0.052);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD1 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.059,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD2 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.064,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD3 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.061,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD4 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.063,0.063);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD6 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.063,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD8 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.066,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD12 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.064,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD16 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.065,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD20 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.065,0.063);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKBXD24 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.068,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD1 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.067,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD2 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.074,0.071);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD3 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.082,0.078);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD4 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.090,0.083);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD6 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.083,0.076);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD8 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.090,0.084);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD12 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.106,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD16 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.103,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD20 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.100,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD24 (output Q, input TE, E, CP);
    wire q;
    assign Q = q && CP;
    assign D = E || TE;
    Wrapped_DLatch LibU1 (q, D, !CP, 1'b1, 1'b1);
    specify
    (TE, E, CP *> Q) = (0.107,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKMUX2D0 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1   (Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.068,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKMUX2D1 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1   (Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.077,0.081);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKMUX2D2 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1   (Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.086,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKMUX2D4 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1   (Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.091,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND0 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.032,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND1 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.032,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND2 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.032,0.031);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND3 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.033,0.031);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND4 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.033,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND6 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.034,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND8 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.033,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND12 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.034,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND16 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.033,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND20 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.034,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND24 (output CN, input CLK);
    assign CN = !CLK;
    specify
    (CLK *> CN) = (0.034,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND2D0 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.060,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND2D1 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.055,0.057);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND2D2 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.056,0.059);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND2D3 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.057,0.058);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND2D4 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.057,0.059);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKND2D8 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.059,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD0 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.032,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD1 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.032,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD2 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.032,0.031);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD3 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.033,0.031);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD4 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.033,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD6 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.034,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD8 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.033,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD12 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.034,0.033);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD16 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.033,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD20 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.034,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKNXD24 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.034,0.032);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKXOR2D0 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.076,0.078);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKXOR2D1 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.083,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKXOR2D2 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.091,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module CKXOR2D4 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.090,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module CMPE22D1 (output S, CO, input A, B);
    assign S = A ^ B;
    assign CO = A && B;
    specify
    (A, B *> S, CO) = (0.099,0.067);
    endspecify
endmodule
`endcelldefine

`celldefine
module CMPE22D2 (output S, CO, input A, B);
    assign S = A ^ B;
    assign CO = A && B;
    specify
    (A, B *> S, CO) = (0.104,0.073);
    endspecify
endmodule
`endcelldefine

`celldefine
module CMPE32D1 (output S, CO, input A, B, CI);
    assign S = (A ^ B) ^ CI;
    assign CO = ( A&&B ) || ( A&&CI ) || ( B&&CI );
    specify
    (A, B, CI *> S, CO) = (0.116,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module CMPE32D2 (output S, CO, input A, B, CI);
    assign S = (A ^ B) ^ CI;
    assign CO = ( A&&B ) || ( A&&CI ) || ( B&&CI );
    specify
    (A, B, CI *> S, CO) = (0.124,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module CMPE42D1 (output S, COX, CO, input A, B, C, D, CIX);
    assign S   = ( A^B^C^D ) ^ CIX;
    assign CO  = ( (A^B^C) && D ) || ( (A^B^C) && CIX ) || ( D&&CIX );
    assign COX = ( A&&B ) || ( A&&C ) || ( B&&C );
    specify
    (A, B, C, D, CIX *> S, COX, CO) = (0.152,0.146);
    endspecify
endmodule
`endcelldefine

`celldefine
module CMPE42D2 (output S, COX, CO, input A, B, C, D, CIX);
    assign S   = ( A^B^C^D ) ^ CIX;
    assign CO  = ( (A^B^C) && D ) || ( (A^B^C) && CIX ) || ( D&&CIX );
    assign COX = ( A&&B ) || ( A&&C ) || ( B&&C );
    specify
    (A, B, C, D, CIX *> S, COX, CO) = (0.162,0.158);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL0 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.208,0.216);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL005 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.090,0.080);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL01 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.152,0.124);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL015 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.198,0.171);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL02 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.231,0.205);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL1 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.371,0.365);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL2 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.693,0.669);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL3 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (1.035,0.976);
    endspecify
endmodule
`endcelldefine

`celldefine
module DEL4 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (1.361,1.276);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCND1 (output Q, QN, input D, CP, CDN);
    wire q;
    assign Q = q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, 1'b1);
    specify
    (D, CP, CDN *> Q, QN) = (0.153,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCND2 (output Q, QN, input D, CP, CDN);
    wire q;
    assign Q = q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, 1'b1);
    specify
    (D, CP, CDN *> Q, QN) = (0.147,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCND4 (output Q, QN, input D, CP, CDN);
    wire q;
    assign Q = q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, 1'b1);
    specify
    (D, CP, CDN *> Q, QN) = (0.154,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCNQD1 (output Q, input D, CP, CDN);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, 1'b1);
    specify
    (D, CP, CDN *> Q) = (0.150,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCNQD2 (output Q, input D, CP, CDN);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, 1'b1);
    specify
    (D, CP, CDN *> Q) = (0.142,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCNQD4 (output Q, input D, CP, CDN);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, 1'b1);
    specify
    (D, CP, CDN *> Q) = (0.149,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCSND1 (output Q, QN, input D, CP, CDN, SDN);
    wire q;
    assign Q = q;
    assign QN = !q && SDN;
    Wrapped_DFF LibU1 (q, D, CP, CDN, SDN);
    specify
    (D, CP, CDN, SDN *> Q, QN) = (0.141,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCSND2 (output Q, QN, input D, CP, CDN, SDN);
    wire q;
    assign Q = q;
    assign QN = !q && SDN;
    Wrapped_DFF LibU1 (q, D, CP, CDN, SDN);
    specify
    (D, CP, CDN, SDN *> Q, QN) = (0.141,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCSND4 (output Q, QN, input D, CP, CDN, SDN);
    wire q;
    assign Q = q;
    assign QN = !q && SDN;
    Wrapped_DFF LibU1 (q, D, CP, CDN, SDN);
    specify
    (D, CP, CDN, SDN *> Q, QN) = (0.148,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCSNQD1 (output Q, input D, CP, CDN, SDN);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, SDN);
    specify
    (D, CP, CDN, SDN *> Q) = (0.140,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCSNQD2 (output Q, input D, CP, CDN, SDN);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, SDN);
    specify
    (D, CP, CDN, SDN *> Q) = (0.137,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFCSNQD4 (output Q, input D, CP, CDN, SDN);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1 (q, D, CP, CDN, SDN);
    specify
    (D, CP, CDN, SDN *> Q) = (0.143,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFD1 (output Q, QN, input D, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    specify
    (D, CP *> Q, QN) = (0.132,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFD2 (output Q, QN, input D, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    specify
    (D, CP *> Q, QN) = (0.139,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFD4 (output Q, QN, input D, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    specify
    (D, CP *> Q, QN) = (0.141,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCND1 (output Q, QN, input D, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D&&CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN *> Q, QN) = (0.135,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCND2 (output Q, QN, input D, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D&&CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN *> Q, QN) = (0.141,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCND4 (output Q, QN, input D, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D&&CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN *> Q, QN) = (0.144,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCNQD1 (output Q, input D, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D&&CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN *> Q) = (0.132,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCNQD2 (output Q, input D, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D&&CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN *> Q) = (0.136,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCNQD4 (output Q, input D, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D&&CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN *> Q) = (0.140,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCSND1 (output Q, QN, input D, CP, CN, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, (!SN || D) && CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN, SN *> Q, QN) = (0.131,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCSND2 (output Q, QN, input D, CP, CN, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, (!SN || D) && CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN, SN *> Q, QN) = (0.141,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKCSND4 (output Q, QN, input D, CP, CN, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, (!SN || D) && CN, CP, 1'b1, 1'b1);
    specify
    (D, CP, CN, SN *> Q, QN) = (0.145,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKSND1 (output Q, QN, input D, CP, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, !SN || D, CP, 1'b1, 1'b1);
    specify
    (D, CP, SN *> Q, QN) = (0.132,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKSND2 (output Q, QN, input D, CP, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, !SN || D, CP, 1'b1, 1'b1);
    specify
    (D, CP, SN *> Q, QN) = (0.139,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFKSND4 (output Q, QN, input D, CP, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, !SN || D, CP, 1'b1, 1'b1);
    specify
    (D, CP, SN *> Q, QN) = (0.143,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNCND1 (output Q, QN, input D, CPN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, CDN, 1'b1);
    specify
    (D, CPN, CDN *> Q, QN) = (0.168,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNCND2 (output Q, QN, input D, CPN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, CDN, 1'b1);
    specify
    (D, CPN, CDN *> Q, QN) = (0.163,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNCND4 (output Q, QN, input D, CPN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, CDN, 1'b1);
    specify
    (D, CPN, CDN *> Q, QN) = (0.175,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNCSND1 (output Q, QN, input D, CPN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DFF LibU1 (q, D, !CPN, CDN, SDN);
    specify
    (D, CPN, CDN, SDN *> Q, QN) = (0.145,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNCSND2 (output Q, QN, input D, CPN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DFF LibU1 (q, D, !CPN, CDN, SDN);
    specify
    (D, CPN, CDN, SDN *> Q, QN) = (0.144,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNCSND4 (output Q, QN, input D, CPN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DFF LibU1 (q, D, !CPN, CDN, SDN);
    specify
    (D, CPN, CDN, SDN *> Q, QN) = (0.151,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFND1 (output Q, QN, input D, CPN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, 1'b1, 1'b1);
    specify
    (D, CPN *> Q, QN) = (0.140,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFND2 (output Q, QN, input D, CPN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, 1'b1, 1'b1);
    specify
    (D, CPN *> Q, QN) = (0.157,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFND4 (output Q, QN, input D, CPN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, 1'b1, 1'b1);
    specify
    (D, CPN *> Q, QN) = (0.151,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNSND1 (output Q, QN, input D, CPN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, 1'b1, SDN);
    specify
    (D, CPN, SDN *> Q, QN) = (0.150,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNSND2 (output Q, QN, input D, CPN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, 1'b1, SDN);
    specify
    (D, CPN, SDN *> Q, QN) = (0.148,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFNSND4 (output Q, QN, input D, CPN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, !CPN, 1'b1, SDN);
    specify
    (D, CPN, SDN *> Q, QN) = (0.153,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFQD1 (output Q, input D, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    specify
    (D, CP *> Q) = (0.125,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFQD2 (output Q, input D, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    specify
    (D, CP *> Q) = (0.133,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFQD4 (output Q, input D, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    specify
    (D, CP *> Q) = (0.135,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFSND1 (output Q, QN, input D, CP, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, SDN);
    specify
    (D, CP, SDN *> Q, QN) = (0.139,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFSND2 (output Q, QN, input D, CP, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, SDN);
    specify
    (D, CP, SDN *> Q, QN) = (0.141,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFSND4 (output Q, QN, input D, CP, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, SDN);
    specify
    (D, CP, SDN *> Q, QN) = (0.149,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFSNQD1 (output Q, input D, CP, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, SDN);
    specify
    (D, CP, SDN *> Q) = (0.135,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFSNQD2 (output Q, input D, CP, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, SDN);
    specify
    (D, CP, SDN *> Q) = (0.142,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFSNQD4 (output Q, input D, CP, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, SDN);
    specify
    (D, CP, SDN *> Q) = (0.146,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFXD1 (output Q, QN, input DA, DB, SA, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D, DB, DA, SA);
    specify
    (DA, DB, SA, CP *> Q, QN) = (0.132,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFXD2 (output Q, QN, input DA, DB, SA, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF  LibU1 (q, D, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2 (D, DB, DA, SA);
    specify
    (DA, DB, SA, CP *> Q, QN) = (0.139,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFXD4 (output Q, QN, input DA, DB, SA, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1(q, D, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D, DB, DA, SA);
    specify
    (DA, DB, SA, CP *> Q, QN) = (0.141,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFXQD1 (output Q, input DA, DB, SA, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D, DB, DA, SA);
    specify
    (DA, DB, SA, CP *> Q) = (0.127,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFXQD2 (output Q, input DA, DB, SA, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D, DB, DA, SA);
    specify
    (DA, DB, SA, CP *> Q) = (0.134,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module DFXQD4 (output Q, input DA, DB, SA, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, D, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D, DB, DA, SA);
    specify
    (DA, DB, SA, CP *> Q) = (0.136,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFCND1 (output Q, QN, input D, E, CP, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, DE, CP, CDN, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP, CDN *> Q, QN) = (0.141,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFCND2 (output Q, QN, input D, E, CP, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, DE, CP, CDN, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP, CDN *> Q, QN) = (0.147,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFCND4 (output Q, QN, input D, E, CP, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, DE, CP, CDN, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP, CDN *> Q, QN) = (0.158,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFCNQD1 (output Q, input D, E, CP, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, DE, CP, CDN, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP, CDN *> Q) = (0.139,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFCNQD2 (output Q, input D, E, CP, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, DE, CP, CDN, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP, CDN *> Q) = (0.143,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFCNQD4 (output Q, input D, E, CP, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, DE, CP, CDN, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP, CDN *> Q) = (0.151,0.087);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFD1 (output Q, QN, input D, E, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, DE, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP *> Q, QN) = (0.131,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFD2 (output Q, QN, input D, E, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, DE, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP *> Q, QN) = (0.136,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFD4 (output Q, QN, input D, E, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, DE, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP *> Q, QN) = (0.138,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFKCND1 (output Q, QN, input D, E, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, CN&&D1, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D1, q, D, E);
    specify
    (D, E, CP, CN *> Q, QN) = (0.131,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFKCND2 (output Q, QN, input D, E, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, CN&&D1, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D1, q, D, E);
    specify
    (D, E, CP, CN *> Q, QN) = (0.136,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFKCND4 (output Q, QN, input D, E, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DFF LibU1 (q, CN&&D1, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D1, q, D, E);
    specify
    (D, E, CP, CN *> Q, QN) = (0.137,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFKCNQD1 (output Q, input D, E, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, CN&&D1, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D1, q, D, E);
    specify
    (D, E, CP, CN *> Q) = (0.129,0.116);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFKCNQD2 (output Q, input D, E, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, CN&&D1, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D1, q, D, E);
    specify
    (D, E, CP, CN *> Q) = (0.132,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFKCNQD4 (output Q, input D, E, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, CN&&D1, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(D1, q, D, E);
    specify
    (D, E, CP, CN *> Q) = (0.132,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFQD1 (output Q, input D, E, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, DE, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP *> Q) = (0.129,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFQD2 (output Q, input D, E, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, DE, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP *> Q) = (0.131,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module EDFQD4 (output Q, input D, E, CP);
    wire q;
    assign Q  =  q;
    Wrapped_DFF LibU1 (q, DE, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(DE, q, D, E);
    specify
    (D, E, CP *> Q) = (0.132,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module FA1D0 (output S, CO, input A, B, CI);
    assign S  = A ^ B ^ CI;
    assign CO = ( A&&B ) || ( A&&CI ) || ( B&&CI );
    specify
    (A, B, CI *> S, CO) = (0.127,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module FA1D1 (output S, CO, input A, B, CI);
    assign S  = A ^ B ^ CI;
    assign CO = ( A&&B ) || ( A&&CI ) || ( B&&CI );
    specify
    (A, B, CI *> S, CO) = (0.118,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module FA1D2 (output S, CO, input A, B, CI);
    assign S  = A ^ B ^ CI;
    assign CO = ( A&&B ) || ( A&&CI ) || ( B&&CI );
    specify
    (A, B, CI *> S, CO) = (0.125,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module FA1D4 (output S, CO, input A, B, CI);
    assign S  = A ^ B ^ CI;
    assign CO = ( A&&B ) || ( A&&CI ) || ( B&&CI );
    specify
    (A, B, CI *> S, CO) = (0.133,0.116);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCICIND1 (output CO, input A, B, CIN);
    assign CO = ( A&&B ) || ( A&&(!CIN) ) || ( B&&(!CIN) );
    specify
    (A, B, CIN *> CO) = (0.119,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCICIND2 (output CO, input A, B, CIN);
    assign CO = ( A&&B ) || ( A&&(!CIN) ) || ( B&&(!CIN) );
    specify
    (A, B, CIN *> CO) = (0.124,0.122);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCICOND1 (output CON, input A, B, CI);
    assign CON = !( (A&&B) || (A&&CI) || (B&&CI) );
    specify
    (A, B, CI *> CON) = (0.243,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCICOND2 (output CON, input A, B, CI);
    assign CON = !( (A&&B) || (A&&CI) || (B&&CI) );
    specify
    (A, B, CI *> CON) = (0.139,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCSICIND1 (output S, CO0, CO1, input A, B, CIN0, CIN1, CS);
    assign   S = ((A ^ B ^ !CIN1) && CS) || (!CS && (A ^ B ^ !CIN0));
    assign CO0 = (A&&B) || (A && !CIN0) || (B && !CIN0);
    assign CO1 = (A&&B) || (A && !CIN1) || (B && !CIN1);
    specify
    (A, B, CIN0, CIN1, CS *> S, CO0, CO1) = (0.138,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCSICIND2 (output S, CO0, CO1, input A, B, CIN0, CIN1, CS);
    assign   S = ((A ^ B ^ !CIN1) && CS) || (!CS && (A ^ B ^ !CIN0));
    assign CO0 = (A&&B) || (A && !CIN0) || (B && !CIN0);
    assign CO1 = (A&&B) || (A && !CIN1) || (B && !CIN1);
    specify
    (A, B, CIN0, CIN1, CS *> S, CO0, CO1) = (0.141,0.118);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCSICOND1 (output S, CON0, CON1, input A, B, CI0, CI1, CS);
    assign   S = (!CS && (A^B^CI0)) || (CS && (A^B^CI1));
    assign CON0 = !( (A&&B) || (A&&CI0) || (B&&CI0) );
    assign CON1 = !( (A&&CI1) || (A&&B) || (B&&CI1) );
    specify
    (A, B, CI0, CI1, CS *> S, CON0, CON1) = (0.145,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module FCSICOND2 (output S, CON0, CON1, input A, B, CI0, CI1, CS);
    assign   S = (!CS && (A^B^CI0)) || (CS && (A^B^CI1));
    assign CON0 = !( (A&&B) || (A&&CI0) || (B&&CI0) );
    assign CON1 = !( (A&&CI1) || (A&&B) || (B&&CI1) );
    specify
    (A, B, CI0, CI1, CS *> S, CON0, CON1) = (0.152,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module FICIND1 (output S, CO, input A, B, CIN);
    assign  S =  A ^ B ^ !CIN;
    assign CO =  (A&&B) || (A&&(!CIN)) || (B&&(!CIN));
    specify
    (A, B, CIN *> S, CO) = (0.126,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module FICIND2 (output S, CO, input A, B, CIN);
    assign  S =  A ^ B ^ !CIN;
    assign CO =  (A&&B) || (A&&(!CIN)) || (B&&(!CIN));
    specify
    (A, B, CIN *> S, CO) = (0.128,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module FICOND1 (output S, CON, input A, B, CI);
    assign   S =  A ^ B ^ CI;
    assign CON = !( (A&&B) || (A&&CI) || (B&&CI) );
    specify
    (A, B, CI *> S, CON) = (0.140,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module FICOND2 (output S, CON, input A, B, CI);
    assign   S =  A ^ B ^ CI;
    assign CON = !( (A&&B) || (A&&CI) || (B&&CI) );
    specify
    (A, B, CI *> S, CON) = (0.141,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module FIICOND1 (output S, CON0, CON1, input A, B, C);
    assign    S =  A ^ B ^ C;
    assign CON0 = !( A && B );
    assign CON1 = !( A || B );
    specify
    (A, B, C *> S, CON0, CON1) = (0.097,0.078);
    endspecify
endmodule
`endcelldefine

`celldefine
module FIICOND2 (output S, CON0, CON1, input A, B, C);
    assign    S =  A ^ B ^ C;
    assign CON0 = !( A && B );
    assign CON1 = !( A || B );
    specify
    (A, B, C *> S, CON0, CON1) = (0.098,0.076);
    endspecify
endmodule
`endcelldefine

`celldefine
module GAN2D1 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.102,0.066);
    endspecify
endmodule
`endcelldefine

`celldefine
module GAN2D2 (output Z, input A1, A2);
    assign Z = A1 && A2;
    specify
    (A1, A2 *> Z) = (0.104,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module GAOI22D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1&&A2) || (B1&&B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.199,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module GBUFFD1 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.095,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module GBUFFD2 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.097,0.068);
    endspecify
endmodule
`endcelldefine

`celldefine
module GBUFFD3 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.101,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module GBUFFD4 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.096,0.067);
    endspecify
endmodule
`endcelldefine

`celldefine
module GBUFFD8 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.099,0.071);
    endspecify
endmodule
`endcelldefine

`celldefine
module GDFQD1 (output Q, input D, CP);
    Wrapped_DFF LibU1 (Q, D, CP, 1'b1, 1'b1);
    specify
    (D, CP *> Q) = (0.120,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module GINVD1 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.094,0.054);
    endspecify
endmodule
`endcelldefine

`celldefine
module GINVD2 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.092,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module GINVD3 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.093,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module GINVD4 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.093,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module GINVD8 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.093,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module GMUX2D1 (output Z, input I0, I1, S);
  Wrapped_Mux2 LibU1 (Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.109,0.085);
    endspecify
endmodule
`endcelldefine

`celldefine
module GMUX2D2 (output Z, input I0, I1, S);
  Wrapped_Mux2 LibU1 (Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.113,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module GND2D1 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.098,0.080);
    endspecify
endmodule
`endcelldefine

`celldefine
module GND2D2 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.100,0.081);
    endspecify
endmodule
`endcelldefine

`celldefine
module GND2D3 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.098,0.081);
    endspecify
endmodule
`endcelldefine

`celldefine
module GND2D4 (output ZN, input A1, A2);
    assign ZN = !(A1 && A2);
    specify
    (A1, A2 *> ZN) = (0.098,0.082);
    endspecify
endmodule
`endcelldefine

`celldefine
module GND3D1 (output ZN, input A1, A2, A3);
    assign ZN = !(A1 && A2 && A3);
    specify
    (A1, A2, A3 *> ZN) = (0.104,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module GND3D2 (output ZN, input A1, A2, A3);
    assign ZN = !(A1 && A2 && A3);
    specify
    (A1, A2, A3 *> ZN) = (0.103,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module GNR2D1 (output ZN, input A1, A2);
    assign ZN = !(A1 || A2);
    specify
    (A1, A2 *> ZN) = (0.173,0.056);
    endspecify
endmodule
`endcelldefine

`celldefine
module GNR2D2 (output ZN, input A1, A2);
    assign ZN = !(A1 || A2);
    specify
    (A1, A2 *> ZN) = (0.174,0.056);
    endspecify
endmodule
`endcelldefine

`celldefine
module GOR2D1 (output Z, input A1, A2);
    assign Z = (A1 || A2);
    specify
    (A1, A2 *> Z) = (0.098,0.078);
    endspecify
endmodule
`endcelldefine

`celldefine
module GOR2D2 (output Z, input A1, A2);
    assign Z = (A1 || A2);
    specify
    (A1, A2 *> Z) = (0.098,0.087);
    endspecify
endmodule
`endcelldefine

`celldefine
module GXNR2D1 (output ZN, input A1, A2);
    assign ZN = !(A1 ^ A2);
    specify
    (A1, A2 *> ZN) = (0.115,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module GXNR2D2 (output ZN, input A1, A2);
    assign ZN = !(A1 ^ A2);
    specify
    (A1, A2 *> ZN) = (0.118,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module GXOR2D1 (output Z, input A1, A2);
    assign Z = (A1 ^ A2);
    specify
    (A1, A2 *> Z) = (0.114,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module GXOR2D2 (output Z, input A1, A2);
    assign Z = (A1 ^ A2);
    specify
    (A1, A2 *> Z) = (0.117,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module HA1D0 (output S, CO, input A, B);
    assign S  = (A ^ B);
    assign CO = (A && B);
    specify
    (A, B *> S, CO) = (0.100,0.070);
    endspecify
endmodule
`endcelldefine

`celldefine
module HA1D1 (output S, CO, input A, B);
    assign S  = (A ^ B);
    assign CO = (A && B);
    specify
    (A, B *> S, CO) = (0.099,0.067);
    endspecify
endmodule
`endcelldefine

`celldefine
module HA1D2 (output S, CO, input A, B);
    assign S  = (A ^ B);
    assign CO = (A && B);
    specify
    (A, B *> S, CO) = (0.104,0.072);
    endspecify
endmodule
`endcelldefine

`celldefine
module HA1D4 (output S, CO, input A, B);
    assign S  = (A ^ B);
    assign CO = (A && B);
    specify
    (A, B *> S, CO) = (0.104,0.072);
    endspecify
endmodule
`endcelldefine

`celldefine
module HCOSCIND1 (output S, CO, input A, CIN, CS);
    assign S  = (CS && (A ^ !CIN)) || (A && !CS);
    assign CO = (A && !CIN);
    specify
    (A, CIN, CS *> S, CO) = (0.116,0.074);
    endspecify
endmodule
`endcelldefine

`celldefine
module HCOSCIND2 (output S, CO, input A, CIN, CS);
    assign S  = (CS && (A ^ !CIN)) || (A && !CS);
    assign CO = (A && !CIN);
    specify
    (A, CIN, CS *> S, CO) = (0.121,0.080);
    endspecify
endmodule
`endcelldefine

`celldefine
module HCOSCOND1 (output S, CON, input A, CI, CS);
    assign   S = (A && !CS)  || (CS && (A^CI));
    assign CON = !( A && CI);
    specify
    (A, CI, CS *> S, CON) = (0.098,0.080);
    endspecify
endmodule
`endcelldefine

`celldefine
module HCOSCOND2 (output S, CON, input A, CI, CS);
    assign   S = (A && !CS)  || (CS && (A^CI));
    assign CON = !( A && CI);
    specify
    (A, CI, CS *> S, CON) = (0.098,0.076);
    endspecify
endmodule
`endcelldefine

`celldefine
module HICIND1 (output S, CO, input A, CIN);
    assign  S = A ^  !CIN;
    assign CO = A && !CIN;
    specify
    (A, CIN *> S, CO) = (0.106,0.069);
    endspecify
endmodule
`endcelldefine

`celldefine
module HICIND2 (output S, CO, input A, CIN);
    assign  S = A ^  !CIN;
    assign CO = A && !CIN;
    specify
    (A, CIN *> S, CO) = (0.113,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module HICOND1 (output S, CON, input A, CI);
    assign   S = A ^ CI;
    assign CON = !(A && CI);
    specify
    (A, CI *> S, CON) = (0.097,0.078);
    endspecify
endmodule
`endcelldefine

`celldefine
module HICOND2 (output S, CON, input A, CI);
    assign   S = A ^ CI;
    assign CON = !(A && CI);
    specify
    (A, CI *> S, CON) = (0.099,0.076);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO21D0 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 && !A2) || B);
    specify
    (A1, A2, B *> ZN) = (0.184,0.085);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO21D1 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 && !A2) || B);
    specify
    (A1, A2, B *> ZN) = (0.174,0.079);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO21D2 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 && !A2) || B);
    specify
    (A1, A2, B *> ZN) = (0.182,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO21D4 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 && !A2) || B);
    specify
    (A1, A2, B *> ZN) = (0.183,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO22D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 && !A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.195,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO22D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 && !A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.180,0.082);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO22D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 && !A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.121,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module IAO22D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 && !A2) || (B1 && B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.122,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module IIND4D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 && !A2 && B1 && B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.127,0.163);
    endspecify
endmodule
`endcelldefine

`celldefine
module IIND4D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 && !A2 && B1 && B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.121,0.160);
    endspecify
endmodule
`endcelldefine

`celldefine
module IIND4D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 && !A2 && B1 && B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.125,0.167);
    endspecify
endmodule
`endcelldefine

`celldefine
module IIND4D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 && !A2 && B1 && B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.112,0.157);
    endspecify
endmodule
`endcelldefine

`celldefine
module IINR4D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 || !A2 || B1 || B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.198,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module IINR4D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 || !A2 || B1 || B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.197,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module IINR4D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 || !A2 || B1 || B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.210,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module IINR4D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( !A1 || !A2 || B1 || B2 );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.198,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND2D0 (output ZN, input A1, B1);
    assign ZN = !( !A1 && B1 );
    specify
    (A1, B1 *> ZN) = (0.101,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND2D1 (output ZN, input A1, B1);
    assign ZN = !( !A1 && B1 );
    specify
    (A1, B1 *> ZN) = (0.097,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND2D2 (output ZN, input A1, B1);
    assign ZN = !( !A1 && B1 );
    specify
    (A1, B1 *> ZN) = (0.103,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND2D4 (output ZN, input A1, B1);
    assign ZN = !( !A1 && B1 );
    specify
    (A1, B1 *> ZN) = (0.102,0.085);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND3D0 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 && B1 && B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.107,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND3D1 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 && B1 && B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.103,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND3D2 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 && B1 && B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.107,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND3D4 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 && B1 && B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.110,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND4D0 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 && B1 && B2 && B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.112,0.150);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND4D1 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 && B1 && B2 && B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.108,0.147);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND4D2 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 && B1 && B2 && B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.112,0.159);
    endspecify
endmodule
`endcelldefine

`celldefine
module IND4D4 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 && B1 && B2 && B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.111,0.150);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2D0 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.181,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2D1 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.171,0.064);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2D2 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.177,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2D4 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.178,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2XD0 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.098,0.066);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2XD1 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.099,0.064);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2XD2 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.103,0.069);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR2XD4 (output ZN, input A1, B1);
    assign ZN = !( !A1 || B1 );
    specify
    (A1, B1 *> ZN) = (0.104,0.067);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR3D0 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 || B1 || B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.146,0.066);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR3D1 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 || B1 || B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.147,0.065);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR3D2 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 || B1 || B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.268,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR3D4 (output ZN, input A1, B1, B2);
    assign ZN = !( !A1 || B1 || B2 );
    specify
    (A1, B1, B2 *> ZN) = (0.283,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR4D0 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 || B1 || B2 || B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.200,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR4D1 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 || B1 || B2 || B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.196,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR4D2 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 || B1 || B2 || B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.200,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module INR4D4 (output ZN, input A1, B1, B2, B3);
    assign ZN = !( !A1 || B1 || B2 || B3 );
    specify
    (A1, B1, B2, B3 *> ZN) = (0.370,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD0 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.092,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD1 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.089,0.054);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD1P5 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.090,0.054);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD2 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.090,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD2P5 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.091,0.054);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD3 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.092,0.054);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD4 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.092,0.054);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD5 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.094,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD6 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.094,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD8 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.095,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD10 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.096,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD12 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.096,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD16 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.097,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD20 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.097,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module INVD24 (output ZN, input I);
    assign ZN = !I;
    specify
    (I *> ZN) = (0.098,0.053);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA21D0 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 || !A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.108,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA21D1 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 || !A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.102,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA21D2 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 || !A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.106,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA21D4 (output ZN, input A1, A2, B);
    assign ZN = !( (!A1 || !A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.112,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA22D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 || !A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.159,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA22D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 || !A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.150,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA22D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 || !A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.114,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module IOA22D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (!A1 || !A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.118,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module ISOHID1 (output Z, input ISO, I);
    assign Z = ISO || I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module ISOHID2 (output Z, input ISO, I);
    assign Z = ISO || I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module ISOHID4 (output Z, input ISO, I);
    assign Z = ISO || I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module ISOHID8 (output Z, input ISO, I);
    assign Z = ISO || I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module ISOLOD1 (output Z, input ISO, I);
    assign Z = !ISO && I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine   
module ISOLOD2 (output Z, input ISO, I);
    assign Z = !ISO && I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine   
module ISOLOD4 (output Z, input ISO, I);
    assign Z = !ISO && I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine   
module ISOLOD8 (output Z, input ISO, I);
    assign Z = !ISO && I;
    specify
    (ISO, I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCND1 (output Q, QN, input D, E, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, E, CDN, 1'b1);
    specify
    (D, E, CDN *> Q, QN) = (0.140,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCND2 (output Q, QN, input D, E, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, E, CDN, 1'b1);
    specify
    (D, E, CDN *> Q, QN) = (0.146,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCND4 (output Q, QN, input D, E, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, E, CDN, 1'b1);
    specify
    (D, E, CDN *> Q, QN) = (0.161,0.130);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCNQD1 (output Q, input D, E, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, CDN, 1'b1);
    specify
    (D, E, CDN *> Q) = (0.131,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCNQD2 (output Q, input D, E, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, CDN, 1'b1);
    specify
    (D, E, CDN *> Q) = (0.136,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCNQD4 (output Q, input D, E, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, CDN, 1'b1);
    specify
    (D, E, CDN *> Q) = (0.141,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCSND1 (output Q, QN, input D, E, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, E, CDN, SDN);
    specify
    (D, E, CDN, SDN *> Q, QN) = (0.146,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCSND2 (output Q, QN, input D, E, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, E, CDN, SDN);
    specify
    (D, E, CDN, SDN *> Q, QN) = (0.141,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCSND4 (output Q, QN, input D, E, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, E, CDN, SDN);
    specify
    (D, E, CDN, SDN *> Q, QN) = (0.157,0.130);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCSNQD1 (output Q, input D, E, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, CDN, SDN);
    specify
    (D, E, CDN, SDN *> Q) = (0.133,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCSNQD2 (output Q, input D, E, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, CDN, SDN);
    specify
    (D, E, CDN, SDN *> Q) = (0.131,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHCSNQD4 (output Q, input D, E, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, CDN, SDN);
    specify
    (D, E, CDN, SDN *> Q) = (0.138,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHD1 (output Q, QN, input D, E);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, 1'b1);
    specify
    (D, E *> Q, QN) = (0.118,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHD2 (output Q, QN, input D, E);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, 1'b1);
    specify
    (D, E *> Q, QN) = (0.123,0.118);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHD4 (output Q, QN, input D, E);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, 1'b1);
    specify
    (D, E *> Q, QN) = (0.140,0.145);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHQD1 (output Q, input D, E);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, 1'b1);
    specify
    (D, E *> Q) = (0.118,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHQD2 (output Q, input D, E);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, 1'b1);
    specify
    (D, E *> Q) = (0.122,0.118);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHQD4 (output Q, input D, E);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, 1'b1);
    specify
    (D, E *> Q) = (0.136,0.144);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHSND1 (output Q, QN, input D, E, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, SDN);
    specify
    (D, E, SDN *> Q, QN) = (0.129,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHSND2 (output Q, QN, input D, E, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, SDN);
    specify
    (D, E, SDN *> Q, QN) = (0.129,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHSND4 (output Q, QN, input D, E, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, SDN);
    specify
    (D, E, SDN *> Q, QN) = (0.145,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHSNQD1 (output Q, input D, E, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, SDN);
    specify
    (D, E, SDN *> Q) = (0.119,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHSNQD2 (output Q, input D, E, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, SDN);
    specify
    (D, E, SDN *> Q) = (0.120,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module LHSNQD4 (output Q, input D, E, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, E, 1'b1, SDN);
    specify
    (D, E, SDN *> Q) = (0.127,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCND1 (output Q, QN, input D, EN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, 1'b1);
    specify
    (D, EN, CDN *> Q, QN) = (0.145,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCND2 (output Q, QN, input D, EN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, 1'b1);
    specify
    (D, EN, CDN *> Q, QN) = (0.149,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCND4 (output Q, QN, input D, EN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, 1'b1);
    specify
    (D, EN, CDN *> Q, QN) = (0.165,0.129);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCNQD1 (output Q, input D, EN, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, 1'b1);
    specify
    (D, EN, CDN *> Q) = (0.136,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCNQD2 (output Q, input D, EN, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, 1'b1);
    specify
    (D, EN, CDN *> Q) = (0.139,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCNQD4 (output Q, input D, EN, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, 1'b1);
    specify
    (D, EN, CDN *> Q) = (0.146,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCSND1 (output Q, QN, input D, EN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, SDN);
    specify
    (D, EN, CDN, SDN *> Q, QN) = (0.142,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCSND2 (output Q, QN, input D, EN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, SDN);
    specify
    (D, EN, CDN, SDN *> Q, QN) = (0.143,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCSND4 (output Q, QN, input D, EN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, SDN);
    specify
    (D, EN, CDN, SDN *> Q, QN) = (0.160,0.130);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCSNQD1 (output Q, input D, EN, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, SDN);
    specify
    (D, EN, CDN, SDN *> Q) = (0.132,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCSNQD2 (output Q, input D, EN, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, SDN);
    specify
    (D, EN, CDN, SDN *> Q) = (0.132,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNCSNQD4 (output Q, input D, EN, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, CDN, SDN);
    specify
    (D, EN, CDN, SDN *> Q) = (0.141,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module LND1 (output Q, QN, input D, EN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, 1'b1);
    specify
    (D, EN *> Q, QN) = (0.119,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module LND2 (output Q, QN, input D, EN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, 1'b1);
    specify
    (D, EN *> Q, QN) = (0.124,0.124);
    endspecify
endmodule
`endcelldefine

`celldefine
module LND4 (output Q, QN, input D, EN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, 1'b1);
    specify
    (D, EN *> Q, QN) = (0.139,0.149);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNQD1 (output Q, input D, EN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, 1'b1);
    specify
    (D, EN *> Q) = (0.118,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNQD2 (output Q, input D, EN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, 1'b1);
    specify
    (D, EN *> Q) = (0.122,0.124);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNQD4 (output Q, input D, EN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, 1'b1);
    specify
    (D, EN *> Q) = (0.137,0.151);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNSND1 (output Q, QN, input D, EN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, SDN);
    specify
    (D, EN, SDN *> Q, QN) = (0.134,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNSND2 (output Q, QN, input D, EN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, SDN);
    specify
    (D, EN, SDN *> Q, QN) = (0.134,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNSND4 (output Q, QN, input D, EN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, SDN);
    specify
    (D, EN, SDN *> Q, QN) = (0.148,0.122);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNSNQD1 (output Q, input D, EN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, SDN);
    specify
    (D, EN, SDN *> Q) = (0.124,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNSNQD2 (output Q, input D, EN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, SDN);
    specify
    (D, EN, SDN *> Q) = (0.122,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module LNSNQD4 (output Q, input D, EN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_DLatch LibU1(q, D, !EN, 1'b1, SDN);
    specify
    (D, EN, SDN *> Q) = (0.131,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLHLD1 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLHLD2 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLHLD4 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLHLD8 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLLHD1 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLLHD2 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLLHD4 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module LVLLHD8 (output Z, input I);
    assign Z = I;
    specify
    (I *> Z) = (0.000,0.000);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI222D0 (output ZN, input A, B, C);
    assign ZN = !( (A&&B) || (A&&C) || (B&&C) );
    specify
    (A, B, C *> ZN) = (0.228,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI222D1 (output ZN, input A, B, C);
    assign ZN = !( (A&&B) || (A&&C) || (B&&C) );
    specify
    (A, B, C *> ZN) = (0.246,0.117);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI222D2 (output ZN, input A, B, C);
    assign ZN = !( (A&&B) || (A&&C) || (B&&C) );
    specify
    (A, B, C *> ZN) = (0.140,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI222D4 (output ZN, input A, B, C);
    assign ZN = !( (A&&B) || (A&&C) || (B&&C) );
    specify
    (A, B, C *> ZN) = (0.149,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI22D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1&&A2) || !(B1||B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.197,0.087);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI22D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1&&A2) || !(B1||B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.190,0.082);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI22D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1&&A2) || !(B1||B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.113,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module MAOI22D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1&&A2) || !(B1||B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.124,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module MOAI22D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1||A2) && !(B1&&B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.156,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module MOAI22D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1||A2) && !(B1&&B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.148,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module MOAI22D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1||A2) && !(B1&&B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.112,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module MOAI22D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1||A2) && !(B1&&B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.121,0.119);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2D0 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1(Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.110,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2D1 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1(Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.109,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2D2 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1(Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.115,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2D4 (output Z, input I0, I1, S);
    Wrapped_Mux2 LibU1(Z, I0, I1, S);
    specify
    (I0, I1, S *> Z) = (0.116,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2ND0 (output ZN, input I0, I1, S);
    wire zn;
    assign ZN = !zn;
    Wrapped_Mux2 LibU1(zn, I0, I1, S);
    specify
    (I0, I1, S *> ZN) = (0.156,0.081);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2ND1 (output ZN, input I0, I1, S);
    wire zn;
    assign ZN = !zn;
    Wrapped_Mux2 LibU1(zn, I0, I1, S);
    specify
    (I0, I1, S *> ZN) = (0.116,0.087);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2ND2 (output ZN, input I0, I1, S);
    wire zn;
    assign ZN = !zn;
    Wrapped_Mux2 LibU1(zn, I0, I1, S);
    specify
    (I0, I1, S *> ZN) = (0.124,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX2ND4 (output ZN, input I0, I1, S);
    wire zn;
    assign ZN = !zn;
    Wrapped_Mux2 LibU1(zn, I0, I1, S);
    specify
    (I0, I1, S *> ZN) = (0.124,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3D0 (output Z, input I0, I1, I2, S0, S1);
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> Z) = (0.127,0.116);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3D1 (output Z, input I0, I1, I2, S0, S1);
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> Z) = (0.119,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3D2 (output Z, input I0, I1, I2, S0, S1);
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> Z) = (0.126,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3D4 (output Z, input I0, I1, I2, S0, S1);
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> Z) = (0.132,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3ND0 (output ZN, input I0, I1, I2, S0, S1);
    wire z, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> ZN) = (0.177,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3ND1 (output ZN, input I0, I1, I2, S0, S1);
    wire z, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> ZN) = (0.126,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3ND2 (output ZN, input I0, I1, I2, S0, S1);
    wire z, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> ZN) = (0.132,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX3ND4 (output ZN, input I0, I1, I2, S0, S1);
    wire z, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z, I0, I1, S0);
    Wrapped_Mux2 LibU2(Z, z, I2, S1);
    specify
    (I0, I1, I2, S0, S1 *> ZN) = (0.140,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4D0 (output Z, input I0, I1, I2, I3, S0, S1);
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> Z) = (0.129,0.131);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4D1 (output Z, input I0, I1, I2, I3, S0, S1);
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> Z) = (0.118,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4D2 (output Z, input I0, I1, I2, I3, S0, S1);
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> Z) = (0.126,0.121);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4D4 (output Z, input I0, I1, I2, I3, S0, S1);
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> Z) = (0.147,0.146);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4ND0 (output ZN, input I0, I1, I2, I3, S0, S1);
    wire z0, z1, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> ZN) = (0.333,0.160);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4ND1 (output ZN, input I0, I1, I2, I3, S0, S1);
    wire z0, z1, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> ZN) = (0.122,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4ND2 (output ZN, input I0, I1, I2, I3, S0, S1);
    wire z0, z1, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> ZN) = (0.131,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module MUX4ND4 (output ZN, input I0, I1, I2, I3, S0, S1);
    wire z0, z1, Z;
    assign ZN = !Z;
    Wrapped_Mux2 LibU1(z0, I0, I1, S0);
    Wrapped_Mux2 LibU2(z1, I2, I3, S0);
    Wrapped_Mux2 LibU3(Z, z0, z1, S1);
    specify
    (I0, I1, I2, I3, S0, S1 *> ZN) = (0.146,0.124);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D0 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.099,0.081);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D1 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.096,0.080);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D1P5 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.097,0.063);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D2 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.096,0.078);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D2P5 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.099,0.067);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D3 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.098,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D4 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.099,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D5 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.099,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D6 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.100,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND2D8 (output ZN, input A1, A2);
    assign ZN = !( A1 && A2 );
    specify
    (A1, A2 *> ZN) = (0.101,0.084);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND3D0 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 && A2 && A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.105,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND3D1 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 && A2 && A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.101,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND3D2 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 && A2 && A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.103,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND3D3 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 && A2 && A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.104,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND3D4 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 && A2 && A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.108,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND3D8 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 && A2 && A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.105,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND4D0 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 && A2 && A3 && A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.109,0.147);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND4D1 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 && A2 && A3 && A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.106,0.143);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND4D2 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 && A2 && A3 && A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.108,0.150);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND4D3 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 && A2 && A3 && A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.110,0.145);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND4D4 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 && A2 && A3 && A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.110,0.148);
    endspecify
endmodule
`endcelldefine

`celldefine
module ND4D8 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 && A2 && A3 && A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.133,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D0 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.175,0.056);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D1 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.166,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D1P5 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.131,0.056);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D2 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.167,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D2P5 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.148,0.056);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D3 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.173,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D4 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.174,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D5 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.178,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D6 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.179,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2D8 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.180,0.055);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2XD0 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.095,0.058);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2XD1 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.096,0.058);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2XD2 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.097,0.057);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2XD3 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.099,0.057);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2XD4 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.100,0.057);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR2XD8 (output ZN, input A1, A2);
    assign ZN = !( A1 || A2 );
    specify
    (A1, A2 *> ZN) = (0.103,0.057);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR3D0 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 || A2 || A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.144,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR3D1 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 || A2 || A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.143,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR3D2 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 || A2 || A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.155,0.059);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR3D3 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 || A2 || A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.151,0.060);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR3D4 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 || A2 || A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.157,0.059);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR3D8 (output ZN, input A1, A2, A3);
    assign ZN = !( A1 || A2 || A3 );
    specify
    (A1, A2, A3 *> ZN) = (0.161,0.059);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR4D0 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 || A2 || A3 || A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.193,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR4D1 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 || A2 || A3 || A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.193,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR4D2 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 || A2 || A3 || A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.216,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR4D3 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 || A2 || A3 || A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.208,0.062);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR4D4 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 || A2 || A3 || A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.216,0.061);
    endspecify
endmodule
`endcelldefine

`celldefine
module NR4D8 (output ZN, input A1, A2, A3, A4);
    assign ZN = !( A1 || A2 || A3 || A4 );
    specify
    (A1, A2, A3, A4 *> ZN) = (0.187,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA211D0 (output Z, input A1, A2, B, C);
    assign Z = (A1 || A2) && B && C;
    specify
    (A1, A2, B, C *> Z) = (0.120,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA211D1 (output Z, input A1, A2, B, C);
    assign Z = (A1 || A2) && B && C;
    specify
    (A1, A2, B, C *> Z) = (0.108,0.081);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA211D2 (output Z, input A1, A2, B, C);
    assign Z = (A1 || A2) && B && C;
    specify
    (A1, A2, B, C *> Z) = (0.116,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA211D4 (output Z, input A1, A2, B, C);
    assign Z = (A1 || A2) && B && C;
    specify
    (A1, A2, B, C *> Z) = (0.119,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA21D0 (output Z, input A1, A2, B);
    assign Z = (A1 || A2) && B;
    specify
    (A1, A2, B *> Z) = (0.109,0.085);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA21D1 (output Z, input A1, A2, B);
    assign Z = (A1 || A2) && B;
    specify
    (A1, A2, B *> Z) = (0.102,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA21D2 (output Z, input A1, A2, B);
    assign Z = (A1 || A2) && B;
    specify
    (A1, A2, B *> Z) = (0.107,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA21D4 (output Z, input A1, A2, B);
    assign Z = (A1 || A2) && B;
    specify
    (A1, A2, B *> Z) = (0.109,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA221D0 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 || A2) && (B1 || B2) && C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.128,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA221D1 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 || A2) && (B1 || B2) && C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.116,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA221D2 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 || A2) && (B1 || B2) && C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.124,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA221D4 (output Z, input A1, A2, B1, B2, C);
    assign Z = (A1 || A2) && (B1 || B2) && C;
    specify
    (A1, A2, B1, B2, C *> Z) = (0.124,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA222D0 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 || A2) && (B1 || B2) && (C1 || C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.126,0.121);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA222D1 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 || A2) && (B1 || B2) && (C1 || C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.121,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA222D2 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 || A2) && (B1 || B2) && (C1 || C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.128,0.116);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA222D4 (output Z, input A1, A2, B1, B2, C1, C2);
    assign Z = (A1 || A2) && (B1 || B2) && (C1 || C2);
    specify
    (A1, A2, B1, B2, C1, C2 *> Z) = (0.128,0.116);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA22D0 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 || A2) && (B1 || B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.113,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA22D1 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 || A2) && (B1 || B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.104,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA22D2 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 || A2) && (B1 || B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.108,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA22D4 (output Z, input A1, A2, B1, B2);
    assign Z = (A1 || A2) && (B1 || B2);
    specify
    (A1, A2, B1, B2 *> Z) = (0.109,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA31D0 (output Z, input A1, A2, A3, B);
    assign Z = (A1 || A2 || A3) && B;
    specify
    (A1, A2, A3, B *> Z) = (0.111,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA31D1 (output Z, input A1, A2, A3, B);
    assign Z = (A1 || A2 || A3) && B;
    specify
    (A1, A2, A3, B *> Z) = (0.106,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA31D2 (output Z, input A1, A2, A3, B);
    assign Z = (A1 || A2 || A3) && B;
    specify
    (A1, A2, A3, B *> Z) = (0.109,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA31D4 (output Z, input A1, A2, A3, B);
    assign Z = (A1 || A2 || A3) && B;
    specify
    (A1, A2, A3, B *> Z) = (0.112,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA32D0 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 || A2 || A3) && (B1 || B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.116,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA32D1 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 || A2 || A3) && (B1 || B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.106,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA32D2 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 || A2 || A3) && (B1 || B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.111,0.124);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA32D4 (output Z, input A1, A2, A3, B1, B2);
    assign Z = (A1 || A2 || A3) && (B1 || B2);
    specify
    (A1, A2, A3, B1, B2 *> Z) = (0.115,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA33D0 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 || A2 || A3) && (B1 || B2 || B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.118,0.145);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA33D1 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 || A2 || A3) && (B1 || B2 || B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.112,0.130);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA33D2 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 || A2 || A3) && (B1 || B2 || B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.115,0.144);
    endspecify
endmodule
`endcelldefine

`celldefine
module OA33D4 (output Z, input A1, A2, A3, B1, B2, B3);
    assign Z = (A1 || A2 || A3) && (B1 || B2 || B3);
    specify
    (A1, A2, A3, B1, B2, B3 *> Z) = (0.118,0.145);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI211D0 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 || A2) && B && C );
    specify
    (A1, A2, B, C *> ZN) = (0.157,0.121);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI211D1 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 || A2) && B && C );
    specify
    (A1, A2, B, C *> ZN) = (0.147,0.118);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI211D2 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 || A2) && B && C );
    specify
    (A1, A2, B, C *> ZN) = (0.150,0.116);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI211D4 (output ZN, input A1, A2, B, C);
    assign ZN = !( (A1 || A2) && B && C );
    specify
    (A1, A2, B, C *> ZN) = (0.151,0.121);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI21D0 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 || A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.159,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI21D1 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 || A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.152,0.085);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI21D2 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 || A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.156,0.083);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI21D4 (output ZN, input A1, A2, B);
    assign ZN = !( (A1 || A2) && B );
    specify
    (A1, A2, B *> ZN) = (0.157,0.085);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI221D0 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 || A2) && (B1 || B2) && C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.207,0.133);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI221D1 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 || A2) && (B1 || B2) && C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.187,0.129);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI221D2 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 || A2) && (B1 || B2) && C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.189,0.126);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI221D4 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 || A2) && (B1 || B2) && C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.141,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI221XD4 (output ZN, input A1, A2, B1, B2, C);
    assign ZN = !( (A1 || A2) && (B1 || B2) && C );
    specify
    (A1, A2, B1, B2, C *> ZN) = (0.190,0.129);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI222D0 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 || A2) && (B1 || B2) && (C1 || C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.247,0.142);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI222D1 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 || A2) && (B1 || B2) && (C1 || C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.217,0.135);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI222D2 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 || A2) && (B1 || B2) && (C1 || C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.222,0.132);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI222D4 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 || A2) && (B1 || B2) && (C1 || C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.149,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI222XD4 (output ZN, input A1, A2, B1, B2, C1, C2);
    assign ZN = !( (A1 || A2) && (B1 || B2) && (C1 || C2) );
    specify
    (A1, A2, B1, B2, C1, C2 *> ZN) = (0.227,0.134);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI22D0 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 || A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.200,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI22D1 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 || A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.196,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI22D2 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 || A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.199,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI22D4 (output ZN, input A1, A2, B1, B2);
    assign ZN = !( (A1 || A2) && (B1 || B2) );
    specify
    (A1, A2, B1, B2 *> ZN) = (0.200,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI31D0 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 || A2 || A3) && B );
    specify
    (A1, A2, A3, B *> ZN) = (0.243,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI31D1 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 || A2 || A3) && B );
    specify
    (A1, A2, A3, B *> ZN) = (0.231,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI31D2 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 || A2 || A3) && B );
    specify
    (A1, A2, A3, B *> ZN) = (0.250,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI31D4 (output ZN, input A1, A2, A3, B);
    assign ZN = !( (A1 || A2 || A3) && B );
    specify
    (A1, A2, A3, B *> ZN) = (0.234,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI32D0 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.284,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI32D1 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.262,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI32D2 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.280,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI32D4 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.149,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI32XD4 (output ZN, input A1, A2, A3, B1, B2);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2) );
    specify
    (A1, A2, A3, B1, B2 *> ZN) = (0.267,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI33D0 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2 || B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.349,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI33D1 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2 || B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.322,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI33D2 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2 || B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.343,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI33D4 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2 || B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.165,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module OAI33XD4 (output ZN, input A1, A2, A3, B1, B2, B3);
    assign ZN = !( (A1 || A2 || A3) && (B1 || B2 || B3) );
    specify
    (A1, A2, A3, B1, B2, B3 *> ZN) = (0.329,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR2D0 (output Z, input A1, A2);
    assign Z = A1 || A2;
    specify
    (A1, A2 *> Z) = (0.103,0.083);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR2D1 (output Z, input A1, A2);
    assign Z = A1 || A2;
    specify
    (A1, A2 *> Z) = (0.102,0.075);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR2D2 (output Z, input A1, A2);
    assign Z = A1 || A2;
    specify
    (A1, A2 *> Z) = (0.107,0.086);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR2D4 (output Z, input A1, A2);
    assign Z = A1 || A2;
    specify
    (A1, A2 *> Z) = (0.108,0.084);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR2D8 (output Z, input A1, A2);
    assign Z = A1 || A2;
    specify
    (A1, A2 *> Z) = (0.114,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR2XD1 (output Z, input A1, A2);
    assign Z = A1 || A2;
    specify
    (A1, A2 *> Z) = (0.094,0.077);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR3D0 (output Z, input A1, A2, A3);
    assign Z = A1 || A2 || A3;
    specify
    (A1, A2, A3 *> Z) = (0.106,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR3D1 (output Z, input A1, A2, A3);
    assign Z = A1 || A2 || A3;
    specify
    (A1, A2, A3 *> Z) = (0.103,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR3D2 (output Z, input A1, A2, A3);
    assign Z = A1 || A2 || A3;
    specify
    (A1, A2, A3 *> Z) = (0.110,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR3D4 (output Z, input A1, A2, A3);
    assign Z = A1 || A2 || A3;
    specify
    (A1, A2, A3 *> Z) = (0.110,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR3D8 (output Z, input A1, A2, A3);
    assign Z = A1 || A2 || A3;
    specify
    (A1, A2, A3 *> Z) = (0.116,0.119);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR3XD1 (output Z, input A1, A2, A3);
    assign Z = A1 || A2 || A3;
    specify
    (A1, A2, A3 *> Z) = (0.096,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR4D0 (output Z, input A1, A2, A3, A4);
    assign Z = A1 || A2 || A3 || A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.109,0.135);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR4D1 (output Z, input A1, A2, A3, A4);
    assign Z = A1 || A2 || A3 || A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.107,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR4D2 (output Z, input A1, A2, A3, A4);
    assign Z = A1 || A2 || A3 || A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.111,0.133);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR4D4 (output Z, input A1, A2, A3, A4);
    assign Z = A1 || A2 || A3 || A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.113,0.131);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR4D8 (output Z, input A1, A2, A3, A4);
    assign Z = A1 || A2 || A3 || A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.118,0.146);
    endspecify
endmodule
`endcelldefine

`celldefine
module OR4XD1 (output Z, input A1, A2, A3, A4);
    assign Z = A1 || A2 || A3 || A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.099,0.122);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CQD0 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1(q, d, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    specify
    (SI, D, SE, CP *> Q) = (0.127,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CQD1 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1(q, d, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    specify
    (SI, D, SE, CP *> Q) = (0.120,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CQD2 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1(q, d, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    specify
    (SI, D, SE, CP *> Q) = (0.126,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CQD4 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q = q;
    Wrapped_DFF LibU1(q, d, CP, 1'b1, 1'b1);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    specify
    (SI, D, SE, CP *> Q) = (0.135,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CXQXD1 (output Q, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q = q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3(q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q) = (0.130,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CXQXD2 (output Q, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q = q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3(q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q) = (0.133,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CXQXD4 (output Q, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q = q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3(q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q) = (0.140,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CXXD1 (output Q, QN, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3(q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q, QN) = (0.131,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CXXD2 (output Q, QN, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3(q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q, QN) = (0.136,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDF4CXXD4 (output Q, QN, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3(q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q, QN) = (0.143,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCND0 (output Q, QN, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q, QN) = (0.142,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCND1 (output Q, QN, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q, QN) = (0.142,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCND2 (output Q, QN, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q, QN) = (0.148,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCND4 (output Q, QN, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q, QN) = (0.155,0.091);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCNQD0 (output Q, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q) = (0.143,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCNQD1 (output Q, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q) = (0.138,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCNQD2 (output Q, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q) = (0.143,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCNQD4 (output Q, input SI, D, SE, CP, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, 1'b1);
    specify
    (SI, D, SE, CP, CDN *> Q) = (0.150,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSND0 (output Q, QN, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q, QN) = (0.139,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSND1 (output Q, QN, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q, QN) = (0.132,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSND2 (output Q, QN, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q, QN) = (0.141,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSND4 (output Q, QN, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q, QN) = (0.148,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSNQD0 (output Q, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1 (d, D, SI, SE);
    Wrapped_DFF LibU2  (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q) = (0.135,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSNQD1 (output Q, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1 (d, D, SI, SE);
    Wrapped_DFF LibU2  (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q) = (0.126,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSNQD2 (output Q, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1 (d, D, SI, SE);
    Wrapped_DFF LibU2  (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q) = (0.135,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFCSNQD4 (output Q, input SI, D, SE, CP, CDN, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1 (d, D, SI, SE);
    Wrapped_DFF LibU2  (q, d, CP, CDN, SDN);
    specify
    (SI, D, SE, CP, CDN, SDN *> Q) = (0.139,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFD0 (output Q, QN, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1 (d, D, SI, SE);
    Wrapped_DFF LibU2  (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q, QN) = (0.138,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFD1 (output Q, QN, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q, QN) = (0.132,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFD2 (output Q, QN, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q, QN) = (0.138,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFD4 (output Q, QN, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q, QN) = (0.140,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCND0 (output Q, QN, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q, QN) = (0.131,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCND1 (output Q, QN, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q, QN) = (0.127,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCND2 (output Q, QN, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q, QN) = (0.133,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCND4 (output Q, QN, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q, QN) = (0.128,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCNQD0 (output Q, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q) = (0.134,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCNQD1 (output Q, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q) = (0.125,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCNQD2 (output Q, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q) = (0.132,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCNQD4 (output Q, input SI, D, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN *> Q) = (0.126,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSND0 (output Q, QN, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q, QN) = (0.131,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSND1 (output Q, QN, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q, QN) = (0.128,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSND2 (output Q, QN, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q, QN) = (0.133,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSND4 (output Q, QN, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q, QN) = (0.127,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSNQD0 (output Q, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q) = (0.104,0.089);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSNQD1 (output Q, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q) = (0.126,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSNQD2 (output Q, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q) = (0.132,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKCSNQD4 (output Q, input SI, D, SE, CP, CN, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, CN&&(!SN||D), SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, CN, SN *> Q) = (0.126,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSND0 (output Q, QN, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q, QN) = (0.131,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSND1 (output Q, QN, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q, QN) = (0.128,0.103);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSND2 (output Q, QN, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q, QN) = (0.134,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSND4 (output Q, QN, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q, QN) = (0.127,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSNQD0 (output Q, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q) = (0.107,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSNQD1 (output Q, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q) = (0.126,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSNQD2 (output Q, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q) = (0.132,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFKSNQD4 (output Q, input SI, D, SE, CP, SN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, !SN||D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP, SN *> Q) = (0.126,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCND0 (output Q, QN, input SI, D, SE, CPN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, 1'b1);
    specify
    (SI, D, SE, CPN, CDN *> Q, QN) = (0.157,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCND1 (output Q, QN, input SI, D, SE, CPN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, 1'b1);
    specify
    (SI, D, SE, CPN, CDN *> Q, QN) = (0.158,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCND2 (output Q, QN, input SI, D, SE, CPN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, 1'b1);
    specify
    (SI, D, SE, CPN, CDN *> Q, QN) = (0.163,0.095);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCND4 (output Q, QN, input SI, D, SE, CPN, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, 1'b1);
    specify
    (SI, D, SE, CPN, CDN *> Q, QN) = (0.166,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCSND0 (output Q, QN, input SI, D, SE, CPN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, SDN);
    specify
    (SI, D, SE, CPN, CDN, SDN *> Q, QN) = (0.143,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCSND1 (output Q, QN, input SI, D, SE, CPN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, SDN);
    specify
    (SI, D, SE, CPN, CDN, SDN *> Q, QN) = (0.136,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCSND2 (output Q, QN, input SI, D, SE, CPN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, SDN);
    specify
    (SI, D, SE, CPN, CDN, SDN *> Q, QN) = (0.145,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNCSND4 (output Q, QN, input SI, D, SE, CPN, CDN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q && SDN;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, CDN, SDN);
    specify
    (SI, D, SE, CPN, CDN, SDN *> Q, QN) = (0.152,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFND0 (output Q, QN, input SI, D, SE, CPN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, 1'b1);
    specify
    (SI, D, SE, CPN *> Q, QN) = (0.147,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFND1 (output Q, QN, input SI, D, SE, CPN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, 1'b1);
    specify
    (SI, D, SE, CPN *> Q, QN) = (0.150,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFND2 (output Q, QN, input SI, D, SE, CPN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, 1'b1);
    specify
    (SI, D, SE, CPN *> Q, QN) = (0.155,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFND4 (output Q, QN, input SI, D, SE, CPN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, 1'b1);
    specify
    (SI, D, SE, CPN *> Q, QN) = (0.151,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNSND0 (output Q, QN, input SI, D, SE, CPN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, SDN);
    specify
    (SI, D, SE, CPN, SDN *> Q, QN) = (0.147,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNSND1 (output Q, QN, input SI, D, SE, CPN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, SDN);
    specify
    (SI, D, SE, CPN, SDN *> Q, QN) = (0.141,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNSND2 (output Q, QN, input SI, D, SE, CPN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, SDN);
    specify
    (SI, D, SE, CPN, SDN *> Q, QN) = (0.148,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFNSND4 (output Q, QN, input SI, D, SE, CPN, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, !CPN, 1'b1, SDN);
    specify
    (SI, D, SE, CPN, SDN *> Q, QN) = (0.155,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQD0 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q) = (0.131,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQD1 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q) = (0.127,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQD2 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q) = (0.134,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQD4 (output Q, input SI, D, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> Q) = (0.136,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQND0 (output QN, input SI, D, SE, CP);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> QN) = (0.092,0.076);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQND1 (output QN, input SI, D, SE, CP);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> QN) = (0.136,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQND2 (output QN, input SI, D, SE, CP);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> QN) = (0.141,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFQND4 (output QN, input SI, D, SE, CP);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, SE, CP *> QN) = (0.142,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSND0 (output Q, QN, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q, QN) = (0.140,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSND1 (output Q, QN, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q, QN) = (0.134,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSND2 (output Q, QN, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q, QN) = (0.142,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSND4 (output Q, QN, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q, QN) = (0.151,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSNQD0 (output Q, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q) = (0.135,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSNQD1 (output Q, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q) = (0.129,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSNQD2 (output Q, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q) = (0.134,0.104);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFSNQD4 (output Q, input SI, D, SE, CP, SDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(d, D, SI, SE);
    Wrapped_DFF LibU2 (q, d, CP, 1'b1, SDN);
    specify
    (SI, D, SE, CP, SDN *> Q) = (0.139,0.102);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXD0 (output Q, QN, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q, QN) = (0.135,0.110);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXD1 (output Q, QN, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q, QN) = (0.136,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXD2 (output Q, QN, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q, QN) = (0.146,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXD4 (output Q, QN, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q, QN) = (0.148,0.120);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXQD0 (output Q, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q) = (0.106,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXQD1 (output Q, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q) = (0.135,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXQD2 (output Q, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q) = (0.144,0.126);
    endspecify
endmodule
`endcelldefine

`celldefine
module SDFXQD4 (output Q, input DA, DB, SA, SI, SE, CP);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(D, DB, DA, SA);
    Wrapped_Mux2 LibU2(d, D, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (DA, DB, SA, SI, SE, CP *> Q) = (0.147,0.121);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CCNQXD1 (output Q, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q) = (0.129,0.090);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CCNQXD2 (output Q, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q) = (0.137,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CCNQXD4 (output Q, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q) = (0.146,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CCNXD1 (output Q, QN, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q, QN) = (0.131,0.090);
    endspecify
endmodule
`endcelldefine


`celldefine
module SEDF4CCNXD2 (output Q, QN, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q, QN) = (0.140,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CCNXD4 (output Q, QN, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q, QN) = (0.149,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQD0 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.134,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQD1 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.121,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQD2 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.127,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQD4 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.129,0.100);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQNXD1 (output QN, input E, SE, CP, SI, D);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> QN) = (0.133,0.108);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQNXD2 (output QN, input E, SE, CP, SI, D);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> QN) = (0.136,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQNXD4 (output QN, input E, SE, CP, SI, D);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> QN) = (0.143,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQXD1 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.129,0.105);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQXD2 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.133,0.107);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CQXD4 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.140,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CXD1 (output Q, QN, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q, QN) = (0.130,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CXD2 (output Q, QN, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q, QN) = (0.136,0.106);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDF4CXD4 (output Q, QN, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q, QN) = (0.143,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCND0 (output Q, QN, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q, QN) = (0.154,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCND1 (output Q, QN, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q, QN) = (0.155,0.092);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCND2 (output Q, QN, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q, QN) = (0.166,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCND4 (output Q, QN, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q, QN) = (0.180,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCNQD0 (output Q, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q) = (0.154,0.088);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCNQD1 (output Q, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q) = (0.155,0.094);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCNQD2 (output Q, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q) = (0.165,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFCNQD4 (output Q, input E, SE, CP, SI, D, CDN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, CDN, 1'b1);
    specify
    (E, SE, CP, SI, D, CDN *> Q) = (0.178,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFD0 (output Q, QN, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q, QN) = (0.130,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFD1 (output Q, QN, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q, QN) = (0.136,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFD2 (output Q, QN, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q, QN) = (0.147,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFD4 (output Q, QN, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q, QN) = (0.148,0.120);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCND0 (output Q, QN, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q, QN) = (0.133,0.109);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCND1 (output Q, QN, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q, QN) = (0.132,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCND2 (output Q, QN, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q, QN) = (0.139,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCND4 (output Q, QN, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q, QN) = (0.138,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCNQD0 (output Q, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q) = (0.120,0.099);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCNQD1 (output Q, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q) = (0.128,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCNQD2 (output Q, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q) = (0.136,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFKCNQD4 (output Q, input SI, D, E, SE, CP, CN);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, CN&&iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (SI, D, E, SE, CP, CN *> Q) = (0.133,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQD0 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.120,0.096);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQD1 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.135,0.111);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQD2 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.145,0.127);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQD4 (output Q, input E, SE, CP, SI, D);
    wire q;
    assign Q  =  q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> Q) = (0.147,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQND0 (output QN, input E, SE, CP, SI, D);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> QN) = (0.142,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQND1 (output QN, input E, SE, CP, SI, D);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> QN) = (0.143,0.131);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQND2 (output QN, input E, SE, CP, SI, D);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> QN) = (0.151,0.146);
    endspecify
endmodule
`endcelldefine

`celldefine
module SEDFQND4 (output QN, input E, SE, CP, SI, D);
    wire q;
    assign QN = !q;
    Wrapped_Mux2 LibU1(iD, q, D, E);
    Wrapped_Mux2 LibU2(d, iD, SI, SE);
    Wrapped_DFF LibU3 (q, d, CP, 1'b1, 1'b1);
    specify
    (E, SE, CP, SI, D *> QN) = (0.168,0.174);
    endspecify
endmodule
`endcelldefine

`celldefine
module TIEH (output Z);
  //supply1 Z;
  assign (supply1, supply0) Z = 1'b1;
endmodule
`endcelldefine

`celldefine
module TIEL (output ZN);
  //supply0 ZN;
  assign (supply1, supply0) Z = 1'b0;
endmodule
`endcelldefine

`celldefine
module XNR2D0 (output ZN, input A1, A2);
    assign ZN = A1 ~^ A2;
    specify
    (A1, A2 *> ZN) = (0.121,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR2D1 (output ZN, input A1, A2);
    assign ZN = A1 ~^ A2;
    specify
    (A1, A2 *> ZN) = (0.115,0.093);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR2D2 (output ZN, input A1, A2);
    assign ZN = A1 ~^ A2;
    specify
    (A1, A2 *> ZN) = (0.119,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR2D4 (output ZN, input A1, A2);
    assign ZN = A1 ~^ A2;
    specify
    (A1, A2 *> ZN) = (0.122,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR3D0 (output ZN, input A1, A2, A3);
    assign ZN = A1 ~^ A2 ~^ A3;
    specify
    (A1, A2, A3 *> ZN) = (0.144,0.121);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR3D1 (output ZN, input A1, A2, A3);
    assign ZN = A1 ~^ A2 ~^ A3;
    specify
    (A1, A2, A3 *> ZN) = (0.134,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR3D2 (output ZN, input A1, A2, A3);
    assign ZN = A1 ~^ A2 ~^ A3;
    specify
    (A1, A2, A3 *> ZN) = (0.139,0.119);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR3D4 (output ZN, input A1, A2, A3);
    assign ZN = A1 ~^ A2 ~^ A3;
    specify
    (A1, A2, A3 *> ZN) = (0.138,0.115);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR4D0 (output ZN, input A1, A2, A3, A4);
    assign ZN = A1 ~^ A2 ~^ A3 ~^ A4;
    specify
    (A1, A2, A3, A4 *> ZN) = (0.144,0.120);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR4D1 (output ZN, input A1, A2, A3, A4);
    assign ZN = A1 ~^ A2 ~^ A3 ~^ A4;
    specify
    (A1, A2, A3, A4 *> ZN) = (0.141,0.124);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR4D2 (output ZN, input A1, A2, A3, A4);
    assign ZN = A1 ~^ A2 ~^ A3 ~^ A4;
    specify
    (A1, A2, A3, A4 *> ZN) = (0.148,0.136);
    endspecify
endmodule
`endcelldefine

`celldefine
module XNR4D4 (output ZN, input A1, A2, A3, A4);
    assign ZN = A1 ~^ A2 ~^ A3 ~^ A4;
    specify
    (A1, A2, A3, A4 *> ZN) = (0.169,0.170);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR2D0 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.121,0.098);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR2D1 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.114,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR2D2 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.115,0.097);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR2D4 (output Z, input A1, A2);
    assign Z = A1 ^ A2;
    specify
    (A1, A2 *> Z) = (0.120,0.101);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR3D0 (output Z, input A1, A2, A3);
    assign Z = A1 ^ A2 ^ A3;
    specify
    (A1, A2, A3 *> Z) = (0.145,0.123);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR3D1 (output Z, input A1, A2, A3);
    assign Z = A1 ^ A2 ^ A3;
    specify
    (A1, A2, A3 *> Z) = (0.133,0.112);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR3D2 (output Z, input A1, A2, A3);
    assign Z = A1 ^ A2 ^ A3;
    specify
    (A1, A2, A3 *> Z) = (0.137,0.113);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR3D4 (output Z, input A1, A2, A3);
    assign Z = A1 ^ A2 ^ A3;
    specify
    (A1, A2, A3 *> Z) = (0.137,0.114);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR4D0 (output Z, input A1, A2, A3, A4);
    assign Z = A1 ^ A2 ^ A3 ^ A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.144,0.122);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR4D1 (output Z, input A1, A2, A3, A4);
    assign Z = A1 ^ A2 ^ A3 ^ A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.141,0.125);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR4D2 (output Z, input A1, A2, A3, A4);
    assign Z = A1 ^ A2 ^ A3 ^ A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.149,0.138);
    endspecify
endmodule
`endcelldefine

`celldefine
module XOR4D4 (output Z, input A1, A2, A3, A4);
    assign Z = A1 ^ A2 ^ A3 ^ A4;
    specify
    (A1, A2, A3, A4 *> Z) = (0.160,0.161);
    endspecify
endmodule
`endcelldefine

module Wrapped_DFF (output q, input d, cp, cdn, sdn);
  reg Q;
  assign q = Q;
  //
  always@(posedge cp, negedge cdn, negedge sdn)
    begin
    if ( cdn==1'b0 )
         Q <= 1'b0;
    else if (sdn == 1'b0 && cdn==1'b1)
         Q <= 1'b1;
    else if (sdn == 1'bx && cdn==1'b1)
         Q <= 1'bx;
    else Q <= d;
    end
endmodule

// 2008-01-05 jmw:  This model may not be fully correct:
module Wrapped_DLatch (output q, input d, e, cdn, sdn);
  reg Q;
  assign q = Q;
  //
  always@(*)
    begin
    if ( sdn==1'b0 )
         Q = 1'b1;
    else if (cdn==1'b0 && sdn==1'b1 )
         Q = 1'b0;
    else if ( e==1'b1 )
         Q = d;
    end
endmodule

module Wrapped_Mux2 (output q, input d0, d1, s);
  reg Q;
  assign q = Q;
  //
  always@(*)
    begin
    casez ({d0,d1,s})
     3'b0?0  : Q = 1'b0;
     3'b00x  : Q = 1'b0;
     3'b?01  : Q = 1'b0;
     3'b?11  : Q = 1'b1;
     3'b1?0  : Q = 1'b1;
     3'b11x  : Q = 1'b1;
//     default : Q = 1'bx;
    endcase
    end
endmodule

module WrappedBoothMux (output q, input d0, d1, d2, d3, d4);
  reg Q;
  assign q = Q;
  //
  always@(*)
    begin
    casez ({d0,d1,d2,d3,d4})
    5'b000?? : Q = 1'b1;
    5'b001?0 : Q = 1'b0;
    5'b001?1 : Q = 1'b1;
    5'b010?0 : Q = 1'b1;
    5'b010?1 : Q = 1'b0;
    5'b011?? : Q = 1'b0;
    5'b100?? : Q = 1'b1;
    5'b1010? : Q = 1'b0;
    5'b1011? : Q = 1'b1;
    5'b1100? : Q = 1'b1;
    5'b1101? : Q = 1'b0;
    5'b111?? : Q = 1'b0;
//    default  : Q = 1'bx;
    endcase
    end
endmodule

// end library.
