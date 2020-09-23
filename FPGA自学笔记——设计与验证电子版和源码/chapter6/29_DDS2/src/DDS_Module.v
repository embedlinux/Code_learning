/***************************************************
*	Module Name		:	DDS_Module		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-06-25
*	Revision		   :	v1.1
*	Description		:  DDS功能模块，根据频率控制字和相位控制字产生对应正弦数据输出
**************************************************/

module DDS_Module(
	Clk,
	Rst_n,
	EN,
	Fword,
	Pword,
	DA_Clk,
	DA_Data
);

	input Clk;/*系统时钟*/
	input Rst_n;/*系统复位*/
	input EN;/*DDS模块使能*/
	input [31:0]Fword;/*频率控制字*/
	input [11:0]Pword;/*相位控制字*/
	
	output DA_Clk;/*DA数据输出时钟*/
	output [9:0]DA_Data;/*D输出输出A*/
	
	reg [31:0]Fre_acc;	
	reg [11:0]Rom_Addr;

/*---------------相位累加器------------------*/	
	always @(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Fre_acc <= 32'd0;
	else if(!EN)
		Fre_acc <= 32'd0;	
	else 
		Fre_acc <= Fre_acc + Fword;

/*----------生成查找表地址---------------------*/		
	always @(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Rom_Addr <= 12'd0;
	else if(!EN)
		Rom_Addr <= 12'd0;
	else
		Rom_Addr <= Fre_acc[31:20] + Pword;	

/*----------例化查找表ROM-------*/		
	ddsrom ddsrom(
		.address(Rom_Addr),
		.clock(Clk),
		.q(DA_Data)
	);

/*----------输出DA时钟----------*/	
	assign DA_Clk = (EN)?Clk:1'b1;

endmodule
