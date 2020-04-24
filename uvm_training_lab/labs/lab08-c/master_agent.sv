`ifndef __MASTER_AGENT__SV__
`define __MASTER_AGENT__SV__

class master_agent extends uvm_agent;
  
  `uvm_component_utils(master_agent)

  my_sequencer m_seqr;
  my_driver    m_driv;
  my_monitor   m_moni;

  agent_config m_agent_cfg;
  
  uvm_analysis_port #(my_transaction) m_a2r_a_port;

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
    this.m_a2r_a_port = new("m_a2r_a_port", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(agent_config)::get(this, "", "m_agent_cfg", m_agent_cfg)) begin
      `uvm_fatal("CONFIG_FATAL", "master_agent can not get the configuration !!!")
    end

    is_active = m_agent_cfg.is_active;
    
    uvm_config_db#(int unsigned)::set(this, "m_driv", "pad_cycles", m_agent_cfg.pad_cycles);
    uvm_config_db#(virtual dut_interface)::set(this, "m_driv", "vif", m_agent_cfg.m_vif);
    uvm_config_db#(virtual dut_interface)::set(this, "m_moni", "vif", m_agent_cfg.m_vif);

    if(is_active == UVM_ACTIVE) begin
      m_seqr = my_sequencer::type_id::create("m_seqr", this);
      m_driv = my_driver::type_id::create("m_driv", this);
    end
    m_moni = my_monitor::type_id::create("m_moni", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE)
      m_driv.seq_item_port.connect(m_seqr.seq_item_export);
    m_moni.m2r_a_port = this.m_a2r_a_port;
  endfunction
    
endclass

`endif
