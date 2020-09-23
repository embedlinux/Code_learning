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
		press_key;
		#10000;
		press_key;
		#10000;
		press_key;
		$stop;		
	end

	reg [15:0]myrand;
	
	task press_key;
		begin
			repeat(50)begin
				myrand = {$random}%65536;//0~65535;
				#myrand key_in = ~key_in;			
			end
			key_in = 0;
			#50000000;
			
			repeat(50)begin
				myrand = {$random}%65536;//0~65535;
				#myrand key_in = ~key_in;			
			end
			key_in = 1;
			#50000000;		
		end	
	endtask
	
endmodule
