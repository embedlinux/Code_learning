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


module simple_seq;

`define true 1

logic clk;

logic a, b, c, d, e;
integer i;

initial

begin
	clk = 1'b0;
	for(i=0; i<20; i++)
	begin
		a = $random();
		b = $random();
		c = $random();
		d = $random();
		e = $random();
		@(posedge clk);
	end

repeat(2) @(posedge clk);
$finish();

end

initial
	forever clk = #25 ~clk;

always_comb
begin
a_ia: assert (a && b); // a_ia immediate assertion
end

// a_s1 Simple sequence
a_s1: assert property(@(posedge clk) a);

// a_s2 simple sequence using $rose
a_s2: assert property(@(posedge clk) $rose(a));

// a_s3 simple seuence using logical operators 
a_s3: assert property(@(posedge clk) a || b);

// a_cc concurrent assertion
a_cc: assert property(@(posedge clk) not (a && b));

// overlapped implcation
a_p8: assert property(@(posedge clk) a |-> b);

// non-overlapped implication
a_p9: assert property(@(posedge clk) a |=> b);

// implication using fixed time window
a_p10: assert property(@(posedge clk) a |-> ##2 b);

// implication using fixed timing and antecedent
a_p11: assert property(@(posedge clk) ((a&&b) ##1 c) |-> ##2 !d);

// timing window in SVA
a_p12: assert property(@(posedge clk)  (a && b) |-> ##[1:3] c);

// Overlapping fixed time window
a_p13: assert property(@(posedge clk)  (a && b) |-> ##[0:2] c);

// indefinite time window
a_p14: assert property(@(posedge clk)  a |->  ##[1:$] b ##[0:$] c);

// using length operator to control the sequence length
a_p35: assert property(@(posedge clk)  1[*2:5] intersect (a ##[1:$] b ##[1:$] c));

// using select operator
a_p17: assert property(@(posedge clk) c ? d == a : d == b);

//$past construct
a_p19: assert property(@(posedge clk) (c&&d) |-> ($past((a&&b),2) == 1'b1));

// using the SVA ended construct
sequence s15a; @(posedge clk) a ##1 b; endsequence
sequence s15b; @(posedge clk) c ##1 d; endsequence
property p15a; @(posedge clk) s15a |=> s15b; endproperty
property p15b; @(posedge clk) s15a.ended |-> ##2 s15b.ended; endproperty
a15a: assert property(p15a);
a15b: assert property(p15b);

// part of property 16, passing parameter
generic_chk #(.delay(2)) i1 (a, b, clk);
generic_chk i2 (c, d, clk);


// using the `true operator
sequence s18a; @(posedge clk) a ##1 b; endsequence
sequence s18a_ext; @(posedge clk) a ##1 b ##1 `true; endsequence
sequence s18b; @(posedge clk) c ##1 d; endsequence
property p18; @(posedge clk) s18a.ended |-> ##2 s18b.ended; endproperty
property p18_ext; @(posedge clk) s18a_ext.ended |=> s18b.ended; endproperty
a18: assert property(p18);
a18_ext: assert property(p18_ext);



initial $vcdpluson();

endmodule	

module generic_chk (input logic a, b, clk);

parameter delay = 1;

// SVA using parameters
property p16;
	@(posedge clk) a |-> ##delay b;
endproperty
a16: assert property(p16);

endmodule




