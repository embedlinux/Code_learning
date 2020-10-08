//----------------------------------------------------------------------------
//    Design unit : FIFO module DEPTH = 16 WIDTH = 8
//    File name   : frame_fifo.v
//    System      : Verilog
//    Author      : XinXiaoNing
//    Revision    : Version 0.5 11/21/2003
//----------------------------------------------------------------------------
`timescale 1ns/1ps
module fifo16x8
(rst      ,
 clk      ,
 clr      ,
 rd_n     ,
 wr_n     ,
 di       ,
 do       ,
 full     ,
 empty
 );
//----------------------------------------------------------------------------
//           data type definitions.
//---------------------------------------------------------------------------- 
input rst;                    // system reset signal,active high 
input clk;                    // system clock signal.
input clr;                    // clear signal.
input rd_n;                   // FIFO read signal,active low.
input wr_n;                   // FIFO write signal,active low.
input[7:0] di;
output[7:0] do;
output full;
output empty;
//----------------------------------------------------------------------------
//    Internal Variables.Reg[0]-Reg[3] are 4 registers,pWR and pRD are 
//    Address when write or read.Full and Empty are internal signals.
//----------------------------------------------------------------------------
reg[7:0] elem[15:0];
reg[3:0] p_wr;
reg[3:0] p_rd;
reg full;
reg empty;
reg[7:0] do;
reg empty_m;
//----------------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        do <= 8'h00;
    else if(rd_n == 1'b0)
        do <= elem[p_rd];
end
//----------------------------------------------------------------------------
//   This process is used to change write pointer.
//----------------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        p_wr <= 4'b0000;
    else if(clr == 1'b1)
        p_wr <= 4'b0000;
    else if((wr_n == 1'b0) && (full == 1'b0)) begin
        elem[p_wr] <= di;
        p_wr <= p_wr + 1'b1;
        end
end
//----------------------------------------------------------------------------
//  This process is used to change Read pointer.
//----------------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        p_rd <= 4'b0000;
    else if(clr == 1'b1)
        p_rd <= 4'b0000;
    else if((rd_n == 1'b0) && (empty == 1'b0))
        p_rd <= p_rd + 1'b1;
end
//----------------------------------------------------------------------------
//    This process is used to set or clear the Empty signal.
//----------------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        empty <= 1'b1;
    else 
        empty <= empty_m;
end
//----------------------------------------------------------------------------
always @(rd_n or wr_n or empty or p_wr or p_rd or clr)
begin
    if((clr == 1'b1) || ((p_wr == p_rd + 1) && (rd_n == 1'b0) && (wr_n == 1'b1)))
        empty_m = 1'b1;
    else if((wr_n == 1'b0) && (rd_n == 1'b1))
        empty_m = 1'b0;     
    else
        empty_m = empty;
end            
//----------------------------------------------------------------------------
//    This process is used to set or clear the Full signal.
//----------------------------------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst == 1'b1)
        full <= 1'b0;
    else if(clr == 1'b1)
        full <= 1'b0;
    else if((p_wr == (p_rd + 4'b1111)) && (wr_n == 1'b0) && (rd_n == 1'b1))
        full <= 1'b1;
    else if((full == 1'b1) && (rd_n == 1'b0))
        full <= 1'b0;
end
endmodule
//------------------------------ END ----------------------------------------