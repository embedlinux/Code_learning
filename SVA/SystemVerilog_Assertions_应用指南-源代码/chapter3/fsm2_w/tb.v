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


`define PERIOD 25

module tb;

integer i;

wire gnt1, gnt2, gnt3; 
wire req1, req2, req3;
wire frame1, frame2, frame3;
wire irdy1, irdy2, irdy3;

reg [2:0] ask;
wire gnt;
wire bus_is_free;
reg clk, reset;

master_bfm u1 (ask[2], clk, req1, gnt1, frame1, irdy1);
master_bfm u2 (ask[1], clk, req2, gnt2, frame2, irdy2);
master_bfm u3 (ask[0], clk, req3, gnt3, frame3, irdy3);
bus_arbiter u4 (clk, reset, frame, irdy, req1, req2, req3, gnt1, gnt2, gnt3);

assign frame = frame1 && frame2 && frame3;
assign irdy = irdy1 && irdy2 && irdy3;

assign gnt = !gnt1 || !gnt2 || !gnt3;
assign bus_is_free = gnt1 && gnt2 && gnt3;


initial
	$vcdpluson();

initial
begin
	clk = 1'b0; reset = 1'b1; i=0; ask = 3'b000;
	repeat(2) @(posedge clk)
	reset = 1'b0;
	$display("\nResetting the design at %0t\n", $time);
	repeat(2) @(posedge clk)
	reset = 1'b1;
	$display("Reset finished at %0t\n", $time);
	#50 $display("Waiting for Master Requests\n");
	while(i != 500)
	begin
		ask = $random()%8;
		if (ask == 3'b000)
		begin
			$display("No valid requests from any master at %0t\n", $time);
			i=i+1;
		end
		else
		begin
			$display("Valid request from a master available at %0t: %b\n", $time, ask);
			wait(gnt);
			$display("Bus Occupied at %0t\n", $time);
			ask = 3'b000;
			wait(bus_is_free)
			$display("Bus is free at %0t\n", $time);
			i=i+1;
		end
	end
	#100 $finish();
end

initial
	forever clk = #(`PERIOD) ~clk;

always@(negedge gnt1 or negedge gnt2 or negedge gnt3)
begin
        if(!gnt1)
        $display("Master1 Acquired the bus at %0t\n", $time);
        if(!gnt2)
        $display("Master2 Acquired the bus at %0t\n", $time);
        if(!gnt3)
        $display("Master3 Acquired the bus at %0t\n", $time);
end

always@(negedge req1 or negedge req2 or negedge req3)
begin
        if(!req1)
        $display("Master 1 is Requesting the bus at %0t\n", $time);
        if(!req2)
        $display("Master 2 is Requesting the bus at %0t\n", $time);
        if(!req3)
        $display("Master 3 is Requesting the bus at %0t\n", $time);
end

endmodule
