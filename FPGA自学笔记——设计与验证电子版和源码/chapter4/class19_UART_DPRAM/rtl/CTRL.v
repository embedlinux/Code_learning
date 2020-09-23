/***************************************************
*	Module Name		:	UART_DPRAM		   
*	Engineer		   :	小梅哥
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2017-3-31
*	Revision		   :	v1.0
*	Description		:  串口收发与双端口RAM顶层设计
**************************************************/

module CTRL(
	Clk,       //时钟输入50M
	Rst_n,     //模块复位
	Key_flag,  //按键标志信号
	Key_state, //按键状态信号
	Rx_Done,   //一次数据接收完成标志
	Tx_Done,   //一次数据发送完成标志
	rdaddress, //读地址
	wraddress, //写地址
	wren,      //写使能
	Send_en    //发送使能
);	

	input Clk;
	input Rst_n;
	input Key_flag;
	input Key_state;
	input Rx_Done;
	input Tx_Done;
	output reg[7:0]rdaddress;
	output reg[7:0]wraddress;
	output wren;
	output reg Send_en;
	
	assign wren = Rx_Done;
	
	reg do_send;	//
	reg r0_send_done,r1_send_done;
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		wraddress <= 8'd0;
	else if(Rx_Done)
		wraddress <= wraddress + 1'b1;
	else
		wraddress <= wraddress;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		do_send <= 1'd0;
	else if(Key_flag && !Key_state)
		do_send <= ~do_send;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)	
		rdaddress <= 8'd0;
	else if(do_send && Tx_Done)
		rdaddress <= rdaddress + 8'd1;
	else
		rdaddress <= rdaddress;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		r0_send_done <= 1'b0;
		r1_send_done <= 1'b0;
	end
	else begin
		r0_send_done <= (do_send && Tx_Done);
		r1_send_done <= r0_send_done;	
	end
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Send_en <= 1'b0;
	else if(Key_flag && !Key_state)
		Send_en <= 1'b1;
	else if(r1_send_done)
		Send_en <= 1'b1;
	else
		Send_en <= 1'b0;

endmodule
