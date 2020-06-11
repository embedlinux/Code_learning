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


module ram262144x8(data, rd, wr, memory_enable, addr);

input [17:0] addr;
input wr,rd,memory_enable;

inout [7:0] data;

reg [7:0] mem[262143:0];
reg [7:0] data_out;

assign data_in = data;
assign data = rd ? data_out : 8'bz; 

// write cycle

always @(addr or wr)
begin
	if(memory_enable)
		if(wr)
			begin
	 			mem[addr] = #5 data_in;
			end
end

// Read cycle

always @(addr or rd)
begin
	if(memory_enable)
		if(rd)
			begin
	 			data_out = mem[addr];
			end
end

endmodule

/*

module ram_test;

wire [7:0] pixel_read;

reg we, memory_enable;
reg [13:0] address;
reg [7:0] pixel_write;

ram16384x8 u1 (pixel_write, pixel_read, we, memory_enable, address);

initial
begin
	memory_enable = 0;
	#50 memory_enable = 1;
	#50 address = 14'd150;
	#50 pixel_write = 8'd 10;
	#50 we = 1;
	#50 pixel_write = 8'd20;
	address = 14'd200;
	#50 we = 0;
	#50 address = 14'd150;
	#50 $finish;
end

endmodule

*/
