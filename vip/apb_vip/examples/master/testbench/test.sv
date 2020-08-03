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

import TESTENV::*;
import APB_M::*;

program test (apb_m_if apb_ifc);
  initial begin
    //
    int  startTime, simTime;
    real clockCycles[2];
    // Create APB vip and test environment objects
    ABP_m_env apb = new(apb_ifc);
    TestEnv   env = new(apb_ifc, apb);
    // Start test environment
    env.testStart();
    // Set APB pready signal time out to 14 clock cylce.
    apb.setPreadyTimeOut(14);
    // Test all lengths between 1 to 100 blocks. 1 block is 16 bytes.
    repeat(2) begin
      for (int i = 16; i < 1601; i+=16)begin
        // Encrypt
        env.PktProc(1, i, i, 0);
        // Decrypt
        env.PktProc(1, i, i, 1);
      end
      // Start random tests.
      env.PktProc(1000, 16, 16*50, 2, 0);
      env.PktProc(1000, 16, 16*50, 2, 1);
      // Will generate random read/write transactions with wron address.
      // Slave error messages will be printed out
      env.PktProc(1000, 16, 16*50, 2, 2);
      // Set APB bus timing random delays.
      apb.rndDelayEn(1, 10, 1, 5);
    end
    // Start performance test. Set APB bus timing delays to high value to
    // avoid waiting cycles.
    apb.setDelay(0, 1);
    // Performance test for encrypt
    // Get current simulation time
    startTime = $time;
    // Run encryption for 1000 packets. Each packet is 160 bytes.
    env.PktProc(1000, 16*10, 16*10, 0);
    // Get current simulation time and calculate performance
    simTime = $time - startTime;
    clockCycles[0] = 160.0/(((simTime/10.0)/1000.0));
    // Performance test for decrypt
    // Get current simulation time
    startTime = $time;
    // Run decryption for 1000 packets. Each packet is 160 bytes.
    env.PktProc(1000, 16*10, 16*10, 1);
    // Get current simulation time and calculate performance
    simTime = $time - startTime;
    clockCycles[1] = 160.0/(((simTime/10.0)/1000.0));
    // Test is done print status
    env.testFinish();
    // Print performance values
    $display("***Performance results***");
    $display("1000 packets was run. Each packet size was 160 bytes");
    $display("Performance for encrypt is %f bytes per clock", clockCycles[0]);
    $display("Performance for decrypt is %f bytes per clock", clockCycles[1]);
    //
  end
endprogram
