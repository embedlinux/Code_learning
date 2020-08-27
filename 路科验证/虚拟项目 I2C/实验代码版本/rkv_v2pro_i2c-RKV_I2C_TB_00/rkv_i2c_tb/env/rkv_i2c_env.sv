
`ifndef RKV_I2C_ENV_SV
`define RKV_I2C_ENV_SV

class rkv_i2c_env extends uvm_component;

  // top configuration
  rkv_i2c_config cfg;

  lvc_apb_master_agent apb_mst;

  lvc_i2c_master_agent i2c_mst;

  lvc_i2c_slave_agent i2c_slv;

  // top scoreboard
  rkv_i2c_scoreboard sbd;

  // top virtual sequencer
  rkv_i2c_virtual_sequencer sqr;

  // top coverage model
  rkv_i2c_cgm cgm;

  // top register model and related components
  ral_block_rkv_i2c rgm;
  lvc_apb_reg_adapter adapter;
  uvm_reg_predictor #(lvc_apb_transfer) predictor;

  `uvm_component_utils(rkv_i2c_env)

  function new (string name = "rkv_i2c_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  endfunction: build_phase


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // TODO
    // connect monitor analysis port to scoreboard
      
    // TODO
    // connect monitor analysis port to coverage model

    // virtual sequencer routing with sub-sequencers

    // register model integration

  endfunction: connect_phase

endclass


`endif
