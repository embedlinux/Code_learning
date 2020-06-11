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

module pipo (reset_, latch_en, d63,d62,d61,d60,d59,d58,d57,d56,d55,d54,d53,d52,d51,d50,d49,d48,d47,d46,d45,d44,d43,d42,d41,d40,d39,d38,d37,d36,d35,d34,d33,d32,d31,d30,d29,d28,d27,d26,d25,d24,d23,d22,d21,d20,d19,d18,d17,d16,d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0, q63,q62,q61,q60,q59,q58,q57,q56,q55,q54,q53,q52,q51,q50,q49,q48,q47,q46,q45,q44,q43,q42,q41,q40,q39,q38,q37,q36,q35,q34,q33,q32,q31,q30,q29,q28,q27,q26,q25,q24,q23,q22,q21,q20,q19,q18,q17,q16,q15,q14,q13,q12,q11,q10,q9,q8,q7,q6,q5,q4,q3,q2,q1, q0);

input logic reset_, latch_en;

input logic signed [15:0] d63,d62,d61,d60,d59,d58,d57,d56,d55,d54,d53,d52,d51,d50,d49,d48,d47,d46,d45,d44,d43,d42,d41,d40,d39,d38,d37,d36,d35,d34,d33,d32,d31,d30,d29,d28,d27,d26,d25,d24,d23,d22,d21,d20,d19,d18,d17,d16,d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0;

output logic signed [15:0] q63,q62,q61,q60,q59,q58,q57,q56,q55,q54,q53,q52,q51,q50,q49,q48,q47,q46,q45,q44,q43,q42,q41,q40,q39,q38,q37,q36,q35,q34,q33,q32,q31,q30,q29,q28,q27,q26,q25,q24,q23,q22,q21,q20,q19,q18,q17,q16,q15,q14,q13,q12,q11,q10,q9,q8,q7,q6,q5,q4,q3,q2,q1, q0;

latch u0 (reset_,latch_en,d0,q0);
latch u1 (reset_,latch_en,d1,q1);
latch u2 (reset_,latch_en,d2,q2);
latch u3 (reset_,latch_en,d3,q3);
latch u4 (reset_,latch_en,d4,q4);
latch u5 (reset_,latch_en,d5,q5);
latch u6 (reset_,latch_en,d6,q6);
latch u7 (reset_,latch_en,d7,q7);
latch u8 (reset_,latch_en,d8,q8);
latch u9 (reset_,latch_en,d9,q9);
latch u10 (reset_,latch_en,d10,q10);
latch u11 (reset_,latch_en,d11,q11);
latch u12 (reset_,latch_en,d12,q12);
latch u13 (reset_,latch_en,d13,q13);
latch u14 (reset_,latch_en,d14,q14);
latch u15 (reset_,latch_en,d15,q15);
latch u16 (reset_,latch_en,d16,q16);
latch u17 (reset_,latch_en,d17,q17);
latch u18 (reset_,latch_en,d18,q18);
latch u19 (reset_,latch_en,d19,q19);
latch u20 (reset_,latch_en,d20,q20);
latch u21 (reset_,latch_en,d21,q21);
latch u22 (reset_,latch_en,d22,q22);
latch u23 (reset_,latch_en,d23,q23);
latch u24 (reset_,latch_en,d24,q24);
latch u25 (reset_,latch_en,d25,q25);
latch u26 (reset_,latch_en,d26,q26);
latch u27 (reset_,latch_en,d27,q27);
latch u28 (reset_,latch_en,d28,q28);
latch u29 (reset_,latch_en,d29,q29);
latch u30 (reset_,latch_en,d30,q30);
latch u31 (reset_,latch_en,d31,q31);
latch u32 (reset_,latch_en,d32,q32);
latch u33 (reset_,latch_en,d33,q33);
latch u34 (reset_,latch_en,d34,q34);
latch u35 (reset_,latch_en,d35,q35);
latch u36 (reset_,latch_en,d36,q36);
latch u37 (reset_,latch_en,d37,q37);
latch u38 (reset_,latch_en,d38,q38);
latch u39 (reset_,latch_en,d39,q39);
latch u40 (reset_,latch_en,d40,q40);
latch u41 (reset_,latch_en,d41,q41);
latch u42 (reset_,latch_en,d42,q42);
latch u43 (reset_,latch_en,d43,q43);
latch u44 (reset_,latch_en,d44,q44);
latch u45 (reset_,latch_en,d45,q45);
latch u46 (reset_,latch_en,d46,q46);
latch u47 (reset_,latch_en,d47,q47);
latch u48 (reset_,latch_en,d48,q48);
latch u49 (reset_,latch_en,d49,q49);
latch u50 (reset_,latch_en,d50,q50);
latch u51 (reset_,latch_en,d51,q51);
latch u52 (reset_,latch_en,d52,q52);
latch u53 (reset_,latch_en,d53,q53);
latch u54 (reset_,latch_en,d54,q54);
latch u55 (reset_,latch_en,d55,q55);
latch u56 (reset_,latch_en,d56,q56);
latch u57 (reset_,latch_en,d57,q57);
latch u58 (reset_,latch_en,d58,q58);
latch u59 (reset_,latch_en,d59,q59);
latch u60 (reset_,latch_en,d60,q60);
latch u61 (reset_,latch_en,d61,q61);
latch u62 (reset_,latch_en,d62,q62);
latch u63 (reset_,latch_en,d63,q63);

endmodule









