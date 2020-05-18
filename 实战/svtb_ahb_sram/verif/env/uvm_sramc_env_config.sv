//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_env_config.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// Configuration for uvm_sramc_env
//
//=============================================================================

`ifndef UVM_SRAMC_ENV_CONFIG_SV
`define UVM_SRAMC_ENV_CONFIG_SV

class uvm_sramc_env_config extends uvm_object;

  `uvm_object_utils(uvm_sramc_env_config)


  extern function new(string name = "uvm_sramc_env_config");

endclass : uvm_sramc_env_config 


function uvm_sramc_env_config::new(string name = "uvm_sramc_env_config");
  super.new(name);
endfunction : new


`endif // UVM_SRAMC_ENV_CONFIG_SV

