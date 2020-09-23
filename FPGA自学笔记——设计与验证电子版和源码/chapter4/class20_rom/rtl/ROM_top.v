module ROM_top(Clk,Rst_n,q);

	input Clk;
	input Rst_n;
	
	output [7:0]q;
	
	reg [7:0]addr;
	
	rom rom(
		.address(addr),
		.clock(Clk),
		.q(q)
	);
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		addr <= 8'd0;
	else 
		addr <= addr + 1'b1;

endmodule
