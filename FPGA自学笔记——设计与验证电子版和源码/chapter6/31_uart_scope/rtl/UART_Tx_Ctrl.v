/*============================================================================
*
*  LOGIC CORE:          串口发送控制模块		
*  MODULE NAME:         UART_Tx_Ctrl()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为串口发送控制模块，主要负责控制串口发送模块进行数据的发送
===========================================================================*/
`include "../rtl/header.v"

module UART_Tx_Ctrl(
	Clk,
	Rst_n,
	m_wr,
	m_addr,
	m_wrdata,
	ADC_Flag,
	ADC_Busy,
	Byte_En,
	Tx_Done,
	Baud_Set
);
	
	input Clk;
	input Rst_n;
	input m_wr;				/*主机写寄存器请求*/
	input [7:0]m_addr;	/*主机写寄存器地址*/
	input [15:0]m_wrdata;/*主机写寄存器数据*/
	
	input ADC_Flag;		/*ADC转换结果有效标志*/
	input ADC_Busy;		/*此信号本设计中未使用*/
	output reg Byte_En;	/*串口字节发送使能信号*/
	input Tx_Done;			/*串口单字节发送完成信号*/
	output reg [2:0]Baud_Set;/*波特率控制信号*/
	
	reg En_Tx;	/*串口发送使能寄存器，ADDR = 8'd4*/
	reg [2:0]reg_Baud_Set;	/*串口发送波特率设置寄存器，ADDR = 8'd5*/

/*---------写串口发送使能寄存器------------------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		En_Tx <= 1'b0;
	else if(m_wr && (m_addr == `UART_En_Tx))
		En_Tx <= m_wrdata[0];
	else
		En_Tx <= En_Tx;	
	
/*---------写串口发送波特率设置寄存器-------------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		reg_Baud_Set <= 3'd0;	/*设置波特率默认为9600*/
	else if(m_wr && (m_addr == `UART_Baud_Set))
		reg_Baud_Set <= m_wrdata[2:0];
	else
		reg_Baud_Set <= reg_Baud_Set;

/*--------更新波特率控制信号值------------------*/		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Baud_Set <= 3'd0;	/*设置波特率默认为9600*/
	else if(En_Tx && ADC_Flag)/*使能发送且ADC采集结果有效时*/
		Baud_Set <= reg_Baud_Set;
	else
		Baud_Set <= Baud_Set;

/*-----ADC完成一次转换，则使能串口发送模块将数据发送出去-----*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Byte_En <= 1'b0;
	else if(En_Tx)begin/*串口发送使能寄存器为高*/
		if(ADC_Flag)
			Byte_En <= 1'b1;/*使能一次串口数据发送*/
		else
			Byte_En <= 1'b0;
	end
	else 
		Byte_En <= 1'b0;

endmodule
