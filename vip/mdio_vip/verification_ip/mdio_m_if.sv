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

interface mdio_m_if(input bit clk);
  // Master MDIO (STA) signals
  logic  mdi;
  logic  mdo;
  logic  mdo_en;
  logic  mdc;
  // Clock edge alignment
  sequence sync_negedge;
     @(negedge clk) 1;
  endsequence
  // Clocking block
  clocking cb @(negedge clk);
    output mdo;
    output mdo_en;
    input  mdi;
  endclocking
  // Clock edge alignment
  task clockAlign();
    wait(sync_negedge.triggered);
  endtask
  // MDC. MDIO output clock.
  always @* mdc <= clk;
  //
endinterface
