/*
Copyright (C) 2012 SysWip

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
  assign avalon_s_if_0.address            = avalon_m_if_0.address;
  assign avalon_s_if_0.byteenable         = avalon_m_if_0.byteenable;
  assign avalon_s_if_0.chipselect         = avalon_m_if_0.chipselect;
  assign avalon_s_if_0.read               = avalon_m_if_0.read;
  assign avalon_s_if_0.write              = avalon_m_if_0.write;
  assign avalon_s_if_0.writedata          = avalon_m_if_0.writedata;
  assign avalon_s_if_0.burstcount         = avalon_m_if_0.burstcount;
  assign avalon_s_if_0.beginbursttransfer = avalon_m_if_0.beginbursttransfer;
  assign avalon_m_if_0.readdata           = avalon_s_if_0.readdata;
  assign avalon_m_if_0.waitrequest        = avalon_s_if_0.waitrequest;
  assign avalon_m_if_0.readdatavalid      = avalon_s_if_0.readdatavalid;
    
  // Avalon MM master interface
  avalon_m_if avalon_m_if_0(clk);
  // Avalon MM slave interface
  avalon_s_if avalon_s_if_0(clk);
  // Test
  test u_test();

endmodule
