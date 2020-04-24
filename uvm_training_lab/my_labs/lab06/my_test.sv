`ifndef __MY_TEST__SV__
`define __MY_TEST__SV__

class my_test extends uvm_test;

	`uvm_component_utils(my_test)

	my_env m_env;
	env_config m_env_cfg;


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
		m_env_cfg = new("m_env_cfg");
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_env = my_env::type_id::create("m_env", this);
		uvm_config_db#(uvm_object_wrapper)::set(this, "*.m_seqr.run_phase",
								"default_sequence", my_sequence::get_type());
		uvm_config_db#(int)::set(this, "*.m_seqr", "item_num", 20);

		m_env_cfg.is_coverage = 1;
		m_env_cfg.is_check    = 1;
		m_env_cfg.m_agent_cfg.is_active = UVM_ACTIVE;
		m_env_cfg.m_agent_cfg.pad_cycles = 10;

		if (!uvm_config_db#(virtual dut_interface)::get(this, "", "top_if", m_env_cfg.m_agent_cfg.m_vif)) begin 
			`uvm_fatal("CONFIG_FATAL", "test can not get the interface!!!")
		end

		uvm_config_db#(env_config)::set(this, "m_env", "env_cfg", m_env_cfg);

	endfunction : build_phase


	virtual function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		uvm_top.print_topology(uvm_default_table_printer);
	endfunction : start_of_simulation_phase


endclass : my_test

`endif // __MY_TEST__SV__
