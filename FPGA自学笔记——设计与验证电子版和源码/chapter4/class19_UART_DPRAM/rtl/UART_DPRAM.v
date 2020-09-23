/***************************************************
*	Module Name		:	UART_DPRAM		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  串口收发与双端口RAM顶层设计
**************************************************/

module UART_DPRAM(
	
	Clk,     //50M时钟输入
	Rst_n,   //系统复位
	
	Key_in,  //按键输入
	
	Rs232_Rx, //RS232数据输入
	Rs232_Tx  //RS232数据输出
); 
	
	input Clk;
	input Rst_n;
	input Key_in;
	
	input Rs232_Rx;
	
	output Rs232_Tx;
	
	wire Key_flag;
	wire Key_state;
	wire Rx_Done;
	wire Tx_Done;
	wire Send_en;
	wire [7:0]rdaddress,wraddress;
	wire wren;
	wire [7:0]rx_data,tx_data;	
	
	uart_byte_tx uart_byte_tx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.data_byte(tx_data),
		.send_en(Send_en),
		.baud_set(3'd0),
		
		.Rs232_Tx(Rs232_Tx),
		.Tx_Done(Tx_Done),
		.uart_state()
	);
	
	uart_byte_rx uart_byte_rx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.baud_set(3'd0),
		.Rs232_Rx(Rs232_Rx),
		
		.data_byte(rx_data),
		.Rx_Done(Rx_Done)
	);
	
	key_filter key_filter(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(Key_in),
		.key_flag(Key_flag),
		.key_state(Key_state)
	);
	
	dpram dpram0(
		.clock(Clk),
		.data(rx_data),
		.rdaddress(rdaddress),
		.wraddress(wraddress),
		.wren(wren),
		.q(tx_data)
	);
	
	CTRL CTRL(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Key_flag(Key_flag),
		.Key_state(Key_state),
		.Rx_Done(Rx_Done),
		.Tx_Done(Tx_Done),
		.rdaddress(rdaddress),
		.wraddress(wraddress),
		.wren(wren),
		.Send_en(Send_en)	
	);
	
endmodule
