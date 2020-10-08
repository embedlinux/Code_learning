//----------------------------------------------------------------------------
//    Design unit : testbench of counter
//    File name   : counter_tb.v
//    System      : Verilog 1993
//    Author      : XinXiaoNing
//    Revision    : Version 1.0 2/24/2005
//----------------------------------------------------------------------------
`timescale 1ns/1ps
module testbench();
//----------------------------------------------------------------------------
//    Signals for mapping Testting module
//----------------------------------------------------------------------------
reg rst,clk,ld,en;
reg [3:0] di;
wire co;
wire [3:0] qo;
//-------------------- Component under test ----------------------------------
counter UUT
(.rst(rst)       ,
 .clk(clk)       ,
 .ld(ld)         ,
 .en(en)         ,
 .d(di)          ,
 .q(qo)          ,
 .co(co));
//----------------------------------------------------------------------------
task half_pulse;
inout clock;
    #10 clock = ~ clock;
endtask
//----------------------------------------------------------------------------
task pulse;
input[7:0] num;
integer i;
    for(i=0;i<num;i=i+1)
    begin
        half_pulse(clk);
        half_pulse(clk);
    end     
endtask
//---------------------------------------------------------------------------- 
initial
begin
    rst = 0;
    clk = 0;
    en = 0;
    ld = 0;
    di = 4'b0000;
end
//----------------------------------------------------------------------------
always 
begin
    rst = 1;
    pulse(2);
    rst = 0;
    en = 1;
    pulse(10);
    ld = 1;
    pulse(1);
    ld = 0;
    pulse(2);
    en =0;
    pulse(2);
    rst = 1;
    en = 1;
    pulse(10);
    $stop();
end
//----------------------------------------------------------------------------
endmodule 
