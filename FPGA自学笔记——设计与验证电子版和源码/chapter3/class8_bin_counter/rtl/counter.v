/***************************************************
*	Module Name		:	counter		   
*	Engineer		:	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		:	v1.0
*	Description		:   时序逻辑之计时器设计
**************************************************/

module counter(
			Clk50M,
			Rst_n,
			led
		);

	input Clk50M;	//系统时钟，50M
	input Rst_n;	//全局复位，低电平复位
	
	output reg led;	//led输出
	
	reg [24:0]cnt;	//定义计数器寄存器

    //计数器计数进程	
	always@(posedge Clk50M or negedge Rst_n)
	if(Rst_n == 1'b0)
		cnt <= 25'd0;
	else if(cnt == 25'd24_999_999)
	//else if(cnt == 25'd24_999) //仅为测试
		cnt <= 25'd0;
	else
		cnt <= cnt + 1'b1;

    //led输出控制进程
	always@(posedge Clk50M or negedge Rst_n)
	if(Rst_n == 1'b0)
		led <= 1'b1;
	else if(cnt == 25'd24_999_999)
	//else if(cnt == 25'd24_999)  //仅为测试
		led <= ~led;
	else
		led <= led;

endmodule
