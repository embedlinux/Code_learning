/*
  TOP module to test this out - not used in the memctl testbench
  To run:
    %  irun top.sv -incdir ./ -incdir ../apb/sv
*/
`ifndef DUT_DSIZE
   `define DUT_DSIZE 8 
`endif
`ifndef DUT_ASIZE
   `define DUT_ASIZE 32
`endif

`include "apb_if.sv"
`include "memctldut.sv"
`include "memctl.sv"
`ifdef HAS_SUBMOD
`include "submod.sv"
`endif
module top;

bit clock, reset;

apb_if apbif (clock, reset);
memctldut dut (clock, reset, apbif );
 
initial
  begin
    reset = 0;
    #1  reset = 1;
    #20 reset = 0;
    //dut.print_regs();
    #20 $finish();
  end

always #5 clock = ~clock;

function string regname(input bit[15:0] addr);
   casez (addr)
      'h0000: regname = "Mode 0";
      'h0001: regname = "Mode 1";
      'h0002: regname = "Mode 2";
      'h0003: regname = "Mode 3";
      'h0010: regname = "RD Status";
      'h0011: regname = "WR Status";
     default: regname = "UNKNWN";
  endcase
endfunction : regname

endmodule : top
