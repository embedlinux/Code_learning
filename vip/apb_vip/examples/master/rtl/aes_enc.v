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

module aes_enc (
  clk,
  reset_n,
  data_in,
  rnd_key_in,
  init_key,
  data_ld,
  data_en,
  dec_en,
  data_out
);
  // Inputs and outputs
  input            clk;
  input            reset_n;
  input   [127:0]  data_in;
  output  [127:0]  data_out;
  input   [127:0]  rnd_key_in, init_key;
  input            data_ld;
  input            data_en;
  input            dec_en;
  // Internal variables
  reg     [127:0]  data_out_f;
  reg     [127:0]  data_out_nxt;
  wire    [127:0]  sbox_in, sbox_in_inv;
  wire    [127:0]  sbox_out, sbox_out_inv;
  wire    [127:0]  sub_rnd_mxout, sub_rnd_mx;
  wire    [127:0]  sub_rnd_mxout_inv;
  wire    [127:0]  rnd_data;
  wire    [31:0]   clm0_in, clm1_in, clm2_in, clm3_in;
  wire    [31:0]   clm0_out, clm1_out, clm2_out, clm3_out;
  wire    [31:0]   clm0_out_inv, clm1_out_inv, clm2_out_inv, clm3_out_inv;
  wire    [7:0]    s00, s01, s02, s03;
  wire    [7:0]    s10, s11, s12, s13;
  wire    [7:0]    s20, s21, s22, s23;
  wire    [7:0]    s30, s31, s32, s33;
  wire    [7:0]    s00_inv, s01_inv, s02_inv, s03_inv;
  wire    [7:0]    s10_inv, s11_inv, s12_inv, s13_inv;
  wire    [7:0]    s20_inv, s21_inv, s22_inv, s23_inv;
  wire    [7:0]    s30_inv, s31_inv, s32_inv, s33_inv;
  wire    [127:0]  last_data;
  reg              dec_en_f;
  // Outputs
  assign data_out = rnd_data;
  assign rnd_data = last_data ^ rnd_key_in;
  // Internal registers
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      data_out_f    <= 128'd0;
      dec_en_f      <= 1'b0;
    end else begin
      data_out_f    <= data_out_nxt;
      dec_en_f      <= dec_en;
    end
  end
  always @ (data_out_f or data_ld or init_key or
            data_in or sub_rnd_mx or data_en) begin
    data_out_nxt             = data_out_f;
    if (data_ld | data_en) begin
      data_out_nxt = (data_in ^ init_key) & {128{data_ld}} | sub_rnd_mx & {128{data_en}};
    end
  end
  //
  assign sbox_in = data_out_f;
  //
  assign sub_rnd_mx    = dec_en_f ? sub_rnd_mxout_inv : (sub_rnd_mxout ^ rnd_key_in);
  assign sub_rnd_mxout = {clm3_out, clm2_out, clm1_out, clm0_out};
  assign sub_rnd_mxout_inv = {clm3_out_inv, clm2_out_inv, clm1_out_inv, clm0_out_inv};
  //
  assign clm0_in  = dec_en_f ? sbox_out_inv[31:0]  ^ rnd_key_in[31:0]   : {s33, s22, s11, s00};
  assign clm1_in  = dec_en_f ? sbox_out_inv[63:32] ^ rnd_key_in[63:32]  : {s30, s23, s12, s01};
  assign clm2_in  = dec_en_f ? sbox_out_inv[95:64] ^ rnd_key_in[95:64]  : {s31, s20, s13, s02};
  assign clm3_in  = dec_en_f ? sbox_out_inv[127:96]^ rnd_key_in[127:96] : {s32, s21, s10, s03};
  //
  assign {s30, s20, s10, s00} = sbox_out[31:0];
  assign {s31, s21, s11, s01} = sbox_out[63:32];
  assign {s32, s22, s12, s02} = sbox_out[95:64];
  assign {s33, s23, s13, s03} = sbox_out[127:96];
  //
  assign {s30_inv, s20_inv, s10_inv, s00_inv} = sbox_in[31:0];
  assign {s31_inv, s21_inv, s11_inv, s01_inv} = sbox_in[63:32];
  assign {s32_inv, s22_inv, s12_inv, s02_inv} = sbox_in[95:64];
  assign {s33_inv, s23_inv, s13_inv, s03_inv} = sbox_in[127:96];
  //
  assign sbox_in_inv[31:0]  = {s31_inv, s22_inv, s13_inv, s00_inv};
  assign sbox_in_inv[63:32] = {s32_inv, s23_inv, s10_inv, s01_inv};
  assign sbox_in_inv[95:64] = {s33_inv, s20_inv, s11_inv, s02_inv};
  assign sbox_in_inv[127:96]= {s30_inv, s21_inv, s12_inv, s03_inv};
  //
  assign last_data[31:0]   = dec_en_f ? sbox_out_inv[31:0]   : clm0_in;
  assign last_data[63:32]  = dec_en_f ? sbox_out_inv[63:32]  : clm1_in;
  assign last_data[95:64]  = dec_en_f ? sbox_out_inv[95:64]  : clm2_in;
  assign last_data[127:96] = dec_en_f ? sbox_out_inv[127:96] : clm3_in;
  // AES encrypt SBoxes
  aes_sbox u0_aes_sbox(
    .sbox_in (sbox_in[7:0]),
    .sbox_out(sbox_out[7:0])
  );
   aes_sbox u1_aes_sbox(
    .sbox_in (sbox_in[15:8]),
    .sbox_out(sbox_out[15:8])
  );
   aes_sbox u2_aes_sbox(
    .sbox_in (sbox_in[23:16]),
    .sbox_out(sbox_out[23:16])
  );
   aes_sbox u3_aes_sbox(
    .sbox_in (sbox_in[31:24]),
    .sbox_out(sbox_out[31:24])
  );
  aes_sbox u4_aes_sbox(
    .sbox_in (sbox_in[39:32]),
    .sbox_out(sbox_out[39:32])
  );
   aes_sbox u5_aes_sbox(
    .sbox_in (sbox_in[47:40]),
    .sbox_out(sbox_out[47:40])
  );
   aes_sbox u6_aes_sbox(
    .sbox_in (sbox_in[55:48]),
    .sbox_out(sbox_out[55:48])
  );
   aes_sbox u7_aes_sbox(
    .sbox_in (sbox_in[63:56]),
    .sbox_out(sbox_out[63:56])
  );
  aes_sbox u8_aes_sbox(
    .sbox_in (sbox_in[71:64]),
    .sbox_out(sbox_out[71:64])
  );
   aes_sbox u9_aes_sbox(
    .sbox_in (sbox_in[79:72]),
    .sbox_out(sbox_out[79:72])
  );
   aes_sbox u10_aes_sbox(
    .sbox_in (sbox_in[87:80]),
    .sbox_out(sbox_out[87:80])
  );
   aes_sbox u11_aes_sbox(
    .sbox_in (sbox_in[95:88]),
    .sbox_out(sbox_out[95:88])
  );
  aes_sbox u12_aes_sbox(
    .sbox_in (sbox_in[103:96]),
    .sbox_out(sbox_out[103:96])
  );
   aes_sbox u13_aes_sbox(
    .sbox_in (sbox_in[111:104]),
    .sbox_out(sbox_out[111:104])
  );
   aes_sbox u14_aes_sbox(
    .sbox_in (sbox_in[119:112]),
    .sbox_out(sbox_out[119:112])
  );
   aes_sbox u15_aes_sbox(
    .sbox_in (sbox_in[127:120]),
    .sbox_out(sbox_out[127:120])
  );
  // AES decrypt SBoxes
  aes_sbox_inv u0_aes_sbox_inv(
    .sbox_in (sbox_in_inv[7:0]),
    .sbox_out(sbox_out_inv[7:0])
  );
   aes_sbox_inv u1_aes_sbox_inv(
    .sbox_in (sbox_in_inv[15:8]),
    .sbox_out(sbox_out_inv[15:8])
  );
   aes_sbox_inv u2_aes_sbox_inv(
    .sbox_in (sbox_in_inv[23:16]),
    .sbox_out(sbox_out_inv[23:16])
  );
   aes_sbox_inv u3_aes_sbox_inv(
    .sbox_in (sbox_in_inv[31:24]),
    .sbox_out(sbox_out_inv[31:24])
  );
  aes_sbox_inv u4_aes_sbox_inv(
    .sbox_in (sbox_in_inv[39:32]),
    .sbox_out(sbox_out_inv[39:32])
  );
   aes_sbox_inv u5_aes_sbox_inv(
    .sbox_in (sbox_in_inv[47:40]),
    .sbox_out(sbox_out_inv[47:40])
  );
   aes_sbox_inv u6_aes_sbox_inv(
    .sbox_in (sbox_in_inv[55:48]),
    .sbox_out(sbox_out_inv[55:48])
  );
   aes_sbox_inv u7_aes_sbox_inv(
    .sbox_in (sbox_in_inv[63:56]),
    .sbox_out(sbox_out_inv[63:56])
  );
  aes_sbox_inv u8_aes_sbox_inv(
    .sbox_in (sbox_in_inv[71:64]),
    .sbox_out(sbox_out_inv[71:64])
  );
   aes_sbox_inv u9_aes_sbox_inv(
    .sbox_in (sbox_in_inv[79:72]),
    .sbox_out(sbox_out_inv[79:72])
  );
   aes_sbox_inv u10_aes_sbox_inv(
    .sbox_in (sbox_in_inv[87:80]),
    .sbox_out(sbox_out_inv[87:80])
  );
   aes_sbox_inv u11_aes_sbox_inv(
    .sbox_in (sbox_in_inv[95:88]),
    .sbox_out(sbox_out_inv[95:88])
  );
  aes_sbox_inv u12_aes_sbox_inv(
    .sbox_in (sbox_in_inv[103:96]),
    .sbox_out(sbox_out_inv[103:96])
  );
   aes_sbox_inv u13_aes_sbox_inv(
    .sbox_in (sbox_in_inv[111:104]),
    .sbox_out(sbox_out_inv[111:104])
  );
   aes_sbox_inv u14_aes_sbox_inv(
    .sbox_in (sbox_in_inv[119:112]),
    .sbox_out(sbox_out_inv[119:112])
  );
   aes_sbox_inv u15_aes_sbox_inv(
    .sbox_in (sbox_in_inv[127:120]),
    .sbox_out(sbox_out_inv[127:120])
  );
  //
  aes_mx_clm u0_aes_mx_clm (
    .clm_in     (clm0_in),
    .clm_out    (clm0_out),
    .clm_out_inv(clm0_out_inv)
  );
  aes_mx_clm u1_aes_mx_clm (
    .clm_in     (clm1_in),
    .clm_out    (clm1_out),
    .clm_out_inv(clm1_out_inv)
  );
  aes_mx_clm u2_aes_mx_clm (
    .clm_in     (clm2_in),
    .clm_out    (clm2_out),
    .clm_out_inv(clm2_out_inv)
  );
  aes_mx_clm u3_aes_mx_clm (
    .clm_in     (clm3_in),
    .clm_out    (clm3_out),
    .clm_out_inv(clm3_out_inv)
  );

endmodule
