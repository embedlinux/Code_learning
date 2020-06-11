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

module transform (

input logic signed [15:0] d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28, d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58,d59,d60,d61,d62,d63,d64,

output logic signed [15:0] dw1,dw2,dw3,dw4,dw5,dw6,dw7,dw8,dw9,dw10,dw11,dw12,dw13,dw14,dw15,dw16,dw17,dw18,dw19,dw20,dw21,dw22,dw23,dw24,dw25,dw26,dw27,dw28,dw29,dw30,dw31,dw32,dw33,dw34,dw35,dw36,dw37,dw38,dw39,dw40,dw41,dw42,dw43,dw44,dw45,dw46,dw47,dw48,dw49,dw50,dw51,dw52,dw53,dw54,dw55,dw56,dw57,dw58,dw59,dw60,dw61,dw62,dw63,dw64);

wh u1 (d1,d2,d3,d4,d5,d6,d7,d8,dw1,dw2,dw3,dw4,dw5,dw6,dw7,dw8);
wh u2 (d9,d10,d11,d12,d13,d14,d15,d16,dw9,dw10,dw11,dw12,dw13,dw14,dw15,dw16);
wh u3 (d17,d18,d19,d20,d21,d22,d23,d24,dw17,dw18,dw19,dw20,dw21,dw22,dw23,dw24);
wh u4 (d25,d26,d27,d28,d29,d30,d31,d32,dw25,dw26,dw27,dw28,dw29,dw30,dw31,dw32);
wh u5 (d33,d34,d35,d36,d37,d38,d39,d40,dw33,dw34,dw35,dw36,dw37,dw38,dw39,dw40);
wh u6 (d41,d42,d43,d44,d45,d46,d47,d48,dw41,dw42,dw43,dw44,dw45,dw46,dw47,dw48);
wh u7 (d49,d50,d51,d52,d53,d54,d55,d56,dw49,dw50,dw51,dw52,dw53,dw54,dw55,dw56);
wh u8 (d57,d58,d59,d60,d61,d62,d63,d64,dw57,dw58,dw59,dw60,dw61,dw62,dw63,dw64);

endmodule
