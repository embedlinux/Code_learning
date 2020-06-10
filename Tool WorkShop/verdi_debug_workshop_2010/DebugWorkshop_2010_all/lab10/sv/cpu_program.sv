/*###############################################################
###                                                           ###
###   CPU Program                                             ###
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

class cpu_program extends vmm_xactor;
    // NOTE: Changed from cpu_word_t as VCS doesn't support 
    // "byte unsigned" for associative arrays.
    cpu_instr instr_list[*];  

    rand cpu_word_t instr_stop_addr; 
    rand cpu_word_t start_write_addr;
    rand cpu_word_t end_write_addr; 

    function new(string name, string instance);
        super.new(name, instance);
    endfunction: new

    virtual function void pack();
        `vmm_verbose(log, ("Getting ready to pack from cpu_program"));
        `FSDBLOG0("Getting ready to pack from cpu_program","pack",`NOVAS_VERBOSE,$psprintf("%m"))

        assert(instr_list.num() != 0)
        else `vmm_error(log, ("Trying to pack program contents but they have not been generated yet."));
        foreach(instr_list[i]) begin
            `vmm_verbose(log, ($psprintf("About to pack instruction %s (0x%x).", instr_list[i].operation.name(), instr_list[i].start_addr)));
        `FSDBLOG1("About to pack instruction","pack",`NOVAS_VERBOSE,$psprintf("%m"),$psprintf("%s (0x%x).", instr_list[i].operation.name(), instr_list[i].start_addr))
        end
    endfunction: pack

    constraint cpu_address_restrictions {
        start_write_addr<=end_write_addr;
    }

    // NOTE: In SystemVerilog you can't have soft constraints!  So, if
    // someone wants to override this they are going to have to turn off
    // these constraints.
    constraint cpu_address_soft_constraints {
        start_write_addr==8'hf0;
        end_write_addr==8'hff;
    }

    virtual function void gen_program();
        cpu_instr inst;
        // Added count to enable debugging of CPU instruction generation.
        int count;
        bit pre_LDX;

        count = 0;
        pre_LDX = CPU_FALSE;

        instr_stop_addr=0;
        `vmm_verbose(log, $psprintf("B/F while loop - instr_stop_addr = %h, start_write_addr - 1 = %h", instr_stop_addr, (start_write_addr - 1'b1)));
        `FSDBLOG2("B/F while loop","gen_program",`NOVAS_VERBOSE,$psprintf("%m"),instr_stop_addr,start_write_addr)
        while (instr_stop_addr < (start_write_addr - 1'b1)) begin
            `vmm_verbose(log, $psprintf("instr_stop_addr = %h, start_write_addr = %h",
                instr_stop_addr, start_write_addr));

            inst = new(log);

            if (pre_LDX) begin
                // Using this somewhat contorted approach because SystemVerilog does
                // not support "others" when creating a random distribution.
                assert(inst.randomize() with {
                    (inst.instr_percentage == 1)  -> (inst.operation == JMP);
                    (inst.instr_percentage inside {[2:21]}) -> (inst.operation == STA);
                    (inst.instr_percentage inside {[22:100]}) -> !(inst.operation inside {JMP, STA});
                    })
                else `vmm_error(log, "Couldn't randomize an instruction.");
            end
            else begin
                // Using this somewhat contorted approach because SystemVerilog does
                // not support "others" when creating a random distribution.
                assert(inst.randomize() with {
                    (inst.instr_percentage == 1)  -> (inst.operation == JMP);
                    (inst.instr_percentage inside {[2:100]}) -> !(inst.operation inside {JMP, STA});
                    })
                else `vmm_error(log, "Couldn't randomize an instruction.");
            end

            pre_LDX = CPU_FALSE; 
            if (inst.operation == STA_) begin
                //var sta_inst: Absolute cpu_instr;
                assert(inst.randomize(operand) with {
                    inst.operand >= start_write_addr &&
                    inst.operand <= end_write_addr;
                }) else `vmm_error(log, "Couldn't randomize start and end addresses.");
            end
            else if (inst.operation==STA) begin
                cpu_word_t pre_ldx_index;
                cpu_instr pre_ldx_isnt;
                assert(instr_list.last(pre_ldx_index)) else
                    `vmm_error(log, "No last item in instr_list");
                pre_ldx_isnt = instr_list[pre_ldx_index];
                assert(inst.operation != LDX) else
                    `vmm_error(log, $psprintf("Expecting the last instruction to be of type LDX, but it was actually of type %s", inst.operation.name()));
                assert(inst.randomize(operand) with {
                    pre_ldx_isnt.operand<=start_write_addr ->
                        inst.operand>=start_write_addr-pre_ldx_isnt.operand &&
                        inst.operand<=end_write_addr-pre_ldx_isnt.operand;
                    pre_ldx_isnt.operand>start_write_addr ->
                        inst.operand<=255-pre_ldx_isnt.operand;
                }) else `vmm_error(log, "Couldn't randomize start and end addresses.");
            end
            else if (inst.operation == LDX) begin
                pre_LDX = CPU_TRUE; 
            end
            inst.start_addr=instr_stop_addr;
            instr_list[inst.start_addr] = inst;
            instr_stop_addr+=inst.get_size();
            count++;
        end

        `vmm_verbose(log, $psprintf("About to start foreach loop - size = ", instr_list.num()));
        `FSDBLOG1("About to start foreach loop","gen_program",`NOVAS_VERBOSE,$psprintf("%m"),
	$psprintf("instr_list.num() =",instr_list.num()))
        foreach (instr_list[addr]) begin
            if(instr_list[addr].operation==JMP || instr_list[addr].operation==BNZ) begin
                // Correct the destination address of jump instruction
                // to the valid start address of an instruction.
                cpu_word_t jmp_addr;
                int unsigned tmp_count;
                bit jmp_instr_found;
                cpu_instr found_instr;

                jmp_addr=instr_list[addr].operand;

                // NOTE: This is an approximation of the algorithm used in
                // the e version of this testbench.  The foreach loop is used to
                // model the fact that in e we can deal with associative arrays
                // via either their position in the list or via the key (not
                // possible in SV).

                // The jump address is set randomly and could be greater than the
                // number of entries in the list.  Make sure it isn't by taking
                // the modulo.

                //jmp_addr=instr_list[jmp_addr%instr_list.num()].start_addr;

                jmp_addr = jmp_addr%instr_list.num();
                tmp_count = 0;
                jmp_instr_found = 0;
                foreach (instr_list[i]) begin
                    if (tmp_count == jmp_addr) begin
                        jmp_addr = instr_list[i].start_addr;
                        jmp_instr_found = 1;
                        break;
                    end
                    tmp_count++;
                end

                assert(jmp_instr_found == 1) else begin
                    instr_list[addr].print_instr();
                    `vmm_error(log, "Failed to calculate a valid jmp_addr for the above mentioned instruction");
                end
                // Done calculating the jump address.

                found_instr = instr_list[jmp_addr];
                assert(found_instr != null) else begin
                    $write("Working on instruction at start_addr", instr_list[addr].start_addr);
                    instr_list[addr].print_instr();
                    $display("---------");
                    foreach (instr_list[i]) begin
                        $write("%x ", i);
                        instr_list[i].print_instr();
                    end
                `vmm_error(log, $psprintf("Couldn't find an instruction with start addr equal to jmp_addr (0x%x), instr_list.num() = 0x%x", jmp_addr, instr_list.num()));
                end
                if (found_instr.operation==STA) begin
                    bit exists;
                    cpu_instr tmp_instr;
                    if (instr_list.exists(found_instr.start_addr - 8'd1)) begin
                        jmp_addr = found_instr.start_addr - 8'd1;
                    end
                    else if (instr_list.exists(found_instr.start_addr - 8'd2))
                        begin
                        jmp_addr = found_instr.start_addr - 8'd2;
                    end
                    else begin
                        `vmm_error(log, $psprintf("Couldn't find an instruction to jump to."));
                    end
                end

                `vmm_verbose(log, $psprintf("About to add an instruction at address %h", addr));
     		`FSDBLOG1("About to add an instruction at address","gen_program",`NOVAS_VERBOSE,$psprintf("%m"),$psprintf("%h",addr))
                instr_list[addr].operand=jmp_addr;
            end
        end
    endfunction: gen_program

    virtual function void dump_program();
        $display("<<< The test program >>>\n");
        $display("Addr\tInstruction\tOperand\n");
        $display("====\t============\t======\n");
        foreach (instr_list[i]) begin
            $write("0x%02x\t", instr_list[i].start_addr);
            instr_list[i].print_instr();
        end
        $display("==============================\n");

    endfunction: dump_program

endclass: cpu_program
