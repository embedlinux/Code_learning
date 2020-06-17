module hierB (sum_0, dec_tap_1, sum_1, in1,in2,mult_out,add_out);

input [9:0]  sum_0;
input [9:0]  dec_tap_1;
input [63:0]  in1;
input [63:0]  in2;
output [127:0]  mult_out;
output [63:0]  add_out;
output [9:0]  sum_1;

hierA U1 (sum_0, dec_tap_1, sum_1,in1,in2,mult_out,add_out);

endmodule
