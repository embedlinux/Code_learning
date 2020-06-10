/*###############################################################
###                                                           ###
###   PRAM Ref                                                ###
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

typedef class cpu_program;
typedef class pram_duv;

class pram_ref extends vmm_xactor;
    cpu_word_t mem[]; // Size is defined in new().
    vmm_notify memory_notify;

    function new(string name, string instance, vmm_notify notifier);
        super.new(name, instance);
        mem=new[256];
        memory_notify = notifier;
    endfunction: new

    cpu_word_queue_t bytestream;
    virtual function void set_program(cpu_program pgm);
        foreach (pgm.instr_list[i]) begin
          cpu_word_queue_t temp;
          //bytestream = '{bytestream, pgm.instr_list[i].pack()};
          temp = pgm.instr_list[i].pack();
          foreach (temp[i]) begin
            bytestream.push_back(temp[i]);
          end
        end
        assert (bytestream.size() != 0)
        else begin
            `vmm_error(log, "Couldn't pack list of cpu instructions.");
        end
        for (int i = 0; i < bytestream.size(); i++) begin
            mem[i] = bytestream[i];
        end
        for (int i = bytestream.size(); i <= 255; i++) begin
            // NOTE: Need to decide what type of data to use
            // to fill memory with.  The Specman tb uses zeros,
            // so reproducing that here.
            //mem[i] = 'x;
            mem[i] = '0;
        end
    endfunction: set_program

    virtual function cpu_word_t read(cpu_word_t addr);
        return mem[addr];
    endfunction: read

    virtual function void write(cpu_word_t addr, cpu_word_t data);

        mem[addr]=data;
        `vmm_verbose(log, $psprintf("Wrote data=%x at addr=%x", data, addr));
	`FSDBLOG2("Wrot data","write",`NOVAS_VERBOSE,$psprintf("%m"),data,addr)

        memory_notify.indicate(modified);
    endfunction: write

    virtual function void dump_memory();
        $write("<<< The program memory >>>\n");
        $write("==============================");
        for (int i = 0; i <= 255; i++) begin
            if(i%8==0) begin
                $write("\n%2x:   ", i);
            end

            $write("%02x ", mem[i]);
        end
        $write("\n==============================\n");
    endfunction: dump_memory

    function string_queue_t compare(pram_duv pr);
        string_queue_t diff;

        `vmm_verbose(log, "Comparing mem");
	`FSDBLOG0("Comparing mem ","compare",`NOVAS_VERBOSE,$psprintf("%m"))

        for (int i = 0; i < `PRAM_MEMORY_SIZE; i++) begin
            // NOTE: Use case equality because mem may be padded with x in empty locations.
            if (mem[i] === pr.mem[i]) 
                ;
            else begin
                diff.push_back($psprintf("Addr=%02x  expect=%02x  actual=%02x", i, mem[i], pr.mem[i]));
            end
        end
        return diff;
    endfunction:compare

endclass: pram_ref
