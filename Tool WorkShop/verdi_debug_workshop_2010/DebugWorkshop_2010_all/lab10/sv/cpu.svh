/*###############################################################
###                                                           ###
###   Top level include file for the SystemVerilog testbench. ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###############################################################*/

`ifndef CPU_SVH
`define CPU_SVH
const bit CPU_TRUE = 1;
const bit CPU_FALSE = 0;
`define PRAM_MEMORY_SIZE 256

// NOTE: Synopsys Star Request 9000237911:
//       'Issue while expanding typedef of "byte unsigned" on enum'
//       VCS 2006.SP1-18
//
// VCS doesn't seem to understand the "unsigned" part 
// when included in this typedef.  Compilation fails when
// compiling cpu_operation_e enum.  So, using reg[7:0] for now.
// That may be better anyways as reg is 4-state.
//typedef byte unsigned cpu_word_t;
typedef reg [7:0] cpu_word_t;

typedef cpu_word_t cpu_word_queue_t [$];
typedef reg cpu_bit_t;
typedef string string_queue_t [$];
typedef enum {modified} mem_notification;


// novas_vmm_note - an example of a vmm_note wrapper showing
// how it might be possible to wrap a normal `vmm_note call with 
// a special macro that calls $fsdbLog and then `vmm_note.  
// Using log.get_name() as the label parameter is just an example - 
// modify this macro as appropriate to get the desired result.

`define novas_vmm_note(LOG_PTR, NOVAS_MSG) \
    begin \
        $fsdbLog(log.get_name(), NOVAS_MSG); \
        `vmm_note(LOG_PTR, $psprintf("%s: %s", log.get_name(), NOVAS_MSG));\
    end

// Another version of the macro with different parameters than 
// vmm_note but which allows the LABEL to be passed in separately.

//`define novas_vmm_note(LOG_PTR, NOVAS_LABEL, NOVAS_MSG) \
//    begin \
//        $fsdbLog(LABEL, MESSAGE); \
//        `vmm_note(LOG_PTR, $psprintf("%s: %s", LABEL, MESSAGE));\
//    end

`include "vmm.sv"
`include "pram_ref.sv"
`include "cpu_ref.sv"
`include "cpu_instr.sv"
`include "pram_duv.sv"
`include "cpu_duv.sv"
`include "cpu_program.sv"
`include "cpu_env.sv"
`include "cpu_cover.sv"
`endif
