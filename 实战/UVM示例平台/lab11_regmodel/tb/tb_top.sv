/*-----------------------------------------------------------------
File name     : tb_top.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/11/15
Description   : UVM register modelling lab testbenc top level module
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module tb_top;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // import the APB UVC package
  import apb_pkg::*;

  // import the clock and reset UVC package
  import clock_and_reset_pkg::*;

  // UVMREG : import register model 
  import memctl_reg_pkg::*;

  `include "memctl_tb_reg.sv"
  `include "memctl_tests.sv"
  
  initial begin
    clock_and_reset_vif_config::set(null, "uvm_test_top.memctl_tb0.clock_and_reset*", "vif", hw_top.clk_rst_if);

    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.memctl_tb0.apb0*", "vif", hw_top.apbif);

    run_test();
  end

endmodule
