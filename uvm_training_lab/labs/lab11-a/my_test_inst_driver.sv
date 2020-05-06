`ifndef __MY_TEST_INST_DRIVER__SV__
`define __MY_TEST_INST_DRIVER__SV__

class my_test_inst_driver extends my_test;
  
  `uvm_component_utils(my_test_inst_driver)


  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_inst_override_by_type("m_env.m_agent.*",
                              my_driver::get_type(),
                              my_driver_count::get_type());
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    factory.print();
  endfunction

endclass

`endif