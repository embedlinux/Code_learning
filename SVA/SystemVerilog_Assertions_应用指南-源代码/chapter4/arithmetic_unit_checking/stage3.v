// final stage of the WH arithmetic module
/************************************************************************\
|*                                                                      *|
|*    Copyright (c) 2005  Springer. All rights reserved.                *|
|*                                                                      *|
|*  This example code shouyld be used only for illustration purpose     *| 
|*  This material is not to reproduced,  copied,  or used  in any       *|
|*  manner without the authorization of the author's/publishers         *|
|*  written permission                                                  *|
|*                                                                      *|
\************************************************************************/

// Author: Srikanth Vijayaraghavan and Meyyappan Ramanathan

module stage3 (input logic signed [15:0] z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,
		output logic signed [15:0] x1,x2,x3,x4,x5,x6,x7,x8);

add u1 (z1,z2,x1);
sub u2 (z1,z2,x2);
sub u3 (z3,z4,x3);
sub u4 (z5,z6,x4);
sub u5 (z7,z8,x5);
sub u6 (z9,z10,x6);
sub u7 (z11,z12,x7);
sub u8 (z13,z14,x8);

endmodule
