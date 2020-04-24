`ifndef __MY_TEST_DRIVER_ERROR__SV__
`define __MY_TEST_DRIVER_ERROR__SV__


class my_test_driver_error extends my_test;

	`uvm_component_utils(my_test_driver_error)

	driver_error_callback drv_err_cb;


	function new(string name = "", uvm_component parent);
		super.new(name, parent);
	endfunction : new


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv_err_cb = new();
		uvm_callbacks#(my_driver, driver_base_callback)::add(m_env.m_agent.m_drv, drv_err_cb);
	endfunction : connect_phase


endclass : my_test_driver_error


`endif // __MY_TEST_DRIVER_ERROR__SV__
