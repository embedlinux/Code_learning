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

module latch (reset_, latch_en, din, dout);

input reset_;
input latch_en;
input logic signed [15:0] din;
output logic signed [15:0] dout;

always_latch
begin
	// dout = 0;
	if(!reset_)
		dout <= 1'b0;
	else if (latch_en)
		dout <= din;
end

endmodule
