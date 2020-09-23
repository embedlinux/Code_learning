/***************************************************
*	Module Name		:	cmd_analysis		   
*	Engineer	   	:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  命令解析模块，对串口数据进行分析
**************************************************/
module cmd_analysis(
	Clk,
	Rst_n,

	Rx_done,
	Rx_data,

	Wfifo_req,
	Wfifo_data,

	Rddata_num,
	Wrdata_num,
	Wdaddr_num,
	Device_addr,
	Word_addr,
	Rd
);

	input            Clk;           //系统时钟
	input            Rst_n;         //系统复位

	input            Rx_done;       //串口接收一字节数据完成
	input[7:0]       Rx_data;       //串口接收一字节数据

	output reg       Wfifo_req;     //写fifo请求信号
	output reg[7:0]  Wfifo_data;    //写fifo数据

	output reg[5:0]  Rddata_num;    //I2C总线连续读取数据字节数 
	output reg[5:0]  Wrdata_num;    //I2C总线连续读取数据字节数
	output reg[1:0]  Wdaddr_num;    //I2C器件数据地址字节数
	output reg[2:0]  Device_addr;   //EEPROM器件地址
	output reg[15:0] Word_addr;     //EEPROM寄存器地址
	output reg       Rd;            //EEPROM读请求信号
	
	reg [7:0]        buff_data[4:0];//串口接收数据缓存器

	//串口接收数据计数器
	reg [7:0]byte_cnt;
	always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			byte_cnt <= 8'd0;
		else if(Rx_done && byte_cnt==8'd4)begin
			if(buff_data[1]==8'hf2)      //读数据指令
				byte_cnt <= 8'd0;
			else if(buff_data[1]==8'hf1) //写数据指令
				byte_cnt <= byte_cnt + 8'd1;
			else
				byte_cnt <= 8'd0;         //错误指令
		end			
		else if(Rx_done)begin
			if(byte_cnt == 8'd4 + buff_data[4])
				byte_cnt <= 8'd0;
			else
				byte_cnt <= byte_cnt + 8'd1;
		end
		else
			byte_cnt <= byte_cnt;
	end

	//串口接收数据缓存器	
	always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)begin
			buff_data[0] <= 8'h00;
			buff_data[1] <= 8'h00;
			buff_data[2] <= 8'h00;
			buff_data[3] <= 8'h00;
			buff_data[4] <= 8'h00;
		end
		else if(Rx_done && byte_cnt<5)
			buff_data[byte_cnt] <= Rx_data;
		else
			;
	end

	//写fifo请求信号Wfifo_req
	always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			Wfifo_req <= 1'b0;
		else if(byte_cnt >8'd4 && Rx_done)
			Wfifo_req <= 1'b1;
		else
			Wfifo_req <= 1'b0;
	end

	//写fifo数据Wfifo_data
	always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			Wfifo_data <= 8'd0;
		else if(byte_cnt > 8'd4 && Rx_done)
			Wfifo_data <= Rx_data;
		else
			Wfifo_data <= Wfifo_data;
	end

	//EEPROM读请求信号Rd
	always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			Rd <= 1'b0;
		else if(byte_cnt == 8'd4 && Rx_done
		        && buff_data[1]==8'hf2)
			Rd <= 1'b1;
		else
			Rd <= 1'b0;
	end

	//指令完成标志位
	reg cmd_flag;
	always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)
			cmd_flag <= 1'b0;
		else if((byte_cnt == 8'd4)&& Rx_done)
			cmd_flag <= 1'b1;
		else
			cmd_flag <= 1'b0;
	end

	//EEPROM读写数据、寄存器地址字节数，器件地址，寄存器地址
	always@(posedge Clk or negedge Rst_n)
	begin
		if(!Rst_n)begin
		   Rddata_num  <= 6'd0;
		   Wrdata_num  <= 6'd0;
		   Wdaddr_num  <= 2'd0;
		   Device_addr <= 3'd0;
		   Word_addr   <= 16'd0;
		end			
		else if(cmd_flag == 1'b1)begin
			Rddata_num  <= buff_data[4][5:0];
		   Wrdata_num  <= buff_data[4][5:0];
		   Wdaddr_num  <= buff_data[0][5:4];
		   Device_addr <= buff_data[0][2:0];
		   Word_addr   <= {buff_data[2],buff_data[3]};
		end
		else
			;
	end

endmodule 