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

module andor;

logic a,b,c,d,e;
logic clk;

initial
	$vcdpluson();

initial begin
clk=1'b0; a=1'b0; b=1'b0; c=1'b0; d=1'b0; e=1'b0;

repeat(2) @(posedge clk);
a=1'b1; c=1'b1;
repeat(1) @(posedge clk);
b=1'b1; a=1'b0; c=1'b0;
repeat(1) @(posedge clk);
d=1'b1; b=1'b0;
repeat(1) @(posedge clk);
d=1'b0;
repeat(1) @(posedge clk);
a=1'b1; c=1'b1;
repeat(2) @(posedge clk);
b=1'b1; 
repeat(1) @(posedge clk);
d=1'b1; 
repeat(3) @(posedge clk);
d=1'b0; a=1'b0; b=1'b0; c=1'b0;
repeat(3) @(posedge clk);

$finish();
end

sequence s27a;
	@(posedge clk) a##[1:2] b;
endsequence

sequence s27b;
	@(posedge clk) c##[2:3] d;
endsequence

// AND construct
property p27;
	@(posedge clk)  s27a and s27b;
endproperty

// intersect
property p28;
	@(posedge clk)  s27a intersect s27b;
endproperty

// OR construct
property p29;
	@(posedge clk)  s27a or s27b;
endproperty


a27: assert property(p27);
a28: assert property(p28);
a29: assert property(p29);

initial
	forever clk = #25 ~clk;

endmodule
