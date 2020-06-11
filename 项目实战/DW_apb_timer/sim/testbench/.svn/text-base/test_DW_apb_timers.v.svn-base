// -------------------------------------------------------------------------
//
//
//                      (C) COPYRIGHT 2001-2010 SYNOPSYS INC.
//                             ALL RIGHTS RESERVED
//
//
// File    : test_DW_apb_timers.v
// Author  : Joe Mc Cann
// Created : Wed Nov 21 15:06:48 GMT 2001
// Abstract: Top-level verilog testbench for the APB Timers
//           peripheral
//
// -------------------------------------------------------------------------
// Revision: $Id: //dwh/DW_ocb/DW_apb_timers/amba_dev/sim/testbench/test_DW_apb_timers.v#4 $
// -------------------------------------------------------------------------

`timescale 1ns / 10ps
`include "DW_amba_constants.v"
`include "DW_apb_cc_constants.v"
`include "DW_apb_timers_cc_constants.v"

`define MAX_NUM_TIMERS 8

module test_DW_apb_timers;

   reg hclk;
   reg pclk;

   initial begin
     pclk = 1;
     forever begin
       #((`PERIOD*`APB_CLK_RATIO)/2.0)
       pclk = ~pclk;
     end
   end

   initial begin
     hclk = 1;
     forever begin
       #(`PERIOD/2.0)
       hclk = ~hclk;
     end
   end

   wire reset;
   wire presetn;
   wire d_presetn;
   reg  pclk_en;

   assign #1 d_presetn = presetn;

   reg [`MAX_NUM_TIMERS-1:0] xtimer_en;
   wire [`NUM_TIMERS-1:0]    timer_en;

   // ----------------------------------------
   // AHB bus signals
   // ----------------------------------------
   wire                      hsel_s1;
   wire                      hready;
   wire                      hwrite;
   wire                      hready_resp;
   wire [`HRESP_WIDTH-1:0]   hresp;
   wire [`HADDR_WIDTH-1:0]   haddr;
   wire [`HTRANS_WIDTH-1:0]  htrans;
   wire [`AHB_DATA_WIDTH-1:0] hrdata;
   wire [`AHB_DATA_WIDTH-1:0] hwdata;

   // ----------------------------------------
   // APB bus signals
   // ----------------------------------------
   wire                       psel;
   wire                       penable;
   wire                       pwrite;
   wire [`PADDR_WIDTH-1:0]    paddr;
   wire [`APB_DATA_WIDTH-1:0] pwdata;
   wire [`APB_DATA_WIDTH-1:0] prdata;
   wire [63:0]                addr64;
   wire                       stop_pclk;

   // added for new monitor
   wire [15:0]                      hsel;
   wire [15:0]                      bus_hbusreq;
   wire [15:0]                      bus_hgrant;
   wire [15:0]                      bus_hlock;

   wire [15:0]                       psel_apb;


   assign hsel[15:3]        = {13{1'b0}};
   assign hsel[2]           = U_ahb.hsel_s2;
   assign hsel[1]           = U_ahb.hsel_s1;
   assign hsel[0]           = 1'b0;
   assign bus_hbusreq[15:0] = {{14{1'b0}}, U_ahb.hbusreq_m1, 1'b0};
   assign bus_hgrant [15:0] = {{14{1'b0}}, U_ahb.hgrant_m1, 1'b0};
   assign bus_hlock  [15:0] = {{14{1'b0}}, U_ahb.hlock_m1, 1'b0};
   assign psel_apb = {{14{1'b0}}, U_apb.psel_s1, U_apb.psel_s0};
//
// Due to the monitor being 64-bits wide need to have an
// address line the same width
//
   assign addr64[63:32] = 0;
   assign addr64[31:0]  = U_ahb.haddr;


   // ----------------------------------------
   // Instantiate the VERA Shell
   // The connections to the VERA Shell are
   // done with dynamic binds.
   // ----------------------------------------
   test_DW_apb_timers_shell vshell(hclk, pclk);

   // ----------------------------------------
   // Instantiate the top-level AHB Bus IP
   // ----------------------------------------
   ahb_wrapper U_ahb(
                     .hresetn            (reset)
                     ,.hclk              (hclk)
                     ,.haddr             (haddr)
                     ,.hready            (hready)
                     ,.htrans            (htrans)
                     ,.hwrite            (hwrite)
                     ,.hwdata            (hwdata)
                     ,.hsel_s1           (hsel_s1)
                     ,.hready_resp_s1    (hready_resp)
                     ,.hresp_s1          (hresp)
                     ,.hrdata_s1         (hrdata)
                     );

   // ----------------------------------------
   // Instantiate the top-level APB Bus IP
   // ----------------------------------------
   apb_wrapper U_apb(
                     // AHB bus interface signals
                     .hresetn            (reset)
                     ,.hclk              (hclk)   //changed fro pclk
                     ,.pclk_en           (pclk_en)
                     ,.haddr             (haddr)
                     ,.hready            (hready)
                     ,.htrans            (htrans)
                     ,.hwrite            (hwrite)
                     ,.hwdata            (hwdata)
                     ,.hsel              (hsel_s1)
                     ,.hrdata            (hrdata)
                     ,.hready_resp       (hready_resp)
                     ,.hresp             (hresp)
                     // APB bus interface signals
                     ,.paddr             (paddr)
                     ,.penable           (penable)
                     ,.pwrite            (pwrite)
                     ,.pwdata            (pwdata)
                     ,.psel_s0           (psel)
                     ,.prdata_s0         (prdata)
                     ,.pready_s0         (1'b1)
                     ,.pready_s1         (1'b1)
                     ,.pslverr_s0        (1'b0)
                     ,.pslverr_s1        (1'b0)
                     );


   // ----------------------------------------
   // Instantiate the APB slave peripherial
   // ----------------------------------------
  DW_apb_timers U_timers(
      .pclk             (pclk)
    , .presetn          (d_presetn)
    , .psel             (psel)
    , .paddr            (paddr[`TIM_ADDR_SLICE_LHS:0])
    , .pwdata           (pwdata)
    , .pwrite           (pwrite)
    , .penable          (penable)
    , .prdata           (prdata)
    , .timer_en         (timer_en[`NUM_TIMERS-1:0])
/* ===
`ifdef TIM_NEWMODE
    , .timer_1_pause    (1'b0)
`ifdef NUM_TIMERS_GTE_2
    , .timer_2_pause    (1'b0)
`endif
`ifdef NUM_TIMERS_GTE_3
    , .timer_3_pause    (1'b0)
`endif
`ifdef NUM_TIMERS_GTE_4
    , .timer_4_pause    (1'b0)
`endif
`ifdef NUM_TIMERS_GTE_5
    , .timer_5_pause    (1'b0)
`endif
`ifdef NUM_TIMERS_GTE_6
    , .timer_6_pause    (1'b0)
`endif
`ifdef NUM_TIMERS_GTE_7
    , .timer_7_pause    (1'b0)
`endif
`ifdef NUM_TIMERS_GTE_8
    , .timer_8_pause    (1'b0)
`endif
`endif
=== */
  );


  reg t_clk;
   initial begin
     t_clk = 0;
     #(`PERIOD) t_clk = 1;
     forever begin
       #((`PERIOD*`APB_CLK_RATIO*10)/2.0)
       t_clk = ~t_clk;
     end
   end
   // ----------------------------------------
   // Instantiate timer clock control module
   // ----------------------------------------
   timer_clock U_t1_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[0])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_1_clk)
                        );

   timer_clock U_t2_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[1])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_2_clk)
                        );

   timer_clock U_t3_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[2])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_3_clk)
                        );

   timer_clock U_t4_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[3])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_4_clk)
                        );

   timer_clock U_t5_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[4])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_5_clk)
                        );

   timer_clock U_t6_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[5])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_6_clk)
                        );

   timer_clock U_t7_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[6])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_7_clk)
                        );

   timer_clock U_t8_clk(
                        .pclk                 (pclk)
                        ,.timer_en            (xtimer_en[7])
                        ,.timer_resetn        (d_presetn)
                        ,.t_clk               (t_clk)
                        ,.timer_clk           (timer_8_clk)
                        );
   // ----------------------------------------
   // Assign 8-bit wide timer_en bus
   // ----------------------------------------
   always @(timer_en) begin
      xtimer_en = {`MAX_NUM_TIMERS{1'b0}};
      xtimer_en[`NUM_TIMERS-1:0] = timer_en[`NUM_TIMERS-1:0];
   end

   // ----------------------------------------
   // pclk_en control
   // ----------------------------------------
   initial begin
      if (`APB_CLK_RATIO == 1)
        pclk_en = 1;
      else begin
         pclk_en = 0;
         repeat (`APB_CLK_RATIO) @(posedge hclk);
         pclk_en = 1;
         @(posedge hclk);
         pclk_en = 0;
         forever begin
            repeat (`APB_CLK_RATIO-1) @(posedge hclk);
            #1 pclk_en = 1;
            @(posedge hclk);
            #1 pclk_en = 0;
         end
      end // else: !if(`APB_CLK_RATIO == 1)
   end

   // ----------------------------------------
   // dump control
   // ----------------------------------------

