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


module jpeg (clk, reset_, rd, rd_addr, data, get_data, done_frame);

input logic clk;
input logic reset_;
input logic get_data;
output logic rd;
output logic [ADDR_WIDTH-1:0] rd_addr;
input logic [RAM_DATA_WIDTH-1:0] data;
output logic done_frame;

logic sipo_en, latch_en;
logic dp1_en, dp2_en, dp3_en, dp4_en;
logic wr;

logic signed [DATA_WIDTH-1:0] do63,do62,do61,do60,do59,do58,do57,do56,do55,do54,do53,do52,do51,do50,do49,do48,do47,do46,do45,do44,do43,do42,do41,do40,do39,do38,do37,do36,do35,do34,do33,do32,do31,do30,do29,do28,do27,do26,do25,do24,do23,do22,do21,do20,do19,do18,do17,do16,do15,do14,do13,do12,do11,do10,do9,do8,do7,do6,do5,do4,do3,do2,do1,do0;

logic signed [DATA_WIDTH-1:0] q63,q62,q61,q60,q59,q58,q57,q56,q55,q54,q53,q52,q51,q50,q49,q48,q47,q46,q45,q44,q43,q42,q41,q40,q39,q38,q37,q36,q35,q34,q33,q32,q31,q30,q29,q28,q27,q26,q25,q24,q23,q22,q21,q20,q19,q18,q17,q16,q15,q14,q13,q12,q11,q10,q9,q8,q7,q6,q5,q4,q3,q2,q1, q0;

fsm fsm_inst (.*);
data_feeder data_feeder_inst (.*);

datapath datapath_inst (clk, q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10, q11,q12,q13,q14,q15,q16,q17,q18 ,q19,q20,q21,q22,q23,q24,q25, q26,q27,q28, q29,q30,q31,q32,q33,q34,q35,q36,q37,q38,q39,q40 ,q41,q42,q43,q44,q45,q46,q47,q48,q49,q50,q51,q52,q53,q54,q55,q56,q57,q58,q59,q60,q61,q62,q63, dp1_en, dp2_en, dp3_en, dp4_en, reset_, do0, do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do18,do19,do20,do21,do22,do23,do24,do25,do26,do27,do28,do29,do30,do31,do32,do33,do34,do35,do36,do37,do38,do39,do40,do41,do42,do43,do44,do45,do46,do47,do48,do49,do50,do51,do52,do53,do54,do55,do56,do57,do58,do59,do60,do61,do62,do63);

encoder encoder_inst (clk, reset_, wr, do0, do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do18,do19,do20,do21,do22,do23,do24,do25,do26,do27,do28,do29,do30,do31,do32,do33,do34,do35,do36,do37,do38,do39,do40,do41,do42,do43,do44,do45,do46,do47,do48,do49,do50,do51,do52,do53,do54,do55,do56,do57,do58,do59,do60,do61,do62,do63);

endmodule
