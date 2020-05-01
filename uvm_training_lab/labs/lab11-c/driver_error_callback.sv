`ifndef __DRIVER_ERROR_CALLBACK__SV__
`define __DRIVER_ERROR_CALLBACK__SV__

class driver_error_callback extends driver_base_callback;

  function new(string name = "driver_error_callback");
    super.new(name);
  endfunction

  virtual task pre_send(my_driver drv);
    drv.req.payload.push_back(5'b10101);
  endtask


endclass


`endif
