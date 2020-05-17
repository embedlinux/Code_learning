//=============================================================================
// Copyright (c) 2017 by www.eecourse.com Ltd
//=============================================================================
// Project  : ahb_soc
//
// File Name: ahb_slv_scoreboard.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// scoreboard class for ahb
//
//=============================================================================

`ifndef AHB_SLV_SCOREBOARD_SV
`define AHB_SLV_SCOREBOARD_SV

class ahb_slv_scoreboard;
  string name;
  ahb_slv_pkt pkt_sent=new();

  typedef mailbox #(ahb_slv_pkt) in_scoreboard_mailbox;
  in_scoreboard_mailbox in_sb_mbx;

  extern function new (string name="ahb_slv_scoreboard", in_scoreboard_mailbox in_sb_mbx=null);

  extern virtual task start();
  extern virtual task check();

  real coverage_value;

  // coverage modeling
  covergroup ahb_slv_cg;
    coverpoint  pkt_sent.hsel {bins hsel = {0,1};}
    coverpoint  pkt_sent.hwrite {bins hwrite = {0,1};}
    coverpoint  pkt_sent.hready {bins hready = {0,1};}
    coverpoint  pkt_sent.hsize {bins hsize = {2'b00, 2'b01, 2'b10};}
    coverpoint  pkt_sent.htrans {bins htrans = {2'b00, 2'b01, 2'b10, 2'b11};}
    coverpoint  pkt_sent.hburst {bins hburst = {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b101,
    3'b110, 3'b111};}
    coverpoint  pkt_sent.hwdata {bins hwdata = {32'h0, 'h1, 32'h55555555, 32'haaaaaaaa};}
    coverpoint  pkt_sent.haddr inside {[0:65536]};
    coverpoint  pkt_sent.hready_resp inside {1'b1};
    coverpoint  pkt_sent.hresp inside {2'b00};
    coverpoint  pkt_sent.hrdata inside {[0:2**32]};
  endgroup:ahb_slv_cg

  
endclass : ahb_slv_scoreboard
`endif  AHB_SLV_SCOREBOARD_SV

