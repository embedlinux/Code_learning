`timescale 1ns/1ps
`define clk_period 20

module PLL_LED_tb;

//source define

	reg Clk;
	reg Rst_n;

//probe define

	wire [3:0]LED;
	


//instant user module
	PLL_LED PLL_LED(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.LED(LED)
	);
	
	defparam PLL_LED.counter0.CNT_MAX = 24;
	defparam PLL_LED.counter1.CNT_MAX = 24;
	defparam PLL_LED.counter2.CNT_MAX = 24;
	defparam PLL_LED.counter3.CNT_MAX = 24;
	
//generater clock
	initial Clk = 1;
	always #(`clk_period/2)Clk = ~Clk;

	initial begin
		Rst_n = 1'b0;
		#(`clk_period * 20 + 1);
		Rst_n = 1'b1;
		#(`clk_period * 2000);
		$stop;
	end

endmodule
