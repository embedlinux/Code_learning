
`ifndef RKV_APB_BASE_SEQUENCE_SV
`define RKV_APB_BASE_SEQUENCE_SV

virtual class rkv_apb_base_sequence extends uvm_sequence #(lvc_apb_transfer);

  ral_block_rkv_i2c rgm;

  
  `uvm_declare_p_sequencer(lvc_apb_master_sequencer)

  // Register model variables:
  uvm_status_e status;
  rand uvm_reg_data_t data;

  function new (string name = "rkv_apb_base_sequence");
    super.new(name);
  endfunction

  virtual task body();
    // TODO
    // Attach element sequences below
  endtask
endclass

`endif // RKV_APB_BASE_SEQUENCE_SV
