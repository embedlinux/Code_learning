// Second stage of the WH arithmetic module
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

module stage2 (input logic signed [15:0] y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,
	output logic signed [15:0] z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14);

add u1 (y1,y2,z1);
add u2 (y3,y4,z2);
add u3 (y1,y4,z3);
add u4 (y2,y3,z4);
add u5 (y1,y3,z5);
add u6 (y2,y4,z6);
add u7 (y5,y6,z7);
add u8 (y7,y8,z8);
add u9 (y5,y8,z9);
add u10 (y7,y6,z10);
add u11 (y9,y10,z11);
add u12 (y11,y12,z12);
add u13 (y9,y12,z13);
add u14 (y11,y10,z14);

endmodule

