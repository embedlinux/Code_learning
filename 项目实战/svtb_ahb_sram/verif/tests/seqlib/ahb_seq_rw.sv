

class ahb_seq_rw extends ahb_base_seq;

  `uvm_object_utils(ahb_seq_rw)

  extern function new(string name = "ahb_seq_rw");
  extern task body();

endclass : ahb_seq_rw


function ahb_seq_rw::new(string name = "ahb_seq_rw");
  super.new(name);
endfunction : new

task ahb_seq_rw::body();
  `uvm_info(get_type_name(), "Default sequence starting***", UVM_HIGH)

   for(int i=0;i<20;i++)
     `uvm_do_with(req,{haddr==i*4;hwrite==1;hsize==2;});

  for(int i=0;i<20;i++)
     `uvm_do_with(req,{haddr==i*4;hwrite==0;hsize==2;});
  

  `uvm_do_with(req,{haddr==400;hwrite==1;hsize==2;hwdata==32'hffffffff;});
  `uvm_do_with(req,{haddr==400;hwrite==0;hsize==2;});


  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body


