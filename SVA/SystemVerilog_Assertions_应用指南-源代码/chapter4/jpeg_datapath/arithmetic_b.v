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


module arithmetic(

input logic signed [15:0] d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28, d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58,d59,d60,d61,d62,d63, d64,

output logic signed [15:0] dwtwq1, dwtwq2, dwtwq3, dwtwq4, dwtwq5, dwtwq6, dwtwq7, dwtwq8, dwtwq9, dwtwq10, dwtwq11, dwtwq12, dwtwq13, dwtwq14, dwtwq15, dwtwq16, dwtwq17, dwtwq18, dwtwq19, dwtwq20, dwtwq21, dwtwq22, dwtwq23, dwtwq24, dwtwq25, dwtwq26, dwtwq27, dwtwq28, dwtwq29, dwtwq30, dwtwq31, dwtwq32, dwtwq33, dwtwq34, dwtwq35, dwtwq36, dwtwq37, dwtwq38, dwtwq39, dwtwq40, dwtwq41, dwtwq42, dwtwq43, dwtwq44, dwtwq45, dwtwq46, dwtwq47, dwtwq48, dwtwq49, dwtwq50, dwtwq51, dwtwq52, dwtwq53, dwtwq54, dwtwq55, dwtwq56, dwtwq57, dwtwq58, dwtwq59, dwtwq60, dwtwq61, dwtwq62, dwtwq63, dwtwq64

);


logic signed [15:0] dw1,dw2,dw3,dw4,dw5,dw6,dw7,dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15,dw16,dw17, dw18,dw19,dw20,dw21,dw22,dw23,dw24,dw25,dw26,dw27,dw28,dw29,dw30,dw31,dw32,dw33,dw34,dw35, dw36,dw37,dw38,dw39,dw40,dw41,dw42,dw43,dw44,dw45,dw46,dw47,dw48,dw49,dw50,dw51,dw52,dw53, dw54,dw55,dw56,dw57,dw58,dw59,dw60,dw61,dw62,dw63,dw64;

logic signed [15:0] dwt1, dwt2, dwt3, dwt4, dwt5, dwt6, dwt7, dwt8, dwt9, dwt10, dwt11, dwt12, dwt13, dwt14, dwt15, dwt16, dwt17, dwt18, dwt19, dwt20, dwt21, dwt22, dwt23, dwt24, dwt25, dwt26, dwt27, dwt28, dwt29, dwt30, dwt31, dwt32, dwt33, dwt34, dwt35, dwt36, dwt37, dwt38, dwt39, dwt40, dwt41, dwt42, dwt43, dwt44, dwt45, dwt46, dwt47, dwt48, dwt49, dwt50, dwt51, dwt52, dwt53, dwt54, dwt55,dwt56, dwt57, dwt58, dwt59, dwt60, dwt61, dwt62, dwt63, dwt64;

logic signed [15:0] dwtw1, dwtw2, dwtw3, dwtw4, dwtw5, dwtw6, dwtw7, dwtw8, dwtw9, dwtw10, dwtw11, dwtw12, dwtw13, dwtw14, dwtw15, dwtw16, dwtw17, dwtw18, dwtw19, dwtw20, dwtw21, dwtw22, dwtw23, dwtw24, dwtw25, dwtw26, dwtw27, dwtw28, dwtw29, dwtw30, dwtw31, dwtw32, dwtw33, dwtw34, dwtw35, dwtw36, dwtw37, dwtw38, dwtw39, dwtw40, dwtw41, dwtw42, dwtw43, dwtw44, dwtw45, dwtw46, dwtw47, dwtw48, dwtw49, dwtw50, dwtw51, dwtw52, dwtw53, dwtw54, dwtw55, dwtw56, dwtw57, dwtw58, dwtw59, dwtw60, dwtw61, dwtw62, dwtw63, dwtw64;


transform u1 (d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28, d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58,d59,d60,d61,d62,d63,d64,dw1,dw2,dw3,dw4,dw5,dw6,dw7,dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15,dw16,dw17,dw18,dw19,dw20,dw21,dw22,dw23,dw24,dw25,dw26,dw27,dw28,dw29,dw30,dw31,dw32,dw33,dw34,dw35,dw36,dw37,dw38,dw39,dw40,dw41,dw42,dw43,dw44,dw45,dw46,dw47,dw48,dw49,dw50,dw51,dw52,dw53,dw54,dw55,dw56,dw57,dw58,dw59,dw60,dw61,dw62,dw63,dw64);

