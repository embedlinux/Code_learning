
`ifndef RKV_I2C_SLAVE_BASE_SEQUENCE_SV
`define RKV_I2C_SLAVE_BASE_SEQUENCE_SV

virtual class rkv_i2c_slave_base_sequence extends uvm_sequence #(lvc_i2c_slave_transaction);

  ral_block_rkv_i2c rgm;
  lvc_i2c_configuration cfg;

  // Register model variables:
  uvm_status_e status;
  rand uvm_reg_data_t data;

  `uvm_declare_p_sequencer(lvc_i2c_slave_sequencer)

  function new (string name = "rkv_i2c_slave_base_sequence");
    super.new(name);
  endfunction

  virtual task body();
    // TODO
    // Attach element sequences below
  endtask
endclass


`endif // RKV_I2C_SLAVE_BASE_SEQUENCE_SV
