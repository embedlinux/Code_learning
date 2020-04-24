`ifndef __DRIVER_INFO_CALLBACK__SV__
`define __DRIVER_INFO_CALLBACK__SV__


class driver_info_callback extends driver_base_callback;


	function new(string name = "driver_info_callback");
		super.new(name);
	endfunction : new


	virtual task post_send();
		`uvm_info("DRIVER_CALLBACK", "This information is for UVM Callback test!!!", UVM_MEDIUM)
	endtask : post_send


endclass : driver_info_callback


`endif // __DRIVER_INFO_CALLBACK__SV__
