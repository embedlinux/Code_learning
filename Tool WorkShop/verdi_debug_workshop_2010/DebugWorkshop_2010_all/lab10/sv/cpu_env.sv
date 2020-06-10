/*###############################################################
###                                                           ###
###   CPU ENV                                                 ###
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

`ifndef CPU_ENV_SV
`define CPU_ENV_SV
`include "vmm.sv"

typedef class cpu_ref_instr_cover_callback;

class cpu_env extends vmm_env;
    // Environment components
    cpu_duv  cpu_duv;
    pram_duv pram_duv;
    cpu_ref        cpu_ref;
    vmm_notify     memory_notify;

    cpu_if_wrapper wrap_cpu_if;
    pram_if_wrapper wrap_pram_if;

    // Control Properties
    bit sample_prop;

    // constructor
    function new(cpu_if_wrapper c, pram_if_wrapper p);
        super.new();
        wrap_cpu_if = c;
        wrap_pram_if = p;
    endfunction: new

    // build
    virtual function void build();
        string inst_name;
        cpu_ref_instr_cover_callback cpu_ref_cover_cb;
        super.build();

        memory_notify = new(log);
        memory_notify.configure(modified, vmm_notify::ON_OFF);

        cpu_duv = new("cpu_duv", "", wrap_cpu_if);
        pram_duv = new("pram_duv", "", wrap_pram_if, memory_notify);

        cpu_ref = new("cpu_ref", "", pram_duv, cpu_duv, memory_notify);
        cpu_ref.build();

        cpu_ref_cover_cb = new();
        cpu_ref.append_callback(cpu_ref_cover_cb);
    endfunction: build

    // From cpu_top.e
    virtual task start();
        super.start();
         `vmm_note(log, "Starting the run task for the cpu_env.");
     	 `FSDBLOG0("Starting the run task for the cpu_env","start",`NOVAS_VERBOSE,$psprintf("%m"))

         assert(cpu_ref.randomize()) else 
             `vmm_error(log, "Couldn't randomize the CPU reference model.");
 
         cpu_ref.pgm.gen_program();
         cpu_ref.pram.set_program(cpu_ref.pgm);
         cpu_ref.pgm.dump_program();
         cpu_ref.pram.dump_memory();
         
         pram_duv.set_mem(cpu_ref.pram);  
               
         // About to start transactors.
         cpu_ref.start_xactor();
         cpu_duv.start_xactor();
         pram_duv.start_xactor();

         `vmm_verbose(log, "About to fork off do_begin_reset and run_program");
     	 `FSDBLOG0("About to fork off do_begin_reset and run_program","start",`NOVAS_VERBOSE,$psprintf("%m"))
         fork 
             cpu_ref.do_begin_reset();
             cpu_duv.run_program(4);
         join_none
         `vmm_verbose(log, "Finished starting do_begin_reset and run_program");
     	  `FSDBLOG0("Finished starting do_begin_reset and run_program","start",`NOVAS_VERBOSE,$psprintf("%m"))
    endtask: start

    virtual task wait_for_end();
        super.wait_for_end();

        // How long to run the simulation for (however, system.v times out
        // after 12500 ns).
        #10000000;
        `vmm_verbose(log, "wait_for_end() finished.");
     	`FSDBLOG0("wait_for_end() finished ","wait_for_end",`NOVAS_VERBOSE,$psprintf("%m"))
    endtask: wait_for_end
endclass: cpu_env
`endif // CPU_ENV_SV
