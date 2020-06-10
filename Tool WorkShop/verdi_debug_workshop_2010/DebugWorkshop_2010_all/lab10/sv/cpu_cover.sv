/*###############################################################
###                                                           ###
###   Coverage definitions for the CPU testbench.             ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###############################################################*/

// Based on cpu_cover.e.  NOTE: Using VMM callbacks based on the
// cpu_ref class to collect coverage that was previously collected
// using an extension of cpu_instr and another of cpu_ref.
class cpu_ref_instr_cover_callback extends cpu_ref_callbacks;
    static vmm_log log = new("cpu_ref_instr_cover_callback", "class");

    // Save a pointer to the CPU Register model for coverage
    // comparison purposes.
    cpu_regs regs;

    function new();
        super.new();
        cover_instr = new();
        cover_flags = new();
        prev_instr = null;
        instr = null;
    endfunction: new

    event collect_exec_instr;
    cpu_instr instr;

    // Tracking both previous instruction *and* the previous operation
    // because VCS chokes if prev_instr is null (even though I've guarded
    // it with 'iff (prev_instr != null)').
    cpu_instr prev_instr;
    cpu_operation_e prev_operation;

    virtual function void exec_instr(cpu_regs r, cpu_instr i);
        real current_coverage;
        if (instr != null) begin
            prev_operation = instr.operation;
        end
        regs = r;
        prev_instr = instr;
        instr = i;
        `vmm_verbose(log, 
            $psprintf("About to sample coverage for instruction %s.", 
                        i.operation.name()));
//rich_modify
//        `FSDBLOG1("About to sample coverage for instruction","exec_instr",`NOVAS_VERBOSE,$psprintf("%m"), $psprintf("i.operation.name=",i.operation.name()))
	$fsdbLog("About to sample coverage for instruction","exec_instr",4,$psprintf("%m"),$psprintf("i.operation.name=",i.operation.name()));
        cover_instr.sample();
        cover_flags.sample();
        current_coverage = $get_coverage();
//rich_modify
//        `FSDBLOG1("get_coverage","exec_instr",`NOVAS_VERBOSE4,$psprintf("%m"),current_coverage)
	$fsdbLog("get_coverage","exec_instr",4,$psprintf("%m"),current_coverage);
    endfunction: exec_instr

    covergroup cover_instr;
        coverpoint instr.operation; 
        coverpoint instr.mode;

        // This point is just for use in the cross later on.
        coverpoint prev_operation {
            option.weight = 0;
        }

        // from: when Absolute cpu_instr {        
        //           item abs_addr using ranges = {
        coverpoint instr.operand iff (instr.mode == Absolute) {
             bins AbsoluteLow = {[0:100]}; 
             bins AbsoluteHigh= {[101:255]}; 
        } 

        // Using "cross" instead of transition coverage because VCS doesn't
        // appear to support the syntax required to make transitions appear
        // with the enum strings in URG.
       //wl  : not support by 2008.03
       //   cross instr.operation, prev_operation iff (prev_instr != null);

    endgroup: cover_instr
    
    covergroup cover_flags;

        INCA_set_zflag: coverpoint (instr.operation==INCA && regs.ZF==1);
        INCA_set_cflag: coverpoint (instr.operation==INCA && regs.CF==1);
        INCA_zflag_cross_cflag:cross INCA_set_zflag, INCA_set_cflag;
        
        ADDA_set_zflag: coverpoint (instr.operation==ADDA && regs.ZF==1);
        ADDA_set_cflag: coverpoint (instr.operation==ADDA && regs.CF==1);
        ADDA_zflag_cross_cflag:cross ADDA_set_zflag, ADDA_set_cflag;
 
        ADDA__set_zflag: coverpoint (instr.operation==ADDA_ && regs.ZF==1);
        ADDA__set_cflag: coverpoint (instr.operation==ADDA_ && regs.CF==1);
        ADDA__zflag_cross_cflag: cross ADDA__set_zflag, ADDA__set_cflag; 
        
        SUBA_set_zflag: coverpoint (instr.operation==SUBA && regs.ZF==1);
        SUBA_set_cflag: coverpoint (instr.operation==SUBA && regs.CF==1); 

        BNZ_by_zflag: coverpoint (instr.operation==BNZ && regs.ZF!=1);

    endgroup: cover_flags

endclass: cpu_ref_instr_cover_callback
