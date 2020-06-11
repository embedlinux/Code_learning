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


module pformal;

logic clk;
logic a1, a2, a3;
logic b1, b2, b3;
logic c1, c2, c3;
logic d1, d2, d3;

initial $vcdpluson();

initial
begin
clk=1'b0; 
a1=1'b1; b1=1'b1; c1=1'b1; d1=1'b1;
a2=1'b1; b2=1'b1; c2=1'b1; d2=1'b1;
a3=1'b1; b3=1'b1; c3=1'b1; d3=1'b1;

repeat(3) @(posedge clk);
a1=1'b0;
a2=1'b0;
@(posedge clk);
a1=1'b1;
a2=1'b1;
repeat(2) @(posedge clk);
b1=1'b0;
repeat(1) @(posedge clk);
c1=1'd0; d1=1'd0;
repeat(4) @(posedge clk);
c1=1'd1; d1=1'd1;
repeat(1) @(posedge clk);
b1=1'b1;
repeat(2) @(posedge clk);

a1=1'b0;
a3=1'b0;
@(posedge clk);
a1=1'b1;
a3=1'b1;
repeat(2) @(posedge clk);
b3=1'b0;
repeat(1) @(posedge clk);
c3=1'd0; d1=3'd0;
repeat(3) @(posedge clk);
c3=1'd1; d1=3'd1;
repeat(1) @(posedge clk);
b3=1'b1;
repeat(2) @(posedge clk);

$finish();
end

property arb (a, b, c, d);
	@(posedge clk) ($fell(a) ##[2:5] $fell(b)) |->
	##1 ($fell(c) && $fell(d)) ##0 (!c&&!d) [*4] ##1 (c&&d) ##1 b;
endproperty

a36_1: assert property(arb(a1, b1, c1, d1));
a36_2: assert property(arb(a2, b2, c2, d2));
a36_3: assert property(arb(a3, b3, c3, d3));


initial forever clk = #25 ~clk;

endmodule
