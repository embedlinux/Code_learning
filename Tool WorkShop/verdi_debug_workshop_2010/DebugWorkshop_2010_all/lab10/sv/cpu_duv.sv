/*###############################################################
###                                                           ###
###   CPU DUV Agent                                           ###
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


// Define the CPU duv (compare to Novas CPU tb)

`ifndef CPU_DUV_AGENT_SV
`define CPU_DUV_AGENT_SV

// NOTE: Do we need to include code for TEST_VERILOG_BEHV or TEST_VHDL?
`ifdef TEST_VHDL 
    // NOTE: Not Converted from e.
    `define NEXT_INST_SIG 'i_cpu/i_CCU/n_dout2'==3; 
`else
    `ifdef TEST_VERILOG_BEHV
        // NOTE: Not Converted from e.
        `define NEXT_INST_SIG 'i_cpu/new_inst'==1; // NOTE: Not Converted from e
    `else 
        `define NEXT_INST_SIG if_wrap_i.i_cpu_if.ccu_MA == 1
    `endif
`endif

class cpu_if_wrapper;
    virtual cpu_if i_cpu_if;

    function new(string name, virtual cpu_if _if);
        i_cpu_if = _if;
    endfunction: new

endclass: cpu_if_wrapper


class cpu_duv extends vmm_xactor;
    cpu_instr i;
    bit stop_run = CPU_FALSE; 
    event begin_reset_e;
    event end_reset_e;
    event next_instr_e;

    // Instance of the CPU register model.
    cpu_regs regs; 

    // Connect agent to the DUT
    cpu_if_wrapper if_wrap_i;

    function new(string name, string instance, cpu_if_wrapper cif);
        super.new(name, instance);

        i = new(log);
        if (i.randomize() != 1) begin
            `vmm_error(log, "Randomize failed for cpu_instr object.");
        end

        regs = new();
        if_wrap_i = cif;
        
    endfunction: new

    virtual function void sample_regs();
        regs.ACC = if_wrap_i.i_cpu_if.reg_ACC;
        regs.IXR = if_wrap_i.i_cpu_if.reg_IXR;
        regs.PC  = if_wrap_i.i_cpu_if.reg_PC;
        regs.CF  = if_wrap_i.i_cpu_if.reg_CF;
        regs.ZF  = if_wrap_i.i_cpu_if.reg_ZF;
`ifdef TEST_VERILOG_BEHV
// Taken from cpu_duv.e:
//	    'i_cpu/i_ALUB/alu_mode'=regs.alu_mode;
//   	    'i_cpu/i_ALUB/bus_mode'=regs.bus_mode;
//	    'i_cpu/i_ALUB/carry_mode'=regs.carry_mode;

// BOZO: Ported to SV, but commented out and not yet implemented
// in the regs data structure.
//       if_wrap_i.i_cpu_if.alu_mode   = regs.alu_mode;
//       if_wrap_i.i_cpu_if.bus_mode   = regs.bus_mode;
//       if_wrap_i.i_cpu_if.carry_mode = regs.carry_mode;
`elsif
        regs.second.s1 = if_wrap_i.alub_reg_S1;
        regs.second.err_out = if_wrap_i.alub_reg_error_out;
        regs.second.X0 = if_wrap_i.alub_reg_X0;
        regs.second.Y0 = if_wrap_i.alub_reg_Y0;
`endif
    endfunction: sample_regs

    virtual task reset_cpu(int count);
        stop_run = CPU_TRUE; 
        regs.reset();
        if_wrap_i.i_cpu_if.reset_cpu <= 1;

        // NOTE: Could replace with clocking block or task in interface
        @(negedge if_wrap_i.i_cpu_if.clock); 

        if_wrap_i.i_cpu_if.reset_cpu <= 0;
        ->begin_reset_e;
        repeat(count) @(negedge if_wrap_i.i_cpu_if.clock);
        if_wrap_i.i_cpu_if.reset_cpu <= 1;

        // NOTE: Could replace with clocking block or task in interface

        // NOTE: In Specman this was wait[0]. Not sure, but it seems like
        // we probably need to replace @(negedge...) with a #0.  However, the
        // behavior does not match the Specman version if we do that, so
        // leaving it as is for now.
        @(negedge if_wrap_i.i_cpu_if.clock); 
         
        sample_regs();
        `vmm_note(log, "DUV signaling end of reset.");
	`FSDBLOG0("DUV signaling end of reset","",`NOVAS_NOTE,$psprintf("%m"));
        ->end_reset_e;
        
    endtask: reset_cpu

    virtual task next_instr();
        while (stop_run == CPU_FALSE) begin 
            if (`NEXT_INST_SIG) begin
                sample_regs();
                //`novas_vmm_note(log, $psprintf("Instruction completed.") );
		`FSDBLOG0("instruction completed","",`NOVAS_NOTE,$psprintf("%m"));
                ->next_instr_e;
            end
            @(negedge if_wrap_i.i_cpu_if.clock); 
        end

        // Commented out in latest e version of Novas code drop, so leaving
        // this behind here but commented out as well.
        // Stop the simulation with stop_run() in e....
        //vmm_env.stop(); // VMM method for ending sim...

    endtask: next_instr

    virtual task run_program(int reset_cycle);
        reset_cpu(reset_cycle);
        stop_run = CPU_FALSE;
        next_instr();
    endtask: run_program

endclass: cpu_duv
`endif
