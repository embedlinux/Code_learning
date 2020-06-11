//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_test_base.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// Test class for uvm_sramc (included in package uvm_sramc_test_pkg)
//
//=============================================================================

`ifndef UVM_SRAMC_TEST_BASE_SV
`define UVM_SRAMC_TEST_BASE_SV

class uvm_sramc_test_base extends uvm_test;

  `uvm_component_utils(uvm_sramc_test_base)

  uvm_sramc_env           m_env;
  uvm_sramc_env_config    m_env_config;

  ahb_agent_config  m_ahb_agent_config; 

  extern function new(string name, uvm_component parent=null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          main_phase(uvm_phase phase);

endclass : uvm_sramc_test_base


function uvm_sramc_test_base::new(string name, uvm_component parent=null);
  super.new(name, parent);
endfunction : new


function void uvm_sramc_test_base::build_phase(uvm_phase phase);
  m_env        = uvm_sramc_env::type_id::create("m_env", this);
  m_env_config    = uvm_sramc_env_config::type_id::create("m_env_config", this);
  m_ahb_agent_config = ahb_agent_config::type_id::create("m_ahb_agent_config", this);

  void'(m_env_config.randomize());
  uvm_config_db#(uvm_sramc_env_config)::set(this, "*", "m_env_config", m_env_config);
  void'(m_ahb_agent_config.randomize()with {is_active == UVM_ACTIVE;});
  uvm_config_db#(ahb_agent_config)::set(this, "m_env.*", "m_cfg", m_ahb_agent_config);

endfunction : build_phase


function void uvm_sramc_test_base::connect_phase(uvm_phase phase);

endfunction : connect_phase

function void uvm_sramc_test_base::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
  `uvm_info(get_type_name(), $sformatf("Verbosity level is set to: %d", get_report_verbosity_level()), UVM_MEDIUM)
  `uvm_info(get_type_name(), "Print all Factory overrides", UVM_MEDIUM)
  factory.print();
endfunction : end_of_elaboration_phase


task uvm_sramc_test_base::main_phase(uvm_phase phase);

endtask : main_phase

`endif // UVM_SRAMC_TEST_BASE_SV

