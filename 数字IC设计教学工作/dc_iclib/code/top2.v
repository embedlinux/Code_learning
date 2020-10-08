//---------------------------------------------------
//---------------------------------------------------
`timescale 1ns/1ns
module top(clk_sys,rst,ld,di,clk_set,q,cy);
input clk_sys;
input rst;
input ld;
input[3:0] di;
input[1:0] clk_set;
output[3:0] q;
output cy;
//---------------------------------------------------
wire clk_tx_w;
wire ld_w;
wire cy_w;
wire[1:0] clk_set_w;
wire[3:0] di_w;
//---------------------------------------------------
itf u1
(
.clk_sys(clk_sys)      ,
.rst(rst)              ,
.ld(ld)                ,
.di(di)                ,
.clk_set(clk_set)      ,
.ld_m(ld_w)            ,
.di_m(di_w)            ,
.clk_set_m(clk_set_w)
);
//---------------------------------------------------
div u2
(.clk_sys(clk_sys)     ,
 .rst(rst)             ,
 .clk_set(clk_set_w)   ,
 .clk_tx(clk_tx_w)
);
//---------------------------------------------------
counter u3
(.clk(clk_tx_w)        ,
 .rst(rst)             ,
 .ld(ld_w)             ,
 .di(di_w)             ,
 .q(q)                 ,
 .cy(cy_w)
);
//---------------------------------------------------
dly u4
(.s_in(cy_w)           ,
 .s_out(cy)
);
//---------------------------------------------------
endmodule 
