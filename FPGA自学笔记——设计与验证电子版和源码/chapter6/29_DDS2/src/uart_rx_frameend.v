/***************************************************
*	Module Name		:	uart_rx_frameend		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-06-25
*	Revision		   :	v1.1
*	Description		:  串口帧识别模块，根据串口数据字符间隔时间确定一帧数据是否传输完成
**************************************************/

module uart_rx_frameend(
	input Clk,
	input Rst_n,
 
	input clk_cnt_base,	//基本计数时钟，帧结束计数器计数时基
	input mode,	//模式0，使用内部1K的基准时钟，模式1，使用外部计数时钟

	input Rx_int,	//字节接收成功信号
 
	input [15:0]endtimeset, //帧结束判定时间设置
 
	output reg frameend	//帧结束标志信号	

);

	reg [15:0] cnt;	//帧结束判定计数器
	reg cnt_state;
	
	reg [15:0]internal_base_cnt;
	reg internal_base_clk;	//内部计数基准时钟
	wire base_clk; //定时器计数基准时钟
	
	//内部1KHz基准计数时钟计数器
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		internal_base_cnt <= 16'd0;
	else if(internal_base_cnt == 49_999)
		internal_base_cnt <= 16'd0;
	else
		internal_base_cnt <= internal_base_cnt + 1'd1;
	
	//	产生内部1KHz基准时钟
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		internal_base_clk <= 1'd0;
	else if(internal_base_cnt == 49_999)
		internal_base_clk <= 1'd1;
	else
		internal_base_clk <= 1'd0;	
	
//通过模式选择位选择使用内部计数基准时钟或外部计数基准时钟	
	assign base_clk = mode?clk_cnt_base:internal_base_clk;//模式0，使用内部1K的基准时钟，模式1，使用外部计数时钟

	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		cnt_state <= 1'b0;
	else if(Rx_int)	//接收到数据。开始计数
		cnt_state <= 1'd1;
	else if(frameend)	//帧超时，停止计数
		cnt_state <= 1'b0;
	
	//计数进程
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		cnt <= 16'd0;
	//接收到数据或者字节间间隔时长已达设定超时值，清零计数器
	else if(Rx_int || (base_clk && (cnt == endtimeset)))
		cnt <= 16'd0;
	else if(base_clk && cnt_state)
		cnt <= cnt + 16'd1;
		
	//字节间时间间隔时长已经达到设定值，产生帧结束信号
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		frameend <= 1'b0;
	else if(base_clk && (cnt == endtimeset))
		frameend <= 1'b1;
	else
		frameend <= 1'b0;

endmodule
