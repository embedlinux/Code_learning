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


module inline(clk, a, b, d1, d2, d);

input logic clk, a, b;
input logic [7:0] d1, d2;
output logic [7:0] d;

always@(posedge clk)
begin
	if(a)
		d <= d1;
	if(b)
		d <= d2;
end


endmodule

module top(clk, a, b, c, d, in1, in2, in3, in4, out1, out2);

input logic clk, a, b, c, d;
input logic [7:0] in1, in2, in3, in4;
output logic [7:0] out1, out2;

inline u1 (clk, a, b, in1, in2, out1);
inline u2 (clk, c, d, in3, in4, out2);

endmodule


module mutex_chk(a, b, clk);

input logic a, b, clk;

property p_mutex;
	@(posedge clk) not (a && b);
endproperty

a_mutex: assert property(p_mutex);
c_mutex: cover property(p_mutex);

endmodule

// bind inline mutex_chk i2 (a, b, clk);
bind top mutex_chk i3 (a, b, clk);
bind top mutex_chk i4 (c, d, clk);

module tb;

logic clk, a, b, c, d;
// logic [7:0] d1, d2;
// logic [7:0] d;

logic [7:0] in1, in2, in3, in4;
logic [7:0] out1, out2;

// inline i1 (clk, a, b, d1, d2, d);

top top1 (clk, a, b, c, d, in1, in2, in3, in4, out1, out2);

initial $vcdpluson();

initial
begin
clk=1'b0; a=1'b0; b=1'b0;
// #100 d1 = 8'd10; d2 = 8'd25;
#100 in1 = 8'd10; in2 = 8'd25;
#100 a=1'b1;
#100 b=1'b1; a=1'b0;
#100 a=1'b1;
#100 a=1'b0; b=1'b0;
#100
$finish;
end

initial forever clk = #25 ~clk;

endmodule

// c_mutex, 12 attempts, 12 match, 0 vacuous match
