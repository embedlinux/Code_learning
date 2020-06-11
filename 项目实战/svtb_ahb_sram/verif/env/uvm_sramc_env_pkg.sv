//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_env_pkg.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// Package for uvm_sramc
//
//=============================================================================

package uvm_sramc_env_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import ahb_pkg::*;

  `include "uvm_sramc_env_config.sv"
  `include "uvm_sramc_refm.sv"
  `include "uvm_sramc_scb.sv"
  `include "uvm_sramc_env.sv"

endpackage : uvm_sramc_env_pkg

