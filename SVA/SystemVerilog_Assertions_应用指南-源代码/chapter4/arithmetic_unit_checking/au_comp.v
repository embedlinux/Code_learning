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

module au_comp(
	input logic clk, reset, enable1, enable2,
	input logic signed [15:0] d1, d2, d3, d4, d5, d6, d7, d8,
	output logic signed [15:0] o1, o2, o3, o4, o5, o6, o7, o8
);

logic signed [15:0] q1, q2, q3, q4, q5, q6, q7, q8;
logic signed [15:0] w1, w2, w3, w4, w5, w6, w7, w8;

pipo8 u1 ( reset, enable1, d1, d2, d3, d4, d5, d6, d7, d8, q1, q2, q3, q4, q5, q6, q7, q8);
wh u2 ( q1, q2, q3, q4, q5, q6, q7, q8, w1, w2, w3, w4, w5, w6, w7, w8);
pipo8 u3 ( reset, enable2, w1, w2, w3, w4, w5, w6, w7, w8, o1, o2, o3, o4, o5, o6, o7, o8);

endmodule

module tb;

reg reset, enable1, enable2;
reg [15:0] d1, d2, d3, d4, d5, d6, d7, d8;
reg [7:0] dd1, dd2, dd3, dd4, dd5, dd6, dd7, dd8;
reg signed [15:0] o1, o2, o3, o4, o5, o6, o7, o8;
reg clk;
integer i;
reg msb = {8{1'b0}};

au_comp i1 ( clk, reset, enable1, enable2, d1, d2, d3, d4, d5, d6, d7, d8, o1, o2, o3, o4, o5, o6, o7, o8);

initial
	$vcdpluson();

initial
begin
	clk = 1'b0; reset=1'b1; enable1=1'b0; enable2=1'b0;
	#100 reset=1'b0;
	#100 reset=1'b1;
	for(i=0; i<8; i++)
	begin
		#1 dd1= $random % 255;
		d1 = {msb, dd1};
		dd2= $random % 255;
		d2 = {msb, dd2};
		dd3= $random % 255;
		d3 = {msb, dd3};
		dd4= $random % 255;
		d4 = {msb, dd4};
		dd5= $random % 255;
		d5 = {msb, dd5};
		dd6= $random % 255;
		d6 = {msb, dd6};
		dd7= $random % 255;
		d7 = {msb, dd7};
		dd8= $random % 255;
		d8 = {msb, dd8};
		repeat(1) @(posedge clk);
		enable1 = 1'b1;
		#50 enable1 = 1'b0;
		repeat(2) @(posedge clk);
		enable2 = 1'b1;
		#50 enable2 = 1'b0;
	end
	#100 $finish();
end

initial forever clk = #25 ~clk;

endmodule
		




