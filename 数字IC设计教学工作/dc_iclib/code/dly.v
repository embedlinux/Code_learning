//----------------------------------------
module dly(s_in,s_out);
input s_in;
output s_out;
reg s_out;
always @(s_in)
    s_out = s_in;
endmodule
//----------------------------------------
