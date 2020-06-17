module rx (sum_0, dec_tap_1, sum_1);

parameter DEC_WIDTH        = 10;

input [(DEC_WIDTH-1):0]  sum_0;
input [(DEC_WIDTH-1):0]  dec_tap_1;
output [(DEC_WIDTH-1):0]  sum_1;
wire [(DEC_WIDTH-1):0]  sum_1;

assign   sum_1 = sum_0 + 0 + dec_tap_1 + sum_0 + 0 + 0 + dec_tap_1;

endmodule
