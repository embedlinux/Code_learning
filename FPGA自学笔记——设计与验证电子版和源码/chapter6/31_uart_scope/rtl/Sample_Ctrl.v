/*============================================================================
*
*  LOGIC CORE:          ADC采样使能控制模块		
*  MODULE NAME:         Sample_Ctrl()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为ADC采样使能控制模块，主要负责控制ADC进行数据模数转换
===========================================================================*/
`include "header.v"

module Sample_Ctrl(Clk,Rst_n,m_wr,m_addr,m_wrdata,ADC_En);

	input Clk;
	input Rst_n;
	input m_wr;		/*主机写寄存器请求*/
	input [7:0]m_addr;/*主机写寄存器地址*/
	input [15:0]m_wrdata;/*主机写寄存器数据*/
	
	output reg ADC_En;	/*ADC单次转换使能*/
	
	reg [31:0]ADC_Sample_Cnt;
	reg [15:0]ADC_Sample_Cnt_Max_L;/*采样分频计数器计数最大值的低16位，ADDR = 8'd1*/
	reg [15:0]ADC_Sample_Cnt_Max_H;/*采样分频计数器计数最大值的高16位，ADDR = 8'd2*/
	reg ADC_Sample_En;/*采样使能寄存器，ADDR = 8'd3*/

/*-------设置采样分频计数器计数最大值---------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		ADC_Sample_Cnt_Max_H <= 16'd0;
		ADC_Sample_Cnt_Max_L <= 16'd49999;/*默认设置采样率为1K*/
	end
	else if(m_wr && (m_addr == `ADC_S_Cnt_Max_L))/*写采样分频计数器计数最大值的低16位*/
		ADC_Sample_Cnt_Max_L <= m_wrdata;
	else if(m_wr && (m_addr == `ADC_S_Cnt_Max_H))/*写采样分频计数器计数最大值的高16位*/
		ADC_Sample_Cnt_Max_H <= m_wrdata;
	else begin
		ADC_Sample_Cnt_Max_H <= ADC_Sample_Cnt_Max_H;
		ADC_Sample_Cnt_Max_L <= ADC_Sample_Cnt_Max_L;
	end
	
/*---------写采样使能寄存器-------------*/
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		ADC_Sample_En <= 1'b0;
	else if(m_wr && (m_addr == `ADC_Sample_En))
		ADC_Sample_En <= m_wrdata[0];
	else
		ADC_Sample_En <= ADC_Sample_En;
		
/*---------采样计数器计数------------*/
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		ADC_Sample_Cnt <= 32'd0;
	else if(ADC_Sample_En)begin
		if(ADC_Sample_Cnt == {ADC_Sample_Cnt_Max_H,ADC_Sample_Cnt_Max_L})
			ADC_Sample_Cnt <= 32'd0;
		else 
			ADC_Sample_Cnt <= ADC_Sample_Cnt + 1'b1;
	end
	else
		ADC_Sample_Cnt <= 32'd0;

/*-----------ADC采样使能控制输出-------*/		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		ADC_En <= 1'b0;
	else if(ADC_Sample_Cnt == {ADC_Sample_Cnt_Max_H,ADC_Sample_Cnt_Max_L})
		ADC_En <= 1'b1;
	else
		ADC_En <= 1'b0;

endmodule
