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


module match;

logic a, b, clk1, clk2;

initial $vcdpluson();

initial
begin
clk1 = 1'b0; clk2 = 1'b0;
a=1'b0; b=1'b0;
repeat(2) @(posedge clk1);
a = 1'b1;
repeat(1) @(posedge clk1);
a = 1'b0;
@(posedge clk2);
b = 1'b1;
@(posedge clk2);
b = 1'b0;
repeat(2) @(posedge clk1);
a = 1'b1;
repeat(1) @(posedge clk1);
a = 1'b0;
@(posedge clk2);
@(posedge clk2);
b = 1'b1;
@(posedge clk2);
b = 1'b0;
$finish;
end

initial forever clk1 = #25 ~clk1;
initial forever clk2 = #75 !clk2;

sequence s_a;
	@(posedge clk1) $rose(a);
endsequence

sequence s_b;
	@(posedge clk2) $rose(b);
endsequence

property p_match;
	@(posedge clk2) s_a.matched |=> s_b;
endproperty

a_match: assert property(p_match); 

endmodule
