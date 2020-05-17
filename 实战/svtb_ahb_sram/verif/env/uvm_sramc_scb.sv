//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_scb.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// scb for uvm_sramc
//
//=============================================================================

`ifndef uvm_sramc_SCB_SV
`define uvm_sramc_SCB_SV

class uvm_sramc_scb extends uvm_component;

  uvm_analysis_imp #(ahb_seq_item,uvm_sramc_scb) analysis_imp;
  `uvm_component_utils(uvm_sramc_scb)
  ahb_seq_item tr_q[$];
  int count_m;
  int count_dism;

  extern function new(string name, uvm_component parent);
  extern virtual function void write(ahb_seq_item tr);
  extern virtual task compare(ahb_seq_item tr);

endclass : uvm_sramc_scb 


function uvm_sramc_scb::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_imp = new("analysis_imp",this);
endfunction : new


function void uvm_sramc_scb::write(ahb_seq_item tr);
  if(tr.hwrite)  //write
    tr_q.push_back(tr);
  else  //read
    compare(tr);
////`uvm_info("MACTH COUNT",$sformatf("count_m=%0d",count_m),UVM_LOW);
////`uvm_info("DISMACTH COUNT",$sformatf("count_dism=%0d",count_dism),UVM_LOW);
endfunction

task uvm_sramc_scb::compare(ahb_seq_item tr);
  int index[$];
  ahb_seq_item exp;
  index=tr_q.find_index() with ((item.haddr == tr.haddr));
  exp = tr_q[index[0]];
  if(exp.hwdata != tr.hrdata)
    `uvm_error(get_full_name(),$sformatf("data compare mismatch addr=%h, exp data=%h,rtl     data=%h",tr.haddr,exp.hwdata,tr.hrdata))
  else
    `uvm_info(get_full_name(),$sformatf("data compare match addr=%h, exp data=%h,rtl data=%h",tr.haddr,exp.hwdata,tr.hrdata),UVM_LOW)
endtask : compare


`endif // uvm_sramc_SCB_SV

