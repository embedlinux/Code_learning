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

module aes_enc_core (
  clk,
  reset_n,
  data_in,
  key_in,
  core_start,
  dec_en,
  core_ready,
  core_ready_1,
  data_out,
  key_out
);
  // Inputs and outputs
  input             clk;
  input             reset_n;
  input   [127:0]   key_in;
  input   [127:0]   data_in;
  output  [127:0]   data_out, key_out;
  input             core_start;
  input             dec_en;
  output            core_ready, core_ready_1;
  // Internal variables
  wire    [3:0]     rnd_num;
  wire              key_ld;
  wire              data_ld;
  wire              key_en;
  wire              data_en;
  wire    [127:0]   rnd_key_in;
  // Outputs
  assign key_out = rnd_key_in;
  // AES key scheduler
  aes_key_gen u_aes_key_gen (
    .clk          (clk),
    .reset_n      (reset_n),
    .key_in       (key_in),
    .key_ld       (key_ld),
    .key_en       (key_en),
    .rnd_num      (rnd_num),
    .dec_en       (dec_en),
    .key_out      (rnd_key_in)
  );
  // AES Encrypt/Decrypt round
  aes_enc u_aes_enc(
    .clk        (clk),
    .reset_n    (reset_n),
    .data_in    (data_in),
    .rnd_key_in (rnd_key_in),
    .data_ld    (data_ld),
    .data_en    (data_en),
    .init_key   (key_in),
    .dec_en     (dec_en),
    .data_out   (data_out)
  );
  // Control logic
  aes_ctrl u_aes_ctrl (
    .clk          (clk),
    .reset_n      (reset_n),
    .core_start   (core_start),
    .core_ready   (core_ready),
    .core_ready_1 (core_ready_1),
    .rnd_num      (rnd_num),
    .key_ld       (key_ld),
    .data_ld      (data_ld),
    .key_en       (key_en),
    .data_en      (data_en)
  );
  //
endmodule
