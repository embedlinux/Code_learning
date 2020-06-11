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
-- File :                       DW_apb_timers.v
-- Author:                      Ray Beechinor
-- Date :                       $Date: 2010/08/30 $
-- Version      :               $Revision: #4 $
-- Abstract     :               Top level of DW_apb_timers 
//
// Please refer to the databook for full details on the signals.
//
// These are found in the "Signal Description" section of the "Signals" chapter.
// There are details on the following
//   % Input Delays
//   % Output Delays
//   Any False Paths
//   Any Multicycle Paths
//   Any Asynchronous Signals
//
-- =====================================================================
*/
`include "DW_apb_timers_cc_constants.v"
module DW_apb_timers (

  pclk,
                      presetn,
                      penable,
                      psel,
                      pwrite,
                      paddr,
                      pwdata,
                      scan_mode,
                      timer_1_clk,
                      timer_2_clk,
                      timer_1_resetn,
                      timer_2_resetn,
                      timer_en,
                      timer_intr,
                      prdata
                      );

  input                                           pclk;
  input                                           presetn;
  input                                           penable;
  input                                           psel;
  input                                           pwrite;
  input [`TIM_ADDR_SLICE_LHS:0]                   paddr;        
  input [`APB_DATA_WIDTH-1:0]                     pwdata;
  input                                           scan_mode; 
  input                                           timer_1_clk;
  input                                           timer_1_resetn;
  input                                           timer_2_clk;
  input                                           timer_2_resetn;
  output [`NUM_TIMERS-1:0]                        timer_en;
  output [`NUM_TIMERS-1:0]                        timer_intr;
  output [`APB_DATA_WIDTH-1:0]                    prdata;

//
// Internal Wiring
//

//
// "bus_load_value" contains the value to be loaded into each timer
// Each timer takes 32 bits from this bus
//

  wire [255:0]                                    bus_load_value;

//
// "bus_current_value" contains the current value of each timer
// Each timer contributes 32 bits to this bus
//

  wire [255:0]                                    temp_current_value;
  wire [255:0]                                    bus_current_value;
  wire [255:0]                                    raw_current_value;
  wire [255:0]                                    coherent_current_value;

//
// "bus_interrupt" contains the raw interrupt flag set by each timer
// and captured by DW_tim_apb
//

  wire [7:0]                                      timer_clk_interrupt;
  wire [7:0]                                      bus_interrupt;

  wire                                            timer_1_clk; 
  wire                                            timer_1_resetn;
  wire                                            timer_1_toggle;

  wire                                            timer_2_clk; 
  wire                                            timer_2_resetn;
  wire                                            timer_2_toggle;

  wire                                            timer_3_clk; 
  wire                                            timer_3_resetn;
  wire                                            timer_3_toggle;

  wire                                            timer_4_clk; 
  wire                                            timer_4_resetn;
  wire                                            timer_4_toggle;

  wire                                            timer_5_clk; 
  wire                                            timer_5_resetn;
  wire                                            timer_5_toggle;

  wire                                            timer_6_clk; 
  wire                                            timer_6_resetn;
  wire                                            timer_6_toggle;

  wire                                            timer_7_clk; 
  wire                                            timer_7_resetn;
  wire                                            timer_7_toggle;

  wire                                            timer_8_clk; 
  wire                                            timer_8_resetn;
  wire                                            timer_8_toggle;

  wire [`TIMER_WIDTH_1-1:0] timer1loadcount;
  wire [`TIMER_WIDTH_2-1:0] timer2loadcount;
  wire [`TIMER_WIDTH_3-1:0] timer3loadcount;
  wire [`TIMER_WIDTH_4-1:0] timer4loadcount;
  wire [`TIMER_WIDTH_5-1:0] timer5loadcount;
  wire [`TIMER_WIDTH_6-1:0] timer6loadcount;
  wire [`TIMER_WIDTH_7-1:0] timer7loadcount;
  wire [`TIMER_WIDTH_8-1:0] timer8loadcount;


  wire [`NUM_TIMERS-1:0] timeren;
  wire [`NUM_TIMERS-1:0] timer_mode;
  wire [`NUM_TIMERS-1:0] timer_pwm;

  wire [`NUM_TIMERS-1:0] timer_intr;
  wire [`NUM_TIMERS-1:0] pclk_timer_intr;
  wire [`NUM_TIMERS-1:0] timer_intr_n;
  
  wire timer_intr_flag;
  wire timer_intr_flag_n;
 
  wire timer1_read_b0;
  wire timer2_read_b0;
  wire timer3_read_b0;
  wire timer4_read_b0;
  wire timer5_read_b0;
  wire timer6_read_b0;
  wire timer7_read_b0;
  wire timer8_read_b0;

