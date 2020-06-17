module tx (in1, in2, mult_out,add_out);

parameter DEC_WIDTH        = 64;
parameter MULT_WIDTH        = 128;

input [(DEC_WIDTH-1):0]  in1;
input [(DEC_WIDTH-1) : 0]  in2;
output [(MULT_WIDTH-1):0]  mult_out;
output [(DEC_WIDTH-1):0]  add_out;
wire [(MULT_WIDTH-1):0]  mult_out;

assign      mult_out = in1 * in2;
assign      add_out = in1 + in2;

endmodule
