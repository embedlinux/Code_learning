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

module pipo8 (
	input logic reset, enable,
	input logic signed [15:0] d1, d2, d3, d4, d5, d6, d7, d8,
	output logic signed [15:0] q1, q2, q3, q4, q5, q6, q7, q8
);

latch u1 (reset,enable,d1,q1);
latch u2 (reset,enable,d2,q2);
latch u3 (reset,enable,d3,q3);
latch u4 (reset,enable,d4,q4);
latch u5 (reset,enable,d5,q5);
latch u6 (reset,enable,d6,q6);
latch u7 (reset,enable,d7,q7);
latch u8 (reset,enable,d8,q8);

endmodule
