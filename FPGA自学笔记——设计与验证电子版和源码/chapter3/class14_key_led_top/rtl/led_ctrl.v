/***************************************************
*	Module Name		:	led_ctrl		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  根据按键结果实现加减法计数器设计并用LED显示结果
**************************************************/

module led_ctrl(
			Clk,        //50M时钟输入
			Rst_n,      //模块复位
			key_flag0,  //按键S0标志信号
			key_flag1,  //按键S1标志信号
			key_state0, //按键S0状态信号
			key_state1, //按键S0状态信号
			led
		);

	input Clk;
	input Rst_n;
	input key_flag0,key_flag1;
	
	input key_state0,key_state1;
	
	output [3:0]led;
	
	reg [3:0]led_r;
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		led_r <= 4'b0000;
	else if(key_flag0 && !key_state0)
		led_r <= led_r + 1'b1;
	else if(key_flag1 && !key_state1)
		led_r <= led_r - 1'b1;
	else
		led_r <= led_r;
		
	assign led = ~led_r;
		
endmodule
