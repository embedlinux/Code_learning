`ifndef __MY_ENV__SV__
`define __MY_ENV__SV__

class my_env extends uvm_env;

	`uvm_component_utils(my_env)

	master_agent m_agent;
	env_config   m_env_cfg;
	// agent_config m_agent_cfg;
	

	function new(string name = "", uvm_component parent);
		super.new(name, parent);	
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if (!uvm_config_db#(env_config)::get(this, "", "env_cfg", m_env_cfg)) begin 
			`uvm_fatal("CONFIG_FATAL", "ENV can not get the configuration!!!")
		end
		// m_agent_cfg = m_env_cfg.m_agent_cfg;
		uvm_config_db#(agent_config)::set(this, "m_agent", "m_agent_cfg", m_env_cfg.m_agent_cfg);

		if (m_env_cfg.is_coverage) begin 
			`uvm_info("COVERAGE_ENABLE", "The function coverage is enabled for this testcase", UVM_MEDIUM)
		end
		if (m_env_cfg.is_check) begin 
			`uvm_info("CHECK_ENABLE", "The check function is enabled for this testcase", UVM_MEDIUM)
		end

		m_agent = master_agent::type_id::create("m_agent", this);
	endfunction : build_phase


endclass : my_env

`endif // __MY_ENV__SV__
