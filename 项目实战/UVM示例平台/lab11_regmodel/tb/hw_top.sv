/*-----------------------------------------------------------------
File name     : hw_top.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/11/15
Description   : UVM register modelling lab hardware top level module
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

`ifndef DUT_ASIZE 
  `define DUT_ASIZE 32
`endif

`ifndef DUT_DSIZE 
  `define DUT_DSIZE 8
`endif

module hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;

  // clock and reset interface 
  clock_and_reset_low_if clk_rst_if(
    .clock(clock),
    .reset(reset),
    .run_clock(run_clock),
    .clock_period(clock_period)
  );

  // CLKGEN module generates clock
  clkgen clkgen (
    .clock(clock),
    .run_clock(run_clock),
    .clock_period(clock_period)
  );

  apb_if apbif (clock, reset);

  memctldut dut (.clock, .reset, .apbif);
  
endmodule
