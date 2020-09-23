/***************************************************
*	Module Name		:	DAC_test		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  DAC TLV5618测试顶层
**************************************************/

module DAC_test(
			Clk,   //模块时钟50M
			Rst_n, //模块复位
			
			DAC_CS_N,  //TLV5618的CS_N接口
			DAC_DIN,   //TLV5618的DIN接口
			DAC_SCLK   //TLV5618的SCLK接口
		);
	input Clk;
	input Rst_n;
	
	output DAC_CS_N;
	output DAC_DIN;
	output DAC_SCLK;
	
	reg Start;
	reg [15:0]r_DAC_DATA;
	wire DAC_State;
	wire [15:0]DAC_DATA;
	wire Set_Done;
	
	ISSP ISSP(
		.probe(),
		.source(DAC_DATA)
	);

	tlv5618 tlv5618(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.DAC_DATA(DAC_DATA),
		.Start(Start),
		.Set_Done(Set_Done),
		
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

endmodule
