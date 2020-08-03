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

module aes_mx_clm (
  clm_in,
  clm_out,
  clm_out_inv
);
  //
  input  [31:0] clm_in;
  output [31:0] clm_out, clm_out_inv;
  //
  wire [7:0] l_00, l_01, l_02, l_03;
  wire [7:0] l_10, l_11, l_12, l_13;
  wire [7:0] l_20, l_21, l_22, l_23;
  wire [7:0] l_00_d, l_01_d;
  wire [7:0] l_10_d;
  wire [7:0] l_20_d, l_21_d, l_22_d, l_23_d;
  wire [7:0] x4time_00, x4time_01;
  wire [7:0] l_30_d, l_31_d, l_32_d, l_33_d;

  assign l_00 = clm_in[7:0]   ^ clm_in[15:8];
  assign l_01 = clm_in[23:16] ^ clm_in[15:8];
  assign l_02 = clm_in[23:16] ^ clm_in[31:24];
  assign l_03 = clm_in[7:0]   ^ clm_in[31:24];
  //
  assign l_10 = clm_in[15:8]  ^ l_02;
  assign l_11 = clm_in[7:0]   ^ l_02;
  assign l_12 = clm_in[31:24] ^ l_00;
  assign l_13 = clm_in[23:16] ^ l_00;
  //
  assign l_20 = xtime(l_00) ^ l_10;
  assign l_21 = xtime(l_01) ^ l_11;
  assign l_22 = xtime(l_02) ^ l_12;
  assign l_23 = xtime(l_03) ^ l_13;
  //
  assign clm_out[7:0]   = l_20;
  assign clm_out[15:8]  = l_21;
  assign clm_out[23:16] = l_22;
  assign clm_out[31:24] = l_23;
  //
  assign l_00_d         = clm_in[31:24] ^ clm_in[15:8];
  assign l_01_d         = clm_in[7:0]   ^ clm_in[23:16];
  assign l_10_d         = xtime_x4time(l_00_d) ^ xtime_x4time(l_01_d);
  //
  assign x4time_00      = x4time(l_00_d);
  assign x4time_01      = x4time(l_01_d);
  //
  assign l_20_d         = l_23 ^ x4time_00;
  assign l_21_d         = l_22 ^ x4time_01;
  assign l_22_d         = l_21 ^ x4time_00;
  assign l_23_d         = l_20 ^ x4time_01;
  //
  assign l_30_d         = l_10_d ^ l_20_d;
  assign l_31_d         = l_10_d ^ l_21_d;
  assign l_32_d         = l_10_d ^ l_22_d;
  assign l_33_d         = l_10_d ^ l_23_d;
  //
  assign clm_out_inv[7:0]  = l_33_d;
  assign clm_out_inv[15:8] = l_32_d;
  assign clm_out_inv[23:16]= l_31_d;
  assign clm_out_inv[31:24]= l_30_d;
  //
  function [7:0] xtime;
    input [7:0] din;
    begin
      xtime[0] = din[7];
      xtime[1] = din[7] ^ din[0];
      xtime[2] = din[1];
      xtime[3] = din[7] ^ din[2];
      xtime[4] = din[7] ^ din[3];
      xtime[5] = din[4];
      xtime[6] = din[5];
      xtime[7] = din[6];
    end
  endfunction
  //
  function [7:0] x4time;
    input [7:0] din;
    begin
      x4time[0] = din[6];
      x4time[1] = din[7] ^ din[6];
      x4time[2] = din[0] ^ din[7];
      x4time[3] = din[1] ^ din[6];
      x4time[4] = din[2] ^ x4time[1];
      x4time[5] = din[3] ^ din[7];
      x4time[6] = din[4];
      x4time[7] = din[5];
    end
  endfunction
  //
  function [7:0] xtime_x4time;
    input [7:0] din;
    begin
      xtime_x4time[0] = din[5];
      xtime_x4time[1] = din[5] ^ din[6];
      xtime_x4time[2] = din[6] ^ din[7];
      xtime_x4time[3] = din[5] ^ din[7] ^ din[0];
      xtime_x4time[4] = din[5] ^ din[6] ^ din[1];
      xtime_x4time[5] = din[2] ^ xtime_x4time[2];
      xtime_x4time[6] = din[3] ^ din[7];
      xtime_x4time[7] = din[4];
    end
  endfunction
  //
endmodule
