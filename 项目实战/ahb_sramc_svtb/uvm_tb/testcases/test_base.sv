`ifndef TEST_BASE__SV
`define TEST_BASE__SV

`include "../uvm_tb/router_env.sv"
class test_base extends uvm_test;

  `uvm_component_utils(test_base)

  router_env env;

    function new(string name="test_base", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    env = router_env::type_id::create("env", this);
    uvm_config_db#(virtual AHB_if.master)::set(this, "env.i_agent","AHB_if.master", tb.VIP_MASTER_if);
     uvm_config_db #(uvm_object_wrapper)::set(this, "env.i_agent.seqr.main_phase", "default_sequence", basic_sequence::get_type());

  endfunction: build_phase

  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    uvm_top.print_topology();
    factory.print();

  endfunction: final_phase

endclass: test_base
`endif

