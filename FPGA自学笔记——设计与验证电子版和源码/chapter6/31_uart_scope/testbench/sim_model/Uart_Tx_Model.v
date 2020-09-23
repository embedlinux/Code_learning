/*============================================================================
*
*  LOGIC CORE:          串口发送仿真模型	
*  MODULE NAME:         Uart_Tx_Model()
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
*  本模块为串口发送仿真模型
*
===========================================================================*/
`timescale 1ns/1ps

module Uart_Tx_Model(Baud_Set,Tx_Data,Tx_En,uart_tx,Tx_Done);
	
	input [2:0]Baud_Set;	/*波特率选择信号*/
	input [7:0]Tx_Data;	/*待发送数据字节*/
	input Tx_En;			/*数据字节发送使能信号*/
	output reg uart_tx;	/*仿真串口发送模型发送信号*/
	output reg Tx_Done;	/*发送完成信号*/
	
	reg Clk;	/*仿真模型内部工作时钟*/
	reg Rst_n;	/*仿真模型内部复位信号*/
	
	wire Bps_Clk;	/*发送波特率时钟波特率*/
	reg Bps_En;	/*发送波特率使能信号*/
		
	initial Clk = 1;
	always#10 Clk = ~Clk;

/*----例化发送波特率时钟生成模块-----*/	
	TxModel_Bps_Gen TxModel_Bps_Gen_send(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Baud_Set(Baud_Set),
		.Tx_Done(Tx_Done),
		.Bps_Clk(Bps_Clk),
		.Byte_En(Bps_En)
	);
		
	initial begin
		Tx_Done = 0;
		uart_tx = 1;
		Rst_n = 0;
		Bps_En = 0;
		#100;
		Rst_n = 1;
		forever@(posedge Tx_En)/*每来一个发送使能信号即执行一次发送过程*/
			Uart_Send(Tx_Data);	
	end

/*执行一次字节数据的发送*/	
	task Uart_Send;
		input [7:0]Data;
		begin
			Bps_En = 1;
			Tx_Done = 0;
			$display("Uart_Send Data = %0h",Data);/*打印发送的数据*/
			@(posedge Bps_Clk) #0.1 uart_tx = 0;
			@(posedge Bps_Clk) #0.1 uart_tx = Data[0];
			@(posedge Bps_Clk) #0.1 uart_tx = Data[1];
			@(posedge Bps_Clk) #0.1 uart_tx = Data[2];
			@(posedge Bps_Clk) #0.1 uart_tx = Data[3];
			@(posedge Bps_Clk) #0.1 uart_tx = Data[4];
			@(posedge Bps_Clk) #0.1 uart_tx = Data[5];
			@(posedge Bps_Clk) #0.1 uart_tx = Data[6];
			@(posedge Bps_Clk) #0.1 uart_tx = Data[7];
			@(posedge Bps_Clk) #0.1 uart_tx = 1;
			@(posedge Bps_Clk) #0.1 ;
			Tx_Done = 1;
			Bps_En = 0;
			#20 Tx_Done = 0;
		end
	endtask
	
endmodule

/*串口发送仿真模型波特率生成模块*/
module TxModel_Bps_Gen(
	Clk,
	Rst_n,
	Baud_Set,
	Tx_Done,
	Bps_Clk,
	Byte_En
);
	
	input Clk;		/*系统时钟，默认为50M*/
	input Rst_n;	/*全局复位，低电平复位*/
	input [2:0]Baud_Set;	/*波特率选择信号*/
	input Tx_Done;	/*单个字节发送完成标志信号*/
	input Byte_En;	/*使能单次字节发送的波特率生成*/
	output reg Bps_Clk;	/*发送波特率时钟*/
	
	
	parameter system_clk = 50_000_000; /*输入时钟频率设定，默认50M*/

/*根据输入时钟频率计算生成各波特率时分频计数器的计数最大值*/		
	localparam bps9600 = system_clk/9600 - 1;
	localparam bps19200 = system_clk/19200 - 1;
	localparam bps38400 = system_clk/38400 - 1;
	localparam bps57600 = system_clk/57600 - 1;
	localparam bps115200 = system_clk/115200 - 1;
	localparam bps230400 = system_clk/230400 - 1;
	localparam bps460800 = system_clk/460800 - 1;
	localparam bps921600 = system_clk/921600 - 1;		
	
	reg [31:0]BPS_PARA;/*波特率分频计数器的计数最大值*/

	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		BPS_PARA <= bps9600;/*复位时波特率默认为9600bps*/
	end
	else begin
		case(Baud_Set)/*根据波特率控制信号选择不同的波特率计数器计数最大值*/
			3'd0: BPS_PARA <= bps9600;
			3'd1: BPS_PARA <= bps19200;
			3'd2: BPS_PARA <= bps38400;
			3'd3: BPS_PARA <= bps57600;
			3'd4: BPS_PARA <= bps115200;
			3'd5: BPS_PARA <= bps230400;
			3'd6: BPS_PARA <= bps460800;
			3'd7: BPS_PARA <= bps921600;			
			default: BPS_PARA <= bps9600;
		endcase
	end
	
//=========================================================
	reg[12:0]Count;
	
	reg n_state;
	localparam IDEL_1 = 1'b0,
				  SEND   = 1'b1;
				  
	reg BPS_EN;
	
/*-------波特率时钟生成控制逻辑--------------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		BPS_EN <= 1'b0;
		n_state <= IDEL_1;
	end
	else begin
		case(n_state)
			IDEL_1:
				if(Byte_En)begin/*检测到字节发送使能信号，则启动波特率生成进程，同时进入发送状态*/
					BPS_EN <= 1'b1;
					n_state <= SEND;
				end
				else begin
					n_state <= IDEL_1;
					BPS_EN <= 1'b0;
				end
			SEND:
				if(Tx_Done == 1)begin/*发送完成，关闭波特率生成进程，回到空闲状态*/
					BPS_EN <= 1'b0;
					n_state <= IDEL_1;
				end
				else begin
					n_state <= SEND;
					BPS_EN <= 1'b1;
				end
			default:n_state <= IDEL_1;
		endcase
	end

/*-------波特率时钟生成定时器--------------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Count <= 13'd0;	
	else if(BPS_EN == 1'b0)
		Count <= 13'd0;
	else begin
		if(Count == BPS_PARA)
			Count <= 13'd0;
		else 
			Count <= Count + 1'b1;
	end
	
/*输出数据接收采样时钟*/	
//-----------------------------------------------
	always @(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Bps_Clk <= 1'b0;
	else if(Count== 1)
		Bps_Clk <= 1'b1;
	else 
		Bps_Clk <= 1'b0;

//===================================================

endmodule
