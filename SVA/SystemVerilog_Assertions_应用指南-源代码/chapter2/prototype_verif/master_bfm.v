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

module master_bfm (ask_for_it, clk, req, gnt, frame, irdy, trdy, 
data_c, r_sel, data_o, a_master_start1_flag, a_master_start2_flag,
a_master_stop1_flag, a_master_stop2_flag, a_master_data1_flag, a_master_data2_flag,
a_master_datao1_flag, a_master_datao2_flag);

input clk, gnt, ask_for_it;
input [1:0] trdy;
output req, frame, irdy;
output [8:0] data_c;
input [7:0] data_o;
output r_sel;

// debug pins for FPGA prototyping

output a_master_start1_flag;
output a_master_start2_flag;
output a_master_stop1_flag;
output a_master_stop2_flag;
output a_master_data1_flag;
output a_master_data2_flag;
output a_master_datao1_flag;
output a_master_datao2_flag;

reg req, frame, irdy;
reg r_sel;
reg [1:0] trdy;
reg [7:0] data, data_o;
reg [8:0] data_c;

reg rw;


reg a_master_start1_flag;
reg a_master_start2_flag;
reg a_master_stop1_flag;
reg a_master_stop2_flag;
reg a_master_data1_flag;
reg a_master_data2_flag;
reg a_master_datao1_flag;
reg a_master_datao2_flag;

parameter master_sva = 1'b1;
parameter master_sva_severity = 1'b1;

integer i=0, j=0;

assign data_c = {rw,data};

initial
begin
frame = 1'b1; irdy = 1'b1;
req = 1'b1; r_sel = 1'bz;
rw = 1'bz; data = 8'bz; 
end

always@(posedge ask_for_it)
begin
	repeat(1) @(posedge clk);
	req = 1'b0;
	repeat(1) @(posedge clk);
	req = 1'b1;
	while(i!=5)
		begin
			#1 if(!gnt)
				begin
					// $display("Arbiter latency = %d cycles\n", i);
					r_sel = $random();
					$display("Target device %b selected for transaction\n", r_sel);

					#2 frame = 1'b0; irdy = 1'b0;
					@(posedge clk);
					
					$display("waiting for target device %b to respond\n", r_sel); 
					
					if(r_sel) wait(!trdy[1]);
					if(!r_sel) wait(!trdy[0]);
					
					repeat(2)@(posedge clk);
					rw = $random();
					
					#1 if(rw)
					begin 
					for(j=0; j<8; j++)
					begin
					data = $random() % 255;
					@(posedge clk);
					end
					end

					if(!rw)
					begin 
					for(j=0; j<8; j++)
					begin
						@(posedge clk);
					end
					end

					#2 frame = 1'b1; irdy = 1'b1; rw = 1'bz; data = 8'bz; r_sel=1'bz;
					break;
				end
			else if (gnt)
				begin
					i=i+1;
					@(posedge clk);
				end
		end
	i=0;
end

// Block level checks

property p_master_start1;
	@(posedge clk) ($fell(req) ##[2:5] ($fell(gnt) && r_sel)) |-> (!frame && !irdy) ##3 !trdy[1];
endproperty

property p_master_start2;
	@(posedge clk) ($fell(req) ##[2:5] ($fell(gnt) && !r_sel)) |-> (!frame && !irdy) ##3 !trdy[0];
endproperty

property p_master_stop1;
	@(posedge clk) $fell(trdy[1]) |-> ##10 (frame && irdy) ##1 gnt;
endproperty

property p_master_stop2;
	@(posedge clk) $fell(trdy[0]) |-> ##10 (frame && irdy) ##1 gnt;
endproperty

property p_master_data1;
	@(posedge clk) ($fell(!trdy[1]) ##2 rw) |-> ($isunknown(data) == 0) [*8];
endproperty

property p_master_data2;
	@(posedge clk) ($fell(!trdy[0]) ##2 rw) |-> ($isunknown(data) == 0) [*8];
endproperty

property p_master_datao1;
	@(posedge clk) ($fell(trdy[1]) ##3 !rw) |=>  ($isunknown(data_o) == 0) [*8];
endproperty

property p_master_datao2;
	@(posedge clk) ($fell(trdy[0]) ##3 !rw) |=>  ($isunknown(data_o) == 0) [*8];
endproperty

always@(posedge clk)
begin
if(master_sva)
begin

a_master_start1: assert property(p_master_start1) else
		if(master_sva_severity) $fatal;
a_master_start2: assert property(p_master_start2) else
		if(master_sva_severity) $fatal;
a_master_stop1: assert property(p_master_stop1) else
		if(master_sva_severity) $fatal;
a_master_stop2: assert property(p_master_stop2) else
		if(master_sva_severity) $fatal;
a_master_data1: assert property(p_master_data1) else
		if(master_sva_severity) $fatal;
a_master_data2: assert property(p_master_data2) else
		if(master_sva_severity) $fatal;
a_master_datao1: assert property(p_master_datao1) else
		if(master_sva_severity) $fatal;
a_master_datao2: assert property(p_master_datao2) else
		if(master_sva_severity) $fatal;
c_master_start1: cover property(p_master_start1);
c_master_start2: cover property(p_master_start2);
c_master_stop1: cover property(p_master_stop1);
c_master_stop2: cover property(p_master_stop2);
c_master_data1: cover property(p_master_data1);
c_master_data2: cover property(p_master_data2);
c_master_datao1: cover property(p_master_datao1);
c_master_datao2: cover property(p_master_datao2);

end
end

`ifdef master_debug

d_a_master_start1: assert property(p_master_start1) else 
				a_master_start1_flag = 1'b1;
d_a_master_start2: assert property(p_master_start2) else 
				a_master_start2_flag = 1'b1;
d_a_master_stop1: assert property(p_master_stop1) else 
				a_master_stop1_flag = 1'b1;
d_a_master_stop2: assert property(p_master_stop2) else 
				a_master_stop2_flag = 1'b1;
d_a_master_data1: assert property(p_master_data1) else 
				a_master_data1_flag = 1'b1;
d_a_master_data2: assert property(p_master_data2) else 
				a_master_data2_flag = 1'b1;
d_a_master_datao1: assert property(p_master_datao1) else 
				a_master_datao1_flag = 1'b1;
d_a_master_datao2: assert property(p_master_datao2) else 
				a_master_datao2_flag = 1'b1;

`endif

endmodule


