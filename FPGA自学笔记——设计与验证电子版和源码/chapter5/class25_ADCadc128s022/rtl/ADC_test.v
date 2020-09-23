/***************************************************
*	Module Name		:	ADC_test		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  ADC 测试顶层
**************************************************/
module ADC_test(
			Clk,
			Rst_n,
			ADC_SCLK,
			ADC_DOUT,
			ADC_DIN,
			ADC_CS_N,	
			DAC_CS_N,
			DAC_DIN,
			DAC_SCLK
		);

	input Clk;	//输入时钟
	input Rst_n; //复位输入，低电平复位

	output DAC_CS_N;
	output DAC_DIN;
	output DAC_SCLK;	
	
	input   ADC_DOUT;	 //ADC转换结果，由ADC输给FPGA
	output  ADC_SCLK;	 //ADC 串行数据接口时钟信号
	output  ADC_CS_N;  //ADC 串行数据接口使能信号
	output  ADC_DIN;	 //ADC控制信号输出，由FPGA发送通道控制字给ADC	
		
	wire [11:0] ADC_Data;
	wire [2:0] ADC_Channel;
	wire Conv_Done;	
	wire [15:0] DAC_DATA;
	reg [15:0]r_DAC_DATA;
	reg Start;
	wire DAC_State;

	
	ISSP_DAC ISSP_DAC(
		.source(DAC_DATA)
		);
	
	tlv5618 tlv5618(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.DAC_DATA(DAC_DATA),
		.Start(Start),
		.Set_Done(),
		
		.DAC_CS_N(DAC_CS_N),
		.DAC_DIN(DAC_DIN),
		.DAC_SCLK(DAC_SCLK),
		.DAC_State(DAC_State)
	);
	
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		r_DAC_DATA <= 16'd0;
	else if(DAC_State)
		r_DAC_DATA <= DAC_DATA;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Start <= 1'd0;
	else if(r_DAC_DATA != DAC_DATA) 
		Start <= 1'b1;
	else
		Start <= 1'd0;

	ISSP_ADC ISSP_ADC (
		.source (ADC_Channel), // sources.source
		.probe  (ADC_Data)   //  probes.probe
	);
	adc128s022 adc128s022(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.Channel(ADC_Channel),
		.Data(ADC_Data),
		
		.En_Conv(Conv_Done),
		.Conv_Done(),
		.ADC_State(Conv_Done),
		.DIV_PARAM(8'd13),
		
		.ADC_SCLK(ADC_SCLK),
		.ADC_DOUT(ADC_DOUT),
		.ADC_DIN(ADC_DIN),
		.ADC_CS_N(ADC_CS_N)
	);



endmodule 