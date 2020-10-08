//----------------------------------------------------------------------------
//    Design unit : counter example 1 for "Digital IC design with Verilog HDL"
//    File name   : counter.v
//    System      : Verilog 1993
//    Author      : XinXiaoNing
//    Revision    : Version 1.0 2/24/2005
//----------------------------------------------------------------------------
`timescale 1ns/1ps
module counter
(rst      ,
 clk      ,
 ld       ,
 en       ,
 d        ,
 q        ,
 co
 );
//----------------------------------------------------------------------------
//           data type definitions.
//---------------------------------------------------------------------------- 
input rst;                    // system reset signal,active high 
input clk;                    // system clock signal.
input ld;                     // signal for load "d" to "q".
input en;                     // count enable signal.
input[3:0] d;                 // data input to counter.
output[3:0] q;                // counter outputs.
output co;                    // carray signal.
//----------------------------------------------------------------------------
reg[3:0] q;
reg co;
//----------------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        q <= 4'b0000;
    else if(ld == 1'b1)
        q <= d;
    else if(en == 1'b1)
        q <= q + 1'b1;
end
//----------------------------------------------------------------------------
always @(q)
begin
    if(q == 4'b1111)
        co = 1'b1;
    else
        co = 1'b0;
end
//------------------------------- END ----------------------------------------
endmodule
