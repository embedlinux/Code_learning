/***************************************************
*	Module Name		:	uart_rx_top		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  串口接收顶层设计
**************************************************/

module uart_rx_top(
			Clk,     //模块时钟  
			Rst_n,   //模块复位
			Rs232_Rx //RS232数据输入
		);

	input Clk;
	input Rst_n;
	input Rs232_Rx;
	
	reg [7:0]data_rx_r;
	wire [7:0]data_rx;
	wire Rx_Done;
	
	uart_byte_rx uart_byte_rx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.baud_set(3'd0),
		.Rs232_Rx(Rs232_Rx),
		
		.data_byte(data_rx),
		.Rx_Done(Rx_Done)
	);
	
	ISSP issp(
		.probe(data_rx_r),
		.source()
	);
	
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		data_rx_r <= 8'd0;
	else if(Rx_Done)
		data_rx_r <= data_rx;
	else
		data_rx_r <= data_rx_r;
		
endmodule
