/*============================================================================
*
*  LOGIC CORE:          串口单字节接口模块		
*  MODULE NAME:         Uart_Byte_Rx()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为单路串口字节接收模块
===========================================================================*/
module Uart_Byte_Rx(
	Clk,
	Rst_n,
	Baud_Set,
	Rs232_Rx,
	Rx_Byte,
	Rx_Done
);

	input Clk;		/*系统时钟，默认为50M*/
	input Rst_n;	/*全局复位，低电平复位*/
	input [2:0]Baud_Set;	/*波特率选择信号*/
	input Rs232_Rx;	/*串口接收引脚*/

	output reg[7:0]Rx_Byte;	/*接收到的字节数据*/
	output reg Rx_Done;	/*接收字节成功标志信号*/
	
	wire Sample_Clk;	/*采样时钟，为9倍的波特率时钟速率，由子模块Rx_Bps_Gen（）生成*/
	wire Byte_En;	/*使能采样信号，当检测到串口起始位时，即启动一次接收*/

//*************************************************************************
//
reg Rs232_Rx0,Rs232_Rx1,Rs232_Rx2,Rs232_Rx3;

	always @ (posedge Clk or negedge Rst_n) 
	if(!Rst_n) begin
		Rs232_Rx0 <= 1'b0;
		Rs232_Rx1 <= 1'b0;
		Rs232_Rx2 <= 1'b0;
		Rs232_Rx3 <= 1'b0;
	end
	else begin 
		Rs232_Rx0 <= Rs232_Rx;
		Rs232_Rx1 <= Rs232_Rx0;
		Rs232_Rx2 <= Rs232_Rx1;
		Rs232_Rx3 <= Rs232_Rx2;
	end
	
	wire neg_Rs232_Rx= Rs232_Rx3 & Rs232_Rx2 & ~Rs232_Rx1 & ~Rs232_Rx0;
	
	assign Byte_En = neg_Rs232_Rx;

/*----------计数采样时钟--------------*/
/*9倍波特率采样时钟，故一个完整的接收过程有90个波特率时钟*/
	reg[6:0]Sample_Clk_Cnt;
	always @ (posedge Clk or negedge Rst_n) 
	if(!Rst_n)
		Sample_Clk_Cnt <= 7'd0;
	else if(Sample_Clk)begin
		if(Sample_Clk_Cnt == 7'd89)
			Sample_Clk_Cnt <= 7'd0;
		else
			Sample_Clk_Cnt <= Sample_Clk_Cnt + 1'b1;
	end
	else
		Sample_Clk_Cnt <= Sample_Clk_Cnt;

	reg [1:0]Start_Bit;	/*起始位，这里虽然定义，但并未使用该位来判断接收数据的正确性，即默认接收都是成功的*/
	reg [1:0]Stop_Bit;	/*停止位，这里虽然定义，但并未使用该位来判断接收数据的正确性，即默认接收都是成功的*/
	reg [1:0] Data_Tmp[7:0];/*此部分较为复杂，请参看说明文档中相关解释*/
	
	always @ (posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		Data_Tmp[0] <= 2'd0;
		Data_Tmp[1] <= 2'd0;
		Data_Tmp[2] <= 2'd0;
		Data_Tmp[3] <= 2'd0;
		Data_Tmp[4] <= 2'd0;
		Data_Tmp[5] <= 2'd0;
		Data_Tmp[6] <= 2'd0;
		Data_Tmp[7] <= 2'd0;
		Start_Bit <= 2'd0;
		Stop_Bit <= 2'd0;		
	end
	else if(Sample_Clk)begin
		case(Sample_Clk_Cnt)
			7'd0:
				begin
					Data_Tmp[0] <= 2'd0;
					Data_Tmp[1] <= 2'd0;
					Data_Tmp[2] <= 2'd0;
					Data_Tmp[3] <= 2'd0;
					Data_Tmp[4] <= 2'd0;
					Data_Tmp[5] <= 2'd0;
					Data_Tmp[6] <= 2'd0;
					Data_Tmp[7] <= 2'd0;
					Start_Bit <= 2'd0;
					Stop_Bit <= 2'd0;	
				end
			7'd3,7'd4,7'd5:	Start_Bit <= Start_Bit + Rs232_Rx;
			7'd12,7'd13,7'd14:Data_Tmp[0] <= Data_Tmp[0] + Rs232_Rx;
			7'd21,7'd22,7'd23:Data_Tmp[1] <= Data_Tmp[1] + Rs232_Rx;
			7'd30,7'd31,7'd32:Data_Tmp[2] <= Data_Tmp[2] + Rs232_Rx;
			7'd39,7'd40,7'd41:Data_Tmp[3] <= Data_Tmp[3] + Rs232_Rx;
			7'd48,7'd49,7'd50:Data_Tmp[4] <= Data_Tmp[4] + Rs232_Rx;
			7'd57,7'd58,7'd59:Data_Tmp[5] <= Data_Tmp[5] + Rs232_Rx;	
			7'd66,7'd67,7'd68:Data_Tmp[6] <= Data_Tmp[6] + Rs232_Rx;
			7'd75,7'd76,7'd77:Data_Tmp[7] <= Data_Tmp[7] + Rs232_Rx;	
			7'd84,7'd85,7'd86:Stop_Bit <= Stop_Bit + Rs232_Rx;
			default:;
		endcase
	end
	else ;

/*----产生接收完成信号-------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Rx_Done <= 1'b0;
	else if(Sample_Clk & Sample_Clk_Cnt == 89)
		Rx_Done <= 1'b1;
	else
		Rx_Done <= 1'b0;

/*提取接收到的字节数据，此部分较为复杂，请参看说明文档中相关解释*/		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Rx_Byte <= 8'b0;
	else if(Sample_Clk & Sample_Clk_Cnt == 89)
		Rx_Byte = {Data_Tmp[7][1],Data_Tmp[6][1],Data_Tmp[5][1],Data_Tmp[4][1],
					  Data_Tmp[3][1],Data_Tmp[2][1],Data_Tmp[1][1],Data_Tmp[0][1]};
	else
		Rx_Byte <= Rx_Byte;

/*例化接收波特率生成模块*/		
	Rx_Bps_Gen Rx_Bps_Gen(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Baud_Set(Baud_Set),
		.Rx_Done(Rx_Done),
		.Sample_Clk(Sample_Clk),
		.Byte_En(Byte_En)
	);
	
endmodule
