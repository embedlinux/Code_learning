//----------------------------------------------------------------------------
//    Design unit : testbench of counter
//    File name   : traffic_tb.v
//    System      : Verilog 1993
//    Author      : XinXiaoNing
//    Revision    : Version 1.0 2005-03-15
//----------------------------------------------------------------------------
module testbench();
//----------------------------------------------------------------------------
//    Signals for mapping Testting module
//----------------------------------------------------------------------------
reg rst,clk,req_n;
wire major_red,major_green,minor_red,minor_green,req_ind;
//----------------------------------------------------------------------------
traffic_controller uut
(.clk(clk)                  ,
 .rst(rst)                  ,
 .req_n(req_n)              ,
 .major_red(major_red)      ,
 .major_green(major_green)  ,
 .minor_red(minor_red)      ,
 .minor_green(minor_green)  ,
 .req_ind(req_ind)
);
//----------------------------------------------------------------------------
task half_pulse;
inout clock;
    #10 clock = ~ clock;
endtask
//----------------------------------------------------------------------------
task pulse;
input[9:0] num;
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
    req_n = 1; 
end
//----------------------------------------------------------------------------
always 
begin
    rst = 1;
    pulse(1);
    rst = 0;
    pulse(100);
    req_n = 1'b0;
    pulse(3);
    req_n = 1'b1;
    pulse(50);
    $stop();
end
//----------------------------------------------------------------------------
endmodule 
