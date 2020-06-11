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


module disableiff;

logic clk, reset, start;
logic a,b,c;

initial $vcdpluson();

initial
begin
clk=1'b0; reset=1'b0; start = 1'b0;
repeat(2) @(posedge clk);
reset = 1'b1; a=1'b0; b=1'b0; c=1'b0;
repeat(2) @(posedge clk) reset = 1'b0; start = 1'b1; 

@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
repeat(2) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
repeat(2) @(posedge clk);
@(posedge clk) b=1'b1;
@(posedge clk) b=1'b0;
repeat(2) @(posedge clk);
@(posedge clk) b=1'b1;
@(posedge clk) b=1'b0;
repeat(1) @(posedge clk);
start = 1'b0;
repeat(2) @(posedge clk);start = 1'b1;

@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
repeat(2) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
repeat(2) @(posedge clk);
@(posedge clk) b=1'b1; reset = 1'b1;
@(posedge clk) b=1'b0;
repeat(2) @(posedge clk);
@(posedge clk) b=1'b1;
@(posedge clk) b=1'b0;
repeat(1) @(posedge clk);
start = 1'b0;
repeat(2) @(posedge clk);

$finish();
end

property p34;
	 @(posedge clk) disable iff (reset) $rose(start) |=> a[=2] ##1 b[=2] ##1 !start ;
endproperty

a34: assert property(p34);

initial forever clk = #25 ~clk;

endmodule
