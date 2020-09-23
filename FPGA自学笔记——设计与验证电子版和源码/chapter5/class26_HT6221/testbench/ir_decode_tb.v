`timescale 1ns/1ns

`define clk_period 20

module ir_decode_tb;
	
	reg Clk;
	reg Rst_n;
	reg iIR;
	
	wire Get_Flag;
	wire [15:0]irData;
	wire [15:0]irAddr;
	
	integer i;

	ir_decode ir_decode(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.iIR(iIR),
		
		.Get_Flag(Get_Flag),
		.irData(irData),
		.irAddr(irAddr)
	);
	
	initial Clk = 1'b1;
	always#(`clk_period/2)Clk = ~Clk;

	initial begin
		Rst_n = 1'b0;
		iIR = 1'b1;
		#(`clk_period*10+1'b1);
		Rst_n = 1'b1;
		#2000;
		iIR = 1'b1;
		send_data(1,8'h12);
		#60000000;
		send_data(3,8'heb);
		#60000000;
		$stop	;
	end


	
	task send_data;
		input [15:0]addr;
		input [7:0]data;
		begin
			iIR = 0;#9000000;
			iIR = 1;#4500000;
			for(i=0;i<=15;i=i+1)begin
				bit_send(addr[i]);		
			end
			for(i=0;i<=7;i=i+1)begin
				bit_send(data[i]);		
			end
			for(i=0;i<=7;i=i+1)begin
				bit_send(~data[i]);		
			end
			iIR = 0;#560000;
			iIR = 1;		
		end
	endtask
	
	task bit_send;
		input one_bit;
		begin
			iIR = 0; #560000;
			iIR = 1;
			if(one_bit)
				#1690000;
			else
				#560000;
		end	
	endtask

endmodule
