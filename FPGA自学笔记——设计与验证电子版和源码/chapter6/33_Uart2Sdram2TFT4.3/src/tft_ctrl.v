/***************************************************
*	Module Name		:	tft_ctrl		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  4.3寸TFT显示屏控制器
**************************************************/
module tft_ctrl(
	Clk9M,
	Rst_n,
	Data_in,
	Hcount,
	Vcount,
	TFT_rgb,
	TFT_hs,
	TFT_vs,
	TFT_clk,
	TFT_de,
	TFT_pwm,
	TFT_begin
);

	//input port
	input        Clk9M;    //系统时钟
	input        Rst_n;    //异步复位信号
	input [15:0] Data_in;  //待显示数据

	//output port 
	output [9:0] Hcount;   //TFT行扫描计数器
	output [9:0] Vcount;   //TFT场扫描计数器
	output [15:0]TFT_rgb;  //TFT数据输出
	output       TFT_hs;   //TFT行同步信号
	output       TFT_vs;   //TFT场同步信号
	output       TFT_clk;  //TFT像素时钟
	output       TFT_de;   //TFT数据使能
	output       TFT_pwm;  //TFT背光控制
	output       TFT_begin;//TFT显示一帧图片开始标志位

	//内部寄存器定义
	reg [9:0]hcount_r;
	reg [9:0]vcount_r;
	
	//内部连线定义
	wire hcount_ov;       //行扫描计数满
	wire vcount_ov;       //场扫描计数满
	wire dat_ack;         //有效显示标定
	
	//TFT行、场扫描时序参数表
	parameter tft_hs_end = 10'd40,
	          hdat_begin = 10'd42,
				 hdat_end   = 10'd522,
				 hpixel_end = 10'd524,
				 tft_vs_end = 10'd9,
				 vdat_begin = 10'd11,
				 vdat_end   = 10'd283,
				 vline_end  = 10'd285;
				 
	assign Hcount = hcount_r - hdat_begin;
	assign Vcount = vcount_r - vdat_begin;
	
	assign TFT_clk  = Clk9M;
	assign TFT_de   = dat_ack;
	assign TFT_pwm  = Rst_n;
	
	//TFT驱动部分
	//行扫描
	always@(posedge Clk9M or negedge Rst_n)
	begin
		if(!Rst_n)
			hcount_r <= 10'd0;
		else if(hcount_ov)
			hcount_r <= 10'd0;
		else 
			hcount_r = hcount_r + 1'b1;
	end 
		
	assign hcount_ov = (hcount_r == hpixel_end);
			
	//场扫描
	always@(posedge Clk9M or negedge Rst_n)
	begin
		if(!Rst_n)
			vcount_r <= 10'd0;
		else if(hcount_ov)
		begin
			if(vcount_ov)
				vcount_r <= 10'd0;
			else 
				vcount_r <= vcount_r + 1'b1;		
		end
		else
		vcount_r <= vcount_r;	
	end 
	
	assign vcount_ov = (vcount_r == vline_end);
	
	//数据、同步信号输出
	assign dat_ack = ((hcount_r >= hdat_begin)&&(hcount_r < hdat_end))&&
	                 ((vcount_r >= vdat_begin)&&(vcount_r < vdat_end))?1'b1:1'b0;
						  
	assign TFT_hs = (hcount_r > tft_hs_end);
	assign TFT_vs = (vcount_r > tft_vs_end);
	assign TFT_rgb = dat_ack ? Data_in : 16'h0000; 

	assign TFT_begin = (hcount_r==0)&&(vcount_r==0)?1'b1:1'b0;
	
endmodule 