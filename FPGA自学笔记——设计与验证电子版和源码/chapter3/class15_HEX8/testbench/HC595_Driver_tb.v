`timescale 1ns/1ns

`define clk_period 20
module HC595_Driver_tb;

	reg Clk;
	reg Rst_n;
	reg [15 : 0] Data;	//data to send
	reg S_EN;	//send en
	wire SH_CP;	//shift clock
	wire ST_CP;	//latch data clock
	wire DS;	//shift serial data
	

	HC595_Driver HC595_Driver(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Data(Data),
		.S_EN(S_EN),
		.SH_CP(SH_CP),
		.ST_CP(ST_CP),
		.DS(DS)
	);
	initial Clk = 1;
	always#(`clk_period/2) Clk = ~Clk;

initial begin
		Rst_n = 1'b0;
		S_EN = 1;
		Data = 16'b1010_1111_0110_0101;
		#(`clk_period*20);
		Rst_n = 1;
		#(`clk_period*20);
		#5000;
		Data = 16'b0101_0101_1010_0101;
		#5000;

		$stop;
	end
endmodule 