/*============================================================================
*
*  LOGIC CORE:          串口单字节发送模块		
*  MODULE NAME:         UART_Byte_Tx()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为单路串口字节发送模块
===========================================================================*/
module UART_Byte_Tx(	
	Clk,
	Rst_n,
	Byte_En,
	Baud_Set,
	Data_Byte,
	Tx_Done,
	Rs232_Tx
);

	input Clk;		/*系统时钟，默认为50M*/
	input Rst_n;	/*全局复位，低电平复位*/
	input Byte_En;	/*字节发送使能信号*/
	input [2:0]Baud_Set; /*波特率选择信号*/
	input [7:0] Data_Byte;/*待发送的字节数据*/ 
	output reg Tx_Done;	/*字节发送完成标志信号*/
	output reg Rs232_Tx;	/*串口发送引脚*/
	
	wire Bps_Clk; /*波特率时钟*/
	
	Tx_Bps_Gen Tx_Bps_Gen_inst(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Baud_Set(Baud_Set),
		.Tx_Done(Tx_Done),
		.Bps_Clk(Bps_Clk),
		.Byte_En(Byte_En)
	);

	reg [3:0] Bps_Clk_Cnt;/*波特率时钟生成计数器*/
	reg [7:0] Data;/*待发送数据缓存寄存器*/

/*计数波特率时钟，11个波特率时钟为一次完整的数据发送过程*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Bps_Clk_Cnt <= 4'b0;
	else if(Bps_Clk_Cnt == 4'd11)
		Bps_Clk_Cnt <= 4'b0;
	else if(Bps_Clk)
		Bps_Clk_Cnt <= Bps_Clk_Cnt + 1'b1;
	else
		Bps_Clk_Cnt <= Bps_Clk_Cnt;

/*生成数据发送完成标志信号*/		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Tx_Done <= 1'b0;
	else if(Bps_Clk_Cnt == 4'd11)
		Tx_Done <= 1'b1;
	else
		Tx_Done <= 1'b0;

/*在开始发送起始位的时候就读取并寄存Data_Byte，以免Data_Byte变化导致数据的丢失*/		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Data = 8'd0;
	else if(Bps_Clk & Bps_Clk_Cnt == 4'd1)
		Data <= Data_Byte;
	else
		Data <= Data;

/*发送数据序列机*/		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)	
		Rs232_Tx <= 1'b1;
	else begin
		case(Bps_Clk_Cnt)
			4'd1: Rs232_Tx <= 1'b0;
			4'd2: Rs232_Tx <= Data[0];
			4'd3: Rs232_Tx <= Data[1];
			4'd4: Rs232_Tx <= Data[2];	
			4'd5: Rs232_Tx <= Data[3];
			4'd6: Rs232_Tx <= Data[4];
			4'd7: Rs232_Tx <= Data[5];
			4'd8: Rs232_Tx <= Data[6];
			4'd9: Rs232_Tx <= Data[7];
			4'd10: Rs232_Tx <= 1'b1;
			default:Rs232_Tx <= 1'b1;
		endcase
	end

endmodule
