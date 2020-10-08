//------------------------------------------------------------
//------------------------------------------------------------
`timescale 1ns/1ns
module itf(clk_sys,rst,ld,di,clk_set,ld_m,di_m,clk_set_m);
input clk_sys;
input rst;
input ld;
input[3:0] di;
input[1:0] clk_set;
output ld_m;
output[3:0] di_m;
output[1:0] clk_set_m;
//------------------------------------------------------------
reg ld_m;
reg[1:0] clk_set_m;
reg[3:0] di_m;
//------------------------------------------------------------
always @(posedge clk_sys or posedge rst)
begin
    if(rst == 1'b1)
        ld_m <= 1'b0;
    else
        ld_m <= ld;    
end
//------------------------------------------------------------
always @(posedge clk_sys or posedge rst)
begin
    if(rst == 1'b1)
        di_m <= 4'b0000;
    else
        di_m <= di;
end
//------------------------------------------------------------
always @(posedge clk_sys or posedge rst)
begin
    if(rst == 1'b1)
        clk_set_m <= 2'b00;
    else
        clk_set_m <= clk_set;
end
//------------------------------------------------------------
endmodule 