//=============================================================================
// Copyright (c) 2017 by www.eecourse.com 
//=============================================================================
// Project  : ahb_soc
//
// File Name: ahb_if.sv
//
// Author   : Name   :   
//            Email  :    
//            Dept   : 
//
// Version  : v1.0
//=============================================================================
// Description:
//
// Signal interface for agent ahb
//
//=============================================================================

`ifndef AHB_IF_SV
`define AHB_IF_SV

interface ahb_if(input hclk,input hresetn); 
  logic	        hsel;
  logic	        hwrite;
  logic         hready;
  logic	[2:0] 	hsize;
  logic	[1:0] 	htrans;
  logic	[2:0] 	hburst;
  logic	[31:0]	hwdata;
  logic	[31:0]	haddr;	
  logic		    hready_resp;
  logic	[1:0] 	hresp;
  logic	[31:0]	hrdata;

  clocking drvCLK @(posedge hclk);
    output  hsel;
    output  hwrite;
    output  hready;
    output  hsize;
    output  htrans;
    output  haddr;
    output  hwdata;
    input   hresetn;
  endclocking : drvCLK
  
  clocking monCLK @(posedge hclk);
    input  hready;
    input  hsel;
    input  hwrite;
    input  hsize;
    input  htrans;
    input  haddr;
    input  hwdata;
    input  hrdata;
  endclocking : monCLK
  
  modport driver (clocking drvCLK);
  modport monitor(clocking monCLK);

  // You could add properties and assertions, for example
  // property name;
  // ...
  // endproperty : name
  // label: assert property(name);

endinterface : ahb_if

`endif // AHB_IF_SV
