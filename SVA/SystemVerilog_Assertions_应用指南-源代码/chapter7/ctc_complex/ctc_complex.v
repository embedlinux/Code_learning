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


module ctc_complex;

logic irdyn, trdyn, devseln, stopn, framen;
integer i, j;
logic clk;
logic [3:0] test_expr;

assign irdyn = test_expr[3];
assign trdyn = test_expr[2];
assign devseln = test_expr[1];
assign stopn = test_expr[0];

initial $vcdpluson();

initial begin
clk = 1'b0; test_expr = 4'd15;
repeat(2) @(posedge clk);

for(i=1; i<17; i++) // timing loop
begin
for(j=0; j<16; j++) // logical loop
begin
	framen = 1'b0;
	repeat(1) @(posedge clk);
	test_expr = 4'b1101;
	repeat(i) @(posedge clk);
	test_expr = j;
	repeat(1) @(posedge clk);
	framen = 1'b1;
	repeat(1) @(posedge clk);
	test_expr = 4'b1111;
	repeat(1) @(posedge clk);
end
end
	
repeat(2) @(posedge clk);
$finish;
end

initial forever clk = #25 ~clk;

// checker under test

sequence s_tchk9a;
@(posedge clk) 
(!irdyn && !trdyn);
endsequence

sequence s_tchk9b;
@(posedge clk) 
(!irdyn && !stopn);
endsequence

sequence s_tchk9_fast;
@(posedge clk) 
$fell(framen) ##1 $fell(devseln);
endsequence

property p_tchk9_fast;
@(posedge clk) 
s_tchk9_fast |->  (!framen && !devseln) throughout 
	(##[1:15] (s_tchk9a.ended || s_tchk9b.ended));
endproperty

a_tchk9_fast: assert property(p_tchk9_fast);
c_tchk9_fast: cover property(p_tchk9_fast);

endmodule
