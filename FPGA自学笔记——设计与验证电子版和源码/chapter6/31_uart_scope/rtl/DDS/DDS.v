/*============================================================================
*
*  LOGIC CORE:          DDS信号发生器顶层模块		
*  MODULE NAME:         DDS()
*  COMPANY:             芯航线电子工作室
*                       http://xiaomeige.taobao.com
*	author:					小梅哥
*	author QQ Group：472607506
*  REVISION HISTORY:  
*
*    Revision 1.0  01/01/2016     Description: Initial Release.
*
*  FUNCTIONAL DESCRIPTION:
*	本模块为DDS信号发生器顶层模块，实现与主机的通信并控制DDS信号发生器生成指定要求的信号
===========================================================================*/
`include "header.v"

module DDS(Clk,Rst_n,m_wr,m_addr,m_wrdata,DDS_Data,DDS_Flag);

	input Clk;
	input Rst_n;
	input m_wr;		/*主机写寄存器请求*/
	input [7:0]m_addr;/*主机写寄存器地址*/
	input [15:0]m_wrdata;/*主机写寄存器数据*/

	output [11:0]DDS_Data;
	output reg DDS_Flag;
	
	wire [9:0]DA_Data;/*DDS输出，为10位的数据*/
	


	reg DDS_En;/*DDS使能寄存器，ADDR = 8'd6*/
	reg [15:0]reg_Fword_H;/*DDS频率控制字高16位,ADDR = 8'd7*/
	reg [15:0]reg_Fword_L;/*DDS频率控制字低16位,ADDR = 8'd8*/
	
	reg [11:0]reg_Pword;/*DDS相位控制字,ADDR = 8'd9*/
	
	DDS_Module DDS_Module(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.EN(DDS_En),
		.Fword({reg_Fword_H,reg_Fword_L}),
		.Pword(reg_Pword),
		.DA_Clk(),
		.DA_Data(DA_Data)
	);
	
	assign DDS_Data = {DA_Data,2'd0};
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		DDS_En <= 1'b0;
	else if(m_wr && (m_addr == `DDS_En))
		DDS_En <= m_wrdata[0];
	else
		DDS_En <= DDS_En;

	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		reg_Fword_L <= 16'd859;	/*复位时设置频率为10Hz*/
		reg_Fword_H <= 16'd0;
	end
	else if(m_wr && (m_addr == `DDS_Fword_L))/*写采样分频计数器计数最大值的低16位*/
		reg_Fword_L <= m_wrdata;
	else if(m_wr && (m_addr == `DDS_Fword_H))/*写采样分频计数器计数最大值的高16位*/
		reg_Fword_H <= m_wrdata;
	else begin
		reg_Fword_H <= reg_Fword_H;
		reg_Fword_L <= reg_Fword_L;
	end
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		reg_Pword <= 1'b0;
	else if(m_wr && (m_addr == `DDS_Pword))
		reg_Pword <= m_wrdata[11:0];
	else
		reg_Pword <= reg_Pword;
	
///////////////////////////////////////////////////////////////////////////	
	reg [31:0]DDS_Sample_Cnt;
	reg [15:0]DDS_Sample_Cnt_Max_L;/*采样分频计数器计数最大值的低16位，ADDR = 8'd10*/
	reg [15:0]DDS_Sample_Cnt_Max_H;/*采样分频计数器计数最大值的高16位，ADDR = 8'd11*/
	reg DDS_Sample_En;/*采样使能寄存器，ADDR = 8'd12*/

/*-------设置采样分频计数器计数最大值---------*/	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		DDS_Sample_Cnt_Max_H <= 16'd0;
		DDS_Sample_Cnt_Max_L <= 16'd49999;/*默认设置采样率为1K*/
	end
	else if(m_wr && (m_addr == `DDS_S_Cnt_Max_L))/*写采样分频计数器计数最大值的低16位*/
		DDS_Sample_Cnt_Max_L <= m_wrdata;
	else if(m_wr && (m_addr == `DDS_S_Cnt_Max_H))/*写采样分频计数器计数最大值的高16位*/
		DDS_Sample_Cnt_Max_H <= m_wrdata;
	else begin
		DDS_Sample_Cnt_Max_H <= DDS_Sample_Cnt_Max_H;
		DDS_Sample_Cnt_Max_L <= DDS_Sample_Cnt_Max_L;
	end
	
/*---------写采样使能寄存器-------------*/
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		DDS_Sample_En <= 1'b0;
	else if(m_wr && (m_addr == `DDS_Sample_En))
		DDS_Sample_En <= m_wrdata[0];
	else
		DDS_Sample_En <= DDS_Sample_En;
		
/*---------采样计数器计数------------*/
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		DDS_Sample_Cnt <= 32'd0;
	else if(DDS_Sample_En)begin
		if(DDS_Sample_Cnt >= {DDS_Sample_Cnt_Max_H,DDS_Sample_Cnt_Max_L})
			DDS_Sample_Cnt <= 32'd0;
		else 
			DDS_Sample_Cnt <= DDS_Sample_Cnt + 1'b1;
	end
	else
		DDS_Sample_Cnt <= 32'd0;

/*-----------DDS采样使能控制输出-------*/		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		DDS_Flag <= 1'b0;
	else if(DDS_Sample_Cnt == {DDS_Sample_Cnt_Max_H,DDS_Sample_Cnt_Max_L})
		DDS_Flag <= 1'b1;
	else
		DDS_Flag <= 1'b0;

endmodule
