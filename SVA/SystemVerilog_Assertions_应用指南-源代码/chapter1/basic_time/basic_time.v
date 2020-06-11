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


module basic_time;

logic clk;

logic a, b;
integer i;

initial

begin
	clk = 1'b0; a = 1'b0; b= 1'b0;
	repeat(1) @(posedge clk);
	for(i=0; i<3; i++)
	begin
		a = 1'b1;
		repeat(1) @(posedge clk);
		a = 1'b0;
		repeat(i) @(posedge clk);
		b = 1'b1;
		@(posedge clk);
		b = 1'b0;
		@(posedge clk);
	end
	for(i=0; i<1; i++)
	begin
		a = 1'b1;
		repeat(1) @(posedge clk);
		a = 1'b0;
		repeat(1) @(posedge clk);
		b = 1'b1;
		@(posedge clk);
		b = 1'b0;
		@(posedge clk);
	end
	

repeat(2) @(posedge clk);
$finish();

end

initial
	forever clk = #25 ~clk;

// sequence with timing window
a_s4: assert property(@(posedge clk) (a ##2 b));


// forbidding a property using "not"
a_s6: assert property(@(posedge clk) not (a ##2 b));

// action block

property p7;
	@(posedge clk) a ##2 b;
endproperty

a7: assert property(p7) $display("Property p7 succeeded\n");
			else $display("Property p7 failed\n");



initial $vcdpluson();

endmodule	


