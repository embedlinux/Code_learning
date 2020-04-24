`ifndef __MY_DRIVER_COUNT__SV__
`define __MY_DRIVER_COUNT__SV__

class my_driver_count extends my_driver;

	`uvm_component_utils(my_driver_count)

	function new(string name = "my_driver_count", uvm_component parent);
		super.new(name, parent);
	endfunction : new


	virtual task run_phase(uvm_phase phase);
		int i = 0;
		forever begin 
			seq_item_port.get_next_item(req);
			`uvm_info("DRV_RUN_PHASE", $sformatf("\n%s", req.sprint()), UVM_MEDIUM)
			#100;
			`uvm_info("DRV_RUN_PHASE", $sformatf("Driver get the %0dth item!", ++i), UVM_MEDIUM)
			seq_item_port.item_done();
		end
	endtask : run_phase


endclass : my_driver_count


`endif // __MY_DRIVER_COUNT__SV__
