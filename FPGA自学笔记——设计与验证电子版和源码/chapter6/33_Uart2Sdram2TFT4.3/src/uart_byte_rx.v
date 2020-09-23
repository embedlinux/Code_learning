/***************************************************
*	Module Name		:	uart_byte_rx		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  串口接收模块
**************************************************/
module uart_byte_rx(
	Clk,
	Rst_n,
	Rs232_rx,
	Baud_set,

	Data_byte,
	Rx_done
);

	input Clk;
	input Rst_n;
	input Rs232_rx;
	input [2:0]Baud_set;

	output reg [7:0]Data_byte;
	output reg Rx_done;
	
	reg s0_Rs232_rx, s1_Rs232_rx;    //同步寄存器
	reg tmp0_Rs232_rx, tmp1_Rs232_rx;//数据寄存器
	
	reg [15:0]bps_DR; //分频计数器计数最大值
	reg [15:0]div_cnt;//分频计数器计数
	reg bps_clk;      //采样的频率，所选波特率的16倍
	reg [7:0]bps_cnt; //采样次数计数器
	reg uart_state;   //串口传输状态，1为忙，0为空闲	
	
	reg rx_done_r;       //接收完成寄存器
	wire ndge;
	wire error_start;  //错误开始的标志位
	
	//同步寄存器
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		s0_Rs232_rx <= 1'b0;
		s1_Rs232_rx <= 1'b0;
	end
	else begin
		s0_Rs232_rx <= Rs232_rx;
		s1_Rs232_rx <= s0_Rs232_rx;
	end
	
	//数据寄存器
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		tmp0_Rs232_rx <= 1'b0;
		tmp1_Rs232_rx <= 1'b0;
	end
	else begin
		tmp0_Rs232_rx <= s1_Rs232_rx;
		tmp1_Rs232_rx <= tmp0_Rs232_rx;
	end
	
	assign ndge = !tmp0_Rs232_rx & tmp1_Rs232_rx;
	
	//波特率查找表
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		bps_DR = 16'd324;
	else begin
		case(Baud_set)
			3'd0:bps_DR = 16'd324; //波特率9600*16
			3'd1:bps_DR = 16'd162; //波特率19200*16
			3'd2:bps_DR = 16'd80;  //波特率38400*16
			3'd3:bps_DR = 16'd53;  //波特率57600*16
			3'd4:bps_DR = 16'd26;  //波特率115200*16
			3'd5:bps_DR = 16'd1;   //波特率1562500*16
			default:bps_DR = 16'd324;	
		endcase
	end
	
	//分频计数器的实现
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		div_cnt <= 16'd0;
	else if(!uart_state)
		div_cnt <= 16'd0;
	else if(div_cnt == bps_DR)
		div_cnt <= 16'd0;
	else	
		div_cnt <= div_cnt + 16'b1;		
	
	//波特率的产生
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		bps_clk <= 1'b0;
	else if(div_cnt == 16'b1)
		bps_clk <= 1'b1;
	else	
		bps_clk <= 1'b0;
		
	//数据传输状态的判断
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		uart_state <= 1'b0;
	else if(ndge)
		uart_state <= 1'b1;
	else if(Rx_done || error_start)
		uart_state <= 1'b0;
	else
		uart_state <= uart_state;	
	
	//数据传输计数器bps_cnt
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		bps_cnt <= 8'b0;
	else if(bps_cnt == 8'd159 || error_start)
		bps_cnt <= 8'b0;
	else if(bps_clk)	
		bps_cnt <= bps_cnt + 8'b1;
	else
		bps_cnt <= bps_cnt;
		
	//一次数据传送完成输出位rx_done_r
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		rx_done_r <= 1'b0;
	else if(bps_cnt == 8'd159)
		rx_done_r <= 1'b1;
	else 
		rx_done_r <= 1'b0;	
		
	reg [2:0]r_Data_byte[7:0];
	reg [7:0]tmp_Data_byte;
	reg [2:0]START_BIT;
	reg [2:0]STOP_BIT;
	
	//数据采样, 每个波特率中采集16次，但只记录中间的6次，并将6次记录的数据累加
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		START_BIT <= 3'd0;
		r_Data_byte[0] <= 3'd0;
		r_Data_byte[1] <= 3'd0;
		r_Data_byte[2] <= 3'd0;
		r_Data_byte[3] <= 3'd0;
		r_Data_byte[4] <= 3'd0;
		r_Data_byte[5] <= 3'd0;
		r_Data_byte[6] <= 3'd0;
		r_Data_byte[7] <= 3'd0;	
		STOP_BIT <= 3'd0;
	end
	else if(bps_clk)begin
		case(bps_cnt)
		0:begin
			START_BIT <= 3'd0;
			r_Data_byte[0] <= 3'd0;
			r_Data_byte[1] <= 3'd0;
			r_Data_byte[2] <= 3'd0;
			r_Data_byte[3] <= 3'd0;
			r_Data_byte[4] <= 3'd0;
			r_Data_byte[5] <= 3'd0;
			r_Data_byte[6] <= 3'd0;
			r_Data_byte[7] <= 3'd0;
			STOP_BIT <= 3'd0;
		end
		5,  6,  7,  8,  9,  10: START_BIT <= START_BIT + s1_Rs232_rx;
		21, 22, 23, 24, 25, 26: r_Data_byte[0] <= r_Data_byte[0] + s1_Rs232_rx;
		37, 38, 39, 40, 41, 42: r_Data_byte[1] <= r_Data_byte[1] + s1_Rs232_rx;
		53, 54, 55, 56, 57, 58: r_Data_byte[2] <= r_Data_byte[2] + s1_Rs232_rx;
		69, 70, 71, 72, 73, 74: r_Data_byte[3] <= r_Data_byte[3] + s1_Rs232_rx;
		85, 86, 87, 88, 89, 90: r_Data_byte[4] <= r_Data_byte[4] + s1_Rs232_rx;
		101,102,103,104,105,106:r_Data_byte[5] <= r_Data_byte[5] + s1_Rs232_rx;
		117,118,119,120,121,122:r_Data_byte[6] <= r_Data_byte[6] + s1_Rs232_rx;
		133,134,135,136,137,138:r_Data_byte[7] <= r_Data_byte[7] + s1_Rs232_rx;
		149,150,151,152,153,154:STOP_BIT <= STOP_BIT + s1_Rs232_rx;
		default:begin
			START_BIT <= START_BIT;
			r_Data_byte[0] <= r_Data_byte[0];
			r_Data_byte[1] <= r_Data_byte[1];
			r_Data_byte[2] <= r_Data_byte[2];
			r_Data_byte[3] <= r_Data_byte[3];
			r_Data_byte[4] <= r_Data_byte[4];
			r_Data_byte[5] <= r_Data_byte[5];
			r_Data_byte[6] <= r_Data_byte[6];
			r_Data_byte[7] <= r_Data_byte[7];
			STOP_BIT <= STOP_BIT;
		end
		endcase
	end
	
	//当检测的开始信号不是低电平时，错误开始标志置1
	assign error_start = ((bps_cnt == 8'd12) && (START_BIT > 2))?1'b1:1'b0;	
	
	//判断所传输的数据，通过比较采样的高低电平的概率来判断
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		tmp_Data_byte <= 8'b0000_0000;
	else if(bps_cnt == 8'd159)begin
		tmp_Data_byte[0] <= (r_Data_byte[0]>3);
		tmp_Data_byte[1] <= (r_Data_byte[1]>3);
		tmp_Data_byte[2] <= (r_Data_byte[2]>3);
		tmp_Data_byte[3] <= (r_Data_byte[3]>3);
		tmp_Data_byte[4] <= (r_Data_byte[4]>3);
		tmp_Data_byte[5] <= (r_Data_byte[5]>3);
		tmp_Data_byte[6] <= (r_Data_byte[6]>3);
		tmp_Data_byte[7] <= (r_Data_byte[7]>3);	
	end
	
	//数据传输完成将数据输出
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Data_byte <= 8'd0;
	else if(rx_done_r)
		Data_byte <= tmp_Data_byte;
	else
		Data_byte <= Data_byte;
		
	//数据传输完成标志位Rx_done
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Rx_done <= 1'b0;
	else if(rx_done_r)
		Rx_done <= 1'b1;
	else
		Rx_done <= 1'b0;
		
endmodule 