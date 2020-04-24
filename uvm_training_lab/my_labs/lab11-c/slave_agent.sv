`ifndef __SLAVE_AGENT__SV__
`define __SLAVE_AGENT__SV__

class slave_agent extends uvm_agent;

	`uvm_component_utils(slave_agent)

	out_monitor m_mon;

	agent_config m_agent_cfg;

	uvm_blocking_put_export #(my_transaction) s_a2s_export;


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
		this.s_a2s_export = new("s_a2s_export", this);
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if (!uvm_config_db#(agent_config)::get(this, "", "m_agent_cfg", m_agent_cfg)) begin 
			`uvm_fatal("CONFIG_FATAL", "slave_agent can not get the configuration!!!")
		end

		uvm_config_db#(virtual dut_interface)::set(this, "m_mon", "vif", m_agent_cfg.m_vif);

		m_mon = out_monitor::type_id::create("m_mon", this);
	endfunction : build_phase


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		m_mon.m2s_port.connect(this.s_a2s_export);
	endfunction : connect_phase


endclass : slave_agent

`endif // __SLAVE_AGENT__SV__
