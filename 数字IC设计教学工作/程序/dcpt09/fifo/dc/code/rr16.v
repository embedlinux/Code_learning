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
reg[7:0] re0;
reg[7:0] re1;
reg[7:0] re2;
reg[7:0] re3;
reg[7:0] re4;
reg[7:0] re5;
reg[7:0] re6;
reg[7:0] re7;
reg[7:0] re8;
reg[7:0] re9;
reg[7:0] re10;
reg[7:0] re11;
reg[7:0] re12;
reg[7:0] re13;
reg[7:0] re14;
reg[7:0] re15;
reg[7:0] do_m;
//-----------------------------------------------------------------
// No WRITE action when FIFO is full.
//-----------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1) begin
        re0  <= 8'h00;
        re1  <= 8'h00;
        re2  <= 8'h00;
        re3  <= 8'h00;
        re4  <= 8'h00;
        re5  <= 8'h00;
        re6  <= 8'h00;
        re7  <= 8'h00;
        re8  <= 8'h00;
        re9  <= 8'h00;
        re10 <= 8'h00;
        re11 <= 8'h00;
        re12 <= 8'h00;
        re13 <= 8'h00;
        re14 <= 8'h00;
        re15 <= 8'h00;
        end
    else if((wr_n == 1'b0) && (full == 1'b0)) begin
        case(aw)
            4'h0  : re0  <= d;
            4'h1  : re1  <= d;
            4'h2  : re2  <= d;
            4'h3  : re3  <= d;
            4'h4  : re4  <= d;
            4'h5  : re5  <= d;
            4'h6  : re6  <= d;
            4'h7  : re7  <= d;
            4'h8  : re8  <= d;
            4'h9  : re9  <= d;
            4'ha  : re10 <= d;
            4'hb  : re11 <= d;
            4'hc  : re12 <= d;
            4'hd  : re13 <= d;
            4'he  : re14 <= d;
            4'hf  : re15 <= d;
            endcase
        end
end
//-----------------------------------------------------------------
// Output do_m is combinational signal in this module.
//-----------------------------------------------------------------
always @
(   ar
 or re0
 or re1
 or re2
 or re3
 or re4
 or re5
 or re6
 or re7
 or re8
 or re9
 or re10
 or re11
 or re12
 or re13
 or re14
 or re15
 )
begin
    case(ar)
        4'h0  : do_m = re0;
        4'h1  : do_m = re1;
        4'h2  : do_m = re2;
        4'h3  : do_m = re3;
        4'h4  : do_m = re4;
        4'h5  : do_m = re5;
        4'h6  : do_m = re6;
        4'h7  : do_m = re7;
        4'h8  : do_m = re8;
        4'h9  : do_m = re9;
        4'ha  : do_m = re10;
        4'hb  : do_m = re11;
        4'hc  : do_m = re12;
        4'hd  : do_m = re13;
        4'he  : do_m = re14;
        4'hf  : do_m = re15;
        endcase
end
//-----------------------------------------------------------------
endmodule