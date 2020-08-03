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

interface apb_m_if (input bit clk);

  logic  [31:0] paddr;
  logic  [31:0] pwdata;
  logic  [31:0] prdata;
  logic  psel;
  logic  penable;
  logic  pwrite;
  logic  pready;
  logic  pslverr;

  sequence sync_posedge;
     @(posedge clk) 1;
  endsequence

  clocking cb @(posedge clk);
    output pwdata;
    output paddr;
    output psel, penable, pwrite;
    input  prdata;
    input  pready;
    input  pslverr;
  endclocking

  task clockAlign();
    wait(sync_posedge.triggered);
  endtask

endinterface
