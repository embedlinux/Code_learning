/***************************************************
*	Module Name		:	DDS2		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-06-25
*	Revision		   :	v1.1
*	Description		:  AC620开发板双通道信号发生器工程顶层
**************************************************/

module DDS2(
	Clk,
	Rst_n,
	Rs232_Rx,
	CS_N,
	DIN,
	SCLK
);
	input Clk;		//为控制器的工作时钟，频率为50MHz
	input Rst_n;	//控制器复位，低电平复位
	input Rs232_Rx;//串口接收接口，接收串口助手发送数据
	output CS_N;	//TLV5618的CS_N接口
	output DIN;		//TLV5618的DIN接口
	output SCLK;	//TLV5618的SCLK接口


	wire [31:0]Fword0,Fword1;	//频率控制字
	wire [11:0]Pword0,Pword1;	//相位控制字
	wire [3:0]Aword0,Aword1;		//幅度控制字
	
	wire [9:0]DA_Data0,DA_Data1;	//DDS输出的波形数据
	wire [11:0]DATA_A,DATA_B;	//送给DAC通道的波形数据（幅度受控）
	
	wire DA_Clk0,DA_Clk1;
	
	assign DATA_A = {DA_Data0,2'b00} >> Aword0;
	assign DATA_B = {DA_Data1,2'b00} >> Aword1;
	
	wire Rx_Done;
	wire [7:0]Rx_Byte;
	wire [3:0]CH_Sync;

	DDS_Module DDS_Module0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.EN(CH_Sync[0]),
		.Fword(Fword0),
		.Pword(Pword0),
		.DA_Clk(DA_Clk0),
		.DA_Data(DA_Data0)
	);
	
	DDS_Module DDS_Module1(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.EN(CH_Sync[1]),
		.Fword(Fword1),
		.Pword(Pword1),
		.DA_Clk(DA_Clk1),
		.DA_Data(DA_Data1)
	);
	
	DAC_2CH DAC_2CH(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.DATA_A(DATA_A),
		.DATA_B(DATA_B),
		.CS_N(CS_N),
		.DIN(DIN),
		.SCLK(SCLK)
	);
	
	uart_byte_rx uart_byte_rx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.baud_set(3'd0),
		.Rs232_Rx(Rs232_Rx),
		
		.data_byte(Rx_Byte),
		.Rx_Done(Rx_Done)
	);
	
	CMD CMD(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Rx_Byte(Rx_Byte),
		.Rx_Int(Rx_Done),
		.Fword0(Fword0), .Fword1(Fword1),	//频率控制字
		.Pword0(Pword0), .Pword1(Pword1),	//相位控制字
		.Aword0(Aword0), .Aword1(Aword1),		//幅度控制字
		.CH_Sync(CH_Sync)
	);

endmodule
