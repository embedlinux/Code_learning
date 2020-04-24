`ifndef __OUT_MONITOR__SV__
`define __OUT_MONITOR__SV__

class out_monitor extends uvm_monitor;

	`uvm_component_utils(out_monitor)

	virtual dut_interface m_vif;

	uvm_blocking_put_port #(my_transaction) m2s_port;


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
		this.m2s_port = new("m2s_port", this);
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
		if (!uvm_config_db#(virtual dut_interface)::get(this,"", "vif", m_vif)) begin 
			`uvm_fatal("CONFIG_FATAL", "Out Monitor can not get the interface!!!")
		end
	endfunction : build_phase


	// virtual task reset_phase(uvm_phase phase);
	// 	phase.raise_objection(this);
	// 	#150;
	// 	`uvm_info("MON_RESET_PHASE", "Now Monitor reset_phase running!", UVM_MEDIUM)
	// 	phase.drop_objection(this);
	// endtask : reset_phase


	virtual task run_phase(uvm_phase phase);
		my_transaction tr;
		int active_port;
		logic [7:0] temp;
		int count;
		forever begin
			active_port = -1;
			count = 0;

			tr = my_transaction::type_id::create("tr");

			// Wait for bus active
			while (1) begin 
				@(m_vif.omonitor_cb);
				foreach (m_vif.omonitor_cb.frameo_n[i]) begin 
					if (m_vif.omonitor_cb.frameo_n[i] == 0) begin 
						active_port = i;
					end
				end
				if (active_port != -1) begin 
					break;
				end
			end

			// Active port has been detected
			tr.da = active_port;

			// Get the payload
			forever begin 
				if (m_vif.omonitor_cb.valido_n[tr.da] == 0) begin 
					temp[count] = m_vif.omonitor_cb.dout[tr.da];
					count++;
					if (count == 8) begin 
						tr.payload.push_back(temp);
						count = 0;
					end
				end

				if (m_vif.omonitor_cb.frameo_n[tr.da]) begin 
					if (count != 0) begin 
						tr.payload.push_back(temp);
						`uvm_warning("PAYLOAD_WARNING", "Payload not byte aligned!!!")
					end
					break;
				end
				@(m_vif.omonitor_cb);
			end

			`uvm_info("Out_Monitor", {"\n", "Out monitor Got An Input Transaction: \n", tr.sprint()}, UVM_MEDIUM)
			`uvm_info("Out_Monitor", "Now, Out monitor send the transaction to the Scoreboard!", UVM_MEDIUM)
			this.m2s_port.put(tr);
		end
	endtask : run_phase


endclass : out_monitor

`endif // __OUT_MONITOR__SV__