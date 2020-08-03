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
  bit reset_n;
  // Clock generator
  initial begin
    forever #5 clk = ~clk;
  end
  // Reset generator. Reset is active low
  initial begin
    reset_n = 1'b1;
    repeat(3) @(posedge clk);
    #1
    reset_n = 1'b0;
    @(posedge clk);
    #1
    reset_n = 1'b1;
  end
  // APB master interface
  apb_m_if apb_m_if_0 (
    clk
  );
  // DUT. AES crypto engine with APB slave interface
  aes_s_apb aes_s_apb (
    .clk    (clk),
    .reset_n(reset_n),
    .psel   (apb_m_if_0.psel),
    .penable(apb_m_if_0.penable),
    .pwrite (apb_m_if_0.pwrite),
    .paddr  (apb_m_if_0.paddr[4:0]),
    .pwdata (apb_m_if_0.pwdata),
    .prdata (apb_m_if_0.prdata),
    .pready (apb_m_if_0.pready),
    .pslverr(apb_m_if_0.pslverr)
  );
  // Test
  test u_test(.apb_ifc(apb_m_if_0));

endmodule
