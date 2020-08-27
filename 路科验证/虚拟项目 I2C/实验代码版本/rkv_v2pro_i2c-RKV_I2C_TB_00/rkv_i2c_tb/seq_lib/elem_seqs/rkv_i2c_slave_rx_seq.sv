
`ifndef RKV_I2C_SLAVE_RX_SEQ_SV
`define RKV_I2C_SLAVE_RX_SEQ_SV

class rkv_i2c_slave_rx_seq extends rkv_i2c_slave_base_sequence;

  `uvm_object_utils(rkv_i2c_slave_rx_seq)

 

  function new (string name = "rkv_apb_config_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_I2C_SLAVE_RX_SEQ_SV
