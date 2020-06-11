/************************************************************************\
|*                                                                      *|
|*    Copyright (c) 2005  Springer. All rights reserved.                *|
|*                                                                      *|
|*  This example code shouyld be used only for illustration purpose     *| 
|*  This material is not to reproduced,  copied,  or used  in any       *|
|*  manner without the authorization of the author's/publishers         *|
|*  written permission                                                  *|
|*                                                                      *|
\************************************************************************/

// Author: Srikanth Vijayaraghavan and Meyyappan Ramanathan


module encoder(clk, reset_, wr, do0, do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do18,do19,do20,do21,do22,do23,do24,do25,do26,do27,do28,do29,do30,do31,do32,do33,do34,do35,do36,do37,do38,do39,do40,do41,do42,do43,do44,do45,do46,do47,do48,do49,do50,do51,do52,do53,do54,do55,do56,do57,do58,do59,do60,do61,do62,do63);

input logic signed [DATA_WIDTH-1:0] do0, do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do18,do19,do20,do21,do22,do23,do24,do25,do26,do27,do28,do29,do30,do31,do32,do33,do34,do35,do36,do37,do38,do39,do40,do41,do42,do43,do44,do45,do46,do47,do48,do49,do50,do51,do52,do53,do54,do55,do56,do57,do58,do59,do60,do61,do62,do63;

input logic clk;
input logic reset_;
input logic wr;
//output logic done_frame;
logic done_frame;

logic [DATA_WIDTH-1:0] mem [262143:0];

logic [ADDR_WIDTH-1:0] addr = 0;

//assign addr = (!reset_ || done_frame) ? 'd0 : (wr == 1) ? addr+'d64 : addr;

always @(posedge clk)
begin
	if (reset_ && wr)
	begin
		mem[addr+6'd0] <= do0;	
		mem[addr+6'd1] <= do1;	
		mem[addr+6'd2] <= do2;	
		mem[addr+6'd3] <= do3;	
		mem[addr+6'd4] <= do4;	
		mem[addr+6'd5] <= do5;	
		mem[addr+6'd6] <= do6;	
		mem[addr+6'd7] <= do7;	
		mem[addr+6'd8] <= do8;	
		mem[addr+6'd9] <= do9;	
		mem[addr+6'd10] <= do10;	
		mem[addr+6'd11] <= do11;	
		mem[addr+6'd12] <= do12;	
		mem[addr+6'd13] <= do13;	
		mem[addr+6'd14] <= do14;	
		mem[addr+6'd15] <= do15;	
		mem[addr+6'd16] <= do16;	
		mem[addr+6'd17] <= do17;	
		mem[addr+6'd18] <= do18;	
		mem[addr+6'd19] <= do19;	
		mem[addr+6'd20] <= do20;	
		mem[addr+6'd21] <= do21;	
		mem[addr+6'd22] <= do22;	
		mem[addr+6'd23] <= do23;	
		mem[addr+6'd24] <= do24;	
		mem[addr+6'd25] <= do25;	
		mem[addr+6'd26] <= do26;	
		mem[addr+6'd27] <= do27;	
		mem[addr+6'd28] <= do28;	
		mem[addr+6'd29] <= do29;	
		mem[addr+6'd30] <= do30;	
		mem[addr+6'd31] <= do31;	
		mem[addr+6'd32] <= do32;	
		mem[addr+6'd33] <= do33;	
		mem[addr+6'd34] <= do34;	
		mem[addr+6'd35] <= do35;	
		mem[addr+6'd36] <= do36;	
		mem[addr+6'd37] <= do37;	
		mem[addr+6'd38] <= do38;	
		mem[addr+6'd39] <= do39;	
		mem[addr+6'd40] <= do40;	
		mem[addr+6'd41] <= do41;	
		mem[addr+6'd42] <= do42;	
		mem[addr+6'd43] <= do43;	
		mem[addr+6'd44] <= do44;	
		mem[addr+6'd45] <= do45;	
		mem[addr+6'd46] <= do46;	
		mem[addr+6'd47] <= do47;	
		mem[addr+6'd48] <= do48;	
		mem[addr+6'd49] <= do49;	
		mem[addr+6'd50] <= do50;	
		mem[addr+6'd51] <= do51;	
		mem[addr+6'd52] <= do52;	
		mem[addr+6'd53] <= do53;	
		mem[addr+6'd54] <= do54;	
		mem[addr+6'd55] <= do55;	
		mem[addr+6'd56] <= do56;	
		mem[addr+6'd57] <= do57;	
		mem[addr+6'd58] <= do58;	
		mem[addr+6'd59] <= do59;	
		mem[addr+6'd60] <= do60;	
		mem[addr+6'd61] <= do61;	
		mem[addr+6'd62] <= do62;	
		mem[addr+6'd63] <= do63;	
		addr <= (done_frame) ? 0 : addr + 64;
		$display ( "The address is %d", addr);
	end
end

assign done_frame = (addr == 18'd262143) ? 1'b1 : 1'b0;

 	

endmodule
