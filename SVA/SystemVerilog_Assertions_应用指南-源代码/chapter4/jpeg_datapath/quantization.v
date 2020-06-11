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


module quantization (

input logic signed [15:0] d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28,d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44, d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58,d59,d60,d61,d62,d63,d64,

output logic signed [15:0] do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do18,do19,do20,do21,do22,do23,do24,do25,do26,do27,do28,do29,do30,do31,do32,do33,do34,do35,do36,do37,do38,do39,do40,do41,do42,do43,do44,do45,do46,do47,do48,do49,do50,do51,do52,do53,do54,do55,do56,do57,do58,do59,do60,do61,do62,do63,do64

);

always@(*)
begin
	do1 <= d1 >>> 5;
	do2 <= d2 >>> 6;
	do3 <= d3 >>> 6;
	do4 <= d4 >>> 7;
	do5 <= d5 >>> 7;
	do6 <= d6 >>> 7;
	do7 <= d7 >>> 7;
	do8 <= d7 >>> 8;

	do9 <= d9 >>> 6;
	do10 <= d10 >>> 6;
	do11 <= d11 >>> 7;
	do12 <= d12 >>> 7;
	do13 <= d13 >>> 7;
	do14 <= d14 >>> 7;
	do15 <= d15 >>> 8;
	do16 <= d16 >>> 8;

	do17 <= d17 >>> 6;
	do18 <= d18 >>> 7;
	do19 <= d19 >>> 7;
	do20 <= d20 >>> 7;
	do21 <= d21 >>> 7;
	do22 <= d22 >>> 8;
	do23 <= d23 >>> 8;
	do24 <= d24 >>> 8;

	do25 <= d25 >>> 7;
	do26 <= d26 >>> 7;
	do27 <= d27 >>> 7;
	do28 <= d28 >>> 7;
	do29 <= d29 >>> 8;
	do30 <= d30 >>> 8;
	do31 <= d31 >>> 8;
	do32 <= d32 >>> 8;

	do33 <= d33 >>> 7;
	do34 <= d34 >>> 7;
	do35 <= d35 >>> 7;
	do36 <= d36 >>> 7;
	do37 <= d37 >>> 8;
	do38 <= d38 >>> 8;
	do39 <= d39 >>> 8;
	do40 <= d40 >>> 8;
	
	do41 <= d41 >>> 7;
	do42 <= d42 >>> 7;
	do43 <= d43 >>> 7;
	do44 <= d44 >>> 8;
	do45 <= d45 >>> 8;
	do46 <= d46 >>> 8;
	do47 <= d47 >>> 8;
	do48 <= d48 >>> 8;

	do49 <= d49 >>> 7;
	do50 <= d50 >>> 7;
	do51 <= d51 >>> 7;
	do52 <= d52 >>> 8;
	do53 <= d53 >>> 8;
	do54 <= d54 >>> 8;
	do55 <= d55 >>> 8;
	do56 <= d56 >>> 8;

	do57 <= d57 >>> 7;
	do58 <= d58 >>> 7;
	do59 <= d59 >>> 7;
	do60 <= d60 >>> 8;
	do61 <= d61 >>> 8;
	do62 <= d62 >>> 8;
	do63 <= d63 >>> 8;
	do64 <= d64 >>> 8;
end

endmodule
