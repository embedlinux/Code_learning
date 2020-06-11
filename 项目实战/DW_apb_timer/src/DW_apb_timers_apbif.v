/*
------------------------------------------------------------------------
--
--                   (C) COPYRIGHT 2001-2010 SYNOPSYS INC.
--                             ALL RIGHTS RESERVED
--
--  This software and the associated documentation are confidential and
--  proprietary to Synopsys, Inc.  Your use or disclosure of this software
--  is subject to the terms and conditions of a written license agreement
--  between you, or your company, and Synopsys, Inc.
--
--  The entire notice above must be reproduced on all authorized copies.
--
-- File :                       DW_apb_timers_apbif.v
-- Author:                      Ray Beechinor
-- Date :                       $Date: 2010/08/30 $
-- Version      :               $Revision: #4 $
-- Abstract     :               APB Slave Interface for DW_apb_timers
--
--
-- Modification History:
-- Date                 By      Version Change  Description
-- =====================================================================
-- See CVS log
-- =====================================================================
*/
`include "DW_apb_timers_cc_constants.v"
`define TIMER1LC_OFFSET 8'd0
`define TIMER1CV_OFFSET 8'd1
`define TIMER1CR_OFFSET 8'd2
`define TIMER1EOI_OFFSET 8'd3
`define TIMER1INTST_OFFSET 8'd4
`define TIMER2LC_OFFSET 8'd5
`define TIMER2CV_OFFSET 8'd6
`define TIMER2CR_OFFSET 8'd7
`define TIMER2EOI_OFFSET 8'd8
`define TIMER2INTST_OFFSET 8'd9
`define TIMER3LC_OFFSET 8'd10
`define TIMER3CV_OFFSET 8'd11
`define TIMER3CR_OFFSET 8'd12
`define TIMER3EOI_OFFSET 8'd13
`define TIMER3INTST_OFFSET 8'd14
`define TIMER4LC_OFFSET 8'd15
`define TIMER4CV_OFFSET 8'd16
`define TIMER4CR_OFFSET 8'd17
`define TIMER4EOI_OFFSET 8'd18
`define TIMER4INTST_OFFSET 8'd19
`define TIMER5LC_OFFSET 8'd20
`define TIMER5CV_OFFSET 8'd21
`define TIMER5CR_OFFSET 8'd22
`define TIMER5EOI_OFFSET 8'd23
`define TIMER5INTST_OFFSET 8'd24
`define TIMER6LC_OFFSET 8'd25
`define TIMER6CV_OFFSET 8'd26
`define TIMER6CR_OFFSET 8'd27
`define TIMER6EOI_OFFSET 8'd28
`define TIMER6INTST_OFFSET 8'd29
`define TIMER7LC_OFFSET 8'd30
`define TIMER7CV_OFFSET 8'd31
`define TIMER7CR_OFFSET 8'd32
`define TIMER7EOI_OFFSET 8'd33
`define TIMER7INTST_OFFSET 8'd34
`define TIMER8LC_OFFSET 8'd35
`define TIMER8CV_OFFSET 8'd36
`define TIMER8CR_OFFSET 8'd37
`define TIMER8EOI_OFFSET 8'd38
`define TIMER8INTST_OFFSET 8'd39
`define TIMERSINTST_OFFSET 8'd40
`define TIMERSEOI_OFFSET 8'd41
`define TIMERSRAW_OFFSET 8'd42
`define TIM_VID_OFFSET 8'd43

`define TIMER1LC2_OFFSET 8'd44
`define TIMER2LC2_OFFSET 8'd45
`define TIMER3LC2_OFFSET 8'd46
`define TIMER4LC2_OFFSET 8'd47
`define TIMER5LC2_OFFSET 8'd48
`define TIMER6LC2_OFFSET 8'd49
`define TIMER7LC2_OFFSET 8'd50
`define TIMER8LC2_OFFSET 8'd51

module DW_apb_timers_apbif (
    input                                 pclk
  , input                                 presetn
  , input                                 penable
  , input                                 pwrite
  , input      [`APB_DATA_WIDTH-1:0]      pwdata
  , input                                 psel
  , input      [`TIM_ADDR_SLICE_LHS:0]    paddr
  , input      [`MAX_CURRVALUE_WIDTH-1:0] bus_current_value
  , input      [`TIM_MAX_TIMERS-1:0]      bus_interrupts
  , output reg [`APB_DATA_WIDTH-1:0]      prdata
  , output [`TIMER_WIDTH_1-1:0]           timer1loadcount
  , output                                timer1_read_b0 
  , output [`TIMER_WIDTH_2-1:0]           timer2loadcount
  , output                                timer2_read_b0 
  , output [`NUM_TIMERS-1:0]              timer_intr
  , output [`NUM_TIMERS-1:0]              timer_intr_n
  , output [`NUM_TIMERS-1:0]              timer_en
  , output [`NUM_TIMERS-1:0]              timer_mode
  , output [`NUM_TIMERS-1:0]              timer_pwm
  , output                                timer_intr_flag
  , output                                timer_intr_flag_n
);


  integer i;
  wire [`TIMER_WIDTH_1-1:0]      timer1currentvalue;
  wire [`TIM_CTL_WIDTH-1:0]      timer1controlreg;
  wire                           timer1loadcount_wen;
  wire                           timer1controlreg_wen;
  wire                           timer1eoi_ren;
  reg  [`NUM_TIMERS-1:0]         ri_timersintstatus;
  wire [`MAX_APB_DATA_WIDTH-1:0] int_timer1currentvalue;
  reg                            ri_timer1intstatus;
  wire [`TIMER_WIDTH_2-1:0]      timer2currentvalue;
  wire [`TIM_CTL_WIDTH-1:0]      timer2controlreg;
  wire                           timer2loadcount_wen;
  wire                           timer2controlreg_wen;
  wire                           timer2eoi_ren;
  wire [`MAX_APB_DATA_WIDTH-1:0] int_timer2currentvalue;
  reg                            ri_timer2intstatus;
  wire                           timerseoi_ren;

  reg  [`TIM_MAX_TIMERS-1:0]     sync_interrupts;
  reg  [`TIM_MAX_TIMERS-1:0]     int_bus_interrupts;
  reg  [`NUM_TIMERS-1:0]         edge_flop;
  reg  [`TIM_MAX_TIMERS-1:0]     intr_edge_flop;
  wire [`TIM_MAX_TIMERS-1:0]     int_sync_temp;
  reg  [`TIM_MAX_TIMERS-1:0]     timereoi;
  reg  [`TIM_MAX_TIMERS-1:0]     timeren; 
  reg  [`TIM_MAX_TIMERS-1:0]     timermode;
  reg  [`TIM_MAX_TIMERS-1:0]     timerpwm;
  wire [`TIM_MAX_TIMERS-1:0]     edge_detected;
  reg  [`NUM_TIMERS-1:0]         int_timer_intr;
  wire                           timerseoi;
  reg  [`MAX_APB_DATA_WIDTH-1:0] timerintmask;
  wire [`MAX_APB_DATA_WIDTH-1:0] ri_timer_vid;

  assign ri_timer_vid = `TIM_VERSION_ID;

  wire [3:0] ibyte_en;
  assign ibyte_en = 4'b1111;
  wire [3:0] byte_en; assign byte_en = ibyte_en;

  wire wen, ren;
  assign wen = ((psel == 1'b1) && (penable == 1'b1) && (pwrite == 1'b1));
  assign ren = ((psel == 1'b1) && (penable == 1'b0) && (pwrite == 1'b0));

  assign timer1loadcount_wen   = wen && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER1LC_OFFSET);
  assign timer1controlreg_wen  = wen && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER1CR_OFFSET);
  assign timer1loadcount_ren   = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER1LC_OFFSET);
  assign timer1controlreg_ren  = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER1CR_OFFSET);
  assign timer1eoi_ren         = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER1EOI_OFFSET);
  assign timer1intst_ren       = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER1INTST_OFFSET);
  assign timer1currentvalue_ren = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER1CV_OFFSET);
  assign timer1_read_b0        = byte_en[0] && timer1currentvalue_ren;
  assign timer2loadcount_wen   = wen && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER2LC_OFFSET);
  assign timer2controlreg_wen  = wen && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER2CR_OFFSET);
  assign timer2loadcount_ren   = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER2LC_OFFSET);
  assign timer2controlreg_ren  = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER2CR_OFFSET);
  assign timer2eoi_ren         = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER2EOI_OFFSET);
  assign timer2intst_ren       = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER2INTST_OFFSET);
  assign timer2currentvalue_ren = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMER2CV_OFFSET);
  assign timer2_read_b0        = byte_en[0] && timer2currentvalue_ren;

  wire  timersintst_ren, timersraw_ren, tim_vid_ren;
  assign timersintst_ren       = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMERSINTST_OFFSET);
  assign timerseoi_ren         = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMERSEOI_OFFSET);
  assign timersraw_ren         = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIMERSRAW_OFFSET);
  assign tim_vid_ren           = ren && (paddr[`TIM_ADDR_SLICE_LHS:2] == `TIM_VID_OFFSET);

  DWC_apb_timers_regb
   #(`TIMER_WIDTH_1, `APB_DATA_WIDTH) u_loadcount1 ( 
      .pclk      (pclk)
    , .presetn   (presetn)
    , .byte_en   (byte_en)
    , .wen       (timer1loadcount_wen)
    , .wdata     (pwdata)
    , .odata     (timer1loadcount)
  );
  DWC_apb_timers_regb
   #(`TIMER_WIDTH_2, `APB_DATA_WIDTH) u_loadcount2 ( 
      .pclk      (pclk)
    , .presetn   (presetn)
    , .byte_en   (byte_en)
    , .wen       (timer2loadcount_wen)
    , .wdata     (pwdata)
    , .odata     (timer2loadcount)
  );

  DWC_apb_timers_regb
   #(`TIM_CTL_WIDTH, `APB_DATA_WIDTH) u_t1cr ( 
      .pclk      (pclk)
    , .presetn   (presetn)
    , .byte_en   (byte_en)
    , .wen       (timer1controlreg_wen)
    , .wdata     (pwdata)
    , .odata     (timer1controlreg)
  );
  DWC_apb_timers_regb
   #(`TIM_CTL_WIDTH, `APB_DATA_WIDTH) u_t2cr ( 
      .pclk      (pclk)
    , .presetn   (presetn)
    , .byte_en   (byte_en)
    , .wen       (timer2controlreg_wen)
    , .wdata     (pwdata)
    , .odata     (timer2controlreg)
  );

  // Decode the address and read back the data from
  // the various ri_* registers to prdata
 reg [`MAX_APB_DATA_WIDTH-1:0] c_iprdata;
  always @(posedge pclk or negedge presetn)
  begin : prdata_PROC
    if (presetn == 1'b0) begin
      prdata <= {`APB_DATA_WIDTH{1'b0}};
    end else begin
      if ((pwrite == 1'b0) && (psel == 1'b1) && (penable == 1'b0)) begin
         prdata <= c_iprdata;
       end
    end
  end


  always @(*)
  begin : comb_iprdata
    c_iprdata = {`MAX_APB_DATA_WIDTH{1'b0}};
      if (timer1loadcount_ren)    c_iprdata[`TIMER_WIDTH_1-1:0] = timer1loadcount;
      if (timer1controlreg_ren)   c_iprdata[`TIM_CTL_WIDTH-1:0] = timer1controlreg;
      if (timer1currentvalue_ren) c_iprdata[`TIMER_WIDTH_1-1:0] = int_timer1currentvalue[`TIMER_WIDTH_1-1:0];
      if (timer1intst_ren)        c_iprdata[0]                  = ri_timer1intstatus;
      if (timer2loadcount_ren)    c_iprdata[`TIMER_WIDTH_2-1:0] = timer2loadcount;
      if (timer2controlreg_ren)   c_iprdata[`TIM_CTL_WIDTH-1:0] = timer2controlreg;
      if (timer2currentvalue_ren) c_iprdata[`TIMER_WIDTH_2-1:0] = int_timer2currentvalue[`TIMER_WIDTH_2-1:0];
      if (timer2intst_ren)        c_iprdata[0]                  = ri_timer2intstatus;
      if (timersintst_ren)        c_iprdata[`NUM_TIMERS-1:0]    = ri_timersintstatus[`NUM_TIMERS-1:0];
      if (timersraw_ren)          c_iprdata[`NUM_TIMERS-1:0]    = int_timer_intr[`NUM_TIMERS-1:0];
      if (tim_vid_ren)            c_iprdata                     = ri_timer_vid;
  end

  // This process describes the metastability flops
  // on the interrupt flags coming from the timers

  wire [`NUM_TIMERS-1:0] meta2_intr;
  generate
  genvar gv1;
  for (gv1=0; gv1 < `NUM_TIMERS; gv1 = gv1 + 1)
  begin: gv1_bcm21
    DW_apb_timers_bcm21
    
     #(
         .WIDTH       (1)
       , .F_SYNC_TYPE (2)
     )
     u1_meta
     (
         .clk_d   (pclk)
       , .rst_d_n (presetn)
       , .data_s  (int_bus_interrupts[gv1])
       , .data_d  (meta2_intr[gv1])
       // Unconnected inputs.
       , .init_d_n (1'b1)
       , .test     (1'b0)
     );
  end  
  endgenerate
  
  // This process puts the metastabilised interrupt signals
  // into a bus

  always @ (*) begin : sync_interrupts_PROC
   sync_interrupts = {`TIM_MAX_TIMERS{1'b0}};
   sync_interrupts[`NUM_TIMERS-1:0] = meta2_intr[`NUM_TIMERS-1:0];
  end

  // Grab the relevant interrupt signals from the timers
  // (presented on bus_interrupts)

  always @ (*) begin : int_bus_interrupts_PROC
    int_bus_interrupts = {`TIM_MAX_TIMERS{1'b0}};
    int_bus_interrupts[`NUM_TIMERS-1:0] = bus_interrupts[`NUM_TIMERS-1:0];
  end

  // Choose either the raw interrupt signal or the metastabilised
  // version, depending on individual timer configuration

  assign int_sync_temp[0] = (`TIM_METASTABLE_1==1) ? sync_interrupts[0] : int_bus_interrupts[0];
  assign int_sync_temp[1] = (`TIM_METASTABLE_2==1) ? sync_interrupts[1] : int_bus_interrupts[1];
  assign int_sync_temp[2] = (`TIM_METASTABLE_3==1) ? sync_interrupts[2] : int_bus_interrupts[2];
  assign int_sync_temp[3] = (`TIM_METASTABLE_4==1) ? sync_interrupts[3] : int_bus_interrupts[3];
  assign int_sync_temp[4] = (`TIM_METASTABLE_5==1) ? sync_interrupts[4] : int_bus_interrupts[4];
  assign int_sync_temp[5] = (`TIM_METASTABLE_6==1) ? sync_interrupts[5] : int_bus_interrupts[5];
  assign int_sync_temp[6] = (`TIM_METASTABLE_7==1) ? sync_interrupts[6] : int_bus_interrupts[6];
  assign int_sync_temp[7] = (`TIM_METASTABLE_8==1) ? sync_interrupts[7] : int_bus_interrupts[7];

  // Grap the current value of each timer to present on
  // int_timerXcurrentvalue.

  assign int_timer1currentvalue = bus_current_value[             0+:`TIMER_WIDTH_1];
  assign int_timer2currentvalue = bus_current_value[`TIM1_CV_INDEX+:`TIMER_WIDTH_2];

  // Register the interrupts (for edge detection)

  always @ (posedge pclk or negedge presetn) begin : edge_PROC
    if (presetn == 1'b0)
      edge_flop <= {`NUM_TIMERS{1'b0}};
    else
      edge_flop <= int_sync_temp[`NUM_TIMERS-1:0];
  end

  always @ (edge_flop) begin : intr_edge_PROC
    intr_edge_flop = 0;
    intr_edge_flop = edge_flop[`NUM_TIMERS-1:0];
  end

  // an edge has occurred if the incoming interrupt is
  // asserted and the registered version is zero

  assign edge_detected = int_sync_temp & (~intr_edge_flop);


  assign timerseoi = timerseoi_ren;

  // Build the TimerEOI register
  // The enable bit for each timer is bit zero of the control register
  // The mode bit for each timer is bit one of the control register
  always @(*)
  begin: timermode_PROC
    timermode       = 0;
    timeren         = 0;
    timereoi        = 0;
    timerintmask    = 0;
    timerintmask[0] = timer1controlreg[2];
    timermode[0]    = timer1controlreg[1];
    timeren[0]      = timer1controlreg[0];
    timereoi[0]     = timer1eoi_ren;
    timerintmask[1] = timer2controlreg[2];
    timermode[1]    = timer2controlreg[1];
    timeren[1]      = timer2controlreg[0];
    timereoi[1]     = timer2eoi_ren;
  end

  // Assert an interrupt if an edge is detected on the 
  // interrupt flag, the timer is enabled 
  // Clear it if the individual TimerEOI reg is read 
  // or if TimersEOI is read
  // If the read happens coincident with an edge,
  // setting the interrupt takes priority

  //
  // If the timer is not enabled and an edge detect is detected then the
  // interrupt is not set.
  //
  always @ (posedge pclk or negedge presetn) begin : timer_intr_PROC

    if (presetn == 1'b0) begin
      int_timer_intr <= {`NUM_TIMERS{1'b0}};
    end else begin
      for (i=0; i<`NUM_TIMERS; i=i+1) begin
        if (edge_detected[i] == 1'b1) begin
          if (timeren[i]==1'b1) begin
            int_timer_intr[i] <= 1'b1;
	  end 
        end else begin
          if ((timereoi[i] == 1'b1) || 
              (timerseoi == 1'b1)   || 
              (timeren[i]==1'b0)) begin
            int_timer_intr[i] <= 1'b0;
          end 
	end
      end
    end

  end

  always @ (*)
  begin : ri_timer_intr_PROC
   
    ri_timer1intstatus = int_timer_intr[0] & (~timerintmask[0]);
    ri_timer2intstatus = int_timer_intr[1] & (~timerintmask[1]);
  
    ri_timersintstatus = int_timer_intr[`NUM_TIMERS-1:0] & (~timerintmask[`NUM_TIMERS-1:0]);
  end


  assign timer_intr_flag = |ri_timersintstatus;
  assign timer_intr_flag_n = ~timer_intr_flag;
  assign timer_intr = ri_timersintstatus[`NUM_TIMERS-1:0];
  assign timer_intr_n = ~timer_intr;
  assign timer_en = timeren[`NUM_TIMERS-1:0];
  assign timer_mode = timermode[`NUM_TIMERS-1:0];
  assign timer_pwm  =  timerpwm[`NUM_TIMERS-1:0];
 
endmodule
