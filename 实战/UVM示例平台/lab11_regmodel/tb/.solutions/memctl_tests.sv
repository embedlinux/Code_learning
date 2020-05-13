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

//------------------------------------------------------------------------------
//
// CLASS: uvm_reset_test
//-----------------------------------------------------------------------------

class  uvm_reset_test extends memctl_base_test;

    uvm_reg_hw_reset_seq reset_seq;

  // component macro
  `uvm_component_utils(uvm_reset_test)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      reset_seq = uvm_reg_hw_reset_seq::type_id::create("uvm_reset_seq");
      super.build_phase(phase);
  endfunction : build_phase

  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
     // Set the model property of the sequence to our Register Model instance
     reset_seq.model = memctl_tb0.model;
     #50;
     // Execute the sequence (sequencer is already set in the testbench)
     reset_seq.start(null);
     phase.drop_objection(this," Dropping Objection to uvm built reset test finished");
  endtask

endclass : uvm_reset_test

//------------------------------------------------------------------------------
//
// CLASS: uvm_mem_walk - executes built-in uvm_mem_walk_seq
//-----------------------------------------------------------------------------

class  uvm_mem_walk_test extends memctl_base_test;

    uvm_mem_walk_seq mem_seq;

  // component macro
  `uvm_component_utils(uvm_mem_walk_test)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      mem_seq = uvm_mem_walk_seq::type_id::create("mem_seq");
      super.build_phase(phase);
  endfunction : build_phase

  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
     // Set the model property of the sequence to our Register Model instance
     mem_seq.model = memctl_tb0.model;
     #50;
     // Execute the sequence (sequencer is already set in the testbench)
     mem_seq.start(null);
     phase.drop_objection(this," Dropping Objection to uvm built reset test finished");
  endtask

endclass : uvm_mem_walk_test

//------------------------------------------------------------------------------
//
// CLASS: uvm_reg_access_test - executes built-in uvm_reg_access sequence
//-----------------------------------------------------------------------------

