//------------------------------------------------------------------------
//--
//--
//--                   (C) COPYRIGHT 2001-2010 SYNOPSYS INC.
//--                             ALL RIGHTS RESERVED
//--
//--  This software and the associated documentation are confidential and
//--  proprietary to Synopsys, Inc.  Your use or disclosure of this software
//--  is subject to the terms and conditions of a written license agreement
//--  between you, or your company, and Synopsys, Inc.
//--
//--  The entire notice above must be reproduced on all authorized copies.
//--
//-- File :                       DW_apb_timers_regb.v
//-- Author:                      Peter Gillen
//-- Version      :               $Revision: #14 $
//-- Abstract     :               Register Block 
//--
//--
//-- Modification History:
//-- Date                 By      Version Change  Description
//-- =====================================================================
`include "DW_apb_timers_cc_constants.v"
module DWC_apb_timers_regb 
#(
    parameter TIM_WIDTH = 32
  , parameter DW = 32
)
(
    input                  pclk
  , input                  presetn
  , input  [3:0]           byte_en
  , input                  wen
  , input  [DW-1:0]        wdata
  , output [TIM_WIDTH-1:0] odata
);

reg [7:0] adj_wdata_b0;
reg [7:0] adj_wdata_b1;
reg [7:0] adj_wdata_b2;
reg [7:0] adj_wdata_b3;

  always @(*)
  begin: case32_PROC
    adj_wdata_b0 = wdata[ 7: 0];
    adj_wdata_b1 = wdata[15: 8];
    adj_wdata_b2 = wdata[23:16];
    adj_wdata_b3 = wdata[31:24];
  end



reg [31:0] r_odata;
always @(posedge pclk or negedge presetn)
begin: timer_loadcnt_PROC
  if (presetn == 1'b0) begin
    r_odata <= {TIM_WIDTH{1'b0}}; 
  end else begin
    if (wen && byte_en[0]) r_odata[ 7: 0] <= adj_wdata_b0[7:0];
    if (wen && byte_en[1]) r_odata[15: 8] <= adj_wdata_b1[7:0];
    if (wen && byte_en[2]) r_odata[23:16] <= adj_wdata_b2[7:0];
    if (wen && byte_en[3]) r_odata[31:24] <= adj_wdata_b3[7:0];
  end
end

assign odata = r_odata[TIM_WIDTH-1:0];

endmodule
