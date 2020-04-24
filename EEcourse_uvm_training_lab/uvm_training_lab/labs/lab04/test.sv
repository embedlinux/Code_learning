

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "dut_interface.sv"
  `include "my_transaction.sv"
  `include "my_sequence.sv"
  `include "my_driver.sv"
  `include "my_sequencer.sv"
  `include "my_monitor.sv"
  `include "master_agent.sv"
  `include "my_env.sv"
  `include "my_test.sv"
  `include "my_transaction_da3.sv"
  `include "my_test_type_da3.sv"
  `include "my_test_inst_da3.sv"
  `include "my_driver_count.sv"
  `include "my_test_type_driver.sv"
  `include "my_test_inst_driver.sv"
program automatic test;
  initial begin
    run_test("");
  end

endprogram
