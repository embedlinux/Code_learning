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

module au (
	input logic [7:0] a, b, c,
	input logic sel,
	output logic [15:0] d, dd
);

logic [15:0] e;
logic [15:0] sel_h, sel_l;

always_comb 
begin
	if(sel) d = a*b;
	else d = a*c;
end

always_comb 
begin
	if(sel) e = b; else e = c;
	dd = e*a;
end

always@(a, b, c, sel)
begin
sel_h = a*b;
sel_l = a*c;

// assertions inlined

if(sel)
sel_high : assert ((sel_h == d) && (sel_h == dd)); 
if (!sel)
sel_low : assert ((sel_l == d) && (sel_l == dd));

end

endmodule	

module tb;

logic [7:0] a, b, c;
logic sel;
logic [15:0] d ,dd;
logic [3:0] sel_reg;
integer i;

au i1 (a, b, c, sel, d, dd);

initial
$vcdpluson();

initial
begin
	#50;
	for(i=0; i<50; i++)
	begin
		a = $random % 255;
		b = $random % 255;
		c = $random % 255;
		sel_reg = $random % 15;
		sel = sel_reg[2];
		#50;
	end
#100 $finish;
end

endmodule



