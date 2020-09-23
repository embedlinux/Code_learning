`timescale 1ns/1ns

`define clk_period 20

module key_filter_tb;

	reg Clk;
	reg Rst_n;
	wire key_in;
	
	wire key_flag;
	wire key_state;
	
	key_filter key_filter0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in),
		.key_flag(key_flag),
		.key_state(key_state)
	);
	
	key_model key_model(.key(key_in));
	
	initial Clk= 1;
	always#(`clk_period/2) Clk = ~Clk;
	
	initial begin
		Rst_n = 1'b0;
		#(`clk_period*10) Rst_n = 1'b1;
		#(`clk_period*10 + 1);		
	end

endmodule
