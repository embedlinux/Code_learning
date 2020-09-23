/***************************************************
*	Module Name		:	uart_eeprom		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  串口读写EEPROM顶层文件
**************************************************/
module uart_eeprom(
	Clk,
	Rst_n,
	
	Uart_rx,
	Uart_tx,
	
	Sda,
	Scl
);

parameter Baud_set = 3'd4;//波特率设置,这里设置为115200

	input       Clk;          //系统时钟
	input       Rst_n;        //系统复位
	
	input       Uart_rx;      //串口接收
	output      Uart_tx;      //串口发送
	
	inout       Sda;          //I2C时钟线
	output      Scl;          //I2C数据线

	wire [7:0]  Rx_data;      //串口接收一字节数据
	wire        Rx_done;	     //串口接收一字节数据完成

	wire        wfifo_req;    //写FIFO模块写请求
	wire [7:0]  wfifo_data;   //写FIFO模块写数据
	wire [5:0]  wfifo_usedw;  //写FIFO模块已写数据量

	wire [5:0]  rfifo_usedw;  //读FIFO模块可读数据量
	wire        rfifo_rdreq;  //读FIFO模块读请求

	wire [5:0]  Rddata_num;   //I2C总线连续读取数据字节数
	wire [5:0]  Wrdata_num;   //I2C总线连续读取数据字节数
	wire [1:0]  Wdaddr_num;   //EEPROM数据地址字节数
	wire [2:0]  Device_addr;  //EEPROM地址
	wire [15:0] Word_addr;    //EEPROM寄存器地址
	wire        Wr;           //EEPROM写使能
	wire [7:0]  Wr_data;      //EEPROM写数据
   wire        Wr_data_vaild;//EEPROM写数据有效标志位
	wire        Rd;           //EEPROM读使能
	wire [7:0]  Rd_data;      //EEPROM读数据
	wire        Rd_data_vaild;//EEPROM读数据有效标志位
	wire        Done;         //EEPRO读写完成标识位

	wire        tx_en;        //串口发送使能
	wire [7:0]  tx_data;      //串口待发送数据
	wire        tx_done ;     //一次串口发送完成标志位

	//串口接收模块例化
	uart_byte_rx uart_rx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Rs232_rx(Uart_rx),
		.baud_set(Baud_set),

		.Data_Byte(Rx_data),
		.Rx_Done(Rx_done)
	);

	//指令解析模块例化
	cmd_analysis cmd_analysis(
		.Clk(Clk),
		.Rst_n(Rst_n),

		.Rx_done(Rx_done),
		.Rx_data(Rx_data),

		.Wfifo_req(wfifo_req),
		.Wfifo_data(wfifo_data),

		.Rddata_num(Rddata_num),
		.Wrdata_num(Wrdata_num),
		.Wdaddr_num(Wdaddr_num),
		.Device_addr(Device_addr),
		.Word_addr(Word_addr),
		.Rd(Rd)
	);

	//写缓存fifo模块例化
	fifo_wr fifo_wr(
		.clock(Clk),
		.data(wfifo_data),
		.rdreq(Wr_data_vaild),
		.wrreq(wfifo_req),
		.empty(),
		.full(),
		.q(Wr_data),
		.usedw(wfifo_usedw)
	);

	//EEPROM写使能
	assign Wr = (wfifo_usedw == Wrdata_num)&&
	            (wfifo_usedw != 6'd0);

	//I2C控制模块例化
	I2C I2C(
		.Clk(Clk),
		.Rst_n(Rst_n),

		.Rddata_num(Rddata_num),
	   .Wrdata_num(Wrdata_num),
		.Wdaddr_num(Wdaddr_num),

		.Device_addr(Device_addr),
		.Word_addr(Word_addr),

		.Wr(Wr),
		.Wr_data(Wr_data),
      .Wr_data_vaild(Wr_data_vaild),
		.Rd(Rd),
		.Rd_data(Rd_data),
		.Rd_data_vaild(Rd_data_vaild),

		.Scl(Scl),
		.Sda(Sda),
		.Done(Done)
	);

	//读缓存fifo模块例化
	fifo_rd fifo_rd(
		.clock(Clk),
		.data(Rd_data),
		.rdreq(rfifo_rdreq),
		.wrreq(Rd_data_vaild),
		.empty(),
		.full(),
		.q(tx_data),
		.usedw(rfifo_usedw)
	);

	//串口发送使能
	assign tx_en = ((rfifo_usedw == Rddata_num)&&Done)||
	               ((rfifo_usedw < Rddata_num)&&
						(rfifo_usedw >0)&&tx_done);
	//读FIFO模块读请求					
	assign rfifo_rdreq = tx_en;

	//串口发送模块例化
	uart_byte_tx uart_tx(
		.Clk(Clk), 
		.Rst_n(Rst_n), 
		.send_en(tx_en),
		.baud_set(Baud_set),
		.Data_Byte(tx_data),

		.Rs232_Tx(Uart_tx),
		.Tx_Done(tx_done),
		.uart_state()
	);	

endmodule 