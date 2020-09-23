module counter(Clk,Rst_n,led);

	input Clk;	//系统时钟
	input Rst_n;	//全局复位，低电平复位
	
	output reg led;	//led输出
	
	reg [24:0]cnt;	//定义计数器寄存器
	
	parameter CNT_MAX = 25'd24_999_999;

//计数器计数进程	
	always@(posedge Clk or negedge Rst_n)
	if(Rst_n == 1'b0)
		cnt <= 25'd0;
	else if(cnt == CNT_MAX)
		cnt <= 25'd0;
	else
		cnt <= cnt + 1'b1;

//led输出控制进程
	always@(posedge Clk or negedge Rst_n)
	if(Rst_n == 1'b0)
		led <= 1'b1;
	else if(cnt == CNT_MAX)
		led <= ~led;
	else
		led <= led;

endmodule
