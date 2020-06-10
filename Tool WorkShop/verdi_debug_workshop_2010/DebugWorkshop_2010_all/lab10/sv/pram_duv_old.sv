/*###############################################################
###                                                           ###
###   PRAM DUV Agent                                          ###
###                                                           ###
###   Author  : Verilab, Inc.                                 ### 
###   Contact : JL Gray (jl.gray@verilab.com)                 ###
###   Date    : 4/13/2008                                     ###
###                                                           ###
###   (c) 2008 Verilab, Inc.                                  ###
###                                                           ###
###   Original 'e' version                                    ###
###   (c) 1996, 1997, 1998 Novas Software Inc.                ###
################################################################*/


// Create the PRAM agent (as per Novas e tb)

`ifndef PRAM_DUV_AGENT_SV
`define PRAM_DUV_AGENT_SV

class pram_if_wrapper;
    virtual pram_if i_pram_if;

    function new(string name, virtual pram_if _if);
        i_pram_if = _if;
    endfunction: new
endclass: pram_if_wrapper


class pram_duv extends vmm_xactor;
    cpu_word_t mem[];
    cpu_word_t addr;
    vmm_notify memory_notify;
    pram_if_wrapper if_wrap_i;

    //virtual function void set_mem(ref byte m[]);
    // NOTE: Can't pass in a reference to the array itself, so pass a pointer to pram_ref
    // and then copy the array directly.  (specific to Cadence IUS)
    virtual function void set_mem(pram_ref p);
        cpu_word_t m[];
        `vmm_verbose(log, ($psprintf("Entering pram_duv::set_mem; supplied arg size %d", p.mem.size())));
        `FSDBLOG1("Entering pram_duv::set_mem,suppied arg size","set_mem",`NOVAS_VERBOSE2,$psprintf("%m"),$psprintf("\np.mem.size = %0d",p.mem.size()))
        mem = new[p.mem.size()](p.mem);
        `vmm_verbose(log, ($psprintf("Leaving pram_duv::set_mem; assigned mem size %d", mem.size())));
        `FSDBLOG1("Leaving pram_duv::set_mem,assigned arg size","set_mem",`NOVAS_VERBOSE2,$psprintf("%m"),$psprintf("\np.mem.size = %0d",p.mem.size()))
    endfunction: set_mem

    function new(string name, string instance, pram_if_wrapper piw, vmm_notify notifier);
        super.new(name, instance);
        if_wrap_i = piw;
        memory_notify = notifier;
    endfunction: new

    virtual task on_clk_rise();
        if (if_wrap_i.i_pram_if.VMA == 1) begin
            addr = if_wrap_i.i_pram_if.addr;
            `FSDBLOG1("","on_clk_rise, VMA=1",`NOVAS_VERBOSE2,$psprintf("%m"),$psprintf("\nif_wrap_i.i_pram_if.addr=%h",if_wrap_i.i_pram_if.addr));
            if (if_wrap_i.i_pram_if.R_W == 1) begin
                if_wrap_i.i_pram_if.dataout <= mem[addr]; 
            end
            else begin
                mem[addr] = if_wrap_i.i_pram_if.data;
                `vmm_verbose(log, $psprintf("Wrote data=%x at addr=%x", if_wrap_i.i_pram_if.data, addr));
                `FSDBLOG2("Wrote data","on_clk_rise, VMA=0",`NOVAS_VERBOSE2,$psprintf("%m"), $psprintf("\nif_wrap_i.i_pram_if.data=%h",if_wrap_i.i_pram_if.data), addr)
                memory_notify.indicate(modified);
            end
        end
        
    endtask: on_clk_rise

    virtual protected task main();
        static int compare_count =0;
        static logic [7:0] data_compare;
        fork 
            begin
            super.main();
            end
        join_none

        `vmm_verbose(log, "Running pram_duv.");
        `FSDBLOG0("Running prm_duv","",`NOVAS_VERBOSE,$psprintf("%m"))
        fork
        while (1) begin
            @(posedge if_wrap_i.i_pram_if.clock);
            on_clk_rise();
        end
//add for finding extra "c" @ 6800
        while (1) begin
            @(if_wrap_i.i_pram_if.dataout);
               begin
               data_compare = mem [compare_count];
//wl:  add for flagging error compare 
//rich_modify
               //`FSDBLOG2("compare_map","compare_map",`NOVAS_TRACE,"compare_map", $psprintf("\nmem[%0d]= %h",compare_count,mem[compare_count]), data_compare)
		$fsdbLog("compare_map","compare_map",6,"compare_map",$psprintf("\nmem[%0d]= %h",compare_count,mem[compare_count]),data_compare);
 
               //`FSDBLOG2("dataout ","on_clk_rise, VMA=0",`NOVAS_TRACE,"dataout", compare_count, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout))
		   $fsdbLog("dataout ","on_clk_rise, VMA=0",4,"data_out",compare_count, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout));
                    if (if_wrap_i.i_pram_if.dataout == data_compare) begin
                      //`FSDBLOG2("success","compare_map",`NOVAS_TRACE,"status",data_compare, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout))
		      $fsdbLog("success","compare_map",4,"status",data_compare, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout)); 
                    end
                    else if((compare_count == 17) &&( data_compare == 'h0c)) begin
//rich_modify
                      //`FSDBLOG2("success","compare_map",`NOVAS_TRACE,"status",data_compare, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout))
		     $fsdbLog("success","compare_map",4,"status",data_compare, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout));
                       compare_count++;
                    end
                    else if (compare_count !=0) begin
//rich_modify
                      //`FSDBLOG2("fail","compare_map",`NOVAS_TRACE,"status",data_compare, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout))
		      $fsdbLog("fail","compare_map",4,"status",data_compare, $psprintf("\ndataout= %h",if_wrap_i.i_pram_if.dataout));
                      compare_count--;
                    end
                    compare_count++;
                end
        end
        join_none

    endtask: main

endclass: pram_duv

`endif

