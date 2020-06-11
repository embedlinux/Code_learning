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

module repeats;

logic start, stop;
logic a, b;
logic clk;
reg [1:0] window;

integer i;

initial
begin
clk=1'b0; a=1'b0; b=1'b0; start=1'b0; stop=1'b0;
#50;

// p21 consecutive repeat operator 
// +p21

`ifdef p21
for(i=2; i<5; i++)
begin
	start = 1'b1;
	@(posedge clk) start = 1'b0;
	repeat(i) @(posedge clk) a=1'b1;
	@(posedge clk) a=1'b0;
	@(posedge clk) stop=1'b1;
	@(posedge clk) stop=1'b0;
	@(posedge clk);
end
`else
`endif

// p22 consecutive repeat on a sequence
`ifdef p22
for(i=2; i<5; i++)
begin
	start = 1'b1;
	@(posedge clk) start = 1'b0;
	@(posedge clk);
	repeat(i) 
	begin
		a=1'b1;
		@(posedge clk) a=1'b0;
		@(posedge clk) b=1'b1;
		@(posedge clk) b=1'b0;
	end
	@(posedge clk) stop=1'b1;
	@(posedge clk) stop=1'b0;
end
`else
`endif

// p23 consecutive repeat on a sequence with delay 
`ifdef p23
for(i=2; i<5; i++)
begin
	start = 1'b1;
	@(posedge clk) start = 1'b0;
	@(posedge clk);
	repeat(i) 
	begin
		a=1'b1;
		@(posedge clk) a=1'b0;
		window = $random() %4;
		repeat(window) @(posedge clk);
		b=1'b1;
		@(posedge clk) b=1'b0;
	end
	@(posedge clk) stop=1'b1;
	@(posedge clk) stop=1'b0;
end
`else
`endif

// p24 consecutive repeat and eventuality
`ifdef p24
@(posedge clk) start = 1'b1;
@(posedge clk) start = 1'b0;
repeat(3) @(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
@(posedge clk) stop=1'b1;
@(posedge clk) stop=1'b0;

@(posedge clk) start = 1'b1;
@(posedge clk) start = 1'b0;
repeat(3) @(posedge clk) a=1'b1;
@(posedge clk) a=1'b0; stop=1'b1;
@(posedge clk) stop=1'b0;
@(posedge clk);
`else
`endif

// p25 go to repetetion
`ifdef p25
@(posedge clk) start = 1'b1;
@(posedge clk) start = 1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
@(posedge clk) stop=1'b1;
@(posedge clk) stop=1'b0;
	
@(posedge clk);

@(posedge clk) start = 1'b1;
@(posedge clk) start = 1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0; stop=1'b1;
@(posedge clk) stop=1'b0;

@(posedge clk);

@(posedge clk) start = 1'b1;
@(posedge clk) start = 1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
window = $random() %4;
repeat(window) @(posedge clk);
@(posedge clk) a=1'b1;
@(posedge clk) a=1'b0;
@(posedge clk) stop=1'b1;
@(posedge clk) stop=1'b0;
`else
`endif



#50 $finish();
	
	

end

`ifdef p21
 a21 : assert property(@(posedge clk) $rose(start) |-> ##2 (a[*3]) ##2 stop ##1 !stop);
`else
`endif
`ifdef p22
 a22 : assert property(@(posedge clk) $rose(start) |-> ##2 ((a ##2 b)[*3]) ##2 stop ##1 !stop);
`else
`endif
`ifdef p23
 a23 : assert property(@(posedge clk) $rose(start) |-> ##2 ((a ##[1:4] b)[*3]) ##2 stop ##1 !stop);
`else
`endif
`ifdef p24
 a24 : assert property(@(posedge clk) $rose(start) |-> ##2 (a[*1:$]) ##1 stop ##1 !stop);
`else
`endif
`ifdef p25
 a25 : assert property(@(posedge clk) $rose(start) |-> ##2 (a[->3]) ##1 stop ##1 !stop);
a26 : assert property(@(posedge clk) $rose(start) |-> ##2 (a[=3]) ##1 stop ##1 !stop);
`else
`endif


initial forever clk = #25 ~clk;

initial $vcdpluson();

endmodule


