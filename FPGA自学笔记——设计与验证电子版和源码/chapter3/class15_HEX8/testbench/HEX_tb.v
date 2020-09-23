`timescale 1ns/1ns

`define clk_period 20

module HEX_tb;

	reg Clk;	//50M
	reg Rst_n;
	reg En;	//数码管显示使能，1使能，0关闭
	
	reg [31:0]disp_data;
	
	wire [7:0] sel;//数码管位选（选择当前要显示的数码管）
	wire [6:0] seg;//数码管段选（当前要显示的内容）
	
	HEX8 HEX8(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.En(En),
		.disp_data(disp_data),
		.sel(sel),
		.seg(seg)
	);
	
	initial Clk = 1;
	always#(`clk_period/2) Clk = ~Clk;
	
	initial begin
		Rst_n = 1'b0;
		En = 1;
		disp_data = 32'h12345678;
		#(`clk_period*20);
		Rst_n = 1;
		#(`clk_period*20);
		#20000000;
		disp_data = 32'h87654321;
		#20000000;
		disp_data = 32'h89abcdef;
		#20000000;
		$stop;
	end

endmodule
