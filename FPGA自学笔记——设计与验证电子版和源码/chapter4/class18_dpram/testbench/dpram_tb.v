`timescale 1ns/1ns

`define clk_period 20

module dpram_tb;

	reg clock;
	reg [7:0]data;
	reg [7:0]rdaddress;
	reg [7:0]wraddress;
	reg wren;
	
	wire [7:0]q;
	
	integer i;
	
	dpram dpram0(
		.clock(clock),
		.data(data),
		.rdaddress(rdaddress),
		.wraddress(wraddress),
		.wren(wren),
		.q(q)
	);
	
	initial clock = 1;
	always#(`clk_period/2)clock = ~clock;
	
	initial begin
		data = 0;
		rdaddress = 30;
		wraddress = 0;
		wren = 0;
		#(`clk_period*20 +1 );
		for (i=0;i<=15;i=i+1)begin
			wren = 1;
			data = 255 - i;
			wraddress = i;
			#`clk_period;
		end
		wren = 0;
		#(`clk_period*20);
		for (i=0;i<=15;i=i+1)begin
			rdaddress = i;
			#`clk_period;
		end
		#(`clk_period*20);
		$stop;	
	end

endmodule
