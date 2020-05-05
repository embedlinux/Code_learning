//2011-6-8
//tb.sv

`timescale 1ns/1ps
module tb;
  parameter CYCLE = 100;
  bit clk;
  bit rst_n;

  AHB_if M1_if  	(clk, rst_n);
  AHB_if VIP_MASTER_if 	(clk, rst_n);
  AHB_if S1_if  	(clk, rst_n);
  AHB_if SRAM_if	(clk, rst_n);
  AHB_if S3_if  	(clk, rst_n);
  AHB_if S4_if  	(clk, rst_n);

  DW_ahb_wrapper DW_ahb_model(M1_if, VIP_MASTER_if, S1_if, SRAM_if, S3_if, S4_if);
  sramc_wrapper sram_model(SRAM_if);
 // VIP_MASTER test(VIP_MASTER_if);

  initial begin
    $timeformat(-9, 1, "ns", 10);
    #20;
    clk = 1'b0;
    forever begin
      #(CYCLE/2)
      clk = ~ clk;
    end
  end

  initial begin
    rst_n = 1'b0;
    M1_if.reset_bm_bus();
    VIP_MASTER_if.reset_bm_bus(); 
    S1_if.reset_bm_bus(); 
    SRAM_if.reset_bm_bus();
    S3_if.reset_bm_bus();
    S4_if.reset_bm_bus();
    #200;
    rst_n = 1'b1;
  end
endmodule
