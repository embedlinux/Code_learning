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
  wire  mdio;
  initial begin
    forever #5 clk = ~clk;
  end
  // Connect multiple slaves to the MDIO bus
  assign mdio = mdio_m_if_0.mdo_en ? mdio_m_if_0.mdo : 1'bz;
  assign mdio = mdio_s_if_0.mdo_en ? mdio_s_if_0.mdo : 1'bz;
  assign mdio = mdio_s_if_1.mdo_en ? mdio_s_if_1.mdo : 1'bz;
  assign mdio = mdio_s_if_2.mdo_en ? mdio_s_if_2.mdo : 1'bz;
  assign mdio_m_if_0.mdi = mdio;
  assign mdio_s_if_0.mdi = mdio;
  assign mdio_s_if_1.mdi = mdio;
  assign mdio_s_if_2.mdi = mdio;
  // MDIO master interface
  mdio_m_if mdio_m_if_0(clk);
  // MDIO slave interfaces
  mdio_s_if mdio_s_if_0(mdio_m_if_0.mdc);
  mdio_s_if mdio_s_if_1(mdio_m_if_0.mdc);
  mdio_s_if mdio_s_if_2(mdio_m_if_0.mdc);
  // Test
  test u_test();

endmodule
