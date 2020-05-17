//=============================================================================
// Copyright (c) 2017 by www.eecourse.com Ltd
//=============================================================================
// Project  : ahb_soc
//
// File Name: ahb_slv_driver_base.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// driver base class for ahb
//
//=============================================================================

`ifndef AHB_SLV_DRIVER_BASE_SV
`define AHB_SLV_DRIVER_BASE_SV

class ahb_slv_driver_base;

  string  name ;
  virtual ahb_slv_if.driver drv_if;
  ahb_slv_pkt pkt2send;

  reg        hsel;
  reg        hwrite;
  reg        hready;
  reg [2:0]  hsize;
  reg [2:0]  htrans;
  reg [31:0] haddr;
  reg [31:0] hwdata;
  reg [31:0] hrdata;

  extern function new (string name="ahb_slv_driver_base", virtual ahb_slv_if.driver drv_if);
  
  extern virtual task send_ctrl_addr();

  extern virtual task process_data();

endclass: ahb_slv_driver_base

function ahb_slv_driver_base::new(string name="ahb_slv_driver_base", virtual ahb_slv_if.driver drv_if);
  this.name = name;
  this.drv_if = drv_if;
endfunction: new

task ahb_slv_driver_base::send_ctrl_addr();
  $display($time, "ns: [ahb_slv_driver_base] Sending control and address signals");
  drv_if.drv_cb.hsel    <= hsel;
  drv_if.drv_cb.hwrite  <= hwrite;
  drv_if.drv_cb.hready  <= hready;
  drv_if.drv_cb.hsize   <= hsize;
  drv_if.drv_cb.htrans  <= htrans;
  drv_if.drv_cb.haddr   <= haddr;
  @drv_if.drv_cb;
endtask: send_ctrl_addr

task ahb_slv_driver_base::process_data();
  drv_if.drv_cb.hwdata  <= hwdata;
  hrdata = drv_if.drv_cb.hrdata;
  @drv_if.drv_cb;
endtask: process_data

`endif  // AHB_SLV_DRIVER_BASE_SV
