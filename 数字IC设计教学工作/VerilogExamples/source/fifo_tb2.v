//----------------------------------------------------------------------------
//    Design unit : testbench of FIFO_4_8
//    File name   : fifo_tb.v
//    System      : Verilog
//    Author      : XinXiaoNing
//    Revision    : Version 0.5 02/05/2003
//----------------------------------------------------------------------------
`timescale 1ns/1ps
module testbench();
//----------------------------------------------------------------------------
//    Signals for mapping Testting module
//----------------------------------------------------------------------------
reg rst,clk,clr,wr_n,rd_n;
reg [7:0] di;
wire full_o,empty_o;
wire [7:0] do;
//-------------------- Component under test ----------------------------------
fifo16x8 fifo
(.rst(rst)       ,
 .clk(clk)       ,
 .clr(clr)       ,
 .rd_n(rd_n)     ,
 .wr_n(wr_n)     , 
 .di(di)         ,
 .do(do)         ,
 .full(full_o)   ,
 .empty(empty_o));
//---------------------Variable for Simulation -------------------------------
reg[7:0] test_data[9:0];
//----------------------------------------------------------------------------
task half_pulse;
inout clock;
begin
    #10 clock = ~ clock;
end
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
task write_byte;
input[7:0] data;
    begin
        di = data;
        wr_n = 1'b0;
        pulse(1);
        wr_n = 1'b1;
        pulse(1);
    end    
endtask
//----------------------------------------------------------------------------
task read_byte;
output[7:0] data_buf;
    begin
        rd_n = 1'b0;
        pulse(1);
        data_buf = do;
        rd_n = 1'b1;
        pulse(1);
    end
endtask 
//---------------------------------------------------------------------------- 
initial
begin
    rst = 0;
    clk = 0;
    clr = 0;
    rd_n = 1;
    wr_n = 1;
    di = 8'h00;
end
always 
begin
    rst = 1;
    pulse(2);
    rst = 0;
    pulse(2);
    write_byte(8'h01);
    write_byte(8'h02);
    write_byte(8'h03);
    read_byte(test_data[0]);   // should be 01H
    if(test_data[0] != 8'h01) begin
        $display("error at step1");
        $stop();
        end
    read_byte(test_data[1]);   // should be 02H
    if(test_data[1] != 8'h02) begin
        $display("error at step2");
        $stop();
        end
    write_byte(8'h11);
    write_byte(8'h12);
    write_byte(8'h13);         // should FULL    
    read_byte(test_data[2]);   // should be 03H
    if(test_data[2] != 8'h03) begin
        $display("error at step3");
        $stop();
        end
    read_byte(test_data[3]);   // should be 11H
    if(test_data[3] != 8'h11) begin
        $display("error at step4");
        $stop();
        end
    read_byte(test_data[4]);   // should be 12H
    if(test_data[4] != 8'h12) begin
        $display("error at step5");
        $stop();
        end
    read_byte(test_data[5]);   // should be 13H
    if(test_data[5] != 8'h13) begin
        $display("error at step6");
        $stop();
        end
    clr = 1'b1;
    pulse(1);
    write_byte(8'h01);
    read_byte(test_data[0]);   // should be 01H
    if(test_data[0] != 8'h01) begin
        $display("error at step7");
        $stop();
        end
    pulse(2);
    $display("no error found");
    $stop();
end
//----------------------------------------------------------------------------
endmodule 
