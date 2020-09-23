`timescale 1ns/1ns

`define clock_period 20

module BCD_Counter_top_tb;

	reg Clk;
	reg Cin;
	reg Rst_n;
	
	wire Cout;
	wire [11:0]q;

	BCD_Counter_top BCD_Counter_top0(
		.Clk(Clk), 
		.Cin(Cin), 
		.Rst_n(Rst_n), 
		.Cout(Cout), 
		.q(q)
	);
	
	initial Clk = 1'b1;
	always#(`clock_period/2) Clk = ~Clk;
	
	initial begin
		Rst_n = 1'b0;
		Cin = 1'b0;
		#(`clock_period*200);
		Rst_n = 1'b1;
		#(`clock_period*20);
		Cin = 1'b1;
		#(`clock_period*5000);
		$stop;	
	end
	
endmodule
