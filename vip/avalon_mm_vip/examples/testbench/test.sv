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

import AVALON_M::*;
import AVALON_S::*;
import PACKET::*;
typedef bit [7:0] bit8;

program test ();
  initial begin
    bit8 dataIn[], dataOut[];
    int unsigned address;
    int loopNum;
    //
    Avalon_m_env avalon_m;
    Avalon_s_env avalon_s;
    Packet pkt = new();
    Checker chk = new();
    // Create Avalon master
    avalon_m    = new("Avalon master", testbench_top.avalon_m_if_0, 4);
    // Create Avalon slave
    avalon_s    = new("Avalon slave", testbench_top.avalon_s_if_0, 4);
    // Start master and slave vips
    avalon_m.startEnv();
    avalon_s.startEnv();
    avalon_m.setRandDelay(0, 10, 0, 10);
    avalon_s.setRandDelay(0, 5, 0, 5); // wait request and output valid delays
    // Wait several clocks
    repeat (10) @(posedge testbench_top.clk);
    loopNum = 5000;
    // Master write slave read. Polling.
    repeat(loopNum) begin
      pkt.genRndPkt(pkt.genRndNum(1, 50), dataIn);
      address = pkt.genRndNum(0, 32'hffffffff);
      $display("Data Length is %d bytes", dataIn.size());
      $display("Address is %h", address);
      avalon_m.writeData(address, dataIn);
      avalon_s.pollData(address, dataIn, 10000);
      if(chk.CheckPkt(dataIn, dataIn) == -1) $finish;
    end
    // Slave write master read. Polling.
    repeat(loopNum) begin
      pkt.genRndPkt(pkt.genRndNum(1, 50), dataIn);
      address = pkt.genRndNum(0, 32'hffffffff);
      $display("Data Length is %d bytes", dataIn.size());
      $display("Address is %h", address);
      avalon_s.putData(address, dataIn);
      avalon_m.pollData(address, dataIn);
      if(chk.CheckPkt(dataIn, dataIn) == -1) $finish;
    end
    // Master write master read.
    repeat(loopNum) begin
      pkt.genRndPkt(pkt.genRndNum(1, 50), dataIn);
      address = pkt.genRndNum(0, 32'hffffffff);
      $display("Data Length is %d bytes", dataIn.size());
      $display("Address is %h", address);
      pkt.PrintPkt("Data in ", dataIn);
      avalon_m.writeData(address, dataIn);
      avalon_m.busIdle(5);
      avalon_m.waitCommandDone();
      avalon_m.readData(address, dataIn.size());
      avalon_m.getData(dataIn.size(), dataOut);
      pkt.PrintPkt("Data Out ", dataOut);
      if(chk.CheckPkt(dataOut, dataIn) == -1) begin
        repeat (10) @(posedge testbench_top.clk);
        $finish;
      end
    end
    // Master write master read. Poll.
    repeat(loopNum) begin
      pkt.genRndPkt(pkt.genRndNum(1, 50), dataIn);
      address = pkt.genRndNum(0, 32'hffffffff);
      $display("Data Length is %d bytes", dataIn.size());
      $display("Address is %h", address);
      pkt.PrintPkt("Data in ", dataIn);
      avalon_m.writeData(address, dataIn);
      avalon_m.pollData(address, dataIn);
      if(chk.CheckPkt(dataIn, dataIn) == -1) begin // For check increment
        repeat (10) @(posedge testbench_top.clk);
        $finish;
      end
    end
    // Master write burst. Slave read polling.
    repeat(loopNum) begin
      pkt.genRndPkt(pkt.genRndNum(1, 50), dataIn);
      address = pkt.genRndNum(0, 32'hffffffff);
      $display("Data Length is %d bytes", dataIn.size());
      $display("Address is %h", address);
      avalon_m.writeData(address, dataIn, 1);
      avalon_s.pollData(address, dataIn, 10000);
      if(chk.CheckPkt(dataIn, dataIn) == -1) $finish;
    end
    // Slave write master read burst.
    repeat(loopNum) begin
      pkt.genRndPkt(pkt.genRndNum(1, 50), dataIn);
      address = pkt.genRndNum(0, 32'hffffffff);
      $display("Data Length is %d bytes", dataIn.size());
      $display("Address is %h", address);
      avalon_s.putData(address, dataIn);
      avalon_m.readData(address, dataIn.size(), 1);
      avalon_m.getData(dataIn.size(), dataOut);
      if(chk.CheckPkt(dataIn, dataIn) == -1) $finish;
    end
    // Wait several clocks
    repeat (10) @(posedge testbench_top.clk);
    //
    $display("--------------------------------------------------------");
    avalon_m.printStatus();
    avalon_s.printStatus();
    $display("-----------------------Test Done------------------------");
    $display("------------------Printing Test Status------------------");
    $display("--------------------------------------------------------");
    chk.printFullStatus();
    $display("--------------------------------------------------------");
    //
  end
endprogram
