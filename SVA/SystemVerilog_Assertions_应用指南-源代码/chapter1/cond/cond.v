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

module cond;

logic clk, start;

logic a,b,c,d,e;

initial $vcdpluson();

initial
begin
clk=1'b0;
a=1'b1; b=1'b1; start=1'b1; c=1'b0;

// throughout

repeat(2) @(posedge clk);
start=1'b0;
repeat(1) @(posedge clk);
a=1'b0; b=1'b0;
repeat(2) @(posedge clk);
c=1'b1;
repeat(1) @(posedge clk);
c=1'b0;
repeat(2) @(posedge clk);
c=1'b1;
repeat(1) @(posedge clk);
c=1'b0;
repeat(1) @(posedge clk);
c=1'b1;
repeat(1) @(posedge clk);
c=1'b0; a=1'b1; b=1'b1;
repeat(1) @(posedge clk);
start=1'b1;
repeat(1) @(posedge clk);

repeat(2) @(posedge clk);
start=1'b0;
repeat(1) @(posedge clk);
a=1'b0; b=1'b0;
repeat(3) @(posedge clk);
c=1'b1;
repeat(1) @(posedge clk);
c=1'b0;
repeat(1) @(posedge clk);
c=1'b1;
repeat(1) @(posedge clk);
c=1'b0; 
repeat(1) @(posedge clk);
c=1'b1; start=1'b1;

repeat(1) @(posedge clk);
c=1'b0; a=1'b1; b=1'b1;
repeat(2) @(posedge clk);

$finish();
end

// throughout construct
property p31;
	@(posedge clk) $fell(start) |-> (!start) throughout (##1 (!a&&!b) ##1 (c[->3]) ##1 (a&&b));
endproperty


// within construct
sequence s32a;
	@(posedge clk) ((!a&&!b) ##1 (c[->3]) ##1 (a&&b));
endsequence

sequence s32b;
	@(posedge clk) $fell(start) ##[6:10] $rose(start);
endsequence

sequence s32;
	@(posedge clk) s32a within s32b;
endsequence

property p32;
	@(posedge clk) $fell(start) |-> s32;
endproperty


a31: assert property(p31);
a32: assert property(p32);

initial
forever clk = #25 ~clk;

endmodule
