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
  // Clock and reset
  bit clk;
  // Clock generator
  initial begin
    forever #5 clk = ~clk;
  end
  // APB slave interface
  apb_s_if apb_s_if_0 (
    clk
  );
  // APB master interface
  apb_m_if apb_m_if_0 (
    clk
  );
  assign apb_s_if_0.psel    = apb_m_if_0.psel;
  assign apb_s_if_0.penable = apb_m_if_0.penable;
  assign apb_s_if_0.pwdata  = apb_m_if_0.pwdata;
  assign apb_s_if_0.paddr   = apb_m_if_0.paddr;
  assign apb_s_if_0.pwrite  = apb_m_if_0.pwrite;
  assign apb_m_if_0.prdata  = apb_s_if_0.prdata;
  assign apb_m_if_0.pready  = apb_s_if_0.pready;
  assign apb_m_if_0.pslverr = apb_s_if_0.pslverr;
  // Test
  test u_test(.apb_ifc_s(apb_s_if_0), .apb_ifc_m(apb_m_if_0));

endmodule
