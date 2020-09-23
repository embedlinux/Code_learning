`timescale 1ns/1ns

`define clock_period 20

module counter_tb;

	reg cin;	//进位输入
	reg clk;	//计数基准时钟
	
	wire cout;//进位输出
	wire [3:0] q;

	counter counter0(
		.cin(cin),
		.clock(clk),
		.cout(cout),
		.q(q)
	);
	
	initial clk = 1;
	always #(`clock_period/2)clk = ~clk;
	
	initial begin
		repeat(20)begin
			cin = 0;
			#(`clock_period*5)cin = 1;
			#(`clock_period)cin = 0;		
		end
		#(`clock_period*200);
		$stop;
	end

endmodule
