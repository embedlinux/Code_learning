// changes for memctl_tb_reg.sv to integrate register model

  //UVMREG: Register model handle
  memctl_reg_model_c model;  

  //UVMREG: apb adapter for register model
  reg_to_apb_adapter reg2apb;  

  // UVM automation 
  //UVMREG: add Register model automation
  `uvm_component_utils_begin(memctl_tb)
     `uvm_field_object(model, UVM_ALL_ON) 
  `uvm_component_utils_end

//------------------------------------------------------------------

  //UVMREG: Create, build and lock model in build_phase()
  model = memctl_reg_model_c::type_id::create("model");
  model.build();
  model.lock_model();
  // UVMREG: This is implicit prediction, so make sure auto_predict is turned on.
  //  Default is to have an explicit predictor and auto_predict disabled
  model.default_map.set_auto_predict(1);

  // UVMREG: Create the adapter
  reg2apb = reg_to_apb_adapter::type_id::create("reg2apb",this);

//------------------------------------------------------------------

  //UVMREG: Set the sequencer and adapter for the register model in
  //connect_phase()
  model.default_map.set_sequencer(apb0.master.sequencer, reg2apb);
  
//------------------------------------------------------------------

