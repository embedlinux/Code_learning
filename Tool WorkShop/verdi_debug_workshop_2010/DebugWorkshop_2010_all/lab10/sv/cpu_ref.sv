/*###############################################################
###                                                           ###
###   CPU Ref                                                 ###
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

typedef class cpu_ref;
typedef class cpu_regs;
typedef class cpu_instr;
typedef class pram_duv;
typedef class cpu_duv;

// Use VMM callback mechanism to allow external objects to 
// probe for information from the cpu_ref behavioral model.
virtual class cpu_ref_callbacks extends vmm_xactor_callbacks;
    // Callback that occurs just after an instruction
    // has been executed.
    virtual function void exec_instr(cpu_regs r, cpu_instr i);
    endfunction: exec_instr
endclass: cpu_ref_callbacks


class cpu_ref extends vmm_xactor;
    cpu_regs regs;
    rand cpu_program pgm;
    pram_ref pram;
    pram_duv pram_duv_ptr;
    bit out_of_inst;
    cpu_duv cpu_duv_ptr;
    vmm_notify memory_notify;

    cpu_instr inst;
    event exec_inst_done;
    cpu_word_t instr_index;

    function new(input string name, 
                 string instance, 
                 pram_duv pd, 
                 cpu_duv cd, 
                 vmm_notify notifier);
        super.new(name, instance);
        regs = new();
        memory_notify = notifier;
        pram_duv_ptr = pd;
        cpu_duv_ptr = cd;
    endfunction: new

    virtual function void build();

        `vmm_verbose(log, "About to create pram_ref pram.");
//rich_modify
//	`FSDBLOG0("about to create pram_ref pram","build",`NOVAS_VERBOSE,$psprintf("%m"))
	$fsdbLog("about to create pram_ref pram","build",4,$psprintf("%m"));	
	$display("????????????????????????");
        pram = new("pram", "", memory_notify);

        `vmm_verbose(log, "About to create cpu_program pgm.");
//rich_modify
//	`FSDBLOG0("about to create cpu_program pgm","build",`NOVAS_VERBOSE,$psprintf("%m"))
	$fsdbLog("about to create cpu_program pgm","build",4,$psprintf("%m"));
        pgm = new("program", "");
        assert (pgm != null)
        else begin
            `vmm_error(log, "pgm was null in build()");
        end
    endfunction: build

    virtual function void reset_cpu();
        $write("<<< Reset the CPU reference model. >>>\n");

        regs.reset();
        out_of_inst=CPU_FALSE; 
    endfunction: reset_cpu

    virtual function void execute_inst();
        int unsigned more_instrs;

        if(regs.PC==pgm.instr_stop_addr) begin
            `vmm_note(log, "<<< Execute the out of instruction in the test program. >>>");
            out_of_inst=1;
            return;
        end

        assert(pgm != null)
        else begin
            `vmm_error(log, "pgm is null in cpu_ref.");
        end

        // Get next instruction as referenced by the program counter.
        inst = pgm.instr_list[regs.PC];
        assert(inst != null)
        else begin
            `vmm_error(log, $psprintf("PC=%x does not point to a valid pgm entry.", regs.PC));
        end

        $write("0x%02x\t", inst.start_addr);
        inst.print_instr();
        inst.execute(this);
        //regs.dump_regs();

        // Allow users to look at each instruction after execution
        // is complete.
        `vmm_callback(cpu_ref_callbacks, exec_instr(regs, inst));

        ->exec_inst_done;
    endfunction: execute_inst

    virtual function cpu_word_t read_mem(cpu_word_t addr);
        return pram.read(addr);
    endfunction: read_mem

    virtual function void write_mem(cpu_word_t addr, cpu_word_t data);
        pram.write(addr, data);
    endfunction: write_mem

    virtual function void run_program(int inst_count);
        reset_cpu();

        for (int i = 1; i <= inst_count; i++) begin
            execute_inst();
            if(out_of_inst) begin
                break;
            end
        end
    endfunction: run_program

    virtual function void check();

        string_queue_t diff;


        // check the result of the previous instruction
        diff = regs.compare(cpu_duv_ptr.regs);

        // Use if statement instead of assert and build up entire msg
        // before calling vmm_error to make resulting error message
        // in log file easier to read.
        if (diff.size() != 0) begin
            string err_msg;
            err_msg = "Inconsistent regs:";
            foreach (diff[i]) begin
                $swrite(err_msg, "%s\n    %s", err_msg, diff[i]);
            end
            //`novas_vmm_note(log, err_msg);
            `vmm_error(log, err_msg);
	    `FSDBLOG1("Inconsistent regs","check",`NOVAS_ERROR,$psprintf("%m"),err_msg)

        end

        if (memory_notify.is_on(modified)) begin
            `vmm_verbose(log, "Saw a mem modified notification, about to do mem compare");
	    `FSDBLOG0("about to do mem compare","check",`NOVAS_VERBOSE,$psprintf("%m"))
            diff = pram.compare(pram_duv_ptr);
            if (diff.size() != 0) begin
                string err_msg;
                err_msg = "Inconsistent mem:";
                foreach (diff[i]) begin
                    $swrite(err_msg, "%s\n    %s", err_msg, diff[i]);
                end
                //`novas_vmm_note(log, err_msg);
                `vmm_error(log, err_msg);
	        `FSDBLOG0("Inconsistent mem ","check",`NOVAS_ERROR,$psprintf("%m"))
            end
            memory_notify.reset(modified);
        end

    endfunction : check

    //------------- From cpu_top.e -----------------
    bit memory_modify = CPU_FALSE; 
    event check_regs;
    virtual task do_begin_reset();
        `vmm_note(log, "Waiting for DUV reset before resetting cpu_ref.");
        @(cpu_duv_ptr.begin_reset_e); // Wait for CPU before resetting the reference model.
        `vmm_note(log, "Starting reset.");
        reset_cpu();

        memory_modify=CPU_FALSE; 

        do_end_reset();

    endtask: do_begin_reset

    virtual task do_end_reset();
        @(cpu_duv_ptr.end_reset_e);
        `vmm_note(log, "<<< Check the initial value after CPU reset >>>\n");

        check();

        do_execute_inst();
    endtask: do_end_reset

    virtual task do_execute_inst();
        bit first_inst;

        first_inst=CPU_TRUE;

        forever begin : do_execute_inst_loop
            if(out_of_inst) begin
                cpu_duv_ptr.stop_run=CPU_TRUE; 
                break;
            end

            if(first_inst==CPU_FALSE) begin : not_first_inst 

                check();

            end
            else begin
                first_inst=CPU_FALSE; 
            end

            `vmm_verbose(log, "About to execute an instruction");
//rich_modify
//	    `FSDBLOG0("about to execute an instruction","do_execute_inst",`NOVAS_VERBOSE,$psprintf("%m"))
	     $fsdbLog("about to execute an instruction","do_execute_inst",4,$psprintf("%m"));

            $write("#%0d\t", $time);
            execute_inst();

            `vmm_verbose(log, "about to wait for the next instruction");
//rich_modify
//	    `FSDBLOG0("about to wait for the next instruction","do_execute_inst",`NOVAS_VERBOSE,$psprintf("%m"))
	    $fsdbLog("about to wait for the next instruction","do_execute_inst",4,$psprintf("%m"));
            @(cpu_duv_ptr.next_instr_e);
            `vmm_verbose(log, "next instruction received");
//rich_modify
//	    `FSDBLOG0("next instruction received","do_execute_inst",`NOVAS_VERBOSE,$psprintf("%m"))
	    $fsdbLog("next instruction received","do_execute_inst",4,$psprintf("%m"));
        end
    endtask: do_execute_inst
endclass: cpu_ref