class  uvm_reg_access_test extends memctl_base_test;

    uvm_reg_access_seq reg_seq;

  // component macro
  `uvm_component_utils(uvm_reg_access_test)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      reg_seq = uvm_reg_access_seq::type_id::create("reg_seq");
      super.build_phase(phase);
  endfunction : build_phase

  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
     // Set the model property of the sequence to our Register Model instance
     reg_seq.model = memctl_tb0.model;
     #50;
     // Execute the sequence (sequencer is already set in the testbench)
     reg_seq.start(null);
     phase.drop_objection(this," Dropping Objection to uvm built reset test finished");
  endtask

endclass : uvm_reg_access_test

//------------------------------------------------------------------------------
//
// CLASS: Register API tests
//-----------------------------------------------------------------------------

class  simple_api_test extends memctl_base_test;

  // component macro
  `uvm_component_utils(simple_api_test)

  logic [7:0] mode0, mode1, mode2, mode3, status, rdcount, wrcount, wrdata;
  bit ok;

  memctl_rf_c mc_regs;

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual task run_phase (uvm_phase phase);
     uvm_status_e rstatus;
     phase.raise_objection(this, "Raising Objection to run simple API test");

     // set handle to register file in register model 
     mc_regs = memctl_tb0.model.memctl_rf;

    // WRITE MODE0 REG (FRONTDOOR)
    wrdata = 8'hFF;
    mc_regs.mode0_reg.write(rstatus, wrdata, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode0_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE0 REG (FRONTDOOR)
    mc_regs.mode0_reg.read(rstatus, mode0, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode0_reg:0x%h", mode0), UVM_LOW);

    // WRITE MODE1 REG (FRONTDOOR)
    wrdata = 8'hF0;
    mc_regs.mode1_reg.write(rstatus, wrdata, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode1_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE1 REG (FRONTDOOR)
    mc_regs.mode1_reg.read(rstatus, mode1, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode1_reg:0x%h", mode1), UVM_LOW);

    // WRITE MODE2 REG (FRONTDOOR)
    wrdata = 8'h0F;
    mc_regs.mode2_reg.write(rstatus, wrdata, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode2_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE2 REG (FRONTDOOR)
    mc_regs.mode2_reg.read(rstatus, mode2, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode2_reg:0x%h", mode2), UVM_LOW);

    // WRITE MODE3 REG (FRONTDOOR)
    wrdata = 8'h00;
    mc_regs.mode3_reg.write(rstatus, wrdata, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode3_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE3 REG (FRONTDOOR)
    mc_regs.mode3_reg.read(rstatus, mode3, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode3_reg:0x%h", mode3), UVM_LOW);

    // Get mirrored value of status reg in register Model
    status = mc_regs.status_reg.get_mirrored_value();
    `uvm_info("API_TEST", $sformatf("UVMREG: MIRROR value status_reg:0x%h", status), UVM_LOW);

    // Predict status_reg value - set mirrored value in register Model
    // all mode registers read/written, therefore status should be 0xFF
    ok = mc_regs.status_reg.predict(8'hFF);

    // READ STATUS REG (FRONTDOOR)
    mc_regs.status_reg.read(rstatus, status, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ status_reg:0x%h", status), UVM_LOW);

    status = mc_regs.status_reg.get_mirrored_value();
    `uvm_info("API_TEST", $sformatf("UVMREG: MIRROR value status_reg:0x%h", status), UVM_LOW);

    // Predict read counter value - set mirrored value in register Model
    // all mode registers plus status read, therefore read count should be 0x04
    ok = mc_regs.rd_cnt_reg.predict(8'h04);

    // READ READ COUNTER (FRONTDOOR)
    mc_regs.rd_cnt_reg.read(rstatus, rdcount, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ rd_cnt_reg:0x%h", rdcount), UVM_LOW);

    // Predict write counter value - set mirrored value in register Model
    // all mode registers plus status written, therefore write count should be 0x04
    ok = mc_regs.wr_cnt_reg.predict(8'h04);

    // READ WRITE COUNTER (FRONTDOOR)
    mc_regs.wr_cnt_reg.read(rstatus, wrcount, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ wr_cnt_reg:0x%h", wrcount), UVM_LOW);

     phase.drop_objection(this," Dropping Objection to simple API test");
  endtask

endclass : simple_api_test

class frontback_api_test extends memctl_base_test;

  // component macro
  `uvm_component_utils(frontback_api_test)

  logic [7:0] mode0, mode1, mode2, mode3, status, rdcount, wrcount, wrdata;
  bit ok;

  memctl_rf_c mc_regs;

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual task run_phase (uvm_phase phase);
     uvm_status_e rstatus;
     phase.raise_objection(this, "Raising Objection to frontback API test");

     // set handle to register file in register model 
     mc_regs = memctl_tb0.model.memctl_rf;

    // WRITE MODE0 REG (BACKDOOR)
    wrdata = 8'hFF;
    mc_regs.mode0_reg.write(rstatus, wrdata, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode0_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE0 REG (BACKDOOR)
    mc_regs.mode0_reg.read(rstatus, mode0, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode0_reg:0x%h", mode0), UVM_LOW);

    // WRITE MODE1 REG (BACKDOOR)
    wrdata = 8'hF0;
    mc_regs.mode1_reg.write(rstatus, wrdata, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode1_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE1 REG (BACKDOOR)
    mc_regs.mode1_reg.read(rstatus, mode1, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode1_reg:0x%h", mode1), UVM_LOW);

    // WRITE MODE2 REG (BACKDOOR)
    wrdata = 8'h0F;
    mc_regs.mode2_reg.write(rstatus, wrdata, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode2_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE2 REG (BACKDOOR)
    mc_regs.mode2_reg.read(rstatus, mode2, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode2_reg:0x%h", mode2), UVM_LOW);

    // WRITE MODE3 REG (BACKDOOR)
    wrdata = 8'h00;
    mc_regs.mode3_reg.write(rstatus, wrdata, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: WROTE mode3_reg:0x%h", wrdata), UVM_LOW);

    // READ MODE3 REG (BACKDOOR)
    mc_regs.mode3_reg.read(rstatus, mode3, UVM_BACKDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ mode3_reg:0x%h", mode3), UVM_LOW);

    // Get mirrored value of status reg in register Model
    status = mc_regs.status_reg.get_mirrored_value();
    `uvm_info("API_TEST", $sformatf("UVMREG: MIRROR value status_reg:0x%h", status), UVM_LOW);

    // READ STATUS REG (FRONTDOOR)
    mc_regs.status_reg.read(rstatus, status, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ status_reg:0x%h", status), UVM_LOW);

    // READ READ COUNTER (FRONTDOOR)
    mc_regs.rd_cnt_reg.read(rstatus, rdcount, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ rd_cnt_reg:0x%h", rdcount), UVM_LOW);

    // READ WRITE COUNTER (FRONTDOOR)
    mc_regs.wr_cnt_reg.read(rstatus, wrcount, UVM_FRONTDOOR);
    `uvm_info("API_TEST", $sformatf("UVMREG: READ wr_cnt_reg:0x%h", wrcount), UVM_LOW);

     phase.drop_objection(this," Dropping Objection to frontback API test");
  endtask

endclass : frontback_api_test



