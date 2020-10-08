//---------------------------------------------------
// First example of verilog
//---------------------------------------------------
module counter(clk,rst,ld,di,q,cy);
input clk;
input rst;
input ld;
input[3:0] di;
output[3:0] q;
output cy;
//---------------------------------------------------
reg[3:0] q;
reg cy;
//---------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        q <= 4'b0000;
    else if(ld == 1'b1)
        q <= di;
    else
        q <= q + 1'b1;
end
//---------------------------------------------------
always @(q)
begin
    if(q == 4'b1111)
        cy = 1'b1;
    else
        cy = 1'b0;
end
//---------------------------------------------------
endmodule
