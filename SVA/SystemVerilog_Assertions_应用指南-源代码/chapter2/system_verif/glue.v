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



module glue(clk, frame1, irdy1, frame2, irdy2, frame3, irdy3, trdy,
		rsel1, rsel2, rsel3, data1, data2, data3, sel, 
		data, dataout1, dataout2, datao);

input frame1, irdy1, frame2, irdy2; 
input frame3, irdy3;
input rsel1, rsel2, rsel3;
input clk;
input [1:0] trdy;
input [8:0] data1, data2, data3;
input [7:0] dataout1, dataout2;

output [1:0] sel;
output [8:0] data;
output [7:0] datao;

wire [7:0] dataout1, dataout2;
reg [1:0] sel, trdy;
reg [8:0] data1, data2, data3, data;
reg [7:0] datao;

parameter glue_sva = 1'b1;
parameter glue_sva_severity = 1'b1;

initial
begin
	sel = 2'b0;
end

always@(posedge clk)
begin
	if(frame1 && frame2 && frame3 && irdy1 && irdy2 && irdy3)
		sel = 2'b0;
		
end

always@(negedge frame1 or negedge irdy1)
begin
	@(posedge clk);
	if(rsel1) sel = 2'b10;
	if(!rsel1) sel= 2'b01;
end

always@(negedge frame2 or negedge irdy2)
begin
	@(posedge clk);
	if(rsel2) sel = 2'b10;
	if(!rsel2) sel= 2'b01;
end

always@(negedge frame3 or negedge irdy3)
begin
	@(posedge clk);
	if(rsel3) sel = 2'b10;
	if(!rsel3) sel= 2'b01;
end

always@(posedge clk)
begin
	if(!frame1 && !irdy1) data = #1 data1;
	else if(!frame2 && !irdy2) data = #1 data2;
	else if(!frame3 && !irdy3) data = #1 data3;
	else data = #1 9'bz;
end

always_comb
begin
	if(!trdy[1]) datao = dataout1;
	else if (!trdy[0]) datao = dataout2;
	else datao = 8'bz;
end

// block level checks

property p_sel_1;
	@(posedge clk) (rsel1 || rsel2 || rsel3) |=> sel == 2'b10;
endproperty

property p_sel_0;
	@(posedge clk) (!rsel1 || !rsel2 || !rsel3) |=> sel == 2'b01;
endproperty

property p_rsel1_write;
	@(posedge clk) ((rsel1 || !rsel1) ##3 ($fell(trdy[1]) || $fell(trdy[0])) ##3 data1[8]) |-> (data == $past(data1)) [*7];
endproperty

property p_rsel2_write;
	@(posedge clk) ((rsel2 || !rsel2) ##3 ($fell(trdy[1]) || $fell(trdy[0])) ##3 data2[8]) |-> (data == $past(data2)) [*7];
endproperty

property p_rsel3_write;
	@(posedge clk) ((rsel3 || !rsel3) ##3 ($fell(trdy[1]) || $fell(trdy[0])) ##3 data3[8]) |-> (data == $past(data3)) [*7];
endproperty

property p_read1;
	@(posedge clk) ($fell(trdy[1]) ##4 !data[8]) |-> (dataout1 == datao) [*7];
endproperty

property p_read0;
	@(posedge clk) ($fell(trdy[0]) ##4 !data[8]) |-> (dataout2 == datao) [*7];
endproperty

always@(posedge clk)
begin
if(glue_sva)
begin
a_sel_1: assert property(p_sel_1)
	else if(glue_sva_severity) $fatal;
a_sel_0: assert property(p_sel_0)
	else if(glue_sva_severity) $fatal;
a_rsel1_write: assert property(p_rsel1_write)
	else if(glue_sva_severity) $fatal;
a_rsel2_write: assert property(p_rsel2_write)
	else if(glue_sva_severity) $fatal;
a_rsel3_write: assert property(p_rsel3_write)
	else if(glue_sva_severity) $fatal;
a_read1: assert property(p_read1)
	else if(glue_sva_severity) $fatal;
a_read0: assert property(p_read0)
	else if(glue_sva_severity) $fatal;
/*
c_sel_1: cover property(p_sel_1);
c_sel_0: cover property(p_sel_0);
c_rsel1_write: cover property(p_rsel1_write);
c_rsel2_write: cover property(p_rsel2_write);
c_rsel3_write: cover property(p_rsel3_write);
c_read1: cover property(p_read1);
c_read0: cover property(p_read0);
*/
end
end

endmodule
