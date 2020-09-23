`timescale 1ns/1ns
`define clock_period 20

module Hello_tb;
	
	reg Clk;
	reg Rst_n;
	reg [7:0]ASCII;
	
	wire led;	
	
	Hello Hello0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.data(ASCII),
		.led(led)
	);
	
	initial Clk = 1;
	always#(`clock_period/2)Clk = ~Clk;
	
	initial begin
		Rst_n = 0;
		ASCII = 0;
		#(`clock_period*20);
		Rst_n = 1;
		#(`clock_period*20 + 1);
		forever begin
			ASCII = "I";
			#(`clock_period);
			ASCII = "A";
			#(`clock_period);
			ASCII = "M";
			#(`clock_period);
			ASCII = "X";
			#(`clock_period);
			ASCII = "i";
			#(`clock_period);
			ASCII = "a";
			#(`clock_period);
			ASCII = "o";	
			#(`clock_period);
			ASCII = "M";
			#(`clock_period);
			ASCII = "e";
			#(`clock_period);
			ASCII = "i";
			#(`clock_period);
			ASCII = "g";
			#(`clock_period);
			ASCII = "e";	
			
			#(`clock_period);
			ASCII = "H";
			#(`clock_period);
			ASCII = "E";
			
			#(`clock_period);
			ASCII = "M";
			#(`clock_period);
			ASCII = "l";
			
			#(`clock_period);
			ASCII = "H";
			#(`clock_period);
			ASCII = "E";
			#(`clock_period);
			ASCII = "L";
			#(`clock_period);
			ASCII = "L";
			#(`clock_period);
			ASCII = "O";
			#(`clock_period);
			
			ASCII = "H";
			#(`clock_period);
			ASCII = "e";
			#(`clock_period);
			ASCII = "l";
			#(`clock_period);
			ASCII = "l";
			#(`clock_period);
			ASCII = "o";
			
			#(`clock_period);
			ASCII = "l";		
		end
	end

endmodule
