/***************************************************
*	Module Name		:	uart_tx_top		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  串口发送顶层设计
**************************************************/

module uart_tx_top(
			Clk,       //50M时钟输入
			Rst_n,     //系统复位
			Rs232_Tx,  //Rs232输出信号
			key_in0,   //按键控制输入
			led        //数据发送状态
		);

	input Clk;
	input Rst_n;
	input key_in0;
	
	output Rs232_Tx;
	output led;
	
	wire send_en;
	wire [7:0]data_byte;
	wire key_flag0;
	wire key_state0;
	
	assign send_en = key_flag0 & !key_state0;
	
	uart_byte_tx uart_byte_tx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.data_byte(data_byte),
		.send_en(send_en),
		.baud_set(3'd0),
		
		.Rs232_Tx(Rs232_Tx),
		.Tx_Done(),
		.uart_state(led)
	);
	
	key_filter key_filter0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in0),
		.key_flag(key_flag0),
		.key_state(key_state0)
	);
	
	ISSP ISSP(
		.probe(),
		.source(data_byte)
	);
	

endmodule
