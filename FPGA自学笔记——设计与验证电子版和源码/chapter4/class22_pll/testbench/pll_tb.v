`timescale 1ns/1ps
`define clk_period 20

module pll_tb;

//source define
	reg	  areset;
	reg	  Clk;

//probe define
	wire	  c0;
	wire	  c1;
	wire	  c2;
	wire	  locked;

//instant user module

	pll pll(
		.areset(areset),
		.inclk0(Clk),
		.c0(c0),
		.c1(c1),
		.c2(c2),
		.locked(locked)
	);
//generater clock
	initial Clk = 1;
	always #(`clk_period/2)Clk = ~Clk;

	initial begin
		areset = 1'b1;
		#(`clk_period * 100 + 1);
		areset = 1'b0;
		#(`clk_period * 200 + 1);
		$stop;
	end

endmodule
