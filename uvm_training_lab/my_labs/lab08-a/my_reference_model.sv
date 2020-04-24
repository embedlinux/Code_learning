`ifndef __MY_REFERENCE_MODEL__SV__
`define __MY_REFERENCE_MODEL__SV__


class my_reference_model extends uvm_component;

	`uvm_component_utils(my_reference_model)

	// uvm_blocking_put_imp #(my_transaction, my_reference_model) i_m2r_imp;
	uvm_blocking_get_port #(my_transaction) i_m2r_port;
	my_transaction item;


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
		// this.i_m2r_imp = new("i_m2r_imp", this);
		this.i_m2r_port = new("i_m2r_port", this);
	endfunction : new


	virtual task run_phase(uvm_phase phase);
		`uvm_info("REF_MODEL_RUN", "Reference model runing!", UVM_MEDIUM)

		forever begin 
			i_m2r_port.get(item);
			`uvm_info("REF_REPORT", {"\n", "master agent have been sent a transaction: \n", item.sprint()}, UVM_MEDIUM)
		end
	endtask : run_phase


	// task put(my_transaction tr);
	// 	`uvm_info("REF_REPORT", {"\n", "master agent have been sent a transaction: \n", tr.sprint()}, UVM_MEDIUM)
	// endtask : put


endclass : my_reference_model


`endif // __MY_REFERENCE_MODEL__SV__
