`timescale 1ns/1ns
`define CLK_PERIOD 20

module uart_eeprom_tb;
	reg        Clk;
	reg        Rst_n;

	reg        tx_en;
	reg [7:0]  tx_data;
	wire       tx_done;

	wire       Uart_rx;
	wire       Uart_tx;

	wire       Sda;
	wire       Scl;

	reg [15:0] addr;
	reg [7:0]  data_num;
	reg [7:0]  wr_data;
	reg [39:0] wdata_cmd;
	reg [39:0] rdata_cmd;

localparam Baud_set = 3'd4;  //波特率设置,这里设置为115200
localparam DevAddr  = 3'b000;//I2C器件的器件地址
localparam WdAr_NUM = 2'd2;  //I2C器件的存储器地址字节数

	//串口发送模块例化
	uart_byte_tx uart_tx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.send_en(tx_en),
		.baud_set(Baud_set),
		.Data_Byte(tx_data),

		.Rs232_Tx(Uart_rx),
		.Tx_Done(tx_done),
		.uart_state()
	);

	//串口读写EEPROM模块例化
	uart_eeprom #(.Baud_set(Baud_set))
	uart_eeprom(
		.Clk(Clk),
		.Rst_n(Rst_n),

		.Uart_rx(Uart_rx),
		.Uart_tx(Uart_tx),

		.Sda(Sda),
		.Scl(Scl)
	);

	//EEPROM模型例化
	M24LC64 M24LC64(
		.A0(1'b0), 
		.A1(1'b0), 
		.A2(1'b0), 
		.WP(1'b0), 
		.SDA(Sda), 
		.SCL(Scl), 
		.RESET(!Rst_n)
	);

	//系统时钟产生
	initial Clk = 1'b1;
	always #(`CLK_PERIOD/2)Clk = ~Clk;

	initial
	begin
		Rst_n     = 0;
		tx_data   = 0;
		tx_en     = 0;
		addr      = 0;
		data_num  = 0;
		wr_data   = 0;
		wdata_cmd = 0;
		rdata_cmd = 0;

		#(`CLK_PERIOD*200 + 1)
		Rst_n     = 1;
		#200;

		addr     = 0;
		data_num = 4;
		wr_data  = 0;
		send_uart_data_wr;//写数据
		@(posedge uart_eeprom.I2C.Done);
		#500;
		send_uart_data_rd;//读数据
		@(posedge uart_eeprom.I2C.Done);
		#500;

		addr = 4;
		data_num = 8;
		wr_data  = 20;
		send_uart_data_wr;//写数据
		@(posedge uart_eeprom.I2C.Done);
		#500;
		send_uart_data_rd;//读数据
		@(posedge uart_eeprom.I2C.Done); 

		//从EEPROM读出的数据串口发送出去，等待发送完成
		repeat(data_num)begin  
			@(posedge uart_eeprom.tx_done);
		end

		#5000;
		$stop;
	end

	//串口发送写数据命令和待写入数据任务
	task send_uart_data_wr;
	begin
		//写数据指令
		wdata_cmd = {{2'b00,WdAr_NUM,1'b0,DevAddr},8'hf1,
		             addr[15:8],addr[7:0],data_num};
		//发送写数据指令
		repeat(5)begin
			tx_en   = 1;
			tx_data = wdata_cmd[39:32];
			#(`CLK_PERIOD)
			tx_en   = 0;
			@(posedge tx_done)
			#100;
			wdata_cmd = {wdata_cmd[31:0],8'h00};
		end

		//待写入数据
		tx_data    = wr_data;
		repeat(data_num)begin
			tx_en   = 1;
			tx_data = tx_data + 1;
			#(`CLK_PERIOD)
			tx_en   = 0;
			@(posedge tx_done)
			#100;
		end
	end
	endtask

	//串口发送读数据命令任务
	task send_uart_data_rd;
	begin
		//读数据指令
		rdata_cmd = {{2'b00,WdAr_NUM,1'b0,DevAddr},8'hf2,
		             addr[15:8],addr[7:0],data_num};
		//发送读数据指令
		repeat(5)begin
			tx_en   = 1;
			tx_data = rdata_cmd[39:32];
			#(`CLK_PERIOD)
			tx_en   = 0;
			@(posedge tx_done)
			#100;
			rdata_cmd = {rdata_cmd[31:0],8'h00};
		end
	end
	endtask

endmodule 