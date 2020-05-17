//=============================================================================
// Copyright (c) 2017 by www.eecourse.com Ltd
//=============================================================================
// Project  : ahb_soc
//
// File Name: ahb_slv_driver.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// driver class for ahb
//
//=============================================================================

`ifndef AHB_SLV_DRIVER_SV
`define AHB_SLV_DRIVER_SV

class ahb_slv_driver extends ahb_slv_driver_base;

  string name;
  virtual interface ahb_slv_if.driver drv_if;

  typedef mailbox #(ahb_slv_pkt) in_driver_mailbox;
  in_driver_mailbox in_drv_mbx = new;

  //typedef mailbox #(ahb_slv_pkt) out_driver_mailbox;
  //out_driver_mailbox out_drv_mbx = new;

  //extern function new (string name="ahb_slv_driver", in_driver_mailbox in_drv_mbx, out_driver_mailbox out_drv_mbx, virtual ahb_slv_if.driver drv_if);

  extern function new (string name="ahb_slv_driver", in_driver_mailbox in_drv_mbx,  virtual ahb_slv_if.driver drv_if);
  
  extern virtual task start();

endclass

//function ahb_slv_driver::new(string name="ahb_slv_driver", in_driver_mailbox in_drv_mbx, out_driver_mailbox out_drv_mbx, virtual ahb_slv_if.driver drv_if);
function ahb_slv_driver::new(string name="ahb_slv_driver", in_driver_mailbox in_drv_mbx, virtual ahb_slv_if.driver drv_if);
  super.new(name, drv_if);
  this.in_drv_mbx = in_drv_mbx;
  //this.out_drv_mbx = out_drv_mbx;
endfunction: new

task ahb_slv_driver::start();
  int packets_send = 0;
  $display($time,"ns:[ahb_slv_driver] AHB Slave Driver Started");
  fork
    forever begin
      in_drv_mbx.get(pkt2send);
      packets_send++;
      $display($time,"ns:[ahb_slv_driver] Sending a new ahb_slv_pkt Begin");
      this.hsel   = pkt2send.hsel;
      this.hwrite = pkt2send.hwrite;
      this.hready = pkt2send.hready;
      this.hsize  = pkt2send.hsize;
      this.htrans = pkt2send.htrans;
      this.haddr  = pkt2send.haddr;
      this.hwdata = pkt2send.hwdata;
      pkt2send.hrdata = this.hrdata;

      send_ctrl_addr();
      process_data();
      $display($time, "ns:[ahb_slv_driver] Sending in new packet END");
      $display($time, "ns:[ahb_slv_driver] Number of packets sent = %0d", packets_send);

      if(in_drv_mbx.num()==0) begin
        break;
      end
    end
  join_none
endtask: start
`endif  //AHB_SLV_DRIVER_SV
