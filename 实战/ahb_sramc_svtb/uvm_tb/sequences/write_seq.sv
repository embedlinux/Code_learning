`ifndef WRITE_SEQ__SV
`define WRITE_SEQ__SV

//`include "../uvm_tb/packet.sv"

class write_seq extends basic_sequence;

  `uvm_object_utils(write_seq)
    
    logic [31:0] address=32'h2000_0000;
    logic [31:0] add=32'h0000_0004;
    int i;

  function new(string name = "write_seq");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task body();
   packet pkg;
   pkg =packet::type_id::create("pkg");

    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (starting_phase != null)
      starting_phase.raise_objection(this);
     
     for(i=0;i<200;i++)begin
        address = address+add;
        pkg.randomize()with {pkg.haddr==address &&
                             pkg.hwrite==1'b1;};
        start_item(pkg);
        finish_item(pkg);
      end 
    
   if (starting_phase != null)
     starting_phase.drop_objection(this);
  endtask: body

endclass: write_seq

`endif
