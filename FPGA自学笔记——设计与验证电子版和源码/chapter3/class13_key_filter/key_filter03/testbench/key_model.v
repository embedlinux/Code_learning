`timescale 1ns/1ns

module key_model(key);

	output reg key;
	
	reg [15:0]myrand;
	
	initial begin
		key = 1'b1;
			press_key;
			#10000;
			press_key;
			#10000;
			press_key;
			#10000;
			$stop;
	end
	
	task press_key;
		begin
			repeat(50)begin
				myrand = {$random}%65536;//0~65535;
				#myrand key = ~key;			
			end
			key = 0;
			#25000000;
			
			repeat(50)begin
				myrand = {$random}%65536;//0~65535;
				#myrand key = ~key;			
			end
			key = 1;
			#25000000;		
		end	
	endtask

endmodule
