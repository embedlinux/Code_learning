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


module cubed(enable1, a, aa, clk);

input logic [7:0] a;
input logic enable1, clk;
output logic [23:0] aa;

reg [7:0] valid_a;
reg [23:0] temp_aa;

initial begin
aa = 23'bz;
end

always@(posedge clk)
begin
	if(enable1)
		valid_a <= a;
end

always@(valid_a)
begin
	temp_aa <= valid_a * valid_a * valid_a;
	repeat(4) @(posedge clk);
	aa <= temp_aa;
	repeat(1) @(posedge clk);
	aa <= 23'bz;
end

endmodule

module tb;

reg clk, enable1;
reg [7:0] a;
wire [23:0] aa;

cubed i1  (enable1, a, aa, clk);

initial $vcdpluson();

initial begin
clk = 1'b0;
a = 8'bz; enable1 = 1'b0;
repeat(2) @(posedge clk);
enable1 = 1'b1; a= 8'd5;
repeat(2) @(posedge clk);
enable1 = 1'b0; a = 8'bz;
repeat(3) @(posedge clk);
enable1 = 1'b1; a= 8'd6;
repeat(2) @(posedge clk);
enable1 = 1'b0; a = 8'bz;
repeat(4) @(posedge clk);
$finish();
end


initial forever clk = #25 ~ clk;

property p_local_var1;
int lvar1;
	@(posedge clk) ($rose(enable1), lvar1 = a) |-> ##4 (aa == (lvar1*lvar1*lvar1));
endproperty

a_local_var1: assert property(p_local_var1); 

endmodule






