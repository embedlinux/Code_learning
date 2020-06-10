/*###############################################################
###                                                           ###
###   CPU INSTR                                               ###
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

`ifndef CPU_INSTR_SV
`define CPU_INSTR_SV

typedef enum cpu_word_t {
    CLRA=8'h04, LDA=8'h14, LDA_=8'h18, STA_=8'h28, STA=8'h2C,
    ADDA=8'h34, ADDA_=8'h38, SUBA=8'h48, INCA=8'h08, LDX=8'h54,
    TXA=8'h0C, JMP=8'h8C, BNZ=8'h64} cpu_operation_e;

typedef enum {NoOperand, Immediate, Absolute, AbsIndex} address_mode_e;

class cpu_second_regs;
    static vmm_log log = new("cpu_second_regs", "class");
    cpu_word_t alu_mode;
    cpu_word_t bus_mode;
    cpu_bit_t carry_mode;
    cpu_bit_t s1;
    cpu_bit_t err_out;
    cpu_word_t X0;
    cpu_word_t Y0;

    virtual function void reset();
        X0 = 0;
        Y0 = 0;
        err_out = 0;
        alu_mode = 0;
        bus_mode = 0;
        carry_mode = 0;
        s1 = 0;
    endfunction: reset

    virtual function string_queue_t compare(cpu_second_regs other);
        `vmm_verbose(log, "Doing cpu_second_regs::compare");
	`FSDBLOG0("Doing cpu_second_regs::compare","string_queue_t",`NOVAS_TRACE,$psprintf("%m"))

        if (this.alu_mode == other.alu_mode)
            ;
        else begin
            compare.push_back($psprintf("alu_mode expect=%x actual=%x", this.alu_mode, other.alu_mode));
        end
        if (this.bus_mode == other.bus_mode)
            ;
        else begin
            compare.push_back($psprintf("bus_mode expect=%x actual=%x", this.bus_mode, other.bus_mode));
        end
        if (this.carry_mode == other.carry_mode)
            ;
        else begin
            compare.push_back($psprintf("carry_mode expect=%x actual=%x", this.carry_mode, other.carry_mode));
        end
        if (this.s1 == other.s1)
            ;
        else begin
            compare.push_back($psprintf("s1 expect=%x actual=%x", this.s1, other.s1));
        end
        if (this.err_out == other.err_out)
            ;
        else begin
            compare.push_back($psprintf("err_out expect=%x actual=%x", this.err_out, other.err_out));
        end
        if (this.X0 == other.X0)
            ;
        else begin
            compare.push_back($psprintf("X0 expect=%x actual=%x", this.X0, other.X0));
        end
        if (this.Y0 == other.Y0)
            ;
        else begin
            compare.push_back($psprintf("Y0 expect=%x actual=%x", this.Y0, other.Y0));
        end
    endfunction : compare

    virtual function void dump_regs();
        $write("alu_mode=%2x bus_mode=%2x carry_mode=%b s1=%b err_out=%b X0=%2x Y0=%2x\n",
            alu_mode, bus_mode, carry_mode, s1, err_out, X0, Y0);
    endfunction: dump_regs

endclass: cpu_second_regs

class cpu_regs;
    static vmm_log log = new("cpu_regs", "class");
    cpu_word_t ACC;
    cpu_word_t IXR;
    cpu_word_t PC;
    cpu_bit_t CF;        // carry flag
    cpu_bit_t ZF;        // zero flag
    cpu_second_regs second;

    virtual function void reset();
        ACC=0;
        IXR=0;
        PC=0;
        CF=0;
        ZF=0;
        second.reset();
    endfunction: reset

    virtual function void dump_regs();
        $write("ACC=%2x IXR=%2x PC=%2x CF=%b ZF=%b\n",
             ACC, IXR, PC, CF, ZF);
    endfunction: dump_regs

    virtual function string_queue_t compare(cpu_regs other);
        string_queue_t second_compare;

        `vmm_verbose(log, "Doing cpu_regs::compare");
	`FSDBLOG0("Doing cpu_regs::compare","string_queue_t",`NOVAS_VERBOSE,$psprintf("%m"))


        if (this.ACC == other.ACC)
            ;
        else begin
            compare.push_back($psprintf("ACC expect=%x actual=%x", this.ACC, other.ACC));
        end
        if (this.IXR == other.IXR)
            ;
        else begin
            compare.push_back($psprintf("IXR expect=%x actual=%x", this.IXR, other.IXR));
        end
        if (this.PC == other.PC)
            ;
        else begin
            compare.push_back($psprintf("PC expect=%x actual=%x", this.PC, other.PC));
        end
        if (this.CF == other.CF)
            ;
        else begin
            compare.push_back($psprintf("CF expect=%x actual=%x", this.CF, other.CF));
        end
        if (this.ZF == other.ZF)
            ;
        else begin
            compare.push_back($psprintf("ZF expect=%x actual=%x", this.ZF, other.ZF));
        end
        second_compare = this.second.compare(other.second);
        for (int i = 0; i < second_compare.size(); i = 0) begin
          compare.push_back(second_compare[0]);
          second_compare.delete(0);
        end
    endfunction : compare

    function new(string name="");
        second = new();
    endfunction: new

endclass: cpu_regs

class cpu_instr;
    vmm_log log;
    cpu_word_t start_addr;
    rand cpu_operation_e operation;
    rand address_mode_e mode;
    rand int size;

    // Control variable introduced because SystemVerilog doesn't support the
    // concept of "others" when generating a random distribution. 'instr_percentage'
    // will be constrained from 1 to 100, and so constraints can be written
    // to force the instruction type to fall into certain groups of instructions.
    // See cpu_program.sv for examples.
    rand int instr_percentage;
    constraint instr_percentage_range {
        // Calculate weight, then instruction (which may be eventually based
        // on the weight.
        solve instr_percentage before operation;
        instr_percentage >= 1;
        instr_percentage <= 100;
    }

    // NOTE: In 'e', these were defined via when subtyping.
    // For NoOperand ignore this byte.
    // For Immediate this field is the "data".
    // For Absolute this field is the "abs_addr".
    // For AbsIndex this field is the "index_addr".
    rand cpu_word_t operand;


    virtual function void print_instr();
        static string instruction;
        static string opcode;

        $sformat(instruction,"%s",operation.name);
        $sformat(opcode,"opcode =%h",operation);

        case (mode)
            NoOperand: 	begin 
				$write("%s\n", operation.name());
//rich_modify
//                		`FSDBLOG0(instruction,opcode,`NOVAS_TRACE,$psprintf("%m")) 
				$fsdbLog(instruction,opcode,4,$psprintf("%m"));
			end
            Immediate: 	begin
				$write("%s\t\t$%h\n", operation.name(), operand);
//rich_modify
//                 		`FSDBLOG1(instruction,opcode,`NOVAS_TRACE,$psprintf("%m"), $psprintf("%h",operand))
				$fsdbLog(instruction,opcode,4,$psprintf("%m"),$psprintf("%h",operand));
			end
            Absolute:  	begin
				$write("%s\t\t#$%h\n", operation.name(), operand);
//rich_modify
//                  		`FSDBLOG1(instruction,opcode,`NOVAS_TRACE,$psprintf("%m"), $psprintf("#%h",operand))
				$fsdbLog(instruction,opcode,4,$psprintf("%m"),$psprintf("#%h",operand));
				
			end
            AbsIndex:  	begin
				$write("%s\t\t#($%h+x)\n", operation.name(), operand);
//rich_modify
//                      	`FSDBLOG1(instruction,opcode,`NOVAS_TRACE,$psprintf("%m"), $psprintf("#(%h+x)",operand))
			 	$fsdbLog(instruction,opcode,4,$psprintf("%m"),$psprintf("#(%h+x)",operand));	
			end
            default:	begin
                		`vmm_error(log, $psprintf("%s is not a supported operation for print_instr()", operation.name()));
//rich_modify
//                     		`FSDBLOG1(instruction,"ERROR",`NOVAS_ERROR,$psprintf("%m"),"instruction is not supported") 
				$fsdbLog(instruction,"ERROR",4,$psprintf("%m"),"instruction is not supported");
			end
        endcase

    endfunction

    virtual function int get_size();
        return size;
    endfunction

    // This was in the Novas code drop but commented out.
    constraint novas_commented_out {
        //operation inside {CLRA, ADDA, JMP, BNZ, STA_, ADDA_, SUBA, STA};
    }

    // Taken from Novas cpu_no_bnz.e
    constraint cpu_no_bnz {
        operation != BNZ;
    }

    constraint op_to_mode_mapping {
        operation inside {CLRA, INCA, TXA} -> mode == NoOperand;
        operation inside {LDA, ADDA, LDX, JMP, BNZ} -> mode == Immediate;
        operation inside {LDA_, STA_, ADDA_, SUBA} -> mode == Absolute;
        operation inside {STA} -> mode==AbsIndex;
    }

    // Note: This used to be done via when-subtyping but since that's not
    // possible in SV I'm moving the logic back into the base class itself
    constraint mode_to_size_mapping {
        mode == NoOperand -> size == 1;
        mode inside {Immediate, Absolute, AbsIndex} -> size == 2;
    }

    virtual function void set_flag(cpu_regs regs, reg [8:0] res);
        if(res[8:8]==1) regs.CF=1;
        else regs.CF=0;

        if(res[7:0]==0) regs.ZF=1;
        else regs.ZF=0;
    endfunction: set_flag


    virtual function void execute(cpu_ref cpu);
        // NOTE: Could change these to call the execute() method of objects encapsulating
        // the algorithm for each mode (to remove clutter from this class definition).
        // Or, could have created child classes for each mode, but it seemed more 
        // convenient to include them all in a single base class for this conversion
        // effort.
        case (mode)
            NoOperand: execute_NoOperand(cpu);
            AbsIndex: execute_AbsIndex(cpu);
            Immediate: execute_Immediate(cpu);
            Absolute: execute_Absolute(cpu);
            default:
               `vmm_error(log, $psprintf("Can't execute %s in unknown mode %s.", operation.name(), mode.name()));
        endcase
    endfunction: execute

    virtual function void execute_NoOperand(cpu_ref cpu);
         case (operation)
            CLRA: begin
                cpu.regs.PC+=1;
                cpu.regs.ACC=0;
                set_flag(cpu.regs, {1'b0, cpu.regs.ACC});
            end
            INCA: begin
                cpu_word_t res2;

                cpu.regs.PC+=1;
                res2=cpu.regs.ACC+1;
                cpu.regs.ACC=res2[7:0];
                set_flag(cpu.regs, res2);
            end
            TXA: begin
                cpu.regs.PC+=1;
                cpu.regs.IXR=cpu.regs.ACC;
            end
            default: begin
                `vmm_error(log, $psprintf("Illegal operation: %s", operation.name()));
            end
        endcase
    endfunction:execute_NoOperand

    virtual function void execute_Immediate(cpu_ref cpu);
        case (operation)
        LDA: begin
            cpu.regs.PC+=1;
            cpu.regs.ACC=operand;
            cpu.regs.PC+=1;
            
            // NOTE: Was also commented out in original 'e' code.
            // Not yet converted to SystemVerilog (i.e. still in e syntax).
            //set_flag(cpu.regs, %{cpu.regs.CF, cpu.regs.ACC});
        end
        ADDA: begin
            cpu_word_t res2;

            cpu.regs.PC+=1;
            res2=cpu.regs.ACC+operand;
            cpu.regs.PC+=1;
            cpu.regs.ACC=res2[7:0];
            set_flag(cpu.regs, res2);
        end
        LDX: begin
            cpu.regs.PC+=1;
            cpu.regs.IXR=operand;
            cpu.regs.PC+=1;
        end
        JMP: begin
            cpu.regs.PC=operand;
        end
        BNZ: begin
            cpu.regs.PC+=2;
            if(cpu.regs.ZF!=1) cpu.regs.PC=operand;
        end
        default: begin
            `vmm_error(log, $psprintf("Illegal operation: %s", operation));
        end
        endcase

    endfunction: execute_Immediate

    virtual function void execute_Absolute(cpu_ref cpu);
        case (operation)
        LDA_: begin
            cpu.regs.PC+=1;
            cpu.regs.ACC=cpu.read_mem(operand);
            cpu.regs.PC+=1;
            //set_flag(cpu.regs, %{cpu.regs.CF, cpu.regs.ACC});
        end
        STA_: begin
            cpu.regs.PC+=1;
            cpu.write_mem(operand, cpu.regs.ACC);
            cpu.regs.PC+=1;
        end
        ADDA_: begin
            cpu_word_t res2;
            cpu_word_t data;

            cpu.regs.PC+=1;
            data=cpu.read_mem(operand);
            cpu.regs.PC+=1;
            res2=cpu.regs.ACC+data;
            cpu.regs.ACC=res2[7:0];
            set_flag(cpu.regs, res2);
        end
        SUBA: begin
            cpu_word_t res2;
            cpu_word_t data;

            cpu.regs.PC+=1;
            data=cpu.read_mem(operand);
            cpu.regs.PC+=1;
            res2=cpu.regs.ACC-data;
            cpu.regs.ACC=res2[7:0];
            set_flag(cpu.regs, res2);
        end
        default: begin
            `vmm_error(log, $psprintf("Illegal operation: %s", operation.name()));
        end
        endcase

    endfunction: execute_Absolute

    virtual function void execute_AbsIndex(cpu_ref cpu);
       case (operation)
        STA: begin
                cpu_word_t addr;

                cpu.regs.PC+=1;
                addr=operand+cpu.regs.IXR;
                cpu.regs.PC+=1;
                cpu.write_mem(addr, cpu.regs.ACC);
        end
        default: begin
            `vmm_error(log, $psprintf("Illegal operation: %s", operation));
        end
        endcase

    endfunction: execute_AbsIndex

    virtual function cpu_word_queue_t pack();

        pack.push_back(operation); // 8 bit field
        if (mode != NoOperand) begin
            pack.push_back(operand); // 8 bit field
        end
        `vmm_verbose(log, $psprintf("About to pack %s. (op=%x, operand=%x) Mode=%s, Size = %d", operation.name(), operation, operand, mode.name(), pack.size()));
	`FSDBLOG2($psprintf("About to pack %s",operation.name()), "cpu_word_queue_t",`NOVAS_VERBOSE,$psprintf("%m"), $psprintf("op=%x, operand=%x ",operation,operand), $psprintf("Mode=%s, Size=%d ",mode.name(),pack.size()))

    endfunction: pack

    function new(vmm_log l, string name = "cpu_instr");
        log = l;
    endfunction: new
endclass: cpu_instr
`endif

