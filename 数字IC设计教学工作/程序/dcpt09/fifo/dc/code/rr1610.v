//-----------------------------------------------------------------
// Design unit : rr16
// This is a RTL level description of the registers in FIFO.
//-----------------------------------------------------------------
`timescale 1ns/1ps 
module rr16(clk,rst,aw,ar,d,wr_n,full,do_m);
input clk;
input rst;
input[3:0] aw;
input[3:0] ar;
input[7:0] d;
input wr_n;
input full;
output[7:0] do_m;
//-----------------------------------------------------------------
reg[7:0] re[0:15];
//-----------------------------------------------------------------
// No WRITE action when FIFO is full.
//-----------------------------------------------------------------
always @(posedge clk)
begin
    if((wr_n == 1'b0) && (full == 1'b0)) begin
        case(aw)
            4'h0  : re[0]  <= d;
            4'h1  : re[1]  <= d;
            4'h2  : re[2]  <= d;
            4'h3  : re[3]  <= d;
            4'h4  : re[4]  <= d;
            4'h5  : re[5]  <= d;
            4'h6  : re[6]  <= d;
            4'h7  : re[7]  <= d;
            4'h8  : re[8]  <= d;
            4'h9  : re[9]  <= d;
            4'ha  : re[10] <= d;
            4'hb  : re[11] <= d;
            4'hc  : re[12] <= d;
            4'hd  : re[13] <= d;
            4'he  : re[14] <= d;
            4'hf  : re[15] <= d;
            endcase
        end
end
//-----------------------------------------------------------------
// Output do_m is combinational signal in this module.
//-----------------------------------------------------------------
always @(ar or re)
begin
    case(ar)
        4'h0  : do_m = re[0];
        4'h1  : do_m = re[1];
        4'h2  : do_m = re[2];
        4'h3  : do_m = re[3];
        4'h4  : do_m = re[4];
        4'h5  : do_m = re[5];
        4'h6  : do_m = re[6];
        4'h7  : do_m = re[7];
        4'h8  : do_m = re[8];
        4'h9  : do_m = re[9];
        4'ha  : do_m = re[10];
        4'hb  : do_m = re[11];
        4'hc  : do_m = re[12];
        4'hd  : do_m = re[13];
        4'he  : do_m = re[14];
        4'hf  : do_m = re[15];
        endcase
end
//-----------------------------------------------------------------
endmodule