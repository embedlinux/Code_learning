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

`timescale 1ns/1ns

module bus_arbiter(clk, 
			reset, 
			frame, 
			irdy, 
			req1, 
			req2, 
			req3, 
			gnt1, 
			gnt2, 
			gnt3);

input logic clk, reset, frame, irdy;
input logic req1, req2, req3;

output gnt1, gnt2, gnt3;

enum bit [6:0] {IDLE = 7'b0000001,
		MASTER1 = 7'b0000010,
		IDLE1 = 7'b0000100,
		MASTER2 = 7'b0001000,
		IDLE2 = 7'b0010000,
		MASTER3 = 7'b0100000,
		IDLE3 = 7'b1000000 }next, state;
logic done, gnt1, gnt2, gnt3;

integer req1_cnt = 0, req2_cnt = 0, req3_cnt = 0;
integer gnt1_cnt = 0, gnt2_cnt = 0, gnt3_cnt = 0;

/* define glue signals */

assign done = frame && irdy;

/* state register code */

always@(posedge clk or negedge reset)
begin
	if(!reset)
		state <= IDLE;
	else
		state <= next;
end

/* next state combinational logic */

always@(*)
begin
	next = IDLE;
	case(state)

	IDLE:
		if (req1 == 1'b0)
			next <= MASTER1;
		else if (req1 == 1'b1 & req2 == 1'b0)
			next <= MASTER2;
		else if (req3 == 1'b0 & req1 == 1'b1)
			next <= MASTER3;
		else
			next <= IDLE;

	MASTER1:
		if(!done)
			next <= MASTER1;
		else 
			next <= IDLE1;

	IDLE1:

		if (req2 == 1'b0 )
			next <= MASTER2;
		else if (req3 == 1'b0 & req2 == 1'b1)
			next <= MASTER3;
		else if (req3 == 1'b1 & req1 == 1'b0 & req2 == 1'b1)
			next <= MASTER1;
		else
			next <= IDLE1;

	MASTER2:
		if(!done)
			next <= MASTER2;
		else 
			next <= IDLE2;
	
	IDLE2:
		if (req3 == 1'b0)
			next <= MASTER3;
		else if (req3 == 1'b1 & req1 == 1'b0)
			next <= MASTER1;
		else if (req1 == 1'b1 & req2 == 1'b0)
			next <= MASTER2;
		else
			next <= IDLE2;

	MASTER3:
		if (!done)
			next <= MASTER3;
		else 
			next <= IDLE3;
	
	IDLE3:
		if (req1 == 1'b0)
			next <= MASTER1;
		else if (req1 == 1'b1 & req2 == 1'b0)
			next <= MASTER2;
		else if (req2 == 1'b1 & req3 == 1'b0)
			next <= MASTER3;
		else
			next <= IDLE3;
	endcase

end

/* output generating statements */

assign gnt1 = ((state == MASTER1)) ? 0 : 1;
assign gnt2 = ((state == MASTER2)) ? 0 : 1;
assign gnt3 = ((state == MASTER3)) ? 0 : 1;

endmodule	
