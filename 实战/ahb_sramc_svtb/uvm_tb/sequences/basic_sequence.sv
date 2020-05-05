`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "../uvm_tb/packet.sv"

class basic_sequence extends uvm_sequence #(packet);

  `uvm_object_utils(basic_sequence)

  function new(string name = "basic_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task body();
    packet pkg;
    pkg =packet::type_id::create("pkg");

    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (starting_phase != null)
      starting_phase.raise_objection(this);
    repeat(200) begin
      pkg.randomize();
      start_item(pkg);
      finish_item(pkg);
    end
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask: body

endclass: basic_sequence

`endif
