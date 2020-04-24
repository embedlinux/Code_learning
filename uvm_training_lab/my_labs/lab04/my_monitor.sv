`ifndef __MY_MONITOR__SV__
`define __MY_MONITOR__SV__

class my_monitor extends uvm_monitor;

	`uvm_component_utils(my_monitor)

	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction : new


	// virtual task reset_phase(uvm_phase phase);
	// 	phase.raise_objection(this);
	// 	#150;
	// 	`uvm_info("MON_RESET_PHASE", "Now Monitor reset_phase running!", UVM_MEDIUM)
	// 	phase.drop_objection(this);
	// endtask : reset_phase


	virtual task run_phase(uvm_phase phase);
		forever begin 
			`uvm_info("MON_RUN_PHASE", "Monitor run!", UVM_MEDIUM)
			#100;
		end
	endtask : run_phase


endclass : my_monitor

`endif // __MY_MONITOR__SV__