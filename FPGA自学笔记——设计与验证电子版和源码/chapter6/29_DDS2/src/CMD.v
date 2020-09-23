/***************************************************
*	Module Name		:	uart_rx_frameend		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-06-25
*	Revision		   :	v1.1
*	Description		:  串口数据接收与命令解析模块
*  
**************************************************/

module CMD(
Clk,
Rst_n,
Rx_Byte,
Rx_Int,
Fword0,Fword1,	//频率控制字
Pword0,Pword1,	//相位控制字
Aword0,Aword1,		//幅度控制字
CH_Sync
);

	input Clk;
	input Rst_n;
	
	input [7:0]Rx_Byte;	/*串口接收模块接收到的数据字节*/
	input Rx_Int;	/*串口接收模块接收到数据标志*/
	output reg [31:0]Fword0,Fword1;	//频率控制字
	output reg [11:0]Pword0,Pword1;	//相位控制字
	output reg [3:0]Aword0,Aword1;		//幅度控制字
	output reg [1:0]CH_Sync;

	reg [31:0]s_Fword0,s_Fword1;	//频率控制字影子寄存器
	reg [11:0]s_Pword0,s_Pword1;	//相位控制字影子寄存器
	reg [3:0]s_Aword0,s_Aword1;		//幅度控制字影子寄存器
	
	wire frameend;
	reg [3:0]data_cnt;

	localparam 
		Header0 = 8'hAA,	/*帧头0*/
		Header1 = 8'd03,		/*帧头1*/
		Tail   = 8'h88;	/*帧尾*/
		
	reg [63:0]shift_data;
	reg clr;
	
	//移位寄存数据，接收串口发送的数据并存入移位寄存器中
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		shift_data <= 64'd0;
	else if(clr)
		shift_data <= 64'd0;
	else if(Rx_Int)
		shift_data <= {Rx_Byte,shift_data[63:8]};
	
	//计数接收到的数据总数
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		data_cnt <= 4'd0;
	else if(clr)
		data_cnt <= 4'd0;
	else if(Rx_Int)
		data_cnt <= data_cnt + 1'b1;

//帧结束判定模块，frameend产生一个高脉冲提示当前帧结束		
	uart_rx_frameend uart_rx_frameend(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.clk_cnt_base(1'b0),	//基本计数时钟，帧结束计数器计数时基
		.mode(1'b0),
		.Rx_int(Rx_Int),	//字节接收成功信号
		.endtimeset(4'd5), //帧结束判定时间设置
		.frameend(frameend)	//帧结束标志信号	
	);

	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin	
		Fword0 <= 0; Fword1 <= 0; Pword0 <= 0; Pword1 <= 0;
		Aword0 <= 0; Aword1 <= 0; s_Fword0 <= 0; s_Fword1 <= 0;
		s_Pword0 <= 0; s_Pword1 <= 0; s_Aword0 <= 0; s_Aword1 <= 0;
		CH_Sync <= 2'b00; clr <= 1'b0;
	end
	else if(frameend)begin //帧结束，将接收到的数据提取出来，根据其中的地址段和数据段，写数据到对应寄存器
		clr <= 1'b1;
		if((data_cnt == 8) && (shift_data[7:0] == Header0) && (shift_data[15:8] == Header1) && (shift_data[63:56] == Tail))begin
			case(shift_data[23:16])
				8'h10:Fword0 <= shift_data[55:24];
				8'h11:Fword1 <= shift_data[55:24];
				
				8'h12:Pword0 <= shift_data[35:24];
				8'h13:Pword1 <= shift_data[35:24];
				
				8'h14:Aword0 <= shift_data[27:24];
				8'h15:Aword1 <= shift_data[27:24];
				
				8'h00:s_Fword0 <= shift_data[55:24];
				8'h01:s_Fword1 <= shift_data[55:24];

				8'h02:s_Pword0 <= shift_data[35:24];
				8'h03:s_Pword1 <= shift_data[35:24];

				8'h04:s_Aword0 <= shift_data[27:24];
				8'h05:s_Aword1 <= shift_data[27:24];
				
				8'h06:CH_Sync <= shift_data[25:24];
				
				8'h07:begin
					
					Fword0 <= shift_data[24]?s_Fword0:Fword0;
					Fword1 <= shift_data[25]?s_Fword1:Fword1;
								
					Pword0 <= shift_data[26]?s_Pword0:Pword0;
					Pword1 <= shift_data[27]?s_Pword1:Pword1;
								
					Aword0 <= shift_data[28]?s_Aword0:Aword0;
					Aword1 <= shift_data[29]?s_Aword1:Aword1;	
				end
				default:;
			endcase
		end
	end
	else
		clr <= 1'b0;
		
endmodule
