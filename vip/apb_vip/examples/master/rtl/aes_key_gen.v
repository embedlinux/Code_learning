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

module aes_key_gen (
  clk,
  reset_n,
  key_in,
  key_ld,
  key_en,
  rnd_num,
  dec_en,
  key_out
);
  // Inputs and outputs
  input             clk;
  input             reset_n;
  input   [127:0]   key_in;
  output  [127:0]   key_out;
  input             key_ld;
  input             key_en;
  input             dec_en;
  input   [3:0]     rnd_num;
  // Internal variables
  reg     [127:0]   key_rnd_f;
  reg     [127:0]   key_rnd_nxt;
  reg     [7:0]     rcon, rcon_inv;
  wire    [7:0]     sbox0_out, sbox1_out, sbox2_out, sbox3_out;
  wire    [31:0]    sbox_in;
  wire    [31:0]    w0, w1, w2, w3;
  wire    [31:0]    w0_nxt, w1_nxt, w2_nxt, w3_nxt;
  wire    [31:0]    w3_nxt_dec, w2_nxt_dec, w1_nxt_dec, w0_nxt_dec;
  wire    [127:0]   key_int_inv;
  reg               dec_en_f;
  // Outputs
  assign key_out = dec_en_f ? key_rnd_f : {w3_nxt, w2_nxt, w1_nxt, key_rnd_f[31:0]};
  // Internal registers
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      key_rnd_f     <= 128'd0;
      dec_en_f      <= 1'b0;
    end else begin
      key_rnd_f     <= key_rnd_nxt;
      dec_en_f      <= dec_en;
    end
  end
  // Round key for encrypt or decrypt
  always @ (key_rnd_f or w1 or w2 or w3 or w0_nxt or key_en or
            w0 or w3_nxt_dec or w2_nxt_dec or
            w1_nxt_dec or w0_nxt_dec or dec_en) begin

    key_rnd_nxt     = key_rnd_f;
    if (key_en) begin
      key_rnd_nxt     = dec_en ? {w3_nxt_dec, w2_nxt_dec, w1_nxt_dec, w0_nxt_dec} : {w3, w2, w1, w0_nxt};
    end
  end

  assign key_int_inv = key_ld ? key_in : key_rnd_f;
  assign w0 = key_ld ? key_in[31:0]  : key_rnd_f[31:0];
  assign w1 = key_ld ? key_in[63:32] : w1_nxt;
  assign w2 = key_ld ? key_in[95:64] : w2_nxt;
  assign w3 = key_ld ? key_in[127:96]: w3_nxt;
  assign sbox_in = dec_en ? w3_nxt_dec : w3;
  assign w0_nxt[7:0] = sbox0_out ^ rcon ^ w0[7:0];
  assign w0_nxt[31:8]= {sbox3_out, sbox2_out, sbox1_out} ^ w0[31:8];
  assign w1_nxt = key_rnd_f[31:0] ^ key_rnd_f[63:32];
  assign w2_nxt = w1_nxt ^ key_rnd_f[95:64];
  assign w3_nxt = w2_nxt ^ key_rnd_f[127:96];
  assign w3_nxt_dec = key_int_inv[127:96] ^ key_int_inv[95:64];
  assign w2_nxt_dec = key_int_inv[95:64]  ^ key_int_inv[63:32];
  assign w1_nxt_dec = key_int_inv[31:0]   ^ key_int_inv[63:32];
  assign w0_nxt_dec[7:0] = key_int_inv[7:0] ^ sbox0_out ^ rcon_inv;
  assign w0_nxt_dec[31:8] = {sbox3_out, sbox2_out, sbox1_out} ^ key_int_inv[31:8];

  // Rcon generation from round number for encrypt
  always @ (rnd_num) begin
    case (rnd_num)
      4'd0: rcon = 8'h01;
      4'd1: rcon = 8'h02;
      4'd2: rcon = 8'h04;
      4'd3: rcon = 8'h08;
      4'd4: rcon = 8'h10;
      4'd5: rcon = 8'h20;
      4'd6: rcon = 8'h40;
      4'd7: rcon = 8'h80;
      4'd8: rcon = 8'h1b;
      default: rcon = 8'h36;
    endcase
  end
  // Rcon generation from round number for decrypt
  always @ (rnd_num) begin
    case (rnd_num)
      4'd0: rcon_inv = 8'h36;
      4'd1: rcon_inv = 8'h1b;
      4'd2: rcon_inv = 8'h80;
      4'd3: rcon_inv = 8'h40;
      4'd4: rcon_inv = 8'h20;
      4'd5: rcon_inv = 8'h10;
      4'd6: rcon_inv = 8'h08;
      4'd7: rcon_inv = 8'h04;
      4'd8: rcon_inv = 8'h02;
      default: rcon_inv = 8'h01;
    endcase
  end
  // AES encrypt SBoxes
  aes_sbox u0_aes_sbox(
    .sbox_in (sbox_in[7:0]),
    .sbox_out(sbox3_out)
  );
  aes_sbox u1_aes_sbox(
    .sbox_in (sbox_in[15:8]),
    .sbox_out(sbox0_out)
  );
  aes_sbox u2_aes_sbox(
    .sbox_in (sbox_in[23:16]),
    .sbox_out(sbox1_out)
  );
  aes_sbox u3_aes_sbox(
    .sbox_in (sbox_in[31:24]),
    .sbox_out(sbox2_out)
  );
  //
endmodule
