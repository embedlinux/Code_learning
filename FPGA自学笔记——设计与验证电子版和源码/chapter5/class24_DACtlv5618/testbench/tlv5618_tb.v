`timescale 1ns/1ns

module tlv5618_tb();

	reg Clk;
	reg Rst_n;
	reg [15:0]DAC_DATA;
	reg Start;
	wire Set_Done;
	
	wire DAC_CS_N;
	wire DAC_DIN;
	wire DAC_SCLK;
	
	tlv5618 tlv5618(
		.Clk(Clk),
		.Rst_n(Rst_n),
		
		.DAC_DATA(DAC_DATA),
		.Start(Start),
		.Set_Done(Set_Done),
		
		.DAC_CS_N(DAC_CS_N),
		.DAC_DIN(DAC_DIN),
		.DAC_SCLK(DAC_SCLK),
		.DAC_State()
	);

	initial Clk = 1;
	always#10 Clk = ~Clk;
	
	initial begin
		Rst_n = 0;
		Start = 0;
		DAC_DATA = 0;
		#201;
		Rst_n = 1;
		#200;
		
		DAC_DATA = 16'hC_AAA;
		Start = 1;
		#20;
		Start = 0;
		#200;
		wait(Set_Done);
		
		#20000;
		
		DAC_DATA = 16'h4_555;
		Start = 1;
		#20;
		Start = 0;
		#200;
		wait(Set_Done);
		
		#20000;	
		
		DAC_DATA = 16'h1_555;
		Start = 1;
		#20;
		Start = 0;
		#200;
		wait(Set_Done);
		#20000;
		DAC_DATA = 16'hf_555;
		Start = 1;
		#20;
		Start = 0;
		#200;
		wait(Set_Done);		
		#20000;		
		$stop;
	end
	
endmodule
