`ifndef __MY_TEST_TYPE_DRIVER__SV__
`define __MY_TEST_TYPE_DRIVER__SV__


class my_test_type_driver extends  my_test;

	`uvm_component_utils(my_test_type_driver)


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		set_type_override_by_type(my_driver::get_type(),
								  my_driver_count::get_type());
	endfunction : build_phase


	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		factory.print();
	endfunction : report_phase


endclass : my_test_type_driver


`endif // __MY_TEST_TYPE_DRIVER__SV__
