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


module pipo (

input logic reset,enable,

input logic signed [15:0] d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28, d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58,d59,d60,d61,d62,d63,d64,

output logic signed [15:0] q1,q2,q3,q4,q5,q6,q7,q8,q9,q10, q11,q12,q13,q14,q15,q16,q17,q18 ,q19,q20,q21,q22,q23,q24,q25, q26,q27,q28, q29,q30,q31,q32,q33,q34,q35,q36,q37,q38,q39,q40 ,q41,q42,q43,q44,q45,q46,q47,q48,q49,q50,q51,q52,q53,q54,q55,q56,q57,q58,q59,q60,q61,q62,q63,q64

);

latch u1 (reset,enable,d1,q1);
latch u2 (reset,enable,d2,q2);
latch u3 (reset,enable,d3,q3);
latch u4 (reset,enable,d4,q4);
latch u5 (reset,enable,d5,q5);
latch u6 (reset,enable,d6,q6);
latch u7 (reset,enable,d7,q7);
latch u8 (reset,enable,d8,q8);
latch u9 (reset,enable,d9,q9);
latch u10 (reset,enable,d10,q10);
latch u11 (reset,enable,d11,q11);
latch u12 (reset,enable,d12,q12);
latch u13 (reset,enable,d13,q13);
latch u14 (reset,enable,d14,q14);
latch u15 (reset,enable,d15,q15);
latch u16 (reset,enable,d16,q16);
latch u17 (reset,enable,d17,q17);
latch u18 (reset,enable,d18,q18);
latch u19 (reset,enable,d19,q19);
latch u20 (reset,enable,d20,q20);
latch u21 (reset,enable,d21,q21);
latch u22 (reset,enable,d22,q22);
latch u23 (reset,enable,d23,q23);
latch u24 (reset,enable,d24,q24);
latch u25 (reset,enable,d25,q25);
latch u26 (reset,enable,d26,q26);
latch u27 (reset,enable,d27,q27);
latch u28 (reset,enable,d28,q28);
latch u29 (reset,enable,d29,q29);
latch u30 (reset,enable,d30,q30);
latch u31 (reset,enable,d31,q31);
latch u32 (reset,enable,d32,q32);
latch u33 (reset,enable,d33,q33);
latch u34 (reset,enable,d34,q34);
latch u35 (reset,enable,d35,q35);
latch u36 (reset,enable,d36,q36);
latch u37 (reset,enable,d37,q37);
latch u38 (reset,enable,d38,q38);
latch u39 (reset,enable,d39,q39);
latch u40 (reset,enable,d40,q40);
latch u41 (reset,enable,d41,q41);
latch u42 (reset,enable,d42,q42);
latch u43 (reset,enable,d43,q43);
latch u44 (reset,enable,d44,q44);
latch u45 (reset,enable,d45,q45);
latch u46 (reset,enable,d46,q46);
latch u47 (reset,enable,d47,q47);
latch u48 (reset,enable,d48,q48);
latch u49 (reset,enable,d49,q49);
latch u50 (reset,enable,d50,q50);
latch u51 (reset,enable,d51,q51);
latch u52 (reset,enable,d52,q52);
latch u53 (reset,enable,d53,q53);
latch u54 (reset,enable,d54,q54);
latch u55 (reset,enable,d55,q55);
latch u56 (reset,enable,d56,q56);
latch u57 (reset,enable,d57,q57);
latch u58 (reset,enable,d58,q58);
latch u59 (reset,enable,d59,q59);
latch u60 (reset,enable,d60,q60);
latch u61 (reset,enable,d61,q61);
latch u62 (reset,enable,d62,q62);
latch u63 (reset,enable,d63,q63);
latch u64 (reset,enable,d64,q64);

endmodule









