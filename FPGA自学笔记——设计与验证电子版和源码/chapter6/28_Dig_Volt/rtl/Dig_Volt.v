/***************************************************
*	Module Name		:	Dig_Volt		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.1，修改数码管显示数据格式（110行）
*	Description		:  八通道数字电压表顶层文件
**************************************************/

module Dig_Volt(
			Clk,	
			Rst_n,
			key_in,
			
			ADC_SCLK,
			ADC_CS_N,
			ADC_DOUT,
			ADC_DIN,

			
			SH_CP,
			ST_CP,
			DS
	);

	input Clk;	//输入时钟
	input Rst_n; //复位输入，低电平复位
	input key_in; //通道切换	
	
	output  ADC_SCLK;	//ADC 串行数据接口时钟信号
	output  ADC_CS_N;  //ADC 串行数据接口使能信号
	input   ADC_DOUT;		//ADC转换结果，由ADC输给FPGA
	output  ADC_DIN;	//ADC控制信号输出，由FPGA发送通道控制字给ADC
   //input En_Conv;	//使能单次转换，该信号为单周期有效，高脉冲使能一次转换
	//output ADC_State;	//ADC工作状态，ADC处于转换时为低电平，空闲时为高电平	
	
	output SH_CP;	//shift clock
	output ST_CP;	//latch data clock
	output DS;	//shift serial data
	
	
	wire [2:0] ADC_CHSEL;
	wire Conv_Done;
   wire [11:0] Data;	//ADC转换结果	
	wire [15:0] Voltage;
	wire [15:0] Voltage_BCD;
	wire [31:0] disp_data;
	
	Channel_Slect Channel_Slect(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in),
		.ADC_CHSEL(ADC_CHSEL)
	);	
	/*
	ISSP_CHSEL ISSP_CHSEL(
		.probe(ADC_CHSEL)
		);
	*/

	adc128s022 adc128s022(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Channel(ADC_CHSEL),
		.Data(Data),
		.En_Conv(1'b1),
		.Conv_Done(Conv_Done),
		.ADC_State(),
		.DIV_PARAM(8'd13),
		.ADC_SCLK(ADC_SCLK),
		.ADC_DOUT(ADC_DOUT),
		.ADC_DIN(ADC_DIN),
		.ADC_CS_N(ADC_CS_N)
	);
	/*
	ISSP_ADC ISSP_ADC(
		.probe(Data)
		);
		*/
   //将ADC的10bit输出转换为实际电压值
	Hex_to_V Hex_to_V(
			.Clk(Clk),
			.Rst_n(Rst_n),
			.ADC_flag(Conv_Done),
			.Hex_data(Data),
			.Voltage(Voltage)
			);
	/*	
	ISSP_V ISSP_V(
		.probe(Voltage)
		);	
	*/
	//将实际电压值转换为BCD码格式
	Binary_to_BCD Binary_to_BCD(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.Do_Translate(1'b1),
		.Bin(Voltage),
		.Bcd(Voltage_BCD),
		.Done_Sig()
	);
	/*
	ISSP_HEX ISSP_HEX(
		.probe(disp_data)
		);
		*/
		
	/*此处编码d对应字符“H”的断码，编码e对应灭的状态，具体可见HEX8文件中86、87行*/
	assign disp_data = {4'hC,4'hd,{1'b0,ADC_CHSEL},4'he,Voltage_BCD};

	HEX_top HEX_top(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.disp_data(disp_data),//Voltage_BCD 
		.SH_CP(SH_CP),
		.ST_CP(ST_CP),
		.DS(DS)
	);


endmodule 