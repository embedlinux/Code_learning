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


module routines;

logic clk;

logic [3:0] state;
logic [4:0] bus;
integer i;

initial $vcdpluson();

initial
begin
clk = 1'b0; state = 4'd0; 
@(posedge clk);

for(i=0; i<3; i++)
begin
	state = i*2;
	bus = $random();
	@(posedge clk);
end

for(i=0; i<3; i++)
begin
	state = $random() % 16;
	bus = 8'dz;
	@(posedge clk);
end

bus = 4'd10;
repeat(2) @(posedge clk);

$finish();
end

// builtin system functions

a33a: assert property(@(posedge clk) $onehot(state));
a33b: assert property(@(posedge clk) $onehot0(state));
a33c: assert property(@(posedge clk) $isunknown(bus));
a33d: assert property(@(posedge clk) $countones(bus) > 1);


initial forever clk = #25 ~ clk;

endmodule

