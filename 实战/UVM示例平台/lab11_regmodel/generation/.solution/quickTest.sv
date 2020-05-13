
/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
Standalone test file to test generated register definition file
 To simlulate : 
    irun -clean -uvmhome default \
      -afile access_file ./quickTest.sv
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/

`include "./memctl_reg_pkg.sv"

module test();
  import uvm_pkg::*;  
  import memctl_reg_pkg::*;

  import cdns_uvm_addons::*;

class test extends uvm_test;
  memctl_reg_model_c reg_block;
  
  virtual function void build();
    uvm_reg::include_coverage("*", UVM_CVR_ALL);
    reg_block=memctl_reg_model_c::type_id::create("reg_block", this);
    reg_block.build();
  endfunction
  
  task run();
    reg_block.reset();
    reg_block.print();
    global_stop_request();
  endtask
  `uvm_component_utils(test)
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
endclass
  initial run_test("test");
endmodule
