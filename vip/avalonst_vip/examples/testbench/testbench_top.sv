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

module testbench_top;
  // Clock generator
  bit clk;
  initial begin
    forever #5 clk = ~clk;
  end
  //
  assign avalon_st_m_if_0.ready         = avalon_st_s_if_0.ready;
  assign avalon_st_s_if_0.valid         = avalon_st_m_if_0.valid;
  assign avalon_st_s_if_0.data          = avalon_st_m_if_0.data;
  assign avalon_st_s_if_0.startofpacket = avalon_st_m_if_0.startofpacket;
  assign avalon_st_s_if_0.endofpacket   = avalon_st_m_if_0.endofpacket;
  assign avalon_st_s_if_0.empty         = avalon_st_m_if_0.empty;
  // Avalon master(source) interface
  avalon_st_m_if avalon_st_m_if_0(clk);
  // Avalon slave(sink) interface
  avalon_st_s_if avalon_st_s_if_0(clk);
  // Test
  test u_test();

endmodule
