module UART_DPRAM(
	
	Clk,
	Rst_n,
	
	Key_in,
	
	Rs232_Rx,
	Rs232_Tx
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
