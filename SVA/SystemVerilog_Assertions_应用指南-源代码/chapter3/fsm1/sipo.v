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

module sipo (clk, reset_, sipo_en, data, latch_en,d63,d62,d61,d60,d59,d58,d57,d56,d55,d54,d53,d52,d51,d50,d49,d48,d47,d46,d45,d44,d43,d42,d41,d40,d39,d38,d37,d36,d35,d34,d33,d32,d31,d30,d29,d28,d27,d26,d25,d24,d23,d22,d21,d20,d19,d18,d17,d16,d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0);

input clk;
input reset_;
input sipo_en;
input [7:0] data;
input latch_en;
output logic signed [15:0] d63,d62,d61,d60,d59,d58,d57,d56,d55,d54,d53,d52,d51,d50,d49,d48,d47,d46,d45,d44,d43,d42,d41,d40,d39,d38,d37,d36,d35,d34,d33,d32,d31,d30,d29,d28,d27,d26,d25,d24,d23,d22,d21,d20,d19,d18,d17,d16,d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0;

logic [15:0] d0,d1,d2,d3,d4,d5,d6,d7,d8,d9;
logic [15:0] d10,d11,d12,d13,d14,d15,d16,d17,d18,d19;
logic [15:0] d20,d21,d22,d23,d24,d25,d26,d27,d28,d29;
logic [15:0] d30,d31,d32,d33,d34,d35,d36,d37,d38,d39;
logic [15:0] d40,d41,d42,d43,d44,d45,d46,d47,d48,d49;
logic [15:0] d50,d51,d52,d53,d54,d55,d56,d57,d58,d59;
logic [15:0] d60,d61,d62,d63;

logic [5:0] cnt;

logic sipo_en1;

always_ff @(posedge clk)
	sipo_en1 <= sipo_en;

always @(posedge clk)
	if(!reset_ || latch_en || !sipo_en1)
		cnt=0;
	else if (sipo_en)
		cnt=cnt+1;
	else
		cnt = cnt;

always_ff @(posedge clk)
	if(sipo_en)
	begin
		case (cnt)
		6'd0 : d0 = {6'h0, data[7:0]};
		6'd1 : d1 = {6'h0, data[7:0]};
		6'd2 : d2 = {6'h0, data[7:0]};
		6'd3 : d3 = {6'h0, data[7:0]};
		6'd4 : d4 = {6'h0, data[7:0]};
		6'd5 : d5 = {6'h0, data[7:0]};
		6'd6 : d6 = {6'h0, data[7:0]};
		6'd7 : d7 = {6'h0, data[7:0]};
		6'd8 : d8 = {6'h0, data[7:0]};
		6'd9 : d9 = {6'h0, data[7:0]};
		6'd10 : d10 = {6'h0, data[7:0]};
		6'd11 : d11 = {6'h0, data[7:0]};
		6'd12 : d12 = {6'h0, data[7:0]};
		6'd13 : d13 = {6'h0, data[7:0]};
		6'd14 : d14 = {6'h0, data[7:0]};
		6'd15 : d15 = {6'h0, data[7:0]};
		6'd16 : d16 = {6'h0, data[7:0]};
		6'd17 : d17 = {6'h0, data[7:0]};
		6'd18 : d18 = {6'h0, data[7:0]};
		6'd19 : d19 = {6'h0, data[7:0]};
		6'd20 : d20 = {6'h0, data[7:0]};
		6'd21 : d21 = {6'h0, data[7:0]};
		6'd22 : d22 = {6'h0, data[7:0]};
		6'd23 : d23 = {6'h0, data[7:0]};
		6'd24 : d24 = {6'h0, data[7:0]};
		6'd25 : d25 = {6'h0, data[7:0]};
		6'd26 : d26 = {6'h0, data[7:0]};
		6'd27 : d27 = {6'h0, data[7:0]};
		6'd28 : d28 = {6'h0, data[7:0]};
		6'd29 : d29 = {6'h0, data[7:0]};
		6'd30 : d30 = {6'h0, data[7:0]};
		6'd31 : d31 = {6'h0, data[7:0]};
		6'd32 : d32 = {6'h0, data[7:0]};
		6'd33 : d33 = {6'h0, data[7:0]};
		6'd34 : d34 = {6'h0, data[7:0]};
		6'd35 : d35 = {6'h0, data[7:0]};
		6'd36 : d36 = {6'h0, data[7:0]};
		6'd37 : d37 = {6'h0, data[7:0]};
		6'd38 : d38 = {6'h0, data[7:0]};
		6'd39 : d39 = {6'h0, data[7:0]};
		6'd40 : d40 = {6'h0, data[7:0]};
		6'd41 : d41 = {6'h0, data[7:0]};
		6'd42 : d42 = {6'h0, data[7:0]};
		6'd43 : d43 = {6'h0, data[7:0]};
		6'd44 : d44 = {6'h0, data[7:0]};
		6'd45 : d45 = {6'h0, data[7:0]};
		6'd46 : d46 = {6'h0, data[7:0]};
		6'd47 : d47 = {6'h0, data[7:0]};
		6'd48 : d48 = {6'h0, data[7:0]};
		6'd49 : d49 = {6'h0, data[7:0]};
		6'd50 : d50 = {6'h0, data[7:0]};
		6'd51 : d51 = {6'h0, data[7:0]};
		6'd52 : d52 = {6'h0, data[7:0]};
		6'd53 : d53 = {6'h0, data[7:0]};
		6'd54 : d54 = {6'h0, data[7:0]};
		6'd55 : d55 = {6'h0, data[7:0]};
		6'd56 : d56 = {6'h0, data[7:0]};
		6'd57 : d57 = {6'h0, data[7:0]};
		6'd58 : d58 = {6'h0, data[7:0]};
		6'd59 : d59 = {6'h0, data[7:0]};
		6'd60 : d60 = {6'h0, data[7:0]};
		6'd61 : d61 = {6'h0, data[7:0]};
		6'd62 : d62 = {6'h0, data[7:0]};
		6'd63 : d63 = {6'h0, data[7:0]};
		endcase
	end
	
endmodule
