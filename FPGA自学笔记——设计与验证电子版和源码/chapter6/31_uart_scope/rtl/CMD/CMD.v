/*============================================================================
*
*  LOGIC CORE:          串口数据接收与命令解析模块		
*  MODULE NAME:         CMD()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为串口数据接收与命令解析模块
===========================================================================*/
module CMD(Clk,Rst_n,Rx_Byte,Rx_Int,m_wr,m_addr,m_wrdata);

	input Clk;
	input Rst_n;
	
	input [7:0]Rx_Byte;	/*串口接收模块接收到的数据字节*/
	input Rx_Int;	/*串口接收模块接收到数据标志*/	
	
	output reg m_wr;	/*主机写寄存器请求*/
	output reg [7:0]m_addr;/*主机写寄存器地址*/
	output reg [15:0]m_wrdata;/*主机写寄存器数据*/
	
	reg [5:0] state;
	reg [23:0] reg_CMD_DATA;/*解析得到的命令数据*/
	reg CMD_Valid;/*命令数据有效标志*/
	
	localparam 
		Header = 8'hAA,	/*帧头*/
		Length = 8'd3,		/*帧长*/
		Tail   = 8'h88;	/*帧尾*/

/*----------状态定义-----------------*/		
	localparam
		CMD_HEADER = 6'b00_0001,
		CMD_LENGTH = 6'b00_0010,
		CMD_DATAA  = 6'b00_0100,
		CMD_DATAB  = 6'b00_1000,
		CMD_DATAC  = 6'b01_0000,
		CMD_TAIL   = 6'b10_0000;
	
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		reg_CMD_DATA <= 24'd0;
		CMD_Valid <= 1'b0;
		state <= CMD_HEADER;
	end
	else if(Rx_Int)begin
		case(state)
			CMD_HEADER:	/*解码帧头数据*/
				if(Rx_Byte == Header)
					state <= CMD_LENGTH;
				else
					state <= CMD_HEADER;
			
			CMD_LENGTH:	/*解码帧长数据*/
				if(Rx_Byte == Length)
					state <= CMD_DATAA;
				else
					state <= CMD_HEADER;
			
			CMD_DATAA:	/*解码数据A*/
				begin
					reg_CMD_DATA[23:16] <= Rx_Byte;
					state <= CMD_DATAB;
				end
				
			CMD_DATAB:	/*解码数据B*/
				begin
					reg_CMD_DATA[15:8] <= Rx_Byte;
					state <= CMD_DATAC;				
				end
				
			CMD_DATAC:	/*解码数据C*/
				begin
					reg_CMD_DATA[7:0] <= Rx_Byte;
					state <= CMD_TAIL;				
				end

			CMD_TAIL:	/*解码帧尾数据*/
				if(Rx_Byte == Tail)begin
					CMD_Valid <= 1'b1;	/*解码成功，发送解码数据有效标志*/
					state <= CMD_HEADER;
				end
				else begin
					CMD_Valid <= 1'b0;
					state <= CMD_HEADER;
				end
			default:;
		endcase	
	end
	else begin
		CMD_Valid <= 1'b0;
		reg_CMD_DATA <= reg_CMD_DATA;
	end

/*------驱动总线写外设寄存器--------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		m_wr <= 1'b0;
		m_addr <= 8'd0;
		m_wrdata <= 16'd0;
	end
	else if(CMD_Valid)begin
		m_wr <= 1'b1;
		m_addr <= reg_CMD_DATA[23:16];
		m_wrdata <= reg_CMD_DATA[15:0];	
	end
	else begin
		m_wr <= 1'b0;
		m_addr <= m_addr;
		m_wrdata <= m_wrdata;	
	end
	
endmodule
