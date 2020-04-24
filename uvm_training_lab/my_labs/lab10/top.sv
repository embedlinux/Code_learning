`ifndef __TOP__SV__
`define __TOP__SV__


`include "../../rtl/router.v"
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "dut_interface.sv"
`include "my_transaction.sv"
`include "my_sequence.sv"
`include "agent_config.sv"
`include "env_config.sv"
`include "driver_base_callback.sv"
`include "driver_error_callback.sv"
`include "driver_info_callback.sv"
`include "my_driver.sv"
`include "my_sequencer.sv"
`include "my_monitor.sv"
`include "out_monitor.sv"
`include "master_agent.sv"
`include "slave_agent.sv"
`include "my_reference_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"
`include "my_test.sv"
`include "my_transaction_da3.sv"
`include "my_test_type_da3.sv"
`include "my_test_inst_da3.sv"
`include "my_driver_count.sv"
`include "my_test_type_driver.sv"
`include "my_test_inst_driver.sv"
`include "my_test_driver_error.sv"
`include "my_test_driver_info.sv"

module top ();

	bit sys_clk;

	dut_interface inf(sys_clk);

	router dut(.reset_n	(inf.reset_n),
			   .clock	(inf.clk),
			   .frame_n	(inf.frame_n),
			   .valid_n	(inf.valid_n),
			   .din 	(inf.din),
			   .dout 	(inf.dout),
			   .busy_n	(inf.busy_n),
			   .valido_n(inf.valido_n),
			   .frameo_n(inf.frameo_n)
				);

	initial begin 
		sys_clk = 1'b0;
		forever #10 sys_clk = ~sys_clk;
	end

	initial begin 
		uvm_config_db#(virtual dut_interface)::set(null, "uvm_test_top", "top_if", inf);
		run_test();
	end

	initial begin 
		$dumpvars();
	end


endmodule




`endif // __TOP__SV__

