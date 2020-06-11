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


module formal(clk, reset, a, b);

input logic  reset, clk, a;
output logic b;

reg [2:0] delta;

always@(posedge clk)
begin
	if(reset)
		b = 1'b0;
	else if(a)
		begin
		delta = $random() % 8;
		repeat(delta) @(posedge clk);
		b = 1'b1;
		repeat(1) @(posedge clk);
		b = 1'b0;
		end
end

endmodule

module tb;

logic reset, clk, a;
integer i;

formal i1 (clk, reset, a, b);
		
initial $vcdpluson();

initial 
begin
clk = 1'b0; reset = 1'b0; a=1'b0;
repeat(2) @(posedge clk);
reset = 1'b1;
repeat(2) @(posedge clk);
reset = 1'b0;
repeat(1) @(posedge clk);
for(i=0; i<10; i++)
begin
	a = 1'b1;
	wait(b);
	repeat(1) @(posedge clk);
	a = 1'b0;
	repeat(2) @(posedge clk);
end

$finish;
end

property p_reset_a;
	@(posedge clk) reset |-> !a;
endproperty

property p_a;
	@(posedge clk) b |=> !a;
endproperty

property p_a_until;
	@(posedge clk) a |-> a[*1:8] ##0 b;
endproperty

property p_reset_b;
	@(posedge clk) (reset || !a) |-> !b;
endproperty

property p_b;
	@(posedge clk) b |=> !b;
endproperty

`ifdef FORMAL

assume_reset_a: assume property(p_reset_a);
assume_a: assume property(p_a);
assume_a_until: assume property(p_a_until);

a_reset_b: assert property(p_reset_b);
a_b: assert property(p_b);

`endif

`ifdef SIM

property p_a_to_b;

@(posedge clk) 
(!reset && $rose(a)) |-> 
(a [*1:8] ##0 b) ##1 (!a && !b);
endproperty

a_a_to_b: assert property(p_a_to_b);

`endif

initial forever clk = #25 ~ clk;

endmodule

