module CTRL(
	Clk,
	Rst_n,
	Key_flag,
	Key_state,
	Rx_Done,
	Tx_Done,
	rdaddress,
	wraddress,
	wren,
	Send_en
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
