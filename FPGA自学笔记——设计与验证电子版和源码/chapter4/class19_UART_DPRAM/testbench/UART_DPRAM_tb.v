`timescale 1ns/1ns

`define clk_period 20

module UART_DPRAM_tb;
	
	reg Clk;
	reg Rst_n;
	wire Key_in;
	
	wire Rs232_Rx;
	
	wire Rs232_Tx;
	
	reg [7:0]data_byte_t;
	reg send_en;
	wire [2:0]baud_set;
	wire Tx_Done;
	reg press;
	
	assign baud_set = 3'd0;
	

	UART_DPRAM UART_DPRAM(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Key_in(Key_in),
		.Rs232_Rx(Rs232_Rx),
		.Rs232_Tx(Rs232_Tx)
	);

	uart_byte_tx uart_byte_tx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.data_byte(data_byte_t),
		.send_en(send_en),
		.baud_set(baud_set),
		
		.Rs232_Tx(Rs232_Rx),
		.Tx_Done(Tx_Done),
		.uart_state()
	);
	
	key_model key_model(
		.press(press),
		.key(Key_in)
	);
	
	initial Clk = 1;
	always#(`clk_period/2)Clk = ~Clk;
	
	initial begin
		Rst_n = 1'b0;
		press = 0;
		data_byte_t = 8'd0;
		send_en = 1'd0;
		#(`clk_period*20 + 1 );
		Rst_n = 1'b1;
		#(`clk_period*50);
		
		data_byte_t = 8'haa;
		send_en = 1'd1;
		#`clk_period;
		send_en = 1'd0;		
		@(posedge Tx_Done)
		
		#(`clk_period*5000);
		
		data_byte_t = 8'h55;
		send_en = 1'd1;
		#`clk_period;
		send_en = 1'd0;
		@(posedge Tx_Done)
		
		#(`clk_period*5000);
		
		data_byte_t = 8'h33;
		send_en = 1'd1;
		#`clk_period;
		send_en = 1'd0;		
		@(posedge Tx_Done)
		
		#(`clk_period*5000);
		
		data_byte_t = 8'haf;
		send_en = 1'd1;
		#`clk_period;
		send_en = 1'd0;
		@(posedge Tx_Done)
		
		#(`clk_period*5000);
		
		press = 1;
		#(`clk_period*3)
		press = 0;

			
		$stop;
	end


endmodule
