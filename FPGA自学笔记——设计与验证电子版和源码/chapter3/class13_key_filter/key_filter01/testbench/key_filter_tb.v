`timescale 1ns/1ns

`define clk_period 20

module key_filter_tb;

	reg Clk;
	reg Rst_n;
	reg key_in;
	
	wire key_flag;
	wire key_state;
	
	key_filter key_filter0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in),
		.key_flag(key_flag),
		.key_state(key_state)
	);
	
	initial Clk= 1;
	always#(`clk_period/2) Clk = ~Clk;
	
	initial begin
		Rst_n = 1'b0;
		key_in = 1'b1;
		#(`clk_period*10) Rst_n = 1'b1;
		#(`clk_period*10 + 1);
		key_in = 1'b0;#1000;
		key_in = 1'b1;#2000;
		key_in = 1'b0;#1400;
		key_in = 1'b1;#2600;
		key_in = 1'b0;#1300;
		key_in = 1'b1;#200;
		key_in = 1'b0;#2000100;
		#50000100;
		
		key_in = 1'b1;#2000;
		key_in = 1'b0;#1000;
		key_in = 1'b1;#2000;
		key_in = 1'b0;#1400;
		key_in = 1'b1;#2600;
		key_in = 1'b0;#1300;
		key_in = 1'b1;#2000100;
		#50000100;
		
		key_in = 1'b0;#1000;
		key_in = 1'b1;#2000;
		key_in = 1'b0;#1400;
		key_in = 1'b1;#2600;
		key_in = 1'b0;#1300;
		key_in = 1'b1;#200;
		key_in = 1'b0;#2000100;
		#50000100;
		
		key_in = 1'b1;#2000;
		key_in = 1'b0;#1000;
		key_in = 1'b1;#2000;
		key_in = 1'b0;#1400;
		key_in = 1'b1;#2600;
		key_in = 1'b0;#1300;
		key_in = 1'b1;#2000100;
		#50000100;
		$stop;		
	end
	
endmodule
