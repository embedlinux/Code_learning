/***************************************************
*	Module Name		:	Hex_to_V		   
*	Engineer		   :	小梅哥 
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  将ADC输出的12bit二进制数转换成实际电压值，且为了
	*	               实现均值滤波，累计采集1024次数据，计算一次平均值。
	                  这样能让采样结果显示很稳定，电压表中往往也有这种方式
**************************************************/
module Hex_to_V(
			Clk,      //模块时钟
			Rst_n,    //模块复位
			ADC_flag, //ADC转换完成标志
			Hex_data, //ADC输入二进制数
			Voltage   //实际电压值输出
		);

	input Clk;
	input Rst_n;
	input ADC_flag;
	input [11:0]Hex_data;
	
	output [15:0]Voltage;
	
	reg [21:0]Hex_SUM;
	reg [11:0]Hex;
	
	//计数1024次
	reg [9:0]cnt;
	always@(posedge Clk or negedge Rst_n)
		if(!Rst_n)
			cnt <= 10'b0;
		else if(ADC_flag)
		   cnt <= cnt + 1'b1;
		else 
			cnt <= cnt;
	
   // 累加1024次数据	
	always@(posedge Clk or negedge Rst_n)
		if(!Rst_n)
			Hex_SUM <= 22'd0;
		else if(cnt == 1023 && ADC_flag)
		   Hex_SUM <= 22'd0;
	   else if(ADC_flag)
		   Hex_SUM <= Hex_SUM + Hex_data;
	   else
		   Hex_SUM <= Hex_SUM;
	// 除以1024 直接取
	always@(posedge Clk or negedge Rst_n)
		if(!Rst_n)
			Hex <= 10'b0;
		else if(cnt == 1023 && ADC_flag)
		   Hex <= Hex_SUM[21:10];
    	else
		   Hex <= Hex;
//Voltage*1000 = (3.3*65536*Hex) >> 16
//Voltage*1000  = ((3.3/4096)*65536*1000*Hex) >> 16  52800

   assign Voltage = (52800 * Hex) >> 16;           
	

endmodule
