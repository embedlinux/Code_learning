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
// FSM states defines
`define st_ctrl_idle      2'b00
`define st_ctrl_proc      2'b01
`define st_ctrl_key_gen   2'b10

module aes_s_apb (
  clk,
  reset_n,
  psel,
  penable,
  pwrite,
  paddr,
  pwdata,
  prdata,
  pready,
  pslverr
);
  // Clock and reset
  input                   clk;
  input                   reset_n;
  // APB interface signals
  input                   psel;
  input                   penable;
  input                   pwrite;
  input  [4:0]            paddr;
  input  [31:0]           pwdata;
  output [31:0]           prdata;
  output                  pready;
  output                  pslverr;
  // Externally accessible registers
  reg    [127:0]          key_f, key_nxt;
  reg    [127:0]          data_in_f, data_in_nxt;
  reg    [127:0]          data_out_f, data_out_nxt;
  reg                     mode_f, mode_nxt;
  // Internal registers
  reg                     pready_f, pready_nxt;
  reg                     pslverr_f, pslverr_nxt;
  reg     [1:0]           st_ctrl_curr;
  reg     [1:0]           st_ctrl_next;
  reg                     core_start_f, core_start_nxt;
  reg                     data_wr_f, data_wr_nxt;
  reg                     data_in_rdy_f, data_in_rdy_nxt;
  reg                     data_out_buff_full_f, data_out_buff_full_nxt;
  reg     [1:0]           data_in_cnt_f, data_in_cnt_nxt;
  reg     [1:0]           data_out_cnt_f, data_out_cnt_nxt;
  reg                     new_key_f, new_key_nxt;
  reg                     dec_key_ld_f, dec_key_ld_nxt;
  reg                     dec_en_f, dec_en_nxt;
  // Wires
  wire                    apb_wr_en;
  wire                    apb_rd_en;
  wire                    apb_rd;
  wire                    apb_wr;
  wire                    out_buff_rdy;
  wire                    core_ready_1, core_ready;
  wire    [127:0]         core_data_out;
  wire                    data_in_buff_rdy;
  wire  [127:0]           key_out;
  // Outputs
  assign prdata         = data_out_f[31:0];
  assign pslverr        = pslverr_f;
  assign pready         = pready_f;
  // Assigning registers
  always @ (posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      key_f                 <= 128'd0;
      data_in_f             <= 128'd0;
      data_out_f            <= 128'd0;
      mode_f                <= 1'b0;
      st_ctrl_curr          <= `st_ctrl_idle;
      core_start_f          <= 1'b0;
      data_wr_f             <= 1'b0;
      data_in_rdy_f         <= 1'b0;
      data_out_buff_full_f  <= 1'b0;
      pready_f              <= 1'b1;
      data_in_cnt_f         <= 2'b00;
      data_out_cnt_f        <= 2'b00;
      new_key_f             <= 1'b0;
      dec_key_ld_f          <= 1'b0;
      dec_en_f              <= 1'b0;
      pslverr_f             <= 1'b0;
    end else begin
      key_f                 <= key_nxt;
      data_in_f             <= data_in_nxt;
      data_out_f            <= data_out_nxt;
      mode_f                <= mode_nxt;
      st_ctrl_curr          <= st_ctrl_next;
      core_start_f          <= core_start_nxt;
      data_wr_f             <= data_wr_nxt;
      data_in_rdy_f         <= data_in_rdy_nxt;
      data_out_buff_full_f  <= data_out_buff_full_nxt;
      pready_f              <= pready_nxt;
      data_in_cnt_f         <= data_in_cnt_nxt;
      data_out_cnt_f        <= data_out_cnt_nxt;
      new_key_f             <= new_key_nxt;
      dec_key_ld_f          <= dec_key_ld_nxt;
      dec_en_f              <= dec_en_nxt;
      pslverr_f             <= pslverr_nxt;
    end
  end
  // Loading key, mode and data registers
  always @(key_f or data_in_f or mode_f or apb_wr_en or pwdata or new_key_f or
           paddr or data_in_buff_rdy or data_in_cnt_f or dec_key_ld_f or
           data_in_rdy_f or core_start_f or key_out or st_ctrl_curr) begin
    // Defaults
    key_nxt             = key_f;
    data_in_nxt         = data_in_f;
    mode_nxt            = mode_f;
    data_in_rdy_nxt     = data_in_rdy_f;
    data_in_cnt_nxt     = data_in_cnt_f;
    new_key_nxt         = new_key_f;
    // Loading key register. During decrypt mode generated key is loaded from
    // engine.
    if (dec_key_ld_f) begin
      key_nxt           = key_out;
    end else begin
      if (apb_wr_en & data_in_buff_rdy) begin
        if (paddr[4:2] == 3'd0) begin
          key_nxt[31:0]   = pwdata;
        end
        if (paddr[4:2] == 3'd1) begin
          key_nxt[63:32]  = pwdata;
        end
        if (paddr[4:2] == 3'd2) begin
          key_nxt[95:64]  = pwdata;
        end
        if (paddr[4:2] == 3'd3) begin
          key_nxt[127:96] = pwdata;
          new_key_nxt     = 1'b1;
        end
      end
    end
    // Loading data register. All data should be writen to the same address.
    if (apb_wr_en & data_in_buff_rdy) begin
      if (paddr[4:2] == 3'd5) begin
        data_in_nxt         = {pwdata, data_in_f[127:32]};
        data_in_cnt_nxt     = data_in_cnt_f + 2'b01;
        if (&data_in_cnt_f) begin
          data_in_rdy_nxt   = 1'b1;
        end
      end
    end
    // Loading mode register.
    if (apb_wr_en & data_in_buff_rdy) begin
      if (paddr[4:2] == 3'd4) begin
        mode_nxt            = pwdata[0];
      end
    end
    // Clear new key indicator when key was captured by core
    if (core_start_f) begin
      new_key_nxt           = 1'b0;
    end
    // Clear data_in_ready when data was captured by core.
    if (core_start_f & (st_ctrl_curr != `st_ctrl_key_gen)) begin
      data_in_rdy_nxt       = 1'b0;
    end
  end
  // Output data register
  always @(core_data_out or data_wr_f or data_out_f or data_out_buff_full_f or
           paddr or apb_rd_en or data_out_cnt_f) begin
    // Defaults
    data_out_nxt              = data_out_f;
    data_out_buff_full_nxt    = data_out_buff_full_f;
    data_out_cnt_nxt          = data_out_cnt_f;
    // Data is written by the core will be read by APB interface. Read address
    // is fixed for all data.
    if (data_wr_f) begin
      data_out_nxt            = core_data_out;
      data_out_cnt_nxt        = 2'b00;
    end else if (apb_rd_en & (paddr[4:2] == 3'd6)) begin
      data_out_nxt            = {32'd0, data_out_f[127:32]};
      if (data_out_cnt_f != 2'b11) begin
        data_out_cnt_nxt      = data_out_cnt_f + 2'b01;
      end
    end

    if (data_wr_f) begin
      data_out_buff_full_nxt  = 1'b1;
    end else if (apb_rd_en & (paddr[4:2] == 3'd6) & (&data_out_cnt_f)) begin
      data_out_buff_full_nxt  = 1'b0;
    end
  end
  // pready and pslverr signals
  always @(pready_f or apb_rd or paddr or data_out_buff_full_nxt or
           data_in_rdy_nxt or core_start_nxt or psel or apb_wr) begin
    // Defaults
    pready_nxt          = pready_f;
    pslverr_nxt         = 1'b0;
    // Any read or write to/from wrong address generates slave error and
    // sets pready to high to finish current transaction.
    if(psel & (paddr[1:0] != 2'b00)) begin
      pready_nxt      = 1'b1;
      pslverr_nxt     = 1'b1;
    end else if (apb_rd) begin
      pready_nxt        = data_out_buff_full_nxt;
      if(paddr[4:2] != 3'd6) begin
        pready_nxt      = 1'b1;
        pslverr_nxt     = 1'b1;
      end
    end else if (apb_wr) begin
      pready_nxt        = ~data_in_rdy_nxt | core_start_nxt;
      if(paddr[4:2] > 3'd5)begin
        pready_nxt      = 1'b1;
        pslverr_nxt     = 1'b1;
      end
    end
  end
  // Control FSM
  always @(st_ctrl_curr or apb_wr_en or out_buff_rdy or core_start_f or
           data_in_rdy_nxt or core_ready or core_ready_1 or new_key_nxt or
           mode_f or dec_en_f) begin
    // Defaults
    st_ctrl_next                = st_ctrl_curr;
    core_start_nxt              = 1'b0;
    data_wr_nxt                 = 1'b0;
    dec_key_ld_nxt              = 1'b0;
    dec_en_nxt                  = dec_en_f;

    case(st_ctrl_curr)
      // Waiting for input is ready
      `st_ctrl_idle: begin
        if (new_key_nxt & mode_f) begin
          core_start_nxt        = 1'b1;
          st_ctrl_next          = `st_ctrl_key_gen;
          dec_en_nxt            = 1'b0;
        end else if (data_in_rdy_nxt) begin
          core_start_nxt        = 1'b1;
          st_ctrl_next          = `st_ctrl_proc;
          dec_en_nxt            = mode_f;
        end
      end
      // Encrypt or decrypt processing
      `st_ctrl_proc: begin
        if ((core_ready | core_ready_1) & out_buff_rdy & ~core_start_f) begin
          data_wr_nxt           = 1'b1;
          if (new_key_nxt & mode_f) begin
            core_start_nxt        = 1'b1;
            st_ctrl_next          = `st_ctrl_key_gen;
            dec_en_nxt            = 1'b0;
          end else if (data_in_rdy_nxt) begin
            core_start_nxt      = 1'b1;
            dec_en_nxt          = mode_f;
          end else begin
            st_ctrl_next        = `st_ctrl_idle;
          end
        end
      end
      // Generates decrypt key
      `st_ctrl_key_gen: begin
        if (core_ready_1) begin
          dec_key_ld_nxt        = 1'b1;
          st_ctrl_next          = `st_ctrl_idle;
        end
      end
    endcase
  end

  assign apb_wr_en = psel & penable & pwrite & (paddr[1:0] == 2'b00);
  assign apb_rd_en = psel & penable & ~pwrite & (paddr[1:0] == 2'b00);
  assign apb_rd    = psel & ~pwrite & (paddr[1:0] == 2'b00);
  assign apb_wr    = psel & pwrite & (paddr[1:0] == 2'b00);
  assign data_in_buff_rdy = ~data_in_rdy_f | core_start_f;
  assign out_buff_rdy = ~data_out_buff_full_f | ~data_out_buff_full_nxt;
  // AES encrypt/decrypt 10 clock cycle core. All input must be valid when
  // start is high. dec_en_f shouldn't be changed during processing.
  aes_enc_core u_aes_enc_core (
    .clk(clk),
    .reset_n(reset_n),
    .data_in(data_in_f),
    .key_in(key_f),
    .core_start(core_start_f),
    .dec_en(dec_en_f),
    .core_ready(core_ready),
    .core_ready_1(core_ready_1),
    .data_out(core_data_out),
    .key_out(key_out)
  );

endmodule
`undef st_ctrl_idle
`undef st_ctrl_proc
`undef st_ctrl_key_gen
