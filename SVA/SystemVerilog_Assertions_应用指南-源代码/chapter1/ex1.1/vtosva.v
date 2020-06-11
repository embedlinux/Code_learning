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


module vtosva;

logic a, b, clk;

// verilog checker

always @(posedge a)
begin
     repeat (1) @(posedge clk);
  fork: a_to_b 
     begin
         @(posedge b)
         $display("SUCCESS: b arrived in time\n", $time);
         disable a_to_b;
      end
     begin
        repeat (3) @(posedge clk);
        $display("ERROR: b did not arrive in time\n", $time);
        disable a_to_b;
     end
   join
end 

// SVA Checker

a_to_b_chk: assert property(@(posedge clk) $rose(a) |-> ##[1:3] $rose(b));

initial $vcdpluson();

initial
begin

a=1'b0; b=1'b0; clk=1'b0;

repeat(2) @(posedge clk);
#2 a=1'b1;
repeat(1) @(posedge clk);
#2 a=1'b0; b=1'b1;
repeat(1) @(posedge clk);
#2 b=1'b0;

repeat(2) @(posedge clk);
#2 a=1'b1;
repeat(1) @(posedge clk);
#2 a=1'b0; 
repeat(2) @(posedge clk);
#2 b=1'b1;
repeat(1) @(posedge clk);
#2 b=1'b0;

repeat(2) @(posedge clk);
#2 a=1'b1;
repeat(1) @(posedge clk);
#2 a=1'b0; 
repeat(3) @(posedge clk);
#2 b=1'b1;
repeat(1) @(posedge clk);
#2 b=1'b0;

repeat(2) @(posedge clk);

$finish();
end

initial forever clk = #25 ~clk;

endmodule
