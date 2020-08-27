//=======================================================================
// COPYRIGHT (C) 2018-2020 RockerIC, Ltd.
// This software and the associated documentation are confidential and
// proprietary to RockerIC, Ltd. Your use or disclosure of this software
// is subject to the terms and conditions of a consulting agreement
// between you, or your company, and RockerIC, Ltd. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
// VisitUs  : www.rockeric.com
// Support  : support@rockeric.com
// WeChat   : eva_bill 
//-----------------------------------------------------------------------


`ifndef LVC_I2C_MASTER_MONITOR_SVH
`define LVC_I2C_MASTER_MONITOR_SVH

//typedef uvm_callbacks#(lvc_i2c_master_monitor,lvc_i2c_master_monitor_callback) lvc_i2c_master_monitor_callback_pool;

class lvc_i2c_master_monitor extends uvm_monitor;

  /** 
   * Analysis Port which collects transaction observed on bus. Monitor
   * writes to this port when the complete transaction observed on the bus.
   */
  uvm_analysis_port #(lvc_i2c_master_transaction)   xact_observed_port;

  /** 
   * Analysis Port which collects data observed on bus. Monitor writes the response
   * object to this analysis port immediately after it observes data on the bus, instead
   * of waiting for the complete transaction to appear on the bus.
   */
  uvm_analysis_port #(lvc_i2c_master_transaction)   data_observed_port;

  lvc_i2c_master_monitor_common   common;

  lvc_i2c_agent_configuration  cfg_snapshot;
  
  //////////////////////////////////////////////////////////////////////////////
  //
  //  Public interface (Component users may manipulate these fields/methods)
  //
  //////////////////////////////////////////////////////////////////////////////
  local lvc_i2c_agent_configuration cfg;

  // This field controls if this monitor has its checkers enabled
  // (by default checkers are on)
  bit checks_enable = 1;

  // This field controls if this monitor has its coverage enabled
  // (by default coverage is on)
  bit coverage_enable = 1;

  int xact_cnt=0;

  uvm_event   EVENT_START_CONDITION; 
  uvm_event   EVENT_STOP_CONDITION; 
  uvm_event   EVENT_ACK_RECEIVED; 
  uvm_event   EVENT_NACK_RECEIVED; 
  uvm_event   EVENT_START_BYTE; 
  uvm_event   EVENT_GEN_CALL; 
  uvm_event   EVENT_SLAVE_ADD_7_B; 
  uvm_event   EVENT_SLAVE_ADD_10_B; 
  uvm_event   EVENT_GET_PACKET; 
  uvm_event   EVENT_REPEATED_START_CONDITION; 

  // This macro performs UVM object creation, type control manipulation, and 
  // factory registration
  `uvm_component_utils_begin(lvc_i2c_master_monitor)
     `uvm_field_int(checks_enable, UVM_ALL_ON)
     `uvm_field_int(coverage_enable, UVM_ALL_ON)
     // USER: Register fields here
  `uvm_component_utils_end

   // new - constructor     
   extern function new(string name, uvm_component parent=null);

   // uvm build phase
   extern function void build_phase(uvm_phase phase);

   // uvm run phase
   extern virtual task run_phase(uvm_phase phase);

//   extern virtual function void report_phase(uvm_phase phase);

  // Events needed to trigger covergroups
  event lvc_i2c_master_cov_transaction;

  // Transfer collected covergroup
  covergroup lvc_i2c_master_cov_trans @lvc_i2c_master_cov_transaction;
    // USER implemented coverpoints
  endgroup : lvc_i2c_master_cov_trans

//  extern virtual function void set_common(lvc_i2c_master_monitor_common common);

//  extern virtual task get_cfg_via_task(ref lvc_i2c_configuration cfg);

  extern virtual protected task source_events();

  //extern virtual protected task source_callbacks();
