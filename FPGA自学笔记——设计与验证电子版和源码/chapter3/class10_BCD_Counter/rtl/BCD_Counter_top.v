/***************************************************
*	Module Name		:	BCD_Counter_top		   
*	Engineer		:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		:	v1.0
*	Description		:   BCD计数器级联设计
**************************************************/

module BCD_Counter_top(Clk, Cin, Rst_n, Cout, q);

	input Clk;//计数基准时钟
	input Cin;	//计数器进位输入
	input Rst_n;	//系统复位
	
	output Cout;	//计数进位输出
	output [11:0]q;	//计数值输出
	
	wire Cout0,Cout1;
	wire [3:0]q0,q1,q2;
	
	assign q = {q2,q1,q0};

	BCD_Counter BCD_Counter0(
		.Clk(Clk), 
		.Cin(Cin), 
		.Rst_n(Rst_n), 
		.Cout(Cout0), 
		.q(q0)
	);
	
	BCD_Counter BCD_Counter1(
		.Clk(Clk), 
		.Cin(Cout0), 
		.Rst_n(Rst_n), 
		.Cout(Cout1), 
		.q(q1)
	);
	
	BCD_Counter BCD_Counter2(
		.Clk(Clk), 
		.Cin(Cout1), 
		.Rst_n(Rst_n), 
		.Cout(Cout), 
		.q(q2)
	);
	
endmodule
