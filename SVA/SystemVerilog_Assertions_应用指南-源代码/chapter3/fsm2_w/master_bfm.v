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


module master_bfm (ask_for_it, clk, req, gnt, frame, irdy);

input clk, gnt, ask_for_it;
output req, frame, irdy;

reg req, frame, irdy;
integer i=0;

initial
begin
frame = 1'b1; irdy = 1'b1;
req = 1'b1;
end

always@(posedge ask_for_it)
begin
	repeat(1) @(posedge clk);
	req = 1'b0;
	repeat(1) @(posedge clk);
	req = 1'b1;
	while(i!=5)
		begin
			#1 if(!gnt)
				begin
					$display("Arbiter latency = %d cycles\n", i);
					frame = 1'b0; irdy = 1'b0;
					repeat(8)@(posedge clk);
					frame = 1'b1; irdy = 1'b1;
					break;
				end
			else if (gnt)
				begin
					i=i+1;
					@(posedge clk);
				end
		end
	i=0;
end

endmodule


