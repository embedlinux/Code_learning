`timescale 1ns/1ns

`define clk_period 120

module TFT_CTRL_tb;
	//----------------模块输入端口----------------
	reg  Clk9M;          //系统输入时钟9MHZ
	reg  Rst_n;
	reg  [15:0]data_in;     //待显示数据

	//----------------模块输出端口----------------
	wire [9:0]hcount;
	wire [9:0]vcount;
	wire [15:0]TFT_RGB;  //TFT数据输出
	wire TFT_HS;           //TFT行同步信号
	wire TFT_VS;           //TFT场同步信号
	wire TFT_CLK;
	wire TFT_DE;
	wire TFT_PWM;
	
	reg [11:0]V_cnt = 0;//扫描行数统计计数器

	TFT_CTRL TFT_CTRL(
		.Clk9M(Clk9M),	//系统输入时钟9MHZ
		.Rst_n(Rst_n),
		.data_in(data_in),	//待显示数据
		.hcount(hcount),		//TFT行扫描计数器
		.vcount(vcount),		//TFT场扫描计数器
		.TFT_RGB(TFT_RGB),	//TFT数据输出
		.TFT_HS(TFT_HS),		//TFT行同步信号
		.TFT_VS(TFT_VS),		//TFT场同步信号
		.TFT_CLK(TFT_CLK),
		.TFT_DE(TFT_DE),
		.TFT_PWM(TFT_PWM)
	);
	
	initial Clk9M = 0;
	always #(`clk_period/2) Clk9M = ~Clk9M;
	
	initial begin
		Rst_n = 0;
		data_in = 16'd0;
		#(`clk_period *20 +1);
		Rst_n = 1;
		data_in = 16'hffff;
	end
	
	initial begin
		wait(V_cnt == 3);//等待扫描2帧后结束仿真
		$stop;
	end
	
	always @(posedge TFT_VS)//统计总扫描帧数
		V_cnt <= V_cnt + 1'b1;
	
endmodule
