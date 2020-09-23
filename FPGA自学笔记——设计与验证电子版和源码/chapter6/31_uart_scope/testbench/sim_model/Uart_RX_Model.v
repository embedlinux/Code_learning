/*============================================================================
*
*  LOGIC CORE:          串口接收仿真模型		
*  MODULE NAME:         Uart_RX_Model()
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
*  本模块为串口接收仿真模型
*
===========================================================================*/

`timescale 1ns/1ps

module Uart_RX_Model(Baud_Set,uart_rx);
	
	input [2:0]Baud_Set;/*波特率选择信号*/
	input uart_rx;/*仿真模型串口接收引脚*/
	
	reg Clk;/*仿真模型内部时钟，50M*/
	reg Rst_n;/*仿真模型内部复位信号*/
	
	wire Mid_Flag_Receive;/*数据中点（采样点）标志信号*/
	
	reg Receive_Baud_Start;/*接收波特率生成使能信号*/
	reg [7:0]rx_data;/*接收数据移位寄存器*/
	
	reg [7:0]Rx_Byte;/*最终接收结果*/
		
	initial Clk = 1;
	always#10 Clk = ~Clk;
	
/*例化波特率设置模块*/	
	baud_select baud_select_Receive(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Baud_Set(Baud_Set),
		.Baud_Start(Receive_Baud_Start),
		.Mid_Flag(Mid_Flag_Receive)
	);
	
	initial begin
		Rst_n = 0;
		Rx_Byte = 0;
		rx_data = 0;
		#100 Rst_n = 1;
	end

/*接收一个字节的数据*/
	initial begin
	forever begin
		@(negedge uart_rx)
			begin
				Receive_Baud_Start = 1;
				@(posedge Mid_Flag_Receive);
				@(posedge Mid_Flag_Receive)rx_data[0] = uart_rx;
				@(posedge Mid_Flag_Receive)rx_data[1] = uart_rx;	
				@(posedge Mid_Flag_Receive)rx_data[2] = uart_rx;	
				@(posedge Mid_Flag_Receive)rx_data[3] = uart_rx;
				@(posedge Mid_Flag_Receive)rx_data[4] = uart_rx;	
				@(posedge Mid_Flag_Receive)rx_data[5] = uart_rx;
				@(posedge Mid_Flag_Receive)rx_data[6] = uart_rx;
				@(posedge Mid_Flag_Receive)rx_data[7] = uart_rx;
				@(posedge Mid_Flag_Receive)begin Receive_Baud_Start = 0;Rx_Byte = rx_data;end
				$display("Master_receive Data = %0h",Rx_Byte); 
			end
		end
	end

endmodule

/*---------数据发送波特率生成模块---------*/
/*此模块生成仿真模型接收数据所需波特率时钟信号*/
module baud_select(Clk,Rst_n,Baud_Set,Baud_Start,Mid_Flag);

	input Clk;
	input Rst_n;
	input [2:0]Baud_Set;
	input Baud_Start;
	output Mid_Flag;

	parameter system_clk = 50_000_000;

	localparam bps9600 = system_clk/9600 - 1;
	localparam bps19200 = system_clk/19200 - 1;
	localparam bps38400 = system_clk/38400 - 1;
	localparam bps57600 = system_clk/57600 - 1;
	localparam bps115200 = system_clk/115200 - 1;
	localparam bps230400 = system_clk/230400 - 1;
	localparam bps460800 = system_clk/460800 - 1;
	localparam bps921600 = system_clk/921600 - 1;		

	localparam bps9600_2 = system_clk/9600/2 - 1;
	localparam bps19200_2 = system_clk/19200/2 - 1;
	localparam bps38400_2 = system_clk/38400/2 - 1;
	localparam bps57600_2 = system_clk/57600/2 - 1;
	localparam bps115200_2 = system_clk/115200/2 - 1;
	localparam bps230400_2 = system_clk/230400/2 - 1;
	localparam bps460800_2 = system_clk/460800/2 - 1;
	localparam bps921600_2 = system_clk/921600/2 - 1;	

	reg [31:0]BPS_PARA;
	reg [31:0]BPS_PARA_2;

	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		BPS_PARA <= bps9600;
		BPS_PARA_2 <= bps9600_2;
	end
	else begin
		case(Baud_Set)
			3'd0:begin BPS_PARA <= bps9600;BPS_PARA_2 <= bps9600_2; end
			3'd1:begin BPS_PARA <= bps19200;BPS_PARA_2 <= bps19200_2; end
			3'd2:begin BPS_PARA <= bps38400;BPS_PARA_2 <= bps38400_2; end	
			3'd3:begin BPS_PARA <= bps57600;BPS_PARA_2 <= bps57600_2; end
			3'd4:begin BPS_PARA <= bps115200;BPS_PARA_2 <= bps115200_2; end
			3'd5:begin BPS_PARA <= bps230400;BPS_PARA_2 <= bps230400_2; end
			3'd6:begin BPS_PARA <= bps460800;BPS_PARA_2 <= bps460800_2; end
			3'd7:begin BPS_PARA <= bps921600;BPS_PARA_2 <= bps921600_2; end				
			default:begin BPS_PARA <= bps9600;BPS_PARA_2 <= bps9600_2; end
		endcase
	end

//波特率分频计数器，当启动信号标志位为1时计数开始
	reg[12:0]cont;
	always @(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		cont<= 13'd0;
	else if((cont==BPS_PARA)||!Baud_Start)
		cont<= 13'b0_0000_0000_0000;
	else 
		cont<=cont+1'b1;
	

//发送一个位需要5208个时钟周期，在一个数据位中间时刻，即计数到2603时，接收或发送
//标志位置1，并传输给接收模块或者发送模块，以发送或接收数据；
	reg Mid_Flag_1; 
	always @(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Mid_Flag_1<=1'b0;
	else if((cont==BPS_PARA_2))
		Mid_Flag_1<=1'b1;
	else 
		Mid_Flag_1<=1'b0;
		
	assign Mid_Flag=Mid_Flag_1;

endmodule 

