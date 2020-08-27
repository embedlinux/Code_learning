//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2003 - 2018 SYNOPSYS, INC.
//                            ALL RIGHTS RESERVED
//
//  This software and the associated documentation are confidential and
//  proprietary to Synopsys, Inc.  Your use or disclosure of this
//  software is subject to the terms and conditions of a written
//  license agreement between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
// Component Name   : DW_apb_i2c
// Component Version: 2.02a
// Release Type     : GA
//  ------------------------------------------------------------------------

// 
// Release version :  2.02a
// File Version     :        $Revision: #1 $ 
// Revision: $Id: //dwh/DW_ocb/DW_apb_i2c/amba_dev/src/DW_apb_i2c_regs.v#1 $ 
//
//
// File    : DW_apb_i2c_regs.v
//
//
// Author  : Madhusudhan Prabhu
// Created : Thu Nov 05 00:47:12 IST 2015
// Abstract: The register module used for registering the signals. This is used for
//           avoiding the scenario in which the same file has the logic corresponding 
//           to two clocks i.e. pclk and ic_clk.
//
// -------------------------------------------------------------------
// -------------------------------------------------------------------


module rkv_DW_apb_i2c_regs (
    clk,
    resetn,
    data_in,
    data_r_out
);

parameter DATA_WIDTH = 1;

input                   clk;
input                   resetn;
input  [DATA_WIDTH-1:0] data_in;
output [DATA_WIDTH-1:0] data_r_out;

  reg  [DATA_WIDTH-1:0]  data_r;


  always @(posedge clk or negedge resetn)
  begin : i2c_reg_PROC
    if (resetn == 1'b0) begin
      data_r <= {(DATA_WIDTH){1'b0}};
    end else begin
      data_r <= data_in;
    end
  end

  assign data_r_out = data_r; 

endmodule


