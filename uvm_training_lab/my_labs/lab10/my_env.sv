`ifndef __MY_ENV__SV__
`define __MY_ENV__SV__

class my_env extends uvm_env;

	`uvm_component_utils(my_env)

	master_agent m_agent;
	slave_agent  s_agent;
	env_config   m_env_cfg;
	// agent_config m_agent_cfg;
	my_reference_model ref_model;
	my_scoreboard sb;

	uvm_tlm_analysis_fifo#(my_transaction) r2s_fifo;
	uvm_tlm_analysis_fifo#(my_transaction) s_a2s_fifo;
	

	function new(string name = "", uvm_component parent);
		super.new(name, parent);	
		this.r2s_fifo = new("r2s_fifo", this);
		this.s_a2s_fifo = new("s_a2s_fifo", this);
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if (!uvm_config_db#(env_config)::get(this, "", "env_cfg", m_env_cfg)) begin 
			`uvm_fatal("CONFIG_FATAL", "ENV can not get the configuration!!!")
		end
		// m_agent_cfg = m_env_cfg.m_agent_cfg;
		uvm_config_db#(agent_config)::set(this, "m_agent", "m_agent_cfg", m_env_cfg.m_agent_cfg);
		uvm_config_db#(agent_config)::set(this, "s_agent", "m_agent_cfg", m_env_cfg.m_agent_cfg);

		if (m_env_cfg.is_coverage) begin 
			`uvm_info("COVERAGE_ENABLE", "The function coverage is enabled for this testcase", UVM_MEDIUM)
		end
		if (m_env_cfg.is_check) begin 
			`uvm_info("CHECK_ENABLE", "The check function is enabled for this testcase", UVM_MEDIUM)
			sb = my_scoreboard::type_id::create("sb", this);
		end

		m_agent = master_agent::type_id::create("m_agent", this);
		s_agent = slave_agent::type_id::create("s_agent", this);
		ref_model = my_reference_model::type_id::create("ref_model", this);
	endfunction : build_phase


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("ENV", "Connect the agent and reference model...", UVM_MEDIUM)
		m_agent.m_a2r_export.connect(ref_model.i_m2r_imp);
		s_agent.s_a2s_export.connect(this.s_a2s_fifo.blocking_put_export);
		ref_model.r2s_port.connect(this.r2s_fifo.blocking_put_export);
		if (m_env_cfg.is_check) begin 
			sb.r2s_port.connect(this.r2s_fifo.blocking_get_export);
			sb.s_a2s_port.connect(this.s_a2s_fifo.blocking_get_export);
		end
	endfunction : connect_phase


endclass : my_env

`endif // __MY_ENV__SV__
