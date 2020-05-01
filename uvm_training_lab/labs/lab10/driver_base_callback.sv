`ifndef __DRIVER_BASE_CALLBACK__SV__
`define __DRIVER_BASE_CALLBACK__SV__

typedef class my_driver;

class driver_base_callback extends uvm_callback;

  function new(string name = "driver_base_callback");
    super.new(name);
  endfunction

  virtual task pre_send(my_driver drv);
    
  endtask

  virtual task post_send();
    
  endtask


endclass

`endif
