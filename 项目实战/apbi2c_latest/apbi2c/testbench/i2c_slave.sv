`timescale 1ns/1ps

module i2c_slave
	#(parameter DATA_WIDTH=32)
	(
	input clk,
	input scl,
	inout sda,
	input sda_master_en,

	output logic [DATA_WIDTH-1:0] data_r,//master --> slave
	output logic data_r_vld,
	input [DATA_WIDTH-1:0] data_w,
	input data_w_vld
	);

	logic sda_r;
	logic sda_neg,sda_pos;
	logic cond_end,cond_start;

	assign sda = sda_master_en ? 1'bz : 1'b0;

	always@(posedge clk)begin
		sda_r <= sda;
	end
	assign sda_neg = sda_r & ~sda;
	assign sda_pos = ~sda_r & sda;

	assign cond_start = sda_neg & scl;
	assign cond_end = sda_pos & scl;

	integer bit_index=0;

	always
	begin
		data_r_vld = 0;
		wait(cond_start);
		$display("TRANSMISSION START");
		@(posedge scl);
		while(bit_index < DATA_WIDTH)begin
			@(negedge scl);
			if (sda_master_en)begin
				@(posedge clk);
				data_r = {sda,data_r[DATA_WIDTH-1 -:DATA_WIDTH-1]};
				bit_index = bit_index+1;
				$display("Get bit%d:%d",bit_index,sda);
			end
		end
		data_r_vld = 1;
		repeat(10)
			@(posedge clk);
		data_r_vld = 0;
		$display("TRANSMISSION END");
		bit_index = 0;
	end

endmodule