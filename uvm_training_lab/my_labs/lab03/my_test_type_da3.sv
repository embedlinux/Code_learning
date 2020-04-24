`ifndef __MY_TEST_TYPE_DA3__SV__
`define __MY_TEST_TYPE_DA3__SV__


class my_test_type_da3 extends  my_test;

	`uvm_component_utils(my_test_type_da3)


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		set_type_override_by_type(my_transaction::get_type(),
								  my_transaction_da3::get_type());
	endfunction : build_phase


	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		factory.print();
	endfunction : report_phase


endclass : my_test_type_da3


`endif // __MY_TEST_TYPE_DA3__SV__