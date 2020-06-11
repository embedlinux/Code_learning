//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_env.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// Environment for uvm_sramc
//
//=============================================================================

`ifndef UVM_SRAMC_ENV_SV
`define UVM_SRAMC_ENV_SV

class uvm_sramc_env extends uvm_env;

  `uvm_component_utils(uvm_sramc_env)

  ahb_agent             m_ahb_agent;
  uvm_sramc_refm        m_refm;
  uvm_sramc_scb         m_scb;
  uvm_sramc_env_config  m_env_config;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : uvm_sramc_env 


function uvm_sramc_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void uvm_sramc_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In build_phase", UVM_HIGH)
  if (!uvm_config_db #(uvm_sramc_env_config)::get(this, "", "m_env_config", m_env_config)) 
    `uvm_error(get_type_name(), "Unable to get uvm_sramc_env_config")
  m_refm   =  uvm_sramc_refm::type_id::create("m_refm",this);
  m_scb    =  uvm_sramc_scb::type_id::create("m_scb",this);

  m_ahb_agent  =  ahb_agent::type_id::create("m_ahb_agent", this);

endfunction : build_phase


function void uvm_sramc_env::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In connect_phase", UVM_HIGH)
   m_ahb_agent.analysis_port.connect(m_scb.analysis_imp);   

endfunction : connect_phase


// Could print out diagnostic information, for example
function void uvm_sramc_env::end_of_elaboration_phase(uvm_phase phase);
  //uvm_top.print_topology();
  //`uvm_info(get_type_name(), $sformatf("Verbosity level is set to: %d", get_report_verbosity_level()), UVM_MEDIUM)
  //`uvm_info(get_type_name(), "Print all Factory overrides", UVM_MEDIUM)
  //factory.print();
endfunction : end_of_elaboration_phase


`endif // UVM_SRAMC_ENV_SV

