// First stage of the Arithmetic Module
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

module stage1 (input logic signed [15:0] d1,d2,d3,d4,d5,d6,d7,d8,
		output logic signed [15:0] y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12);

add u1 (d1,d2,y1);
add u2 (d3,d4,y2);
add u3 (d5,d6,y3);
add u4 (d7,d8,y4);
add u5 (d1,d4,y5);
add u6 (d5,d8,y6);
add u7 (d2,d3,y7);
add u8 (d6,d7,y8);
add u9 (d1,d3,y9);
add u10 (d6,d8,y10);
add u11 (d2,d4,y11);
add u12 (d5,d7,y12);

endmodule

