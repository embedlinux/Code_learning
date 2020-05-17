//=============================================================================
// Copyright (c) 2017 by www.eecourse.com Ltd
//=============================================================================
// Project  : ahb_soc
//
// File Name: ahb_sramc_test.sv
//
// Author   : Name   :  
//            Email  :    
//            Dept   : RD
//
// Version  : v1
//=============================================================================
// Description:
//
// ahb sram controller test 
//
//=============================================================================
`ifndef AHB_SRAMC_TEST_SV
`define AHB_SRAMC_TEST_SV

program automatic ahb_sramc_test(ahb_slv_if.driver drv_if);
  ahb_slv_generator  generator;
  ahb_slv_driver     driver;
  ahb_slv_scoreboard scoreboard;
  
  ahb_slv_pkt pkt_send = new();

  initial begin
    number_packets = 1000;
    generator = new ("ahb_slv_generator", number_packets);
    driver = new("ahb_slv_driver", generator.gen_mbx, scoreboard.sb_mbx, drv_if);
    scoreboard = new();

    reset();
    generator.start();
    driver.start();
    scoreboard.start();

    repeat(number_packets+1) @(drv_if.drv_cb);
    $display($time, "we are done ... go home and sleep ...  actually not yet ... ");
  end

  task reset();
    $display($time, "ns: [RESET] Power on reset for the design");
    drv_if.hresetn <= 1'b0;
    repeat(5) @(drv_if.cb);
    drv_if.hresetn <= 1'b1;
    $display($time, "ns: [RESET] Power on reset end");
  endtask: reset

endprogram: ahb_sramc_test

`endif  ABH_SRAMC_TEST_SV
