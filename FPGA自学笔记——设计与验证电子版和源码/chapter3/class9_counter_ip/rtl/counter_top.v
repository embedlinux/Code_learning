/***************************************************
*	Module Name		:	counter_top		   
*	Engineer		:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		:	v1.0
*	Description		:   IP核应用之计数器级联
**************************************************/

module counter_top(
			cin,
			clk,
			cout,
			q
		);

	input cin;
	input clk;
	
	output cout;
	output [7:0]q;
	
	wire cout0;
	
	counter counter0(
		.cin(cin),
		.clock(clk),
		.cout(cout0),
		.q(q[3:0])
	);
	
	counter counter1(
		.cin(cout0),
		.clock(clk),
		.cout(cout),
		.q(q[7:4])
	);	

endmodule
