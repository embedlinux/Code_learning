/***************************************************
*	Module Name		:	pwm_generator		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  无源蜂鸣器驱动设计
**************************************************/

module pwm_generator_test(
			Clk50M,    //系统时钟50M
			Rst_n,     //系统复位
			beep       //蜂鸣器控制输出
		);

	input Clk50M;
	input Rst_n;
	output beep;
	
	reg [31:0]counter_arr;	//预重装值寄存器
	wire [31:0]counter_ccr;	//输出比较值
	
	reg [24:0]delay_cnt;	//500ms延时计数器
	reg [4:0]Pitch_num;	//音调编号
	
	localparam
		L1 = 191130, //低音1
		L2 = 170241, //低音2
		L3 = 151698, //低音3
		L4 = 143183, //低音4
		L5 = 127550, //低音5
		L6 = 113635, //低音6
		L7 = 101234, //低音7

		M1 = 95546, //中音1 
		M2 = 85134, //中音2 
		M3 = 75837, //中音3 
		M4 = 71581, //中音4 
		M5 = 63775, //中音5 
		M6 = 56817, //中音6 
		M7 = 50617, //中音7 

		H1 = 47823, //高音1 
		H2 = 42563, //高音2 
		H3 = 37921, //高音3 
		H4 = 35793, //高音4 
		H5 = 31887, //高音5 
		H6 = 28408, //高音6 
		H7 = 25309; //高音7
		
	//输出比较值为预重装值一半
	assign counter_ccr = counter_arr >> 1;

	pwm_generator pwm_generator(
		.Clk50M(Clk50M),
		.Rst_n(Rst_n),
		.cnt_en(1'b1),
		.counter_arr(counter_arr),
		.counter_ccr(counter_ccr),
		.o_pwm(beep)
	);
	
	//500ms延时计数器计数
	always@(posedge Clk50M or negedge Rst_n)
	if(!Rst_n)
		delay_cnt <= 25'd0;
	else if(delay_cnt == 0)
		delay_cnt <= 25'd24999999;
	else
		delay_cnt <= delay_cnt - 1'b1;
	
	//每500ms切换一次音调
	always@(posedge Clk50M or negedge Rst_n)
	if(!Rst_n)
		Pitch_num <= 5'd0;
	else if(delay_cnt == 0)begin
		if(Pitch_num == 5'd20)
			Pitch_num <= 5'd0;
		else
			Pitch_num <= Pitch_num + 5'd1;
	end
	else
		Pitch_num <= Pitch_num;
		
	//根据音调编号给预重装值给相应的值
	always@(*)
		case(Pitch_num)
			0 :counter_arr  = L1;
			1 :counter_arr  = L2;
			2 :counter_arr  = L3;
			3 :counter_arr  = L4;
			4 :counter_arr  = L5;
			5 :counter_arr  = L6;
			6 :counter_arr  = L7;
			7 :counter_arr  = M1;
			8 :counter_arr  = M2;
			9 :counter_arr  = M3;
			10:counter_arr  = M4;
			11:counter_arr  = M5;
			12:counter_arr  = M6;
			13:counter_arr  = M7;
			14:counter_arr  = H1;
			15:counter_arr  = H2;
			16:counter_arr  = H3;
			17:counter_arr  = H4;
			18:counter_arr  = H5;
			19:counter_arr  = H6;
			20:counter_arr  = H7;
			default:counter_arr  = L1;
		endcase
	
endmodule