`ifdef DUMP_DEPTH
   initial begin
 `ifdef VCS
      $vcdpluson(`DUMP_DEPTH);
 `else
  `ifdef DUMP_FILE
  `else
   `define DUMP_FILE "test.vcd"
  `endif
      $dumpfile(`DUMP_FILE);
      $dumpvars(`DUMP_DEPTH);
 `endif
   end
`endif

   // ----------------------------------------
   // sdf simulations
   // ----------------------------------------
`ifdef SDF_FILE
   initial
     begin
        $display("About to sdf-annotate the design from %s",`SDF_FILE);
        $sdf_annotate(`SDF_FILE, U_timers, , , `SDF_LEVEL);
     end
`endif

`ifdef CODE_COVERAGE
   initial
     begin
        //$set_toggle_mode(1);
        //$start_toggle("U_timers");
     end
`endif

endmodule


// ----------------------------------------
// module for controlling timer clocks
// ----------------------------------------
module timer_clock(
                    pclk,
                    timer_en,
                    timer_resetn,
                    t_clk,
                    timer_clk
                    );

   input   pclk;
   input   timer_en;
   input   timer_resetn;
   input   t_clk;
   //
   output  timer_clk;
   //
   reg            neg_timer_en;


   always @(negedge pclk or negedge timer_resetn)
     begin
        if(timer_resetn == 1'b0)
          neg_timer_en <= 1'b0;
        else
          neg_timer_en <= timer_en;
     end
`ifdef TIM_NEWMODE
   assign timer_clk = t_clk;
`else
   assign timer_clk = pclk & neg_timer_en;
`endif
endmodule // timer_clock
