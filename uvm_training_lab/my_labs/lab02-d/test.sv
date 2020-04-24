`ifndef __TEST__SV__
`define __TEST__SV__

program automatic test;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "my_transaction.sv"
	`include "my_sequence.sv"
	`include "my_driver.sv"
	`include "my_sequencer.sv"
	`include "my_monitor.sv"
	`include "master_agent.sv"
	`include "my_env.sv"
	`include "my_test.sv"

	initial begin 
		run_test("");
	end

endprogram


`endif // __TEST__SV__