xpose_b u2 (dw1,dw2,dw3,dw4,dw5,dw6,dw7,dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15,dw16,dw17, dw18,dw19,dw20,dw21,dw22,dw23,dw24,dw25,dw26,dw27,dw28,dw29,dw30,dw31,dw32,dw33,dw34,dw35, dw36,dw37,dw38,dw39,dw40,dw41,dw42,dw43,dw44,dw45,dw46,dw47,dw48,dw49,dw50,dw51,dw52,dw53, dw54,dw55,dw56,dw57,dw58,dw59,dw60,dw61,dw62,dw63,dw64, dwt1, dwt2, dwt3, dwt4, dwt5, dwt6, dwt7, dwt8, dwt9, dwt10, dwt11, dwt12, dwt13, dwt14, dwt15, dwt16, dwt17, dwt18, dwt19, dwt20, dwt21, dwt22, dwt23, dwt24, dwt25, dwt26, dwt27, dwt28, dwt29, dwt30, dwt31, dwt32, dwt33, dwt34, dwt35, dwt36, dwt37, dwt38, dwt39, dwt40, dwt41, dwt42, dwt43, dwt44, dwt45, dwt46, dwt47, dwt48, dwt49, dwt50, dwt51, dwt52, dwt53, dwt54, dwt55,dwt56, dwt57, dwt58, dwt59, dwt60, dwt61, dwt62, dwt63, dwt64);

transform u3 (dwt1, dwt2, dwt3, dwt4, dwt5, dwt6, dwt7, dwt8, dwt9, dwt10, dwt11, dwt12, dwt13, dwt14, dwt15, dwt16, dwt17, dwt18, dwt19, dwt20, dwt21, dwt22, dwt23, dwt24, dwt25, dwt26, dwt27, dwt28, dwt29, dwt30, dwt31, dwt32, dwt33, dwt34, dwt35, dwt36, dwt37, dwt38, dwt39, dwt40, dwt41, dwt42, dwt43, dwt44, dwt45, dwt46, dwt47, dwt48, dwt49, dwt50, dwt51, dwt52, dwt53, dwt54, dwt55,dwt56, dwt57, dwt58, dwt59, dwt60, dwt61, dwt62, dwt63, dwt64, dwtw1, dwtw2, dwtw3, dwtw4, dwtw5, dwtw6, dwtw7, dwtw8, dwtw9, dwtw10, dwtw11, dwtw12, dwtw13, dwtw14, dwtw15, dwtw16, dwtw17, dwtw18, dwtw19, dwtw20, dwtw21, dwtw22, dwtw23, dwtw24, dwtw25, dwtw26, dwtw27, dwtw28, dwtw29, dwtw30, dwtw31, dwtw32, dwtw33, dwtw34, dwtw35, dwtw36, dwtw37, dwtw38, dwtw39, dwtw40, dwtw41, dwtw42, dwtw43, dwtw44, dwtw45, dwtw46, dwtw47, dwtw48, dwtw49, dwtw50, dwtw51, dwtw52, dwtw53, dwtw54, dwtw55, dwtw56, dwtw57, dwtw58, dwtw59, dwtw60, dwtw61, dwtw62, dwtw63, dwtw64);

quantization u4 (dwtw1, dwtw2, dwtw3, dwtw4, dwtw5, dwtw6, dwtw7, dwtw8, dwtw9, dwtw10, dwtw11, dwtw12, dwtw13, dwtw14, dwtw15, dwtw16, dwtw17, dwtw18, dwtw19, dwtw20, dwtw21, dwtw22, dwtw23, dwtw24, dwtw25, dwtw26, dwtw27, dwtw28, dwtw29, dwtw30, dwtw31, dwtw32, dwtw33, dwtw34, dwtw35, dwtw36, dwtw37, dwtw38, dwtw39, dwtw40, dwtw41, dwtw42, dwtw43, dwtw44, dwtw45, dwtw46, dwtw47, dwtw48, dwtw49, dwtw50, dwtw51, dwtw52, dwtw53, dwtw54, dwtw55, dwtw56, dwtw57, dwtw58, dwtw59, dwtw60, dwtw61, dwtw62, dwtw63, dwtw64, dwtwq1, dwtwq2, dwtwq3, dwtwq4, dwtwq5, dwtwq6, dwtwq7, dwtwq8, dwtwq9, dwtwq10, dwtwq11, dwtwq12, dwtwq13, dwtwq14, dwtwq15, dwtwq16, dwtwq17, dwtwq18, dwtwq19, dwtwq20, dwtwq21, dwtwq22, dwtwq23, dwtwq24, dwtwq25, dwtwq26, dwtwq27, dwtwq28, dwtwq29, dwtwq30, dwtwq31, dwtwq32, dwtwq33, dwtwq34, dwtwq35, dwtwq36, dwtwq37, dwtwq38, dwtwq39, dwtwq40, dwtwq41, dwtwq42, dwtwq43, dwtwq44, dwtwq45, dwtwq46, dwtwq47, dwtwq48, dwtwq49, dwtwq50, dwtwq51, dwtwq52, dwtwq53, dwtwq54, dwtwq55, dwtwq56, dwtwq57, dwtwq58, dwtwq59, dwtwq60, dwtwq61, dwtwq62, dwtwq63, dwtwq64);
 
