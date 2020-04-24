`ifndef __MY_REFERENCE_MODEL__SV__
`define __MY_REFERENCE_MODEL__SV__


class my_reference_model extends uvm_component;

	`uvm_component_utils(my_reference_model)

	uvm_blocking_put_imp #(my_transaction, my_reference_model) i_m2r_imp;
	uvm_blocking_put_port #(my_transaction) r2s_port;
	my_transaction item;


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
		this.i_m2r_imp = new("i_m2r_imp", this);
		this.r2s_port = new("r2s_port", this);
	endfunction : new


	task put(my_transaction tr);

		`uvm_info("REF_REPORT", {"\n", "master agent have sent a transaction: \n", tr.sprint()}, UVM_MEDIUM)
		this.r2s_port.put(tr);

	endtask : put


endclass : my_reference_model


`endif // __MY_REFERENCE_MODEL__SV__
