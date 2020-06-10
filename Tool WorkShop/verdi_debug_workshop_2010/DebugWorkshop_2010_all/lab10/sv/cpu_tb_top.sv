/*###############################################################
###                                                           ###
###   CPU TB Top                                              ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###############################################################*/

`timescale 1 ns / 1ns

// Extend format_msg() to change the way the vmm messages are
// printed to the screen.
class cpu_env_log_fmt extends vmm_log_format;
    virtual function string format_msg( string name,
                                        string instance,
                                        string msg_type,
                                        string severity,
                                        ref string lines[$]);
        $sformat(format_msg, "%0t %s [%0s:%0s] |",
                $time, name, severity, msg_type);
        foreach (lines [ l ] )
            $sformat(format_msg, "%s %s", format_msg, lines[l]);
    endfunction: format_msg

endclass: cpu_env_log_fmt

module cpu_tb_top;
    `include "cpu.svh"

    // NOTE: May want to get rid of cpu_tb_top and instantiate the program block
    // for the test environment under system.  Did not do this yet in case the
    // system module was not meant to be disturbed (easier to swap in Verilog rtl?).
    system system();

    reg clock;
    reg reset_cpu;
    wire [7:0] addr;
    wire [7:0] data;

    // Interface to pass signals back into SVTB.
    cpu_if i_cpu_if(clock);
    pram_if i_pram_if(clock);

    assign clock = system.clock;
    always @(*) system.reset_cpu = i_cpu_if.reset_cpu;
    assign i_cpu_if.reg_ACC = system.i_cpu.i_ALUB.ACC;
    assign i_cpu_if.reg_IXR = system.i_cpu.i_ALUB.IXR;
    assign i_cpu_if.reg_PC = system.i_cpu.i_ALUB.PC;
    assign i_cpu_if.reg_CF = system.i_cpu.i_ALUB.carry_flag;
    assign i_cpu_if.reg_ZF = system.i_cpu.i_ALUB.zero_flag;
    assign i_cpu_if.ccu_MA = system.i_cpu.i_CCU.MA;

    // PRAM interface
    // Inputs to TB
    assign i_pram_if.VMA = system.i_pram.VMA;
    assign i_pram_if.addr = system.i_pram.addr;
    assign i_pram_if.R_W = system.i_pram.R_W;
    assign i_pram_if.data = system.i_pram.data;
    // Outputs from TB
    assign system.i_pram.dataout = i_pram_if.dataout;

endmodule: cpu_tb_top
