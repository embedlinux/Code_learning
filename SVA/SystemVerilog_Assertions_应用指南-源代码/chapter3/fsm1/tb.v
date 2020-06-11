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

`include "defines.h"
module tb;

logic rd, clk, get_data, reset_;
logic sipo_en, latch_en;
logic dp1_en, dp2_en, dp3_en, dp4_en, wr, done_frame;
logic [17:0] rd_addr;
logic [DATA_WIDTH-1:0] data_out [63:0];

logic signed [DATA_WIDTH-1:0] d63,d62,d61,d60,d59,d58,d57,d56,d55,d54,d53,d52,d51,d50,d49,d48,d47,d46,d45,d44,d43,d42,d41,d40,d39,d38,d37,d36,d35,d34,d33,d32,d31,d30,d29,d28,d27,d26,d25,d24,d23,d22,d21,d20,d19,d18,d17,d16,d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0;

logic signed [DATA_WIDTH-1:0] q63,q62,q61,q60,q59,q58,q57,q56,q55,q54,q53,q52,q51,q50,q49,q48,q47,q46,q45,q44,q43,q42,q41,q40,q39,q38,q37,q36,q35,q34,q33,q32,q31,q30,q29,q28,q27,q26,q25,q24,q23,q22,q21,q20,q19,q18,q17,q16,q15,q14,q13,q12,q11,q10,q9,q8,q7,q6,q5,q4,q3,q2,q1, q0;

wire [7:0] data;

fsm fsm_inst (.*);
ram262144x8 ram (.data(data), .rd(rd), .wr(1'b0), .memory_enable(1'b1), .addr(rd_addr));
sipo sipo_inst (.*);
pipo pipo_inst (.*);


always #5 clk = ~clk;

initial begin
clk = 0;
reset_ = 0;
get_data = 0;
#30
reset_ = 1;
#10
get_data = 1;
#5000
get_data = 0;
$finish;
end

initial $readmemh("grande_image.dat", ram.mem);

initial
begin
$vcdpluson();
end
endmodule
