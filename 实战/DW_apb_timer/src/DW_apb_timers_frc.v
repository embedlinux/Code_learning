/*
------------------------------------------------------------------------
--
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
-- File :                       DW_apb_timers_frc.v
-- Author:                      Peter Gillen
-- Date :                       $DateTime: 2010/08/30 05:15:10 $
-- Version      :               $Revision: #3 $
-- Abstract     :               Timer block for DW_apb_timers 
--
--
-- Modification History:
-- Date                 By      Version Change  Description
-- =====================================================================
-- See CVS log
-- =====================================================================
*/
`include "DW_apb_timers_cc_constants.v"
// 20100727 jduarte added Leda exceptions
// leda NTL_RST06 off
module DW_apb_timers_frc 
#(
    parameter TIMER_WIDTH = 8
  , parameter TIM_PULSE_EXTD = 0
)
(
    input                                       timer_clk
  , input                                       timer_resetn
  , input                                       timer_en
  , input                                       timer_mode
  , input  [TIMER_WIDTH-1:0]                    load_value
  , input                                       scan_mode
  , output reg [`TIM_MAX_TIMER_WIDTH-1:0]       current_value
  , output reg                                  toggle
  , output                                      interrupt
);

// Timer registers
  reg [TIMER_WIDTH-1:0]    timer;
// Async clear signal for rising_edge register
  wire                     async_clear;
// Register used to detect a rising edge on timer_en once timer_clk is running
  reg                      rising_edge;
// Register set when the timer is at zero;
  reg                      atzero;
// Pulse extension registers for interrupt signal
  reg                      extend1;
  reg                      extend2;
  reg                      extend3;
// Load pulse to enable the loading of the timer register
  wire                     load;
// Unextended interrupt signal
  wire                     raw_interrupt;
// Pulse extended interrupts
  wire                     interrupt_extd1;
  wire                     interrupt_extd2;
  wire                     interrupt_extd3;
// Asynchronously clear rising_edge register if timer_en is zero and scan_mode is zero 
  assign async_clear = (((timer_en==1'b0) && (scan_mode == 1'b0)) ||
                        (timer_resetn==1'b0));

// Set the rising_edge register if timer_en is asserted and scan_mode is zero 
  always @ (posedge timer_clk or posedge async_clear)
  begin : edge_PROC
    if (async_clear == 1'b1)
      rising_edge <= 1'b0;
    else
      rising_edge <= timer_en;
  end

// If a rising edge is detected on timer_en when timer_clk is 
// running, set "load" to enable a new value to be loaded into
// the timer from the load_value input
  assign load = ((timer_en == 1'b1) && (rising_edge == 1'b0));

// If load signal is asserted, load the value presented on
// load_value into the timer registers.  Otherwise if the timer
// is at zero, wrap the timer to either load_value or its
// maximum possible value, depending on timer_mode.
// If the timer is not at zero, decrement it.

// leda W484 off
// Possible loss of carry/borrow in addition/subtraction
//
// Restriction in the setting of TIMER_WIDTH Macro in the line
//   timer <= timer - {{(TIMER_WIDTH-1){1'b0}},{1'b1}};
// ensures that there will be no loss in the equation.
// Switching this warning off.
wire en_timer;
  assign en_timer = timer_en;


// 20100728 jduarte added Leda exception
// leda C_1406 off
  always @ (posedge timer_clk or posedge async_clear) begin : tmr_PROC

    if (async_clear == 1'b1) begin
      timer <= {TIMER_WIDTH{1'b1}};
    end else begin
      if (en_timer == 1'b1) begin
        if (load == 1'b1)
          timer <= load_value;
        else begin
          if (timer == {TIMER_WIDTH{1'b0}}) begin
            if (timer_mode == `TIM_FREE_RUNNING) begin
              timer <= {TIMER_WIDTH{1'b1}};
            end else
              timer <= load_value;
          end else
            timer <= timer - {{(TIMER_WIDTH-1){1'b0}},{1'b1}};
        end 
      end
    end
  end
// leda C_1406 on
// leda W484 on
//
// The atzero register is a delayed version of onetozero
//
  always @ (posedge timer_clk or posedge async_clear) 
  begin : z_PROC
    if (async_clear == 1'b1)
      atzero <= 1'b0;
    else
      atzero <= (timer=={TIMER_WIDTH{1'b0}});
  end

  assign raw_interrupt = atzero;

//# Each time the timer is reloaded a toggle is created. Allows a slower clock to be generated.
  always @ (posedge timer_clk or posedge async_clear)
  begin : toggle_PROC
    if (async_clear == 1'b1) begin
      toggle <= 1'b0;
    end else begin
      if (timer=={TIMER_WIDTH{1'b0}}) begin
        toggle <= ~toggle;
      end
    end
  end

// Clock the raw_interrupt signal up to three times to facilitate pulse extension
  always @ (posedge timer_clk or posedge async_clear) 
  begin : ext_PROC
    if (async_clear == 1'b1) begin
      extend1 <= 1'b0;
      extend2 <= 1'b0;
      extend3 <= 1'b0;
    end else begin
      extend1 <= raw_interrupt;
      extend2 <= extend1;
      extend3 <= extend2;
    end
  end           

// Extend the raw_interrupt signal by ORing it with its clocked versions
  assign interrupt_extd1 = raw_interrupt | extend1;
  assign interrupt_extd2 = interrupt_extd1 | extend2;
  assign interrupt_extd3 = interrupt_extd2 | extend3;

// Output current_value, padding with zeroes as appropriate 
  always @ (*) begin : current_value_PROC
    current_value = {`TIM_MAX_TIMER_WIDTH{1'b0}};
    if (timer_en == 1'b1) current_value[TIMER_WIDTH-1:0] = timer;
  end

// Drive the interrupt signal, depending on the value of the TIM_PULSE_EXTD parameter
generate if (TIM_PULSE_EXTD == 0) begin : g1
  assign interrupt = raw_interrupt;
end else if (TIM_PULSE_EXTD == 1) begin
  assign interrupt = interrupt_extd1;
end else if (TIM_PULSE_EXTD == 2) begin
  assign interrupt = interrupt_extd2;
end else begin
  assign interrupt = interrupt_extd3;
end
endgenerate
/* ===
  assign interrupt = ((TIM_PULSE_EXTD == 0) ? raw_interrupt :
                     ((TIM_PULSE_EXTD == 1) ? interrupt_extd1 :
                     ((TIM_PULSE_EXTD == 2) ? interrupt_extd2 : 
                                            interrupt_extd3)));
=== */
endmodule
// leda NTL_RST06 on

