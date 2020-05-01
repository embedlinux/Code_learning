`ifndef __MY_DRIVER__SV__
`define __MY_DRIVER__SV__

class my_driver extends uvm_driver #(my_transaction);
  
  `uvm_component_utils(my_driver)

  virtual dut_interface m_vif;

  function new(string name = "my_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual dut_interface)::get(this, "", "vif", m_vif);
  endfunction

  virtual task pre_reset_phase(uvm_phase phase);
    super.pre_reset_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
    phase.raise_objection(this);
    m_vif.driver_cb.frame_n <= 'x;
    m_vif.driver_cb.valid_n <= 'x;
    m_vif.driver_cb.din     <= 'x;
    m_vif.driver_cb.reset_n <= 'x;
    phase.drop_objection(this);
  endtask

  virtual task reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
    phase.raise_objection(this);
    m_vif.driver_cb.frame_n <= '1;
    m_vif.driver_cb.valid_n <= '1;
    m_vif.driver_cb.din     <= '0;
    m_vif.driver_cb.reset_n <= '1;
    repeat(5) @(m_vif.driver_cb);
    m_vif.driver_cb.reset_n <= '0;
    repeat(5) @(m_vif.driver_cb);
    m_vif.driver_cb.reset_n <= '1;
    phase.drop_objection(this);
  endtask

  virtual task run_phase(uvm_phase phase);
    logic [7:0] temp;
    repeat(15)   @(m_vif.driver_cb);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("DRV_RUN_PHASE", req.sprint(), UVM_MEDIUM)
      // Send address
      m_vif.driver_cb.frame_n[req.sa] <= 1'b0;
      for(int i=0; i<4; i++) begin
        m_vif.driver_cb.din[req.sa] <= req.da[i];
        @(m_vif.driver_cb);
      end
      // Send pad
      m_vif.driver_cb.din[req.sa] <= 1'b1;
      m_vif.driver_cb.valid_n[req.sa] <= 1'b1;
      repeat(5) @(m_vif.driver_cb);
      // Send payload
      while(!m_vif.driver_cb.busy_n[req.sa]) @(m_vif.driver_cb);
      foreach(req.payload[index]) begin
        temp = req.payload[index];
        for(int i=0; i<8; i++) begin
          m_vif.driver_cb.din[req.sa]     <= temp[i];
          m_vif.driver_cb.valid_n[req.sa] <= 1'b0;
          m_vif.driver_cb.frame_n[req.sa] <= ((req.payload.size()-1) == index) && (i==7);
          @(m_vif.driver_cb);
        end
      end
      m_vif.driver_cb.valid_n[req.sa] <= 1'b1;
      seq_item_port.item_done();
    end
  endtask

endclass

`endif
