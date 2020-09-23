`timescale 1ns/1ns

`define clk_period 20

module key_led_top_tb;

	reg Clk;
	reg Rst_n;
	
	wire key_in0;
	wire key_in1;
	reg press0,press1;
	
	wire [3:0]led;
	
	key_led_top key_led_top0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in0(key_in0),
		.key_in1(key_in1),
		.led(led)
	);
	
	key_model key_model0(
		.press(press0),
		.key(key_in0)
	);
	
	key_model key_model1(
		.press(press1),
		.key(key_in1)
	);
	
	initial Clk= 1;
	always#(`clk_period/2) Clk = ~Clk;

	initial begin
		Rst_n = 1'b0;
		press0 = 0;
		press1 = 0;
		#(`clk_period*10) Rst_n = 1'b1;
		#(`clk_period*10 + 1);	
		
		press0 = 1;
		#(`clk_period*3)
		press0 = 0;
		
		#80_000_000;
		
		press0 = 1;
		#(`clk_period*3)
		press0 = 0;
		
		#80_000_000;
		
		press1 = 1;
		#(`clk_period*3)
		press1 = 0;
		
		#80_000_000;
		
		press1 = 1;
		#(`clk_period*3)
		press1 = 0;
		
		#80_000_000;
		$stop;		
	end

endmodule
