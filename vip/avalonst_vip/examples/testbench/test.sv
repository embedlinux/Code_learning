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

import AVALONST_M::*;
import AVALONST_S::*;
import PACKET::*;
typedef bit [7:0]    bit8;
typedef bit8 packet[$];

program test ();
  initial begin
    //
    packet dataIn, expData, dataOut;
    int addr;
    int trErrors, trExpErrors;
    int itrNum, checkStatus;
    //
    AVALONST_m_env avalonst_m;
    AVALONST_s_env avalonst_s;
    Packet pkt = new();
    Checker chk = new();
    itrNum = 100;
    // Create AVALONST master
    avalonst_m    = new(testbench_top.avalon_st_m_if_0, 16);
    // Create AVALONST slave
    avalonst_s   = new(testbench_top.avalon_st_s_if_0, 16);
    // Start master and slave vips
    avalonst_m.startEnv();
    avalonst_s.startEnv();
    //
    avalonst_m.setRndDelay(0, 10, 0, 10);
    //avalonst_m.setTimeOut(0, 3);
    avalonst_s.setRndDelay(0, 10);
    avalonst_m.setEndian(0);
    avalonst_s.setEndian(0);
    avalonst_m.setPacketConfig(1, 1, 0);
    trExpErrors = 0;
    // Wait several clocks to be sure that DUT is ready
    repeat (10) @(posedge testbench_top.clk);
    // Master read/write
    repeat (itrNum) begin
      for (int i = 1; i < 10; i++) begin
        pkt.genRndPkt(pkt.genRndNum(i, i), dataIn);
        $display("Length  == %d", dataIn.size());
        avalonst_m.writeData(dataIn );
        avalonst_s.readData(dataOut );
        //pkt.PrintPkt("Data In", dataIn);
        checkStatus = chk.CheckPkt(dataOut, dataIn);
        if(checkStatus == -1) $finish;
      end
      for (int i = 10; i > 0; i--) begin
        pkt.genRndPkt(pkt.genRndNum(i, i), dataIn);
        $display("Length  == %d", dataIn.size());
        avalonst_m.writeData(dataIn );
        avalonst_s.readData(dataOut );
        chk.CheckPkt(dataOut, dataIn);
      end
      for (int i = 500; i > 0; i--) begin
        pkt.genRndPkt(pkt.genRndNum(1, 500), dataIn);
        $display("Length  == %d", dataIn.size());
        avalonst_m.writeData(dataIn );
        avalonst_s.readData(dataOut );
        chk.CheckPkt(dataOut, dataIn);
      end
    end
    avalonst_m.busIdle(10);
    avalonst_m.waitCommandDone();
    //
    repeat (5) @testbench_top.avalon_st_m_if_0.cb;
    //
    trErrors = avalonst_m.printStatus();
    avalonst_s.printStatus();
    $display("-----------------------Test Done------------------------");
    $display("------------------Printing Test Status------------------");
    if (trErrors == trExpErrors) begin
      $display("-Transactions have 0 unexpected TimeOut or Slave Errors-");
    end else begin
      $display("--Transactions have unexpected TimeOut or Slave Errors--");
      $display("Expected  error amount is %d", trExpErrors);
      $display("Generated error amount is %d", trErrors);
    end
    $display("--------------------------------------------------------");
    chk.printFullStatus();
    $display("--------------------------------------------------------");
    //
  end
endprogram
