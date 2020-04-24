`ifndef __MY_DRIVER__SV__
`define __MY_DRIVER__SV__

class my_driver extends uvm_driver #(my_transaction);
  
  `uvm_component_utils(my_driver)

  function new(string name = "my_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("DRV_RUN_PHASE", req.sprint(), UVM_MEDIUM)
      #100;
      seq_item_port.item_done();
    end
  endtask

endclass

`endif
