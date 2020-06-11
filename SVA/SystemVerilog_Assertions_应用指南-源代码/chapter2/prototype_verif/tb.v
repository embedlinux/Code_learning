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
wire [1:0] trdy, sel;
wire [8:0] data1, data2, data3, data;
wire [7:0] dataout1, dataout2, datao;
wire rsel1, rsel2, rsel3;
wire [5:0] ri1, wi1, ri2, wi2;

// debug pins for master 1

wire u1_a_master_start1_flag;
wire u1_a_master_start2_flag;
wire u1_a_master_stop1_flag;
wire u1_a_master_stop2_flag;
wire u1_a_master_data1_flag;
wire u1_a_master_data2_flag;
wire u1_a_master_datao1_flag;
wire u1_a_master_datao2_flag;

// debug pins for master 2

wire u2_a_master_start1_flag;
wire u2_a_master_start2_flag;
wire u2_a_master_stop1_flag;
wire u2_a_master_stop2_flag;
wire u2_a_master_data1_flag;
wire u2_a_master_data2_flag;
wire u2_a_master_datao1_flag;
wire u2_a_master_datao2_flag;

// debug pins for master 2

wire u3_a_master_start1_flag;
wire u3_a_master_start2_flag;
wire u3_a_master_stop1_flag;
wire u3_a_master_stop2_flag;
wire u3_a_master_data1_flag;
wire u3_a_master_data2_flag;
wire u3_a_master_datao1_flag;
wire u3_a_master_datao2_flag;

reg [2:0] ask;
wire gnt;
wire bus_is_free;
reg clk, reset;

assign frame = frame1 && frame2 && frame3;
assign irdy = irdy1 && irdy2 && irdy3;

master_bfm #(.master_sva(1'b0), .master_sva_severity(1'b0)) u1 (ask[2], clk, 
req1, gnt1, frame1, irdy1, trdy, data1, rsel1, datao,
u1_a_master_start1_flag, u1_a_master_start2_flag, u1_a_master_stop1_flag,
u1_a_master_stop2_flag, u1_a_master_data1_flag, u1_a_master_data2_flag,
u1_a_master_datao1_flag, u1_a_master_datao2_flag
);
master_bfm #(.master_sva(1'b0), .master_sva_severity(1'b0)) u2 (ask[1], clk, 
req2, gnt2, frame2, irdy2, trdy, data2, rsel2, datao,
u2_a_master_start1_flag, u2_a_master_start2_flag, u2_a_master_stop1_flag,
u2_a_master_stop2_flag, u2_a_master_data1_flag, u2_a_master_data2_flag,
u2_a_master_datao1_flag, u2_a_master_datao2_flag
);
master_bfm #(.master_sva(1'b0), .master_sva_severity(1'b0)) u3 (ask[0], clk, 
req3, gnt3, frame3, irdy3, trdy, data3, rsel3, datao,
u3_a_master_start1_flag, u3_a_master_start2_flag, u3_a_master_stop1_flag,
u3_a_master_stop2_flag, u3_a_master_data1_flag, u3_a_master_data2_flag,
u3_a_master_datao1_flag, u3_a_master_datao2_flag
);
bus_arbiter #(.arb_sva(1'b0), .arb_sva_severity(1'b0)) u4 (clk, reset, frame, irdy, req1, req2, req3, gnt1, gnt2, gnt3);
glue #(.glue_sva(1'b0)) u5 (clk, frame1, irdy1, frame2, irdy2, frame3, irdy3, trdy, rsel1, rsel2, rsel3, data1, data2, data3, sel, data, dataout1, dataout2, datao);
target_bfm #(.target_sva(1'b0), .target_sva_severity(1'b0)) u6 (clk, reset, sel[1], trdy[1], data, dataout1, ri1, wi1);
target_bfm #(.target_sva(1'b0), .target_sva_severity(1'b0)) u7 (clk, reset, sel[0], trdy[0], data, dataout2, ri2, wi2);


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
			@(posedge clk);
		end
	end
	#100 $finish();
end

initial
	forever clk = #(`PERIOD) ~clk;

/*
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

*/

endmodule
