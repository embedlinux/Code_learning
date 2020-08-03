/*
Copyright (C) 2009 SysWip

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

`timescale 1ns/10ps

`define st_ctrl_idle    4'd0
`define st_ctrl_0       4'd1
`define st_ctrl_1       4'd2
`define st_ctrl_2       4'd3
`define st_ctrl_3       4'd4
`define st_ctrl_4       4'd5
`define st_ctrl_5       4'd6
`define st_ctrl_6       4'd7
`define st_ctrl_7       4'd8
`define st_ctrl_8       4'd9

module aes_ctrl (
  clk,
  reset_n,
  core_start,
  core_ready,
  core_ready_1,
  rnd_num,
  key_ld,
  data_ld,
  data_en,
  key_en
);
  // Inputs and outputs
  input             clk;
  input             reset_n;
  input             core_start;
  output            core_ready, core_ready_1;
  output  [3:0]     rnd_num;
  output            key_ld;
  output            data_ld;
  output            key_en;
  output            data_en;
  // Internal variables
  reg     [3:0]     st_ctrl_curr;
  reg     [3:0]     st_ctrl_next;
  reg               key_ld_f, key_ld_nxt;
  reg               data_ld;
  reg               key_en_f, key_en_nxt;
  reg               data_en_f, data_en_nxt;
  // Outputs
  assign core_ready     = (st_ctrl_curr == `st_ctrl_idle);
  assign core_ready_1   = (st_ctrl_curr == `st_ctrl_8);
  assign key_ld         = key_ld_f;
  assign rnd_num        = st_ctrl_curr;
  assign key_en         = key_en_nxt;
  assign data_en        = data_en_f;
  // Registers
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      st_ctrl_curr        <= `st_ctrl_idle;
      key_ld_f            <= 1'b1;
      key_en_f            <= 1'b0;
      data_en_f           <= 1'b0;
    end else begin
      st_ctrl_curr        <= st_ctrl_next;
      key_ld_f            <= key_ld_nxt;
      key_en_f            <= key_en_nxt;
      data_en_f           <= data_en_nxt;
    end
  end
  // Control FSM
  always @ (st_ctrl_curr or core_start or data_en_f or key_ld_f or key_en_f) begin
    //
    st_ctrl_next      = st_ctrl_curr;
    key_en_nxt        = key_en_f;
    data_en_nxt       = data_en_f;
    key_ld_nxt        = key_ld_f;
    data_ld           = 1'b0;
    //
    case (st_ctrl_curr)
      `st_ctrl_idle: begin
        key_en_nxt        = 1'b0;
        if (core_start) begin
          st_ctrl_next    = `st_ctrl_0;
          key_ld_nxt      = 1'b0;
          data_ld         = 1'b1;
          key_en_nxt      = 1'b1;
          data_en_nxt     = 1'b1;
        end
      end
      `st_ctrl_0: begin
        st_ctrl_next    = `st_ctrl_1;
      end
      `st_ctrl_1: begin
        st_ctrl_next    = `st_ctrl_2;
      end
      `st_ctrl_2: begin
        st_ctrl_next    = `st_ctrl_3;
      end
      `st_ctrl_3: begin
        st_ctrl_next    = `st_ctrl_4;
      end
      `st_ctrl_4: begin
        st_ctrl_next    = `st_ctrl_5;
      end
      `st_ctrl_5: begin
        st_ctrl_next    = `st_ctrl_6;
      end
      `st_ctrl_6: begin
        st_ctrl_next    = `st_ctrl_7;
      end
      `st_ctrl_7: begin
        st_ctrl_next    = `st_ctrl_8;
      end
      `st_ctrl_8: begin
        st_ctrl_next    = `st_ctrl_idle;
        data_en_nxt     = 1'b0;
        key_ld_nxt      = 1'b1;
      end
    endcase
  end
  //
endmodule

`undef st_ctrl_idle
`undef st_ctrl_0
`undef st_ctrl_1
`undef st_ctrl_2
`undef st_ctrl_3
`undef st_ctrl_4
`undef st_ctrl_5
`undef st_ctrl_6
`undef st_ctrl_7
`undef st_ctrl_8