//  extern virtual protected function void pre_master_xact_observed_put(lvc_i2c_master_transaction xact, ref bit drop);
//
//  extern virtual protected function void master_xact_observed_cov(lvc_i2c_master_transaction xact);
//
//  extern virtual protected function void master_transaction_started(lvc_i2c_master_transaction xact);
//
//  extern virtual protected function void master_transaction_ended(lvc_i2c_master_transaction xact);
//  
//  extern virtual protected function void master_transaction_repeated_start(lvc_i2c_master_transaction xact);
//
//  extern virtual protected function void pre_master_xact_observed_put_cb_exec(lvc_i2c_master_transaction xact, ref bit drop);
//  
//  extern virtual protected function void master_xact_observed_cov_cb_exec(lvc_i2c_master_transaction xact);
  extern virtual task reconfigure_via_task(lvc_i2c_configuration cfg);
//  extern virtual protected function void master_transaction_started_cb_exec(lvc_i2c_master_transaction xact);
//  
//  extern virtual protected function void master_transaction_ended_cb_exec(lvc_i2c_master_transaction xact);
//  
//  extern virtual protected function void master_transaction_repeated_start_cb_exec(lvc_i2c_master_transaction xact);
//
//  extern virtual function void config_pre_output_port_put_cb_exec(lvc_i2c_agent_configuration cfg);
//
//  extern virtual protected function void startup_cb_exec();
  extern function void assign_vif();
//  extern virtual task lvc_apply_cfg();
//  extern task collect_errors();
  extern task received_and_sent();

endclass : lvc_i2c_master_monitor

function lvc_i2c_master_monitor::new(string name,uvm_component parent=null);
    super.new(name,parent);
    xact_observed_port = new("xact_observed_port", this);
    data_observed_port = new("data_observed_port", this);
endfunction

function void lvc_i2c_master_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info("build_phase", "lvc_i2c_master_monitor: Starting...",UVM_LOW)
    if(cfg==null && !uvm_config_db#(lvc_i2c_agent_configuration)::get(this,"","cfg",cfg)) begin
      `uvm_fatal("build_phase", "Unable to get the master agent configuration and failed to extract config info from the object")
    end else begin
        if(cfg.i2c_if==null)begin
            `uvm_fatal("build_phase", "A virtual interface was not received through the config object")
        end
        else begin
          common=lvc_i2c_master_monitor_common::type_id::create("common"); 
          common.cfg = this.cfg;
          this.assign_vif();
        end
    end
    `uvm_info("build_phase", $sformatf("%s: finishing...",get_type_name()), UVM_LOW)
  endfunction

task lvc_i2c_master_monitor::reconfigure_via_task(lvc_i2c_configuration cfg);
  if(!$cast(this.cfg, cfg))
    `uvm_fatal("CASTFAIL", "I2C configuration handle type inconsistence")
  common.reconfigure_via_task(cfg);
endtask


task lvc_i2c_master_monitor::source_events();
endtask

function void lvc_i2c_master_monitor::assign_vif();
  common.assign_vif(cfg.i2c_if); 
endfunction

task lvc_i2c_master_monitor::received_and_sent();
  lvc_i2c_master_transaction trans = new();
  lvc_i2c_master_transaction trans_tmp = new();
  fork
     common.collect_transfer(trans);
    forever begin
      wait(trans.data.size()!=0 | common.end_flag);
        $cast(trans_tmp,trans.clone());
        xact_observed_port.write(trans_tmp);
        data_observed_port.write(trans_tmp);
        $display("master monitor get trans, print_monitor_trans");
        trans_tmp.print();
        trans.data.delete();
        common.end_flag = 0;
    end
  join_none
endtask

task lvc_i2c_master_monitor::run_phase(uvm_phase phase);
   super.run_phase(phase);
  `uvm_info("run_phase", "lvc_i2c_master_monitor::Starting...", UVM_LOW)
  `uvm_info("run_phase", "Wait for Reset...", UVM_DEBUG)
  common.wait_for_reset(); 
  `uvm_info("run_phase", "Wait for Observed...", UVM_DEBUG)
  fork
   source_events();
   received_and_sent();
  join_none
  
  `uvm_info("run_phase", "lvc_i2c_master_monitor::Finishing...", UVM_LOW)
endtask

 

`endif // LVC_I2C_MASTER_MONITOR_SVH

