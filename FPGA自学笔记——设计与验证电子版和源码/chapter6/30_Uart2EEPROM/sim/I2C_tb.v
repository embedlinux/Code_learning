`timescale 1ns/1ns
`define CLK_PERIOD 20

//仿真模型选择
`define TEST_M24LC64    //24LC64
//`define TEST_M24LC04    //24LC04

module I2C_tb;

	reg        Clk;          //系统时钟
	reg        Rst_n;        //系统复位信号
	reg [15:0] Word_addr;    //I2C器件寄存器地址

	reg        Wr;           //I2C器件写使能
	reg [7:0]  Wr_data;      //I2C器件写数据
	wire       Wr_data_vaild;//I2C器件写数据有效标志位
	reg        Rd;           //I2C器件读使能
	wire[7:0]  Rd_data;      //I2C器件读数据
	wire       Rd_data_vaild;//I2C器件读数据有效标志位

	wire       Scl;          //I2C时钟线    
	wire       Sda;          //I2C数据线 
	wire       Done;         //对I2C器件读写完成标识位

localparam NUM     = 6'd4;  //单次读写数据字节数

`ifdef TEST_M24LC64
	localparam DevAddr = 3'b000; //I2C器件的器件地址
	localparam WdAr_NUM= 2;      //I2C器件的存储器地址字节数
`elsif TEST_M24LC04
	localparam DevAddr = 3'b001; //I2C器件的器件地址
	localparam WdAr_NUM= 1;      //I2C器件的存储器地址字节数
`endif	

	I2C I2C(
		.Clk(Clk),
		.Rst_n(Rst_n),

		.Rddata_num(NUM),
	   .Wrdata_num(NUM),
		.Wdaddr_num(WdAr_NUM),

		.Device_addr(DevAddr),
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

`ifdef TEST_M24LC64

	M24LC64 M24LC64(
		.A0(1'b0), 
		.A1(1'b0), 
		.A2(1'b0), 
		.WP(1'b0), 
		.SDA(Sda), 
		.SCL(Scl), 
		.RESET(!Rst_n)
	);

`elsif TEST_M24LC04
	
	M24LC04B M24LC04(
		.A0(1'b1),
		.A1(1'b0),
		.A2(1'b0),
		.WP(1'b0),
		.SDA(Sda),
		.SCL(Scl),
		.RESET(!Rst_n)
	);

`endif
	
	//系统时钟产生
	initial Clk = 1'b1;
	always #(`CLK_PERIOD/2)Clk = ~Clk;
	
	initial
	begin
		Rst_n        = 0;
		Word_addr    = 0;
		Wr           = 0;
		Wr_data      = 0;
		Rd           = 0;

		#(`CLK_PERIOD*200 + 1)
		Rst_n        = 1;
		#200;

`ifdef TEST_M24LC64   //仿真验证24LC64模型
		 
		//写入20组数据
		Word_addr  = 0;
		Wr_data    = 0;
		repeat(20)begin
			Wr      = 1'b1;
			#(`CLK_PERIOD);
			Wr      = 1'b0;

			repeat(NUM)begin   //在写数据有效前给待写入数据
				@(posedge Wr_data_vaild)
				Wr_data = Wr_data + 1;
			end
			
			@(posedge Done);
			#2000;
			Word_addr = Word_addr + NUM;
		end
		
		#2000;
		
		//读出刚写入的20组数据
		Word_addr = 0;	
		repeat(20)begin
			Rd     = 1'b1;
			#(`CLK_PERIOD);
			Rd     = 1'b0;
			
			@(posedge Done);
			#2000;
			Word_addr = Word_addr + NUM;
		end
		
`elsif TEST_M24LC04   //仿真验证24LC64模型

		//写入20组数据
		Word_addr  = 100;
		Wr_data    = 100;
		repeat(20)begin
			Wr      = 1'b1;
			#(`CLK_PERIOD);
			Wr      = 1'b0;

			repeat(NUM)begin  //在写数据有效前给待写入数据
				@(posedge Wr_data_vaild)
				Wr_data = Wr_data + 1;
			end

			@(posedge Done);
			#2000;
			Word_addr = Word_addr + NUM;
		end
		
		#2000;
		
		//读出刚写入的20组数据
		Word_addr = 100;
		repeat(20)begin
			Rd     = 1'b1;
			#(`CLK_PERIOD);
			Rd     = 1'b0;
			
			@(posedge Done);
			#2000;
			Word_addr = Word_addr + NUM;
		end
		
`endif
	
		#5000;
		$stop;
	end

endmodule 