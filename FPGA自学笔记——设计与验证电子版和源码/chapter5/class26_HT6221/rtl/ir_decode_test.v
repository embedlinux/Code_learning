/***************************************************
*	Module Name		:	ir_decode_test		   
*	Engineer		:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		:	v1.0
*	Description		:   红外遥控解码测试顶层文件
**************************************************/
module ir_decode_test(
			Clk,      //系统时钟
			Rst_n,    //系统复位
			
			iIR,      //红外输入
			
			Get_Flag, //一次解码完成标志
			irData,   //解码数据
			irAddr    //解码地址
		);

	input Clk;
	input Rst_n;
	input iIR;
	
	output Get_Flag;
	output [15:0]irData;
	output [15:0]irAddr;
	
	ir_decode ir_decode(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.iIR(iIR),
		
		.Get_Flag(Get_Flag),
		.irData(irData),
		.irAddr(irAddr)
	);
	
	ISSP issp(
		.probe({irData,irAddr}),
		.source()
	);

endmodule
