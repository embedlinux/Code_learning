/***************************************************
*	Module Name		:	Channel_Slect		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  通道切换控制
**************************************************/

module Channel_Slect(
			Clk,      //模块时钟
			Rst_n,    //模块复位
			key_in,   //按键输入
			ADC_CHSEL //通道结果输出
		);

	input Clk;
	input Rst_n;
	input key_in;
	
	output reg [2:0] ADC_CHSEL;
	
	wire key_state;
	wire key_flag;
	
	key_filter key_filter(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in),
		.key_flag(key_flag),
		.key_state(key_state)
	);
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		ADC_CHSEL <= 0;
	else if(key_flag && !key_state)begin
		if(ADC_CHSEL == 3'b111)
			ADC_CHSEL <= 3'd0;
		else
			ADC_CHSEL <= ADC_CHSEL + 1'b1;
	end
	else
		ADC_CHSEL <= ADC_CHSEL;




endmodule 