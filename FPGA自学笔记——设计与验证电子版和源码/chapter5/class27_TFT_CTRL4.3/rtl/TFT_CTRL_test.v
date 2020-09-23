module TFT_CTRL_test(
	Clk, 	//50MHZ时钟
	Rst_n,
	TFT_RGB,//TFT数据输出
	TFT_HS,	//TFT行同步信号
	TFT_VS,	//TFT场同步信号
	TFT_CLK,
	TFT_DE,
	TFT_PWM
);

	input Clk;
	input Rst_n;
	output [15:0]TFT_RGB;
	output TFT_HS;
	output TFT_VS;
	output TFT_CLK;
	output TFT_DE;
	output TFT_PWM;
	
	reg [15:0]disp_data;
	wire [9:0]hcount;
	wire [9:0]vcount;
	wire Clk9M;
	
	TFT_test_pll TFT_test_pll(
		.inclk0(Clk),
		.c0(Clk9M)
	);
	
	
	TFT_CTRL TFT_CTRL(
		.Clk9M(Clk9M),	//系统输入时钟9MHZ
		.Rst_n(Rst_n),
		.data_in(disp_data),	//待显示数据
		.hcount(hcount),		//TFT行扫描计数器
		.vcount(vcount),		//TFT场扫描计数器
		.TFT_RGB(TFT_RGB),	//TFT数据输出
		.TFT_HS(TFT_HS),		//TFT行同步信号
		.TFT_VS(TFT_VS),		//TFT场同步信号
		.TFT_CLK(TFT_CLK),
		.TFT_DE(TFT_DE),
		.TFT_PWM(TFT_PWM)
	);
	
	
//定义颜色编码
localparam 
	BLACK		= 16'h0000, //黑色
	BLUE		= 16'h001F, //蓝色
	RED		= 16'hF800, //红色
	PURPPLE	= 16'hF81F, //紫色
	GREEN		= 16'h07E0, //绿色
	CYAN		= 16'h07FF, //青色
	YELLOW	= 16'hFFE0, //黄色
	WHITE		= 16'hFFFF; //白色
	
//定义每个像素块的默认显示颜色值
localparam 
	R0_C0 = BLACK,	//第0行0列像素块
	R0_C1 = BLUE,	//第0行1列像素块
	R1_C0 = RED,	//第1行0列像素块
	R1_C1 = PURPPLE,//第1行1列像素块
	R2_C0 = GREEN,	//第2行0列像素块
	R2_C1 = CYAN,	//第2行1列像素块
	R3_C0 = YELLOW,	//第3行0列像素块
	R3_C1 = WHITE;	//第3行1列像素块

	wire R0_act = vcount >= 0 && vcount < 68;	//正在扫描第0行
	wire R1_act = vcount >= 68 && vcount < 136;//正在扫描第1行
	wire R2_act = vcount >= 136 && vcount < 204;//正在扫描第2行
	wire R3_act = vcount >= 204 && vcount < 272;//正在扫描第3行
	
	wire C0_act = hcount >= 0 && hcount < 240; //正在扫描第0列
	wire C1_act = hcount >= 240 && hcount < 480;//正在扫描第1列 
	
	wire R0_C0_act = R0_act & C0_act;	//第0行0列像素块处于被扫描中标志信号
	wire R0_C1_act = R0_act & C1_act;	//第0行1列像素块处于被扫描中标志信号
	wire R1_C0_act = R1_act & C0_act;	//第1行0列像素块处于被扫描中标志信号
	wire R1_C1_act = R1_act & C1_act;	//第1行1列像素块处于被扫描中标志信号
	wire R2_C0_act = R2_act & C0_act;	//第2行0列像素块处于被扫描中标志信号
	wire R2_C1_act = R2_act & C1_act;	//第2行1列像素块处于被扫描中标志信号
	wire R3_C0_act = R3_act & C0_act;	//第3行0列像素块处于被扫描中标志信号
	wire R3_C1_act = R3_act & C1_act;	//第3行1列像素块处于被扫描中标志信号
	
	always@(*)
		case({R3_C1_act,R3_C0_act,R2_C1_act,R2_C0_act,
				R1_C1_act,R1_C0_act,R0_C1_act,R0_C0_act})
			8'b0000_0001:disp_data = R0_C0;
			8'b0000_0010:disp_data = R0_C1;
			8'b0000_0100:disp_data = R1_C0;
			8'b0000_1000:disp_data = R1_C1;
			8'b0001_0000:disp_data = R2_C0;
			8'b0010_0000:disp_data = R2_C1;
			8'b0100_0000:disp_data = R3_C0;
			8'b1000_0000:disp_data = R3_C1;
			default:disp_data = R0_C0;
		endcase
		
endmodule