endmodule

/*

module tb;

logic signed [15:0] d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28, d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58,d59,d60,d61,d62,d63, d64;

logic signed [15:0] dwtwq1, dwtwq2, dwtwq3, dwtwq4, dwtwq5, dwtwq6, dwtwq7, dwtwq8, dwtwq9, dwtwq10, dwtwq11, dwtwq12, dwtwq13, dwtwq14, dwtwq15, dwtwq16, dwtwq17, dwtwq18, dwtwq19, dwtwq20, dwtwq21, dwtwq22, dwtwq23, dwtwq24, dwtwq25, dwtwq26, dwtwq27, dwtwq28, dwtwq29, dwtwq30, dwtwq31, dwtwq32, dwtwq33, dwtwq34, dwtwq35, dwtwq36, dwtwq37, dwtwq38, dwtwq39, dwtwq40, dwtwq41, dwtwq42, dwtwq43, dwtwq44, dwtwq45, dwtwq46, dwtwq47, dwtwq48, dwtwq49, dwtwq50, dwtwq51, dwtwq52, dwtwq53, dwtwq54, dwtwq55, dwtwq56, dwtwq57, dwtwq58, dwtwq59, dwtwq60, dwtwq61, dwtwq62, dwtwq63, dwtwq64;

arithmetic p1 (

d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28, d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58,d59,d60,d61,d62,d63,d64, dwtwq1, dwtwq2, dwtwq3, dwtwq4, dwtwq5, dwtwq6, dwtwq7, dwtwq8, dwtwq9, dwtwq10, dwtwq11, dwtwq12, dwtwq13, dwtwq14, dwtwq15, dwtwq16, dwtwq17, dwtwq18, dwtwq19, dwtwq20, dwtwq21, dwtwq22, dwtwq23, dwtwq24, dwtwq25, dwtwq26, dwtwq27, dwtwq28, dwtwq29, dwtwq30, dwtwq31, dwtwq32, dwtwq33, dwtwq34, dwtwq35, dwtwq36, dwtwq37, dwtwq38, dwtwq39, dwtwq40, dwtwq41, dwtwq42, dwtwq43, dwtwq44, dwtwq45, dwtwq46, dwtwq47, dwtwq48, dwtwq49, dwtwq50, dwtwq51, dwtwq52, dwtwq53, dwtwq54, dwtwq55, dwtwq56, dwtwq57, dwtwq58, dwtwq59, dwtwq60, dwtwq61, dwtwq62, dwtwq63, dwtwq64

);

initial
$vcdpluson();

initial
begin
d1=211;
d2=200;
d3= 52;
d4=174;
d5=15;
d6=217;
d7=41;
d8=123;
d9=100;
d10=189;
d11=197;
d12=239;
d13=242;
d14=58;
d15=246;
d16=55;
d17=134;
d18=214;
d19=161;
d20=137;
d21=86;
d22=111;
d23=112;
d24=32;
d25=241;
d26=241;
d27=230;
d28=45;
d29=248;
d30=205;
d31=31;
d32=74;
d33=112;
d34=32;
d35=241;
d36=241;
d37=230;
d38=45;
d39=248;
d40=205;
d41=197;
d42=239;
d43=242;
d44=58;
d45=246;
d46=55;
d47=134;
d48=214;
d49=161;
d50=137;
d51=86;
d52=111;
d53=112;
d54=32;
d55=241;
d56=241;
d57=230;
d58=45;
d59=248;
d60=205;
d61=31;
d62=74;
d63=112;
d64=32;

#100 $finish;

end

endmodule
*/



	





