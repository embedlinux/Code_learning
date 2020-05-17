//=============================================================================
// Project  : uvm_sramc
//
// File Name: ahb_slv_pkt.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// data modeling for ahb slave packet 
//
//=============================================================================

`ifndef AHB_SLV_PKT_SV
`define AHB_SLV_PKT_SV

class ahb_slv_pkt ; 

  string name;

  rand bit         hsel;
  rand bit         hwrite;
  rand bit         hready;
  rand bit  [2:0]  hsize;
  rand bit  [2:0]  htrans;
  rand bit  [31:0] haddr;
  rand bit  [31:0] hwdata;
       bit  [31:0] hrdata;

  constraint valid {
    //hsel    inside {0,1};
    hsel    inside {1};
    //hwrite  inside {0,1};
    hwrite  inside {1};
    //hready  inside {0,1};
    hready  inside {1};
    //hsize   inside {3'b000, 3'b001, 3'b010};
    hsize   inside {3'b010};
    //htrans  inside {2'b00, 2'b01, 2'b10, 2'b11};
    htrans  inside {2'b10};
    //haddr   inside {[0:65536]};
    haddr   inside {[0:128]};
  }

  extern function new(string name = "ahb_slv_pkt");
  extern virtual task display();
endclass : ahb_slv_pkt 

function ahb_slv_pkt::new(string name = "ahb_slv_pkt");
  this.name = name ;
endfunction : new

task ahb_slv_pkt::display();
  $display("hsel=%0h", hsel); 
  $display("hwrite=%0h", hwrite); 
  $display("hready=%0h", hready); 
  $display("hsize=%0h", hsize); 
  $display("htrans=%0h", htrans); 
  $display("haddr=%0h", haddr); 
endtask: display

`endif // AHB_SLV_PKT_SV