// 20100727 jduarte added Leda exceptions
// leda A_8C_R off
// leda G_568_1 off
  assign timer_en = timeren[`NUM_TIMERS-1:0];
  assign timer_intr[`NUM_TIMERS-1:0] = pclk_timer_intr[`NUM_TIMERS-1:0];
  assign bus_interrupt[0] = (`NUM_TIMERS>=1) ? timer_clk_interrupt[0] : 1'b0;
  assign bus_interrupt[1] = (`NUM_TIMERS>=2) ? timer_clk_interrupt[1] : 1'b0;
  assign bus_interrupt[2] = (`NUM_TIMERS>=3) ? timer_clk_interrupt[2] : 1'b0;
  assign bus_interrupt[3] = (`NUM_TIMERS>=4) ? timer_clk_interrupt[3] : 1'b0;
  assign bus_interrupt[4] = (`NUM_TIMERS>=5) ? timer_clk_interrupt[4] : 1'b0;
  assign bus_interrupt[5] = (`NUM_TIMERS>=6) ? timer_clk_interrupt[5] : 1'b0;
  assign bus_interrupt[6] = (`NUM_TIMERS>=7) ? timer_clk_interrupt[6] : 1'b0;
  assign bus_interrupt[7] = (`NUM_TIMERS>=8) ? timer_clk_interrupt[7] : 1'b0;

  assign temp_current_value[`MAX_APB_DATA_WIDTH-1:0] =
         (`TIM_COHERENCY_1==1) ? 
         coherent_current_value[`MAX_APB_DATA_WIDTH-1:0] : raw_current_value[`MAX_APB_DATA_WIDTH-1:0];

  assign temp_current_value[`TIM2_CV_INDEX-1:`MAX_APB_DATA_WIDTH] =
         (`TIM_COHERENCY_2==1) ?
         coherent_current_value[`TIM2_CV_INDEX-1:`MAX_APB_DATA_WIDTH] : raw_current_value[`TIM2_CV_INDEX-1:`MAX_APB_DATA_WIDTH];

  assign temp_current_value[`TIM3_CV_INDEX-1:`TIM2_CV_INDEX] =
         (`TIM_COHERENCY_3==1) ?
         coherent_current_value[`TIM3_CV_INDEX-1:`TIM2_CV_INDEX] : raw_current_value[`TIM3_CV_INDEX-1:`TIM2_CV_INDEX];
 
  assign temp_current_value[`TIM4_CV_INDEX-1:`TIM3_CV_INDEX] =
         (`TIM_COHERENCY_4==1) ?
         coherent_current_value[`TIM4_CV_INDEX-1:`TIM3_CV_INDEX] : raw_current_value[`TIM4_CV_INDEX-1:`TIM3_CV_INDEX];
 
  assign temp_current_value[`TIM5_CV_INDEX-1:`TIM4_CV_INDEX] =
         (`TIM_COHERENCY_5==1) ?
         coherent_current_value[`TIM5_CV_INDEX-1:`TIM4_CV_INDEX] : raw_current_value[`TIM5_CV_INDEX-1:`TIM4_CV_INDEX];
 
  assign temp_current_value[`TIM6_CV_INDEX-1:`TIM5_CV_INDEX] =
         (`TIM_COHERENCY_6==1) ?
         coherent_current_value[`TIM6_CV_INDEX-1:`TIM5_CV_INDEX] : raw_current_value[`TIM6_CV_INDEX-1:`TIM5_CV_INDEX];
 
  assign temp_current_value[`TIM7_CV_INDEX-1:`TIM6_CV_INDEX] =
         (`TIM_COHERENCY_7==1) ?
         coherent_current_value[`TIM7_CV_INDEX-1:`TIM6_CV_INDEX] : raw_current_value[`TIM7_CV_INDEX-1:`TIM6_CV_INDEX];
 
  assign temp_current_value[`TIM8_CV_INDEX-1:`TIM7_CV_INDEX] =
         (`TIM_COHERENCY_8==1) ?
         coherent_current_value[`TIM8_CV_INDEX-1:`TIM7_CV_INDEX] : raw_current_value[`TIM8_CV_INDEX-1:`TIM7_CV_INDEX];
 
  assign bus_current_value[`MAX_APB_DATA_WIDTH-1:0] = 
         (`NUM_TIMERS>=1) ?  temp_current_value[`MAX_APB_DATA_WIDTH-1:0] : {`MAX_APB_DATA_WIDTH{1'b0}};
  assign bus_current_value[`TIM2_CV_INDEX-1:`MAX_APB_DATA_WIDTH] = 
         (`NUM_TIMERS>=2) ?  temp_current_value[`TIM2_CV_INDEX-1:`MAX_APB_DATA_WIDTH] : {`MAX_APB_DATA_WIDTH{1'b0}};
  assign bus_current_value[`TIM3_CV_INDEX-1:`TIM2_CV_INDEX] = 
         (`NUM_TIMERS>=3) ?  temp_current_value[`TIM3_CV_INDEX-1:`TIM2_CV_INDEX] : {`MAX_APB_DATA_WIDTH{1'b0}};
  assign bus_current_value[`TIM4_CV_INDEX-1:`TIM3_CV_INDEX] = 
         (`NUM_TIMERS>=4) ?  temp_current_value[`TIM4_CV_INDEX-1:`TIM3_CV_INDEX] : {`MAX_APB_DATA_WIDTH{1'b0}};
  assign bus_current_value[`TIM5_CV_INDEX-1:`TIM4_CV_INDEX] = 
         (`NUM_TIMERS>=5) ?  temp_current_value[`TIM5_CV_INDEX-1:`TIM4_CV_INDEX] : {`MAX_APB_DATA_WIDTH{1'b0}};
  assign bus_current_value[`TIM6_CV_INDEX-1:`TIM5_CV_INDEX] = 
         (`NUM_TIMERS>=6) ?  temp_current_value[`TIM6_CV_INDEX-1:`TIM5_CV_INDEX] : {`MAX_APB_DATA_WIDTH{1'b0}};
  assign bus_current_value[`TIM7_CV_INDEX-1:`TIM6_CV_INDEX] = 
         (`NUM_TIMERS>=7) ?  temp_current_value[`TIM7_CV_INDEX-1:`TIM6_CV_INDEX] : {`MAX_APB_DATA_WIDTH{1'b0}};
  assign bus_current_value[`TIM8_CV_INDEX-1:`TIM7_CV_INDEX] = 
         (`NUM_TIMERS>=8) ?  temp_current_value[`TIM8_CV_INDEX-1:`TIM7_CV_INDEX] : {`MAX_APB_DATA_WIDTH{1'b0}};
// leda A_8C_R on
// leda G_568_1 on

  DW_apb_timers_apbif
   U_apbif (
      .pclk              (pclk)
    , .presetn           (presetn)
    , .penable           (penable)
    , .pwrite            (pwrite)
    , .pwdata            (pwdata)
    , .paddr             (paddr)
    , .psel              (psel)
    , .timer1loadcount   (timer1loadcount) 
    , .timer1_read_b0    (timer1_read_b0)
    , .timer2loadcount   (timer2loadcount) 
    , .timer2_read_b0    (timer2_read_b0)
    , .timer_en          (timeren[`NUM_TIMERS-1:0])
    , .timer_mode        (timer_mode[`NUM_TIMERS-1:0])
    , .timer_pwm         (timer_pwm[`NUM_TIMERS-1:0])
    , .timer_intr_flag   (timer_intr_flag)
    , .timer_intr_flag_n (timer_intr_flag_n)
    , .timer_intr        (pclk_timer_intr)
    , .timer_intr_n      (timer_intr_n)
    , .bus_current_value (bus_current_value)
    , .bus_interrupts    (bus_interrupt)
    , .prdata            (prdata)
  );

  DW_apb_timers_frc
   #(`TIMER_WIDTH_1, `TIM_PULSE_EXTD_1) U_tim1 (
      .timer_clk             (timer_1_clk)
    , .timer_resetn          (timer_1_resetn)
    , .timer_en              (timeren[0])
    , .timer_mode            (timer_mode[0])
    , .load_value            (timer1loadcount)
    , .scan_mode             (scan_mode)
    , .current_value         (raw_current_value[31:0])
    , .toggle                (timer_1_toggle)
    , .interrupt             (timer_clk_interrupt[0])
  );
  DW_apb_timers_frc
   #(`TIMER_WIDTH_2, `TIM_PULSE_EXTD_2) U_tim2 (
      .timer_clk             (timer_2_clk)
    , .timer_resetn          (timer_2_resetn)
    , .timer_en              (timeren[1])
    , .timer_mode            (timer_mode[1])
    , .load_value            (timer2loadcount)
    , .scan_mode             (scan_mode)
    , .current_value         (raw_current_value[63:32])
    , .toggle                (timer_2_toggle)
    , .interrupt             (timer_clk_interrupt[1])
  );

// 20100727 jduarte added Leda exceptions
// leda W287 off
// leda WV951018 off


// leda W287 on
// leda WV951018 on


endmodule
