/*============================================================================
*
*  LOGIC CORE:          串口接口波特率生成模块		
*  MODULE NAME:         Rx_Bps_Gen()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为串口接收波特率生成模块，生成的采样时钟为波特率的9倍
===========================================================================*/
module Rx_Bps_Gen(
	Clk,
	Rst_n,
	Baud_Set,
	Rx_Done,
	Sample_Clk,
	Byte_En
);
	
	input Clk;		/*系统时钟，默认为50M*/
	input Rst_n;	/*全局复位，低电平复位*/
	input [2:0]Baud_Set;	/*波特率选择信号*/
	input Rx_Done;	/*单个字节接收完成标志*/
	input Byte_En;	/*字节接收使能，每个高脉冲使能一次字节数据的接收*/
	output reg Sample_Clk;	/*采样时钟，频率为9倍的波特率时钟频率*/
	
	
	parameter system_clk = 50_000_000;	/*输入时钟频率设定，默认50M*/

/*根据输入时钟频率计算生成各波特率时分频计数器的计数最大值*/	
	localparam bps9600 = system_clk/9600/9 - 1;
	localparam bps19200 = system_clk/19200/9 - 1;
	localparam bps38400 = system_clk/38400/9 - 1;
	localparam bps57600 = system_clk/57600/9 - 1;
	localparam bps115200 = system_clk/115200/9 - 1;
	localparam bps230400 = system_clk/230400/9 - 1;
	localparam bps460800 = system_clk/460800/9 - 1;
	localparam bps921600 = system_clk/921600/9 - 1;		
	
	reg [31:0]BPS_PARA;/*波特率分频计数器的计数最大值*/

	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		BPS_PARA <= bps9600;	/*复位时波特率默认为9600bps*/
	end
	else begin
		case(Baud_Set)	/*根据波特率控制信号选择不同的波特率计数器计数最大值*/
			3'd0: BPS_PARA <= bps9600;
			3'd1: BPS_PARA <= bps19200;
			3'd2: BPS_PARA <= bps38400;
			3'd3: BPS_PARA <= bps57600;
			3'd4: BPS_PARA <= bps115200;
			3'd5: BPS_PARA <= bps230400;
			3'd6: BPS_PARA <= bps460800;
			3'd7: BPS_PARA <= bps921600;			
			default: BPS_PARA <= bps9600;/*异常情况，恢复到9600的波特率*/
		endcase
	end
	
//=====================================================================
	reg[9:0]Count;
	
	reg n_state;
	localparam IDEL_1 = 1'b0,
				  RECEIVE   = 1'b1;
				  
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
				if(Byte_En)begin /*检测到字节接收使能信号，则启动波特率生成进程，同时进入接收状态*/
					BPS_EN <= 1'b1;
					n_state <= RECEIVE;
				end
				else begin
					n_state <= IDEL_1;
					BPS_EN <= 1'b0;
				end
			RECEIVE:
				if(Rx_Done == 1)begin/*接收完成，关闭波特率生成进程，回到空闲状态*/
					BPS_EN <= 1'b0;
					n_state <= IDEL_1;
				end
				else begin
					n_state <= RECEIVE;
					BPS_EN <= 1'b1;
				end
			default:n_state <= IDEL_1;
		endcase
	end

/*-------波特率时钟生成定时器--------------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Count <= 10'd0;	
	else if(BPS_EN == 1'b0)
		Count <= 10'd0;
	else begin
		if(Count == BPS_PARA)
			Count <= 10'd0;
		else 
			Count <= Count + 1'b1;
	end
	
//=====================================================
/*输出数据接收采样时钟*/
	always @(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Sample_Clk <= 1'b0;
	else if(Count== 1)
		Sample_Clk <= 1'b1;
	else 
		Sample_Clk <= 1'b0;

//***************************************************************************

endmodule
