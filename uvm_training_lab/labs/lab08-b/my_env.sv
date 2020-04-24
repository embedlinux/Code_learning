`ifndef __MY_ENV__SV__
`define __MY_ENV__SV__

class my_env extends uvm_env;
  
  `uvm_component_utils(my_env)

  master_agent m_agent;
  env_config   m_env_cfg;
 // agent_config m_agent_cfg;
  my_reference_model ref_model;

  uvm_tlm_analysis_fifo #(my_transaction) magt2ref_fifo;


  function new(string name = "", uvm_component parent);
    super.new(name, parent);
    magt2ref_fifo = new("magt2ref", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(env_config)::get(this, "", "env_cfg", m_env_cfg)) begin
      `uvm_fatal("CONFIG_FATAL","ENV can not get the configuration !!!")
    end
    //m_agent_cfg = m_env_cfg.m_agent_cfg;
    uvm_config_db#(agent_config)::set(this, "m_agent", "m_agent_cfg", m_env_cfg.m_agent_cfg);

    if(m_env_cfg.is_coverage) begin
      `uvm_info("COVERAGE_ENABLE", "The function coverage is enabled for this testcase", UVM_MEDIUM)
    end
    if(m_env_cfg.is_check) begin
      `uvm_info("CHECK_ENABLE", "The check function is enabled for this testcase", UVM_MEDIUM)
    end

    m_agent = master_agent::type_id::create("m_agent", this);
    ref_model = my_reference_model::type_id::create("ref_model", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV", "Connect the agent to fifo...", UVM_MEDIUM)
    m_agent.m_a2r_export.connect(this.magt2ref_fifo.blocking_put_export);
    `uvm_info("ENV", "Connect the reference model to fifl...", UVM_MEDIUM)
    ref_model.i_m2r_port.connect(this.magt2ref_fifo.blocking_get_export);
  endfunction

endclass

`endif
