`timescale 1ns/1ns

`define clock_period 20

module block_nonblock_tb;

	reg Clock;
	reg Rst_n;
	reg a,b,c;
	
	wire [1:0]out;
	
	block_nonblock block_nonblock0(Clock,Rst_n,a,b,c,out);
	
	initial Clock = 1;
	always#(`clock_period/2) Clock = ~Clock;
	
	initial begin
		Rst_n = 1'b0;
		a = 0;
		b = 0;
		c = 0;
		#(`clock_period*200 + 1);
		Rst_n = 1'b1;
		#(`clock_period*200);
		a = 0 ; b = 0 ; c = 0;
		#(`clock_period*200);
		a = 0 ; b = 0 ; c = 1;
		#(`clock_period*200);
		a = 0 ; b = 1 ; c = 0;
		#(`clock_period*200);
		a = 0 ; b = 1 ; c = 1;
		#(`clock_period*200);	
		a = 1 ; b = 0 ; c = 0;
		#(`clock_period*200);
		a = 1 ; b = 0 ; c = 1;
		#(`clock_period*200);
		a = 1 ; b = 1 ; c = 0;
		#(`clock_period*200);
		a = 1 ; b = 1 ; c = 1;
		#(`clock_period*200);
		#(`clock_period*200);
		$stop;	
	end

endmodule

