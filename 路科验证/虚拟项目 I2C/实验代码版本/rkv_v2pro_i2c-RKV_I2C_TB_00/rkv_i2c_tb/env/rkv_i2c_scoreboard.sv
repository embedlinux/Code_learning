
`ifndef RKV_I2C_SCOREBOARD_SV
`define RKV_I2C_SCOREBOARD_SV

class rkv_i2c_scoreboard extends uvm_component;

  // TODO
  // Analysis FIFO declarion below

  `uvm_component_utils(rkv_i2c_scoreboard)

  function new (string name = "rkv_i2c_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction


endclass

`endif // RKV_I2C_SCOREBOARD_SV
