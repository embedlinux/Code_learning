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

import MDIO_M::*;
import MDIO_S::*;
import PACKET::*;
typedef bit [7:0]    bit8;
typedef bit8 packet[$];

program test ();
  initial begin
    int unsigned rdPtr, address;
    int dataOut, dataIn;
    int loopNum;
    int unsigned rdPtrArr[$];
    int unsigned expData[$];
    //
    MDIO_m_env mdio_m;
    MDIO_s_env mdio_s, mdio_s1, mdio_s2;
    Packet pkt = new();
    Checker chk = new();
    // Create MDIO master
    mdio_m    = new(testbench_top.mdio_m_if_0);
    // Create MDIO slaves
    mdio_s    = new(testbench_top.mdio_s_if_0);
    mdio_s1   = new(testbench_top.mdio_s_if_1);
    mdio_s2   = new(testbench_top.mdio_s_if_2);
    // Start master and slave vips
    mdio_m.startEnv();
    mdio_s.startEnv();
    mdio_s1.startEnv();
    mdio_s2.startEnv();
    mdio_m.setRndDelay(0, 10);
    mdio_s.setMemCleanMode(3);
    mdio_s1.setMemCleanMode(3);
    mdio_s2.setMemCleanMode(3);
    // Set PHY address and device type for each slave
    mdio_s.setAddr(0, 0);
    mdio_s1.setAddr(16, 16);
    mdio_s2.setAddr(17, 17);
    // Wait several clocks
    repeat (10) @(posedge testbench_top.clk);
    loopNum = 2000;
    // Master read/write.
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      mdio_m.writeAddr(0, 0, address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(0, 0, dataIn);
      mdio_m.readWord(rdPtr, 0, 0);
      mdio_m.getWord(rdPtr, dataOut);
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
    end
    // Master read/write. Using poll function.
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      mdio_m.writeAddr(0, 0, address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(0, 0, dataIn);
      mdio_m.pollWord(0, 0, address, dataIn);
      if(chk.CheckWord(0, 0) == -1) $finish;
    end
    // Master write slave read.
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      mdio_m.writeAddr(0, 0, address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(0, 0, dataIn);
      mdio_m.mdioDone();
      mdio_s.getWord(address, dataOut);
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
    end
    // Master write slave read. Using poll function.
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      mdio_m.writeAddr(0, 0, address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(0, 0, dataIn);
      if(chk.CheckWord(0, 0) == -1) $finish;
      mdio_s.pollWord(address, dataIn);
    end
    // Slave write master read.
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_s.putWord(address, dataIn);
      mdio_m.writeAddr(0, 0, address);
      mdio_m.readWord(rdPtr, 0, 0);
      mdio_m.getWord(rdPtr, dataOut);
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
    end
    // Slave write master read. Using poll function.
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_s.putWord(address, dataIn);
      if(chk.CheckWord(0, 0) == -1) $finish;
      mdio_m.pollWord(0, 0, address, dataIn);
    end
    // Master read/write. Testing read with address increment
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      for(int i = 0; i < 20; i++) begin
        mdio_m.writeAddr(0, 0, address+i);
        $display("Address is %h", (address+i));
        dataIn = pkt.genRndNum(0, 'hffff);
        $display("Data is %h", dataIn);
        mdio_m.writeWord(0, 0, dataIn);
        expData.push_back(dataIn);
      end
      mdio_m.writeAddr(0, 0, address);
      for(int i = 0; i < 20; i++) begin
        mdio_m.readWord(rdPtr, 0, 0, 1);
        rdPtrArr.push_back(rdPtr);
      end
      for(int i = 0; i < 20; i++) begin
        rdPtr = rdPtrArr.pop_front();
        mdio_m.getWord(rdPtr, dataOut);
        dataIn = expData.pop_front();
        if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
      end
    end
    // Test memory clean
    for(int memClean = 0; memClean < 4; memClean++) begin
      mdio_s.setMemCleanMode(memClean);
      // Master read/write.
      repeat(loopNum) begin
        address = pkt.genRndNum(0, 'hffff);
        $display("Address is %h", address);
        mdio_m.writeAddr(0, 0, address);
        dataIn = pkt.genRndNum(0, 'hffff);
        $display("Data is %h", dataIn);
        mdio_m.writeWord(0, 0, dataIn);
        mdio_m.readWord(rdPtr, 0, 0);
        mdio_m.getWord(rdPtr, dataOut);
        if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
      end
      // Master write slave read. Using poll function.
      repeat(loopNum) begin
        address = pkt.genRndNum(0, 'hffff);
        $display("Address is %h", address);
        mdio_m.writeAddr(0, 0, address);
        dataIn = pkt.genRndNum(0, 'hffff);
        $display("Data is %h", dataIn);
        mdio_m.writeWord(0, 0, dataIn);
        if(chk.CheckWord(0, 0) == -1) $finish;
        mdio_s.pollWord(address, dataIn);
      end
    end
    // Test different PHY address and Device type
    for(int i = 0; i < loopNum; i++) begin
      int phyAddr, devType;
      phyAddr = $urandom_range(0, 15);
      devType = $urandom_range(0, 15);
      mdio_s.setAddr(phyAddr, devType);
      // Master read/write.
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      mdio_m.writeAddr(phyAddr, devType, address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(phyAddr, devType, dataIn);
      mdio_m.readWord(rdPtr, phyAddr, devType);
      mdio_m.getWord(rdPtr, dataOut);
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
    end
    // Test read/write to the different slaves.
    expData.delete();
    mdio_s.setAddr(0, 0);
    repeat(loopNum) begin
      // Select first slave
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      mdio_m.writeAddr(0, 0, address);
      // Select second slave and write the same address
      mdio_m.writeAddr(16, 16, address);
      // Select third slave and write the same address
      mdio_m.writeAddr(17, 17, address);
      // Select first slave and write random data
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(0, 0, dataIn);
      expData.push_back(dataIn);
      // Select second slave and write random data
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(16, 16, dataIn);
      expData.push_back(dataIn);
      // Select third slave and write random data
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(17, 17, dataIn);
      expData.push_back(dataIn);
      // Select first slave and read data.
      mdio_m.readWord(rdPtr, 0, 0, 1);
      mdio_m.getWord(rdPtr, dataOut);
      dataIn = expData.pop_front();
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
      // Select second slave and read data.
      mdio_m.readWord(rdPtr, 16, 16, 1);
      mdio_m.getWord(rdPtr, dataOut);
      dataIn = expData.pop_front();
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
      // Select third slave and read data.
      mdio_m.readWord(rdPtr, 17, 17, 1);
      mdio_m.getWord(rdPtr, dataOut);
      dataIn = expData.pop_front();
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
    end
    // Test Clause 22 (ST == 2'b01) mode.
    mdio_s.setAddr(10, 5);
    repeat(loopNum) begin
      int dummyData;
      mdio_m.setST(1);
      address = pkt.genRndNum(0, 'h1f);
      $display("Address is %h", address);
      // Select first slave and write random data.
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(10, address, dataIn);
      mdio_m.mdioDone();
      mdio_s.getWord(address, dataOut);
      if(chk.CheckWord(dataOut, dataIn) == -1) $finish;
      address = pkt.genRndNum(0, 'h1f);
      $display("Address is %h", address);
      // Select first slave and write random data.
      dataIn = pkt.genRndNum(0, 'hffff);
      dummyData = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(10, address, dataIn);
      mdio_m.pollWord(10, address, dummyData, dataIn);
      if(chk.CheckWord(0, 0) == -1) $finish;
    end
    // Master write slave read. Using poll function.
    mdio_m.setST(0);
    mdio_s.setAddr(4, 7);
    repeat(loopNum) begin
      address = pkt.genRndNum(0, 'hffff);
      $display("Address is %h", address);
      mdio_m.writeAddr(4, 7, address);
      dataIn = pkt.genRndNum(0, 'hffff);
      $display("Data is %h", dataIn);
      mdio_m.writeWord(4, 7, dataIn);
      if(chk.CheckWord(0, 0) == -1) $finish;
      mdio_s.pollWord(address, dataIn);
    end
    // Wait several clocks
    repeat (10) @testbench_top.mdio_m_if_0.cb;
    //
    $display("--------------------------------------------------------");
    if ((mdio_m.printStatus() != 0) || (mdio_s.printStatus() != 0) |
        (mdio_s1.printStatus() != 0) || (mdio_s2.printStatus() != 0)) begin
      $display("----------------Unexpected errors detected--------------");
    end else begin
      $display("---------------No Unexpected errors detected---------------");
    end
    $display("-----------------------Test Done------------------------");
    $display("------------------Printing Test Status------------------");
    $display("--------------------------------------------------------");
    chk.printFullStatus();
    $display("--------------------------------------------------------");
    //
  end
endprogram
