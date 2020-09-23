module PLL_LED(
	Clk,
	Rst_n,
	LED
);

	input Clk;
	input Rst_n;
	output [3:0]LED;
	
	wire c0;	//25M
	wire c1;	//75M
	wire c2;	//100M
	
	wire locked;
	
	pll pll(
		.areset(~Rst_n),
		.inclk0(Clk),
		.c0(c0),
		.c1(c1),
		.c2(c2),
		.locked(locked)
	);
	
	counter
	#(
		.CNT_MAX(25'd24_999_999)
	)
	counter0(
		.Clk(c0),
		.Rst_n(Rst_n),
		.led(LED[0])
	);
	
	counter
	#(
		.CNT_MAX(25'd24_999_999)
	)
	counter1(
		.Clk(c1),
		.Rst_n(Rst_n),
		.led(LED[1])
	);

	counter	
	#(
		.CNT_MAX(25'd24_999_999)
	)
	counter2(
		.Clk(c2),
		.Rst_n(Rst_n),
		.led(LED[2])
	);
	
	counter
	#(
		.CNT_MAX(25'd24_999_999)
	)
	counter3(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.led(LED[3])
	);

endmodule
