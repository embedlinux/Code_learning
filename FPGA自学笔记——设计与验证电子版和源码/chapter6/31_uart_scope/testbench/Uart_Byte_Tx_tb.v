/*============================================================================
*
*  LOGIC CORE:          串口字节发送模块仿真文件	
*  MODULE NAME:         Uart_Byte_Tx_tb()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*	FileType	：Testbench
*
*  FUNCTIONAL DESCRIPTION:
*
*	FileType	：Testbench
*	
*  本模块为串口字节发送模块仿真文件
*
===========================================================================*/

`timescale 1ns/1ns

module Uart_Byte_Tx_tb;

	reg Clk;
	reg Rst_n;
	reg [2:0]Baud_Set;
	reg Byte_En;
	wire Tx_Done;
	reg [7:0]Data_Byte;

	wire Rs232_Tx;

/*-----------例化串口字节发送模块-------*/		
	UART_Byte_Tx UART_Byte_Tx(	
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Byte_En(Byte_En),
		.Baud_Set(Baud_Set),
		.Data_Byte(Data_Byte),
		.Tx_Done(Tx_Done),
		.Rs232_Tx(Rs232_Tx)
	);
	
	initial Clk = 1;
	always #10 Clk = ~Clk;
	
	initial begin
		Rst_n = 0;
		Baud_Set = 3'd0;
		Byte_En = 1'b0;
		Data_Byte = 8'd0;
		#200;
		Rst_n = 1;
		#20000;
		Data_Byte = 8'h3C;
		Byte_En = 1'b1;
		#20;
		Byte_En = 1'b0;
		@(posedge Tx_Done);
		
		#40;
		Data_Byte = 8'h55;
		Byte_En = 1'b1;
		#20;
		Byte_En = 1'b0;
		@(posedge Tx_Done);
		#2000;
		
		$stop;
	end
endmodule
