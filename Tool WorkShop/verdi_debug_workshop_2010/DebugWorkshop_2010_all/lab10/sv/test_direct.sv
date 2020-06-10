/*###############################################################
###                                                           ###
###   Test Direct                                             ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###   Original 'e' version                                    ###
###   (c) 1996, 1997, 1998 Novas Software Inc.                ###
###############################################################*/

`timescale 1 ns / 1ns

// This test runs a directed sequence converted from the Novas file
// test_direct.sv.

class cpu_program_direct extends cpu_program; 
    function new(string name, string instance);
        super.new(name, instance);
    endfunction: new

    virtual function void gen_program();
        //var inst_i: Immediate cpu_instr;
        //var inst_n: NoOperand cpu_instr;
        //var inst_a: Absolute cpu_instr;

        cpu_instr inst;
        
        instr_stop_addr=0;
        
        // LDA  8'hff
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==LDA;
            inst.operand==8'hff;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();

        // INCA
        // cause CF=1 and ZF=1
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==INCA;
            inst.operand==instr_stop_addr;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // LDA  8'h1
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==LDA;
            inst.operand==8'h1;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // ADDA 8'hff
        // cause CF=1 and ZF=1
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==ADDA;
            inst.operand==8'hff;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // LDA  8'h1
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==LDA;
            inst.operand==8'h1;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();

        // STA_ start_write_addr
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==STA_;
            inst.operand==start_write_addr;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // LDA  8'hff
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==LDA;
            inst.operand==8'hff;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // ADDA_ start_write_addr
        // cause CF=1 and ZF=1
        inst=new(log);
        assert(inst.randomize() with {
        inst.operation==ADDA_;
        inst.operand==start_write_addr;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // LDA  8'h80
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==LDA;
            inst.operand==8'h80;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // STA_ end_write_addr
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==STA_;
            inst.operand==end_write_addr;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
        
        // SUBA end_write_addr
        // cause CF=1 and ZF=1
        inst=new(log);
        assert(inst.randomize() with {
            inst.operation==SUBA;
            inst.operand==end_write_addr;
        }) else `vmm_error(log, "Couldn't randomize instruction.");
        inst.start_addr=instr_stop_addr;
        instr_list[inst.start_addr] = inst;
        instr_stop_addr+=inst.get_size();
    endfunction: gen_program
endclass: cpu_program_direct


// This test runs the builtin generator from cpu_program.sv.
program test ();

    cpu_env env;
    cpu_env_log_fmt fmt;

    cpu_program_direct my_cpu_pgm = new("directed_program", "");

    // Connect virtual interface to testbench.
    cpu_if_wrapper cpu_if_wrapper_i = new("cpu_if_wrapper_i", cpu_tb_top.i_cpu_if);
    pram_if_wrapper pram_if_wrapper_i = new("pram_if_wrapper_i", cpu_tb_top.i_pram_if);

    initial begin
        env = new(cpu_if_wrapper_i, pram_if_wrapper_i);
        fmt = new;
        env.log.set_format(fmt);
        `vmm_verbose(env.log,"Testing log message printing from the env.");
        env.build();
        env.cpu_ref.pgm = my_cpu_pgm;
        env.run();
    end
endprogram: test 

