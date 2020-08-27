`ifndef RKV_I2C_DIRECTED_RX_VIRT_SEQ_SV
`define RKV_I2C_DIRECTED_RX_VIRT_SEQ_SV
class rkv_i2c_directed_rx_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_directed_rx_virt_seq)

  function new (string name = "rkv_i2c_directed_rx_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "=====================STARTED=====================", UVM_LOW)
    super.body();
    // TODO
    #1ms;
    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask

endclass
`endif // RKV_I2C_DIRECTED_RX_VIRT_SEQ_SV
