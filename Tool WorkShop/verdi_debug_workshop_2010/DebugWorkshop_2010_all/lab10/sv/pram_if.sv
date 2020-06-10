/*###############################################################
###                                                           ###
###   PRAM IF                                                 ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###############################################################*/
// Create an interface to allow the testbench to connect to the CPU.

`ifndef PRAM_IF_SV
`define PRAM_IF_SV
//`timescale 1 ns / 1ns
interface pram_if (
    input clock
); 
    logic VMA;
    logic [7:0] addr;
    logic [7:0] dataout;
    logic [7:0] data;
    logic R_W; 

endinterface
`endif
