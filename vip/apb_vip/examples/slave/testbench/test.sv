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

import APB_S::*;
import APB_M::*;
import PACKET::*;
import TESTENV::*;

typedef bit[31:0] bit32;
typedef bit[7:0] bit8;
typedef bit8 packet[$];

program test (apb_s_if apb_ifc_s, apb_m_if apb_ifc_m);
  initial begin
    //
    packet pktIn0, pktIn1, pktOut, pktExp;
    int pktLength;
    bit32 inAddr0, inAddr1, outAddr;
    // Create APB vip and test environment objects
    ABP_m_env apb_m = new(apb_ifc_m);
    ABP_s_env apb_s = new(apb_ifc_s);
    Packet pkt = new();
    Checker chk = new();
    TestEnv env = new(apb_ifc_m, apb_m, apb_s);
    // Start test environment
    apb_m.startEnv();
    apb_s.startEnv();
    apb_m.rndDelayEn(0, 5, 0, 15);
    apb_s.rndDelayEn(0, 100);
    // Run DUT. This will emulate DUT. APB Master
    env.runMaster();

    repeat (1000) begin
      // Generating random packets and addresses
      pktLength = pkt.genRndNum(1, 1000, 4);
      pkt.genRndPkt(pktLength, pktIn0);
      pkt.genRndPkt(pktLength, pktIn1);
      inAddr0 = pkt.genRndNum(100, 'hfffff000);
      inAddr1 = inAddr0 + pktLength;
      outAddr = inAddr1 + pktLength;
      $display("Length == %d bytes", pktLength);
      // Writing APB slave internal memory
      apb_s.putData(inAddr0, pktIn0);
      apb_s.putData(inAddr1, pktIn1);
      apb_s.putWord(4, inAddr0);
      apb_s.putWord(8, inAddr1);
      apb_s.putWord(12,outAddr);
      apb_s.putWord(16,pktLength);
      apb_s.putWord(0, 'h98765432);
      // Polling memory. Waiting for DUT (APB master) is done
      apb_s.pollWord(20, 'h32323232);
      apb_s.putWord(20, 0);
      // Get data for internal memory
      apb_s.getData(outAddr, pktOut, pktLength);
      // Create expected packet
      pktExp = {};
      for (int i = 0; i < pktLength; i++) begin
        bit8 tempData;
        tempData = pktIn0[i]^pktIn1[i];
        pktExp = {pktExp, tempData};
      end
      // Check got packet with expected one. Message will be printed out. (Pass or Fail)
      void'(chk.CheckPkt(pktOut, pktExp));
    end
    // Finish test. Print all errors amoumt.
    env.testFinish();
    //
  end
endprogram
