//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_refm.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// refm for uvm_sramc
//
//=============================================================================

`ifndef UVM_SRAMC_REFM_SV
`define UVM_SRAMC_REFM_SV

class uvm_sramc_refm extends uvm_component;

  `uvm_component_utils(uvm_sramc_refm)

  extern function new(string name, uvm_component parent);

  extern task main_phase(uvm_phase phase);
endclass : uvm_sramc_refm 


function uvm_sramc_refm::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


task uvm_sramc_refm::main_phase(uvm_phase phase);

endtask : main_phase

`endif // UVM_SRAMC_REFM_SV

