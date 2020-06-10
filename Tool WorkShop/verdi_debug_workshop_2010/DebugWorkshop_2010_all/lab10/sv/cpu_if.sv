/*###############################################################
###                                                           ###
###   CPU IF                                                  ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###############################################################*/

// Create an interface to allow the testbench to connect to the CPU.

`ifndef CPU_IF_SV
`define CPU_IF_SV
//`timescale 1 ns / 1ns

interface cpu_if (
    input clock
); 
    //logic clock;
    logic reset_cpu;

    //event clk_rise;
    //event clk_fall;
    event begin_reset;
    event end_reset;
    event next_instr;

    logic [7:0] reg_ACC;
    logic [7:0] reg_IXR;
    logic [7:0] reg_PC;
    logic [7:0] reg_CF;
    logic [7:0] reg_ZF;

    logic [7:0] ccu_MA;

    //always @(posedge clock) ->clk_rise;
    //always @(negedge clock) ->clk_fall;
endinterface

`endif
