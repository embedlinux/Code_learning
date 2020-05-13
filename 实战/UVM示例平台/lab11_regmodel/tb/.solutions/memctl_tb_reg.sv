/*-----------------------------------------------------------------
File name     : memctl_tb.sv
Developers    : Kathleen Meade
Created       : Wed Mar 9, 2011
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2011 (c) Cadence Design Systems
-----------------------------------------------------------------*/
//------------------------------------------------------------------------------
// CLASS: memctl_tb
//------------------------------------------------------------------------------
class memctl_tb extends uvm_env;

  // APB environment and configuration
  apb_pkg::apb_env apb0;
  apb_pkg::apb_config apb_cfg;

  //UVMREG: Register model handle
  memctl_reg_model_c model;  

  //UVMREG: apb adapter for register model
  reg_to_apb_adapter reg2apb;  


  // UVM automation 
  //UVMREG: add Register model automation
  `uvm_component_utils_begin(memctl_tb)
     `uvm_field_object(model, UVM_ALL_ON) 
  `uvm_component_utils_end

  // Constructor
  function new (string name, uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : memctl_tb

// UVM build_phase()
function void memctl_tb::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // Configure the APB UVC: 
  if (apb_cfg == null)
    if (!uvm_config_db#(apb_config)::get(this, "", "apb_cfg", apb_cfg)) begin
       `uvm_info("NOCONFIG", "No APB config. creating...", UVM_LOW)
        apb_cfg = apb_config::type_id::create("apb_cfg", this);
        apb_cfg.add_master("master", UVM_ACTIVE);
        apb_cfg.add_slave("slave0", 'h00, 'h1fff, 'h0, UVM_PASSIVE);
    end
  uvm_config_object::set(this, "apb0*", "cfg", apb_cfg);

  // Create the APB  
  apb0              = apb_env::type_id::create("apb0", this);

  //UVMREG: Create, build and lock model
  model = memctl_reg_model_c::type_id::create("model",this);
  model.build();
  model.lock_model();
  // UVMREG: This is implicit prediction, so make sure auto_predict is turned on.
  //  Default is to have an explicit predictor and auto_predict disabled
  model.default_map.set_auto_predict(1);

  // UVMREG: Create the adapter
  reg2apb = reg_to_apb_adapter::type_id::create("reg2apb",this);

endfunction : build_phase

// UVM connect_phase()
function void memctl_tb::connect_phase(uvm_phase phase);

  //UVMREG: Set the sequencer and adapter for the register model
  model.default_map.set_sequencer(apb0.master.sequencer, reg2apb);
  
endfunction : connect_phase

