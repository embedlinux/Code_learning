`timescale 1ns/1ns

`define clk_period 20

module rom_tb;

	reg [7:0]addr;
	reg clk;
	
	wire [7:0]q;

	rom rom(
		.address(addr),
		.clock(clk),
		.q(q)
	);
	
	initial clk = 1;
	always #(`clk_period/2) clk = ~clk;
	
	integer i;
	
	initial begin
		addr = 0;
		#21;
		for(i=0;i<2550;i=i+1)begin
			#`clk_period;
			addr = addr + 1;	
		end
		#(`clk_period * 50);
		$stop;	
	end
	
endmodule
