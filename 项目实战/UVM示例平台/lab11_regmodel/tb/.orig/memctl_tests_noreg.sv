/*-----------------------------------------------------------------
File name     : memctl_tests.sv
Developers    : Kathleen Meade
Created       : Wed Mar 9, 2011
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2011 (c) Cadence Design Systems
-----------------------------------------------------------------*/

//----------------------------------------------------------------
// TEST: memctl_base_test - Base test
//----------------------------------------------------------------
class memctl_base_test extends uvm_test;

  `uvm_component_utils(memctl_base_test)

  memctl_tb memctl_tb0;

  // adjust print options for the test
  uvm_table_printer printer;

  function new(string name = "memctl_base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Enable transaction recording for everything
    set_config_int("*", "recording_detail", UVM_FULL);
    // Create the tb
    memctl_tb0 = memctl_tb::type_id::create("memctl_tb0", this);
    uvm_reg::include_coverage("*", UVM_NO_COVERAGE);
  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_report_info(get_type_name(), "Executing test...", UVM_NONE);
    printer = new();
    printer.knobs.depth=4;
    uvm_top.print_topology(printer);
  endfunction

  task run_phase(uvm_phase phase);
    // set the drain time for this phase
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this, 200ns);
  endtask : run_phase

endclass : memctl_base_test

