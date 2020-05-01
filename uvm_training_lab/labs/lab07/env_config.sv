`ifndef __ENV_CONFIG__SV__
`define __ENV_CONFIG__SV__

class env_config extends uvm_object;

  int is_coverage = 0;
  int is_check    = 0;

  agent_config m_agent_cfg;

  `uvm_object_utils_begin(env_config)
    `uvm_field_int(is_coverage, UVM_ALL_ON)
    `uvm_field_int(is_check, UVM_ALL_ON)
    `uvm_field_object(m_agent_cfg, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="env_config");
    super.new(name);
    m_agent_cfg = new("m_agent_cfg");
  endfunction

endclass

`endif
