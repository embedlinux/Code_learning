`timescale 1ns/1ns
`define CLK_PERIOD 20

module cmd_analysis_tb;

	reg        Clk;
	reg        Rst_n;

	reg        Rx_done;
	reg [7:0]  Rx_data;

	wire       Wfifo_req;
	wire[7:0]  Wfifo_data;

	wire[5:0]  Rddata_num;
	wire[5:0]  Wrdata_num;
	wire[1:0]  Wdaddr_num;
	wire[2:0]  Device_addr;
	wire[15:0] Word_addr;
	wire       Rd;
	
	reg [15:0] addr;
	reg [7:0]  data_num;
	reg [7:0]  wr_data;
	reg [39:0] wdata_cmd;
	reg [39:0] rdata_cmd;

	cmd_analysis cmd_analysis(
		.Clk(Clk),
		.Rst_n(Rst_n),

		.Rx_done(Rx_done),
		.Rx_data(Rx_data),

		.Wfifo_req(Wfifo_req),
		.Wfifo_data(Wfifo_data),

		.Rddata_num(Rddata_num),
		.Wrdata_num(Wrdata_num),
		.Wdaddr_num(Wdaddr_num),
		.Device_addr(Device_addr),
		.Word_addr(Word_addr),
		.Rd(Rd)
	);

   //写FIFO模块例化
	fifo_wr wr(
		.clock(Clk),
		.data(Wfifo_data),
		.rdreq(),
		.wrreq(Wfifo_req),
		.empty(),
		.full(),
		.q(),
		.usedw()
	);

	//系统时钟产生
	initial Clk = 1'b1;
	always #(`CLK_PERIOD/2)Clk = ~Clk;

	initial
	begin
		Rst_n     = 0;
		Rx_done   = 0;
		Rx_data   = 0;
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
		send_uart_data_wr;  //写数据
		#500;
		send_uart_data_rd;  //读数据
		#500;

		addr = 4;
		data_num = 8;
		wr_data  = 20;
		send_uart_data_wr;  //写数据
		#500;
		send_uart_data_rd;  //读数据

		#500;
		$stop;
	end

	//串口发送写数据命令和待写入数据任务
	task send_uart_data_wr;
	begin
		//写数据指令
		wdata_cmd = {8'h21,8'hf1,addr[15:8],addr[7:0],data_num};
		//发送写数据指令
		repeat(5)begin
			Rx_done   = 1;
			Rx_data   = wdata_cmd[39:32];
			#(`CLK_PERIOD)
			Rx_done   = 0;
			#500;
			wdata_cmd = {wdata_cmd[31:0],8'h00};
		end

		//待写入数据
		Rx_data = wr_data;
		repeat(data_num)begin
			Rx_done   = 1;		
			Rx_data   = Rx_data + 1;
			#(`CLK_PERIOD)
			Rx_done   = 0;
			#500;
		end
	end
	endtask

	//串口发送读数据命令任务
	task send_uart_data_rd;
	begin
		//读数据指令
		rdata_cmd = {8'h21,8'hf2,addr[15:8],addr[7:0],data_num};
		//发送读数据指令					  
		repeat(5)begin
			Rx_done   = 1;		
			Rx_data   = rdata_cmd[39:32];
			#(`CLK_PERIOD)
			Rx_done   = 0;
			#500;
			rdata_cmd = {rdata_cmd[31:0],8'h00};
		end
	end
	endtask

endmodule 