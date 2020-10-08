//---------------------------------------------------
//---------------------------------------------------
`timescale 1ns/1ns
module div(clk_sys,rst,clk_set,clk_tx);
input clk_sys;
input rst;
input[1:0] clk_set;
output clk_tx;
reg[3:0] cnt;
//---------------------------------------------------
always @(posedge clk_sys or posedge rst)
begin
    if(rst == 1'b1)
        cnt <= 4'b0000;
    else begin
        case(clk_set)
            2'b00 :  cnt <= cnt + 4'b1000;
            2'b01 :  cnt <= cnt + 4'b0100;
            2'b10 :  cnt <= cnt + 4'b0010;
            2'b11 :  cnt <= cnt + 4'b0001;
            endcase
        end
end
//---------------------------------------------------
assign clk_tx = cnt[3];
//---------------------------------------------------
endmodule 