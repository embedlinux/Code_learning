`ifndef __MY_MONITOR__SV__
`define __MY_MONITOR__SV__

class my_monitor extends uvm_monitor;

  `uvm_component_utils(my_monitor)

  virtual dut_interface m_vif;

  uvm_blocking_put_port #(my_transaction) m2r_port;

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
    this.m2r_port = new("m2r_port", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
    if(!uvm_config_db#(virtual dut_interface)::get(this, "", "vif", m_vif)) begin
      `uvm_fatal("CONFIG_FATAL", "Monitor can not get the interface !!!")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    
    my_transaction tr;
    int active_port;
    logic  [7:0] temp;
    int count;

    forever begin
      active_port = -1;
      count = 0;

      tr = my_transaction::type_id::create("tr");
      
      // Wait for bus active
      while(1) begin
        @(m_vif.imonitor_cb);
        foreach(m_vif.imonitor_cb.frame_n[i]) begin
          if(m_vif.imonitor_cb.frame_n[i] == 0) begin
            active_port = i;
          end
        end

        if(active_port != -1) begin
          break;
        end
      end
      
      // Get the active port id
      tr.sa = active_port;
      
      // Get the target address  
      for(int i=0; i<4; i++) begin
        tr.da[i] = m_vif.imonitor_cb.din[tr.sa];
        @(m_vif.imonitor_cb);
      end

      // Get the payload
      forever begin
        if(m_vif.imonitor_cb.valid_n[tr.sa] == 0) begin
          temp[count] = m_vif.imonitor_cb.din[tr.sa];
          count++;
          if(count == 8) begin
            tr.payload.push_back(temp);
            count = 0;
          end
        end

        if(m_vif.imonitor_cb.frame_n[tr.sa]) begin
          if(count != 0) begin
            tr.payload.push_back(temp);
            `uvm_warning("PAYLOAD_WARNING", "Payload not byte aligned !!!")
          end
          break;
        end
        @(m_vif.imonitor_cb);
      end
      
      `uvm_info("Monitor",{"\n","Monitor Got An Input Transaction: \n", tr.sprint()}, UVM_MEDIUM)
      `uvm_info("Monitor", "Now monitor send the transaction to the reference model!", UVM_MEDIUM)
      this.m2r_port.put(tr);
    end
  endtask

endclass

`endif
