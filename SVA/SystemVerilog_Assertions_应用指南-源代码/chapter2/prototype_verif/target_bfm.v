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


module target_bfm(clk, reset, sel_bit, trdy, datain, dataout, ri, wi);

input clk, reset;
input sel_bit;
output trdy;
input [8:0] datain;
output [7:0] dataout;
output [5:0] ri, wi;

wire [8:0] datain;
reg [7:0] dataout;
reg trdy;
reg [7:0] t_store[63:0];
reg [5:0] ri=0, wi=0;
integer k;

parameter target_sva = 1'b1;
parameter target_sva_severity = 1'b1;

initial 
begin
trdy = 1'b1;
dataout = 8'bz;
end
		
always@(posedge sel_bit)
begin
		@(posedge clk);
		@(posedge clk);
		trdy = 1'b0;
end

always@(posedge clk)
begin
	if(!sel_bit)
		trdy = 1'b1;
end

always@(datain)
// dangerous code, if same data comes twice, this block does not execute.
begin
	if(datain[8] == 1'b1 && !trdy)
	begin
		t_store[wi] = datain[7:0];
		wi++;
	end
end

always@(posedge clk)
begin
	if(datain[8] == 1'b0 && !trdy && sel_bit)
	begin
	for(k=0; k<8; k++)
	begin
		dataout = t_store[ri];
		ri++;
		@(posedge clk);
	end
	end
	else
		dataout = 8'bz;
end	

// block level checks


property p_sel_trdy_start;
	@(posedge clk) $rose(sel_bit) |-> ##1 trdy ##1 !trdy;
endproperty

property p_sel_trdy_stop;
	@(posedge clk) $fell(sel_bit) |=>  trdy;
endproperty

property p_write;
	@(posedge clk) (datain[8] && sel_bit && (wi != 0)) |-> (wi == ($past(wi) + 1));
endproperty

property p_read;
	@(posedge clk) (!datain[8] && sel_bit && (ri != 0)) |-> (ri == ($past(ri) + 1));
endproperty

property p_target_dataout;
	@(posedge clk) ($fell(trdy) ##3 (datain[8])) |-> not ($isunknown(datain)) [*8];
endproperty

always@(posedge clk)
begin
if(target_sva)
begin
a_sel_trdy_start: assert property(p_sel_trdy_start) else
		if(target_sva_severity) $fatal;
a_sel_trdy_stop: assert property(p_sel_trdy_stop) else
		if(target_sva_severity) $fatal;
a_write: assert property(p_write) else
		if(target_sva_severity) $fatal;
a_read: assert property(p_read) else
		if(target_sva_severity) $fatal;
a_target_dataout: assert property(p_target_dataout) else
		if(target_sva_severity) $fatal;
/*
c_sel_trdy_start: cover property(p_sel_trdy_start);
c_sel_trdy_stop: cover property(p_sel_trdy_stop);
c_write: cover property(p_write);
c_read: cover property(p_read);
c_target_dataout: cover property(p_target_dataout);
*/
end
end

endmodule
	
	
