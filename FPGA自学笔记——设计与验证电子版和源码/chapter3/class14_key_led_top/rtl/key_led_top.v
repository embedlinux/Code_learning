/***************************************************
*	Module Name		:	key_led_top		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  两按键实现加减法，并用四位LED作为结果显示
**************************************************/

module key_led_top(
			Clk,     //50M时钟输入
			Rst_n,   //系统复位
			key_in0, //按键S0输入
			key_in1, //按键S1输入
			led      //数据显示
		);

	input Clk;
	input Rst_n;
	input key_in0;
	input key_in1;
	
	output [3:0]led;
	
	wire key_flag0,key_flag1;
	wire key_state0,key_state1;

	key_filter key_filter0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in0),
		.key_flag(key_flag0),
		.key_state(key_state0)
	);
	
	key_filter key_filter1(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in1),
		.key_flag(key_flag1),
		.key_state(key_state1)
	);
	
	led_ctrl led_ctrl0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_flag0(key_flag0),
		.key_flag1(key_flag1),
		.key_state0(key_state0),
		.key_state1(key_state1),
		.led(led)
	);

endmodule
