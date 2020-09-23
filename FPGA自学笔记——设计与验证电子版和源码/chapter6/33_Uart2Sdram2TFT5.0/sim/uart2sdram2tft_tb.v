`timescale 1ns/1ns
`define CLK_PERIOD 20

module uart2sdram2tft_tb;

`include   "../src/Sdram_Params.h"

localparam Baud_set = 3'd5;  //设置波特率，设置为1562500
localparam Img_H    = 200;   //设置图片宽度
localparam Img_V    = 5;     //设置图片高度

	reg               Clk50M;
	reg               Rst_n; 
	
	wire              Uart_rx;
	
	reg               tx_en;
	reg [7:0]         tx_data;
	wire              tx_done;

	wire[`ASIZE-1:0]  Sa;
	wire[`BSIZE-1:0]  Ba;
	wire              Cs_n;
	wire              Cke;
	wire              Clk;
	wire              Ras_n;
	wire              Cas_n;
	wire              We_n;
	wire[`DSIZE-1:0]  Dq;
	wire[`DSIZE/8-1:0]Dqm;
	
	wire [15:0]       TFT_rgb;
	wire              TFT_hs;
	wire              TFT_vs;
	wire              TFT_clk;
	wire              TFT_de;
	wire              TFT_pwm;
	
	uart_byte_tx uart_byte_tx(
		.Clk(Clk50M), 
		.Rst_n(Rst_n), 
		.send_en(tx_en),
		.baud_set(Baud_set),
		.Data_Byte(tx_data),

		.Rs232_Tx(Uart_rx),
		.Tx_Done(tx_done),
		.uart_state()
	);

	uart2sdram2tft 
	#(.Baud_set(Baud_set),
	  .img_h(Img_H),
	  .img_v(Img_V)
	 )
	uart2sdram2tft(
		.Clk50M(Clk50M),
		.Rst_n(Rst_n),
		
		.Uart_rx(Uart_rx),
		
		.Sd_Sa(Sa),
		.Sd_Ba(Ba),
		.Sd_Cs_n(Cs_n),
		.Sd_Cke(Cke),
		.Sd_Clk(Clk),
		.Sd_Ras_n(Ras_n),
		.Sd_Cas_n(Cas_n),
		.Sd_We_n(We_n),
		.Sd_Dq(Dq),
		.Sd_Dqm(Dqm),
		
		.TFT_rgb(TFT_rgb),
		.TFT_hs(TFT_hs),       
		.TFT_vs(TFT_vs),       
		.TFT_clk(TFT_clk),      
		.TFT_de(TFT_de),       
		.TFT_pwm(TFT_pwm)
	);

	//SDRAM模型例化
	sdr sdram_model(
		.Dq(Dq), 
		.Addr(Sa), 
		.Ba(Ba), 
		.Clk(Clk), 
		.Cke(Cke), 
		.Cs_n(Cs_n), 
		.Ras_n(Ras_n), 
		.Cas_n(Cas_n), 
		.We_n(We_n), 
		.Dqm(Dqm)
	);
	
	//系统时钟信号
	initial Clk50M = 1'b1;
	always #(`CLK_PERIOD/2) Clk50M = ~Clk50M;
	
	initial
	begin
		Rst_n     = 0;
		tx_en     = 0;
		tx_data   = 0;		
		#(`CLK_PERIOD*200+1)
		Rst_n     = 1;		
		
		//等待初始化完成
		@(posedge uart2sdram2tft.sdram.sdram_control.init_done)
		#2000;
		
		//串口传输400个数据
		repeat(Img_H*Img_V*2)begin
		tx_en   = 1;
		tx_data = tx_data + 1;
		#(`CLK_PERIOD)
		tx_en   = 0;
		@(posedge tx_done);
		#20;
		end
		
		//等待图片可显示状态到来
		@(posedge uart2sdram2tft.disp_state);		
		@(posedge uart2sdram2tft.TFT_vs);
		@(posedge uart2sdram2tft.TFT_de);
		
		#50000;
		$stop;
	end

endmodule 