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

input clk, reset, frame, irdy;
input req1, req2, req3;

output gnt1, gnt2, gnt3;

reg [8:0] next, state;
wire done, gnt1, gnt2, gnt3;
wire req, gnt;

integer req1_cnt = 0, req2_cnt = 0, req3_cnt = 0;
integer gnt1_cnt = 0, gnt2_cnt = 0, gnt3_cnt = 0;
integer i;
reg [1:0] wait1_dly, wait2_dly, wait3_dly;
integer wd1, wd2, wd3;
integer success_count = 0;
reg areqgnt = 1'b0;
reg agntframe = 1'b1;

// SVA Checks

parameter arb_sva = 1'b1;
parameter arb_sva_severity = 1'b1;

// state definitions

parameter IDLE =    9'b000000000;
parameter WAIT1 =   9'b000000001;
parameter MASTER1 = 9'b000000010;
parameter IDLE1 =   9'b000000100;
parameter WAIT2 =   9'b000001000;
parameter MASTER2 = 9'b000010000;
parameter IDLE2 =   9'b000100000;
parameter WAIT3 =   9'b001000000;
parameter MASTER3 = 9'b010000000; 
parameter IDLE3 =   9'b100000000;

/* define glue signals */

assign done = frame && irdy;
assign req = !req1 || !req2 || !req3;
assign gnt = !gnt1 || !gnt2 || !gnt3;

/* state register code */

always@(posedge clk or negedge reset)
begin
	if(!reset)
		state <= IDLE;
	else
		state <= next;
end

/* next state combinational logic */

always@(state or frame or irdy or req1 or req2 or req3)
begin
	next = IDLE;

	case(state)

	IDLE:
		if (req1 == 1'b0)
			next <= WAIT1;
		else if (req1 == 1'b1 & req2 == 1'b0)
			next <= WAIT2;
		else if (req3 == 1'b0 & req1 == 1'b1)
			next <= WAIT3;
		else
			next <= IDLE;

	WAIT1:
		begin
		wait1_dly = $random() % 4;
		wd1 = wait1_dly;
		for(i=0; i< wd1; i++)
		begin
			next <= WAIT1;
			@(posedge clk);
		end
		next <= MASTER1;
		end
		

	MASTER1:
		if(!done)
			next <= MASTER1;
		else 
			next <= IDLE1;

	IDLE1:

		if (req2 == 1'b0 )
			next <= WAIT2;
		else if (req3 == 1'b0 & req2 == 1'b1)
			next <= WAIT3;
		else if (req3 == 1'b1 & req1 == 1'b0 & req2 == 1'b1)
			next <= WAIT1;
		else
			next <= IDLE1;

	WAIT2:
		begin
		wait2_dly = $random() % 4;
		wd2 = wait2_dly;
		for(i=0; i< wd2; i++)
		begin
			next <= WAIT2;
			@(posedge clk);
		end
		next <= MASTER2;
		end

	MASTER2:
		if(!done)
			next <= MASTER2;
		else 
			next <= IDLE2;
	
	IDLE2:
		if (req3 == 1'b0)
			next <= WAIT3;
		else if (req3 == 1'b1 & req1 == 1'b0)
			next <= WAIT1;
		else if (req1 == 1'b1 & req2 == 1'b0)
			next <= WAIT2;
		else
			next <= IDLE2;

	WAIT3:
		begin
		wait3_dly = $random() % 4;
		wd3 = wait3_dly;
		for(i=0; i< wd3; i++)
		begin
			next <= WAIT3;
			@(posedge clk);
		end
		next <= MASTER3;
		end

	MASTER3:
		if (!done)
			next <= MASTER3;
		else 
			next <= IDLE3;
	
	IDLE3:
		if (req1 == 1'b0)
			next <= WAIT1;
		else if (req1 == 1'b1 & req2 == 1'b0)
			next <= WAIT2;
		else if (req2 == 1'b1 & req3 == 1'b0)
			next <= WAIT3;
		else
			next <= IDLE3;
	endcase

end

/* output generating statements */

assign gnt1 = ((state == MASTER1)) ? 0 : 1;
assign gnt2 = ((state == MASTER2)) ? 0 : 1;
assign gnt3 = ((state == MASTER3)) ? 0 : 1;

// SVA

property p_arb_onehot0;
	@(posedge clk) $onehot0(state);
endproperty

property p_req_gnt;
	@(posedge clk) $rose(req) |-> ##[2:5] $rose(gnt);
endproperty

property p_gnt_frame;
	@(posedge clk) $rose(gnt) |-> $fell(frame && irdy);
endproperty

property p_frame_gnt;
	@(posedge clk) $rose(frame && irdy) |=> $fell(gnt);
endproperty

always@(posedge clk)
begin
if(arb_sva)
begin

a_arb_onehot0: assert property(p_arb_onehot0) else 
			if(arb_sva_severity) $fatal; 
a_req_gnt: assert property(p_req_gnt) else 
			if(arb_sva_severity) $fatal; 
a_gnt_frame : assert property(p_gnt_frame) else 
			if(arb_sva_severity) $fatal; 
a_frame_gnt: assert property(p_frame_gnt) else 
			if(arb_sva_severity) $fatal;
/* 
c_arb_onehot0: cover property(p_arb_onehot0);
c_req_gnt: cover property(p_req_gnt);
c_gnt_frame: cover property(p_gnt_frame);
c_frame_gnt: cover property(p_frame_gnt);
*/
end
end

endmodule	
