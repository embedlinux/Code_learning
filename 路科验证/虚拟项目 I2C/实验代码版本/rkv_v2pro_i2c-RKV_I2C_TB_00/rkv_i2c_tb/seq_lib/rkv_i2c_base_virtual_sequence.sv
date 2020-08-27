

`ifndef RKV_I2C_BASE_VIRTUAL_SEQUENCE_SV
`define RKV_I2C_BASE_VIRTUAL_SEQUENCE_SV

virtual class rkv_i2c_base_virtual_sequence extends uvm_sequence;

  ral_block_rkv_i2c rgm;
  virtual rkv_i2c_if vif;


  // Register model variables:
  uvm_status_e status;
  rand uvm_reg_data_t data;

  // element sequences
  rkv_apb_config_seq     apb_cfg_seq;
  rkv_apb_wait_empty_seq apb_wait_empty_seq;
  rkv_i2c_slave_rx_seq   i2c_slv_rx_seq;

  `uvm_declare_p_sequencer(rkv_i2c_virtual_sequencer)

  function new (string name = "rkv_i2c_base_virtual_sequence");
    super.new(name);
  endfunction

  virtual task body();
    // TODO
    // Attach element sequences below
  endtask

  virtual task do_reset_callback();
    fork
      forever begin
        vif.wait_rstn_release();
        rgm.reset();
      end
    join_none
  endtask

  function bit diff_value(int val1, int val2, string id = "value_compare");
    if(val1 != val2) begin
      `uvm_error("[CMPERR]", $sformatf("ERROR! %s val1 %8x != val2 %8x", id, val1, val2)) 
      return 0;
    end
    else begin
      `uvm_info("[CMPSUC]", $sformatf("SUCCESS! %s val1 %8x == val2 %8x", id, val1, val2), UVM_LOW)
      return 1;
    end
  endfunction

endclass

`endif // RKV_I2C_BASE_VIRTUAL_SEQUENCE_SV
