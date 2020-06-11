`ifndef INPUT_AGENT__SV
`define INPUT_AGENT__SV

`include "../uvm_tb/sequences/basic_sequence.sv"
`include "../uvm_tb/sequences/write_seq.sv"
`include "../uvm_tb/driver.sv"

typedef uvm_sequencer #(packet) my_sequencer;

class input_agent extends uvm_agent;
  
  virtual AHB_if.master sigs;
  my_sequencer seqr;
  driver drv;

  `uvm_component_utils(input_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    
    uvm_config_db#(virtual AHB_if.master)::get(this, "", "AHB_if.master", sigs);
    seqr = my_sequencer::type_id::create("seqr", this);
    drv  = driver::type_id::create("drv", this);
    
    uvm_config_db#(virtual AHB_if.master)::set(this, "drv", "AHB_if.master", sigs);
    uvm_config_db#(virtual AHB_if.master)::set(this, "seqr", "AHB_if.master", sigs);
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction: connect_phase

endclass: input_agent

`endif
