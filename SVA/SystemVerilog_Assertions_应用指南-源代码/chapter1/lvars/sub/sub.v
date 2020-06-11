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

module sub;

logic a, b, clk;

initial $vcdpluson();

initial begin
clk = 1'b0; a=1'b0; b=1'b0;
repeat(2) @(posedge clk);
a=1'b1;
repeat(1) @(posedge clk);
a=1'b0;
repeat(2) @(posedge clk);
b=1'b1;
repeat(1) @(posedge clk);
b=1'b0;

repeat(2) @(posedge clk);
a=1'b1;
repeat(1) @(posedge clk);
a=1'b0;
repeat(6) @(posedge clk);
b=1'b1;
repeat(1) @(posedge clk);
b=1'b0;

repeat(2) @(posedge clk);
$finish;
end

initial forever clk = #25 ~ clk;

sequence s_display1;
	@(posedge clk) ($rose(a), $display("Signal a arrived at %t\n", $time));
endsequence

sequence s_display2;
	@(posedge clk) ($rose(b), $display("Signal b arrived at %t\n", $time));
endsequence

property p_display_window;
	@(posedge clk) s_display1 |-> ##[2:5] s_display2;
endproperty

a_display_window : assert property(p_display_window);

endmodule
