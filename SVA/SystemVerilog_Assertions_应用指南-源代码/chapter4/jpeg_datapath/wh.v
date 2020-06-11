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


module wh (input logic signed [15:0] d1, d2, d3, d4, d5, d6, d7, d8, 
		output logic signed [15:0] x1, x2, x3, x4, x5, x6, x7, x8);

wire signed  [15:0] y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12;
wire signed [15:0] z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14;

stage1 u1(d1,d2,d3,d4,d5,d6,d7,d8,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12);
stage2 u2(y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14);
stage3 u3(z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,x1,x2,x3,x4,x5,x6,x7,x8);

endmodule
