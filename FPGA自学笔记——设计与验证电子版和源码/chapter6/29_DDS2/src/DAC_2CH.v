/***************************************************
*	Module Name		:	DAC_2CH		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-06-25
*	Revision		   :	v1.1
*	Description		:  TLV5618双通道驱动，交替将两个通道的数据送往DAC两个通道
*  
**************************************************/
module DAC_2CH(
	Clk,
	Rst_n,
	DATA_A,
	DATA_B,
	CS_N,
	DIN,
	SCLK
);

	input Clk;
	input Rst_n;

	input [11:0]DATA_A,DATA_B;//每个通道的数据

	output CS_N;
	output DIN;
	output SCLK;

	wire [3:0]CtrlWord;
	wire Set_Done;
	reg [11:0]DATA;
	
	reg Current_CH;
	reg Start;
	wire DAC_State;
	
	
	tlv5618 tlv5618(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.DAC_DATA({CtrlWord,DATA}),
		.Start(Start),
		.Set_Done(Set_Done),
//		.DIV_PARAM(8),
		
		.CS_N(CS_N),
		.DIN(DIN),
		.SCLK(SCLK),
		.DAC_State(DAC_State)
	);

	//
	reg state;//state为0表示当前DAC空闲，state为1表示当前正在进行数据的传输
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		state <= 1'b0;
	else if(state == 0)//每当DAC空闲时，就切换状态到数据传输状态
		state <= 1'b1;
	else if(Set_Done)
		state <= 1'b0;

	//根据DAC控制状态，设置DAC传输数据启动信号
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Start <= 1'b0;
	else if(state == 0)
		Start <= 1'b1;
	else
		Start <= 1'b0;

	//每完成一次转换，通道编号加1，由于总共为2两个通道，所以，Current_CH将循环在0和1直接变化
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Current_CH <= 0;
	else if(Set_Done)
		Current_CH <= Current_CH + 1'b1;

	//根据通道编号从两个DDS数据源中选择DAC数据
	always@(*)
	begin
		case(Current_CH)
			0: DATA = DATA_A;
			1: DATA = DATA_B;
			default:DATA = DATA_A;
		endcase	
	end
	
	assign CtrlWord = Current_CH?4'b1100:4'b0101;

endmodule
