`ifndef DRIVER__SV
`define DRIVER__SV

class driver extends uvm_driver #(packet);
  
  virtual AHB_if.master sigs;
 
  `uvm_component_utils(driver)
    
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"),UVM_HIGH);
  endfunction:new

   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(virtual AHB_if.master)::get(this, "","AHB_if.master", sigs);
    if(sigs == null)begin
      `uvm_fatal("CFGERR", "Interface for Driver not set");
    end
 endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    forever begin
      seq_item_port.get_next_item(req);
      send(req);
      `uvm_info("DRV_RUN", {"\n", req.sprint()}, UVM_MEDIUM);
      seq_item_port.item_done();
    end
  endtask: run_phase

virtual task reset_phase(uvm_phase phase);
 super.reset_phase(phase);
  `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);  
    phase.raise_objection(this);
       sigs.cb_master.haddr<=0;
       sigs.cb_master.hburst<=3'b0; //single transfer
       sigs.cb_master.hbusreq<=0;
       sigs.cb_master.hlock<=0;
       sigs.cb_master.hprot<=4'b0;
       sigs.cb_master.hsize<=3'h0;
       sigs.cb_master.htrans<=2'h0; //NONSEQ
       sigs.cb_master.hwrite<=1'h0;
       sigs.cb_master.hwdata<=0;  //the data to be writen
    phase.drop_objection(this);
endtask:reset_phase  


virtual task send(packet tr);
fork
 begin
    forever begin
      if(sigs.reset_n )begin
        sigs.cb_master.hbusreq <=1'b1;
        break;
      end else begin
       @(sigs.cb_master);
      end
    end
         
   wait(sigs.cb_master.hgrant);
       begin
       sigs.cb_master.haddr <= tr.haddr;
       sigs.cb_master.htrans <= tr.htrans;
       sigs.cb_master.hburst <=tr.hburst;
       sigs.cb_master.hlock <=tr.hlock;
       sigs.cb_master.hprot <=tr.hprot;
       sigs.cb_master.hsize <=tr.hsize;
       sigs.cb_master.hwrite <=tr.hwrite;
       @sigs.cb_master;
       sigs.cb_master.hwdata <=tr.hwdata;
     //  sigs.cb_master.hwrite <=1'b0;
      // tr.hrdata<=sigs.cb_master.hrdata;
       end
  end     
join     
 endtask:send

endclass

`endif

