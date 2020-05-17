//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_test_pkg.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// Test package for uvm_sramc
//
//=============================================================================

`ifndef UVM_SRAMC_TEST_PKG_SV
`define UVM_SRAMC_TEST_PKG_SV

package uvm_sramc_test_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import ahb_pkg::*;
  import uvm_sramc_env_pkg::*;

  `include "ahb_seq_rw.sv"

  `include "uvm_sramc_test_base.sv"
  `include "sramc_test.sv"

endpackage : uvm_sramc_test_pkg

`endif // UVM_SRAMC_TEST_PKG_SV

