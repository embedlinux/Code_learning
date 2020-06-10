/*###############################################################
###                                                           ###
###   Test Random                                             ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###############################################################*/
`timescale 1 ns / 1ns

// This test runs the builtin generator from cpu_program.sv.
program test ();

    cpu_env env;
    cpu_env_log_fmt fmt;
    int novas_severity = 7;

    // Connect virtual interface to testbench.
    cpu_if_wrapper cpu_if_wrapper_i = new("cpu_if_wrapper_i", cpu_tb_top.i_cpu_if);
    pram_if_wrapper pram_if_wrapper_i = new("pram_if_wrapper_i", cpu_tb_top.i_pram_if);

    initial begin
        env = new(cpu_if_wrapper_i, pram_if_wrapper_i);
        fmt = new;
        env.log.set_format(fmt);
        `vmm_verbose(env.log,"Testing log message printing from the env.");
	`FSDBLOG0("Testing log message printing from the env","",`NOVAS_VERBOSE,"test")
        env.build();
        env.run();
    end
endprogram: test 

