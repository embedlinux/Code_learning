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

module f_match;

logic a,b,c,d,e;
logic clk;

initial
	$vcdpluson();

initial begin
clk=1'b0; a=1'b0; b=1'b0; c=1'b0; d=1'b0;

repeat(2) @(posedge clk);
a = 1'b1; c=1'b1;
repeat(1) @(posedge clk);
a = 1'b0; c=1'b0;
repeat(1) @(posedge clk);
d = 1'b1;
repeat(1) @(posedge clk);
b=1'b1; d=1'b0;
repeat(1) @(posedge clk);
b=1'b0;
repeat(2) @(posedge clk);

a = 1'b1; c=1'b1;
repeat(1) @(posedge clk);
a = 1'b0; c=1'b0; b=1'b1; 
repeat(1) @(posedge clk);
d=1'b1;
repeat(2) @(posedge clk);
b=1'b0;
d=1'b0; 
repeat(3) @(posedge clk);


$finish();

end


sequence s30a;
	@(posedge clk) a ##[1:3] b;
endsequence

sequence s30b;
	@(posedge clk) c ##[2:3] d;
endsequence

property p30_fm;
	@(posedge clk) first_match(s30a or s30b);
endproperty

property p30;
	@(posedge clk) s30a or s30b;
endproperty

a30: assert property(p30);
a30_fm: assert property(p30_fm);


initial forever clk = #25 ~clk;


endmodule
