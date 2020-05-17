//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : sram
//
// File Name: sram_test_base.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// Test class for sram (included in package sram_test_pkg)
//
//=============================================================================
//`include "ahb_seq_rw.sv"
`ifndef TEST_TEST_SV
`define TEST_TEST_SV
class sramc_test extends uvm_sramc_test_base;

  `uvm_component_utils(sramc_test)
  extern function new(string name, uvm_component parent=null);
  //extern function void build_phase(uvm_phase phase);
 // extern function void connect_phase(uvm_phase phase);
 // extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          main_phase(uvm_phase phase);

endclass 


function sramc_test::new(string name, uvm_component parent=null);
  super.new(name, parent);
endfunction : new

task sramc_test::main_phase(uvm_phase phase);
  ahb_seq_rw seq1;
  uvm_objection objection;
  super.main_phase(phase);
  objection = phase.get_objection();
  objection.set_drain_time(this,3us);
  seq1 = ahb_seq_rw::type_id::create("seq1");
  
  phase.raise_objection(this, "TEST Started!");
  seq1.start(m_env.m_ahb_agent.m_sequencer);
  phase.drop_objection(this,"Test Finished!");
endtask : main_phase

`endif // TEST1_SV


