

`ifndef __MY_TRANSACTION_DA3__SV__
`define __MY_TRANSACTION_DA3__SV__

class my_transaction_da3 extends my_transaction;


  `uvm_object_utils(my_transaction_da3)

  constraint da3 { da == 3; }

  function new(string name = "my_transaction_da3");
    super.new(name);
  endfunction : new

endclass


`endif
