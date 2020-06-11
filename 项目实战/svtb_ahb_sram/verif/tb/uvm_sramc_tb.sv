//=============================================================================
// Copyright (c) 2015 by ... Ltd
//=============================================================================
// Project  : uvm_sramc
//
// File Name: uvm_sramc_tb.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// Testbench
//
//=============================================================================

`timescale 1ns/1ns
module uvm_sramc_tb;



  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import ahb_pkg::*;
  import uvm_sramc_test_pkg::*;
  import uvm_sramc_env_pkg::*;

  bit hclk;
  bit sram_clk;
  bit hresetn;

  ahb_if    m_ahb_if(hclk,hresetn);

  //HCLK 50M
  initial 
  begin
  	hclk = 0;
  	forever
  	begin
  		#10 hclk = ~hclk;
  	end
  end

  initial 
  begin
  	sram_clk = 1;
  	forever
  	begin
  		#10 sram_clk = ~sram_clk;
  	end
  end

  initial begin
	hresetn = 0;
	#200;
	hresetn = 1;
  end

  sramc_top u_top
  (
	.hclk	  	(hclk),
	.sram_clk	(sram_clk),
	.hresetn	(hresetn),
	.hsel		  (m_ahb_if.hsel),
	.hwrite		(m_ahb_if.hwrite),
	.hready		(m_ahb_if.hready),
	.hsize		(m_ahb_if.hsize),    
	.hburst		(1'b0),
	.htrans		(m_ahb_if.htrans),
	.hwdata		(m_ahb_if.hwdata),
	.haddr		(m_ahb_if.haddr),		
	.dft_en		(1'b0),
	.bist_en	(1'b0),
	.hready_resp(m_ahb_if.hready_resp),
	.hresp		(m_ahb_if.hresp),
	.hrdata		(m_ahb_if.hrdata),
	.bist_done	(),
	.bist_fail	()
  );



  initial
  begin
    uvm_config_db #(virtual ahb_if)::set(null, "*", "vif", m_ahb_if);

    run_test();
  end

  initial begin
    //if($test$plusargs("VPD_ON"))begin
       $vcdpluson();
    //   $vcdplusmemon();
    //end
  end

endmodule

