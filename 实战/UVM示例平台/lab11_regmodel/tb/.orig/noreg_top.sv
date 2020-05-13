/*-----------------------------------------------------------------
File name     : top.sv
Developers    : Kathleen Meade
Created       : Tue Mar 2 2010
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2009 (c) Cadence Design Systems
-----------------------------------------------------------------*/
`ifndef DUT_ASIZE 
  `define DUT_ASIZE 32
`endif

`ifndef DUT_DSIZE 
  `define DUT_DSIZE 8
`endif

module top;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import apb_pkg::*;

  `include "memctl_tb_noreg.sv"
  `include "memctl_tests_noreg.sv"
  
  bit reset, clock;

  apb_if apbif (clock, reset);

  memctldut dut (.clock, .reset, .apbif);
  
  initial begin
    // Configure Virtual Interfaces
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.memctl_tb0.apb0*", "vif", apbif);
    // Run the UVM test via +UVM_TESTNAME command-line option
    run_test();
  end

  initial begin
    reset <= 1'b0;
    clock <= 1'b1;
    #51 reset = 1'b1;
  end

  //Generate Clock
  always
    #5 clock = ~clock;

endmodule
