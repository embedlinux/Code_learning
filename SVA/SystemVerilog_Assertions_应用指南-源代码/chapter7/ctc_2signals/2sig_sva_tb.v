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


module sig_sva_tb;

logic a,b;
logic clk;
logic [1:0] rpt_wait;
logic [1:0] stop_wait;

`include  "config.v"
integer i,j;

logic [1:0] logical_op_reg;
initial $vcdpluson();

initial
begin
clk = 1'b0; a=1'b0; b=1'b0;
logical_op_reg = 2'b00;

//*************************************************
// case 1 
// logical operation, overlapping implication
// level sensitive signals
//*************************************************

if((logic_op == 1 || o_l_implication == 1) && timing == 0 && sig_edge == 0)
begin
for(i=0; i<4; i++)
begin
	a <= logical_op_reg[0];
	b <= logical_op_reg[1];
	repeat(1) @(posedge clk);
	logical_op_reg++;
end
end


//*************************************************
// case 2  
// logical operation, overlapping implication
// edge sensitive signals
//*************************************************

if((logic_op == 1 || o_e_implication == 1) && timing == 0 && sig_edge == 1)
begin

if(sig1_edge == 0) // ff, fr
begin
for(i=0; i<8; i++)
begin
	a <= logical_op_reg[0];
	b <= logical_op_reg[1];
	repeat(1) @(posedge clk);
	logical_op_reg++;
end
end

if(sig1_edge == 1) // rr, rf
begin
for(i=0; i<8; i++)
begin
	a <= !logical_op_reg[0];
	b <= !logical_op_reg[1];
	repeat(1) @(posedge clk);
	logical_op_reg++;
end
end

end

//*************************************************
// case 3
// timing relation between 2 signals
//*************************************************

if(logic_op == 0 && timing == 1)
begin

if(timing_level == 2'b11) begin
a = 1'b0; b=1'b0;
end

if(timing_level== 2'b00) begin
a = 1'b1; b=1'b1;
end

if(timing_level == 2'b01) begin
a = 1'b1; b=1'b0;
end

if(timing_level == 2'b10) begin
a = 1'b0; b=1'b1;
end

for(i=(min_time-1); i<(max_time+3); i++)
begin
	repeat(1) @(posedge clk);
	a <= ~a;
	if(i == 0)
	begin
		b <= ~b;
		repeat(1) @(posedge clk);
		a <= ~a; b <= ~b;
	end
	else
	begin
		repeat(1) @(posedge clk);
		a<= ~a;
		repeat((i-1)) @(posedge clk);
		b<= ~b;
		repeat(1) @(posedge clk);
		b<= ~b;
	end
end
end

//*************************************************
// case 4
// repetitions
//*************************************************

if(rpt_me == 1)
begin

if(rpt_edge == 2'b11) begin
a = 1'b0; b=1'b0;
end

if(rpt_edge == 2'b00) begin
a = 1'b1; b=1'b1;
end

if(rpt_edge == 2'b01) begin
a = 1'b1; b=1'b0;
end

if(rpt_edge == 2'b10) begin
a = 1'b0; b=1'b1;
end

if(c_rpt == 1)
begin
for(i=(repetition-1); i<(repetition+3); i++)
begin
	repeat(1) @(posedge clk);
	a <= ~a;
	repeat(start_wait) @(posedge clk);
	b <= ~b;

	// consecutive repeat condition
	
	repeat((i)) @(posedge clk);
	b <= ~b;
	stop_wait <= $random() % 4;
	repeat(stop_wait[0]) @(posedge clk);
	a <= ~a;
end	
end
end
		
	


repeat(2) @(posedge clk);
$finish();
end


initial
forever clk = #25 ~clk;

endmodule

bind sig_sva_tb sig_sva i1 (a, b, clk);
