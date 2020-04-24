`ifndef __SA6_DA3__SEQUENCE__SV__
`define __SA6_DA3__SEQUENCE__SV__

class sa6_da3_sequence extends my_sequence;

  `uvm_object_utils(sa6_da3_sequence)
  `uvm_add_to_seq_lib(sa6_da3_sequence, my_sequence_lib)

  function new(string name = "sa6_da3_sequence");
    super.new(name);
  endfunction

  virtual task body();
    my_transaction tr;

    if(starting_phase != null) 
      starting_phase.raise_objection(this);

    repeat(item_num) begin
    //`uvm_do(req)
      tr = my_transaction::type_id::create("tr");
      start_item(tr);
      tr.randomize() with {(tr.da == 3)&&(tr.sa == 6);};
      finish_item(tr);
      get_response(rsp);
      `uvm_info("SEQ", {"\n", "Sequence get the response: \n", rsp.sprint()}, UVM_MEDIUM)
    end

    #100;
    if(starting_phase != null)
      starting_phase.drop_objection(this);

  endtask
endclass

`endif
