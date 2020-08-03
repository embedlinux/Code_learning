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

package TESTENV;
//
import APB_M::*;
import APB_S::*;
import PACKET::*;
//
///////////////////////////////////////////////////////////////////////////////
// Class TestEnv:
///////////////////////////////////////////////////////////////////////////////
class TestEnv;
  typedef bit [31:0] bit32;
  typedef bit [7:0]  bit8;
  typedef bit8       packet[$];
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local Packet     pkt;
  local Checker    chk;
  local ABP_m_env  apb_m;
  local ABP_s_env  apb_s;
  virtual apb_m_if ifc_m;
  local int        expError_m = 0;
  local int        expError_s = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual apb_m_if ifc_m, ABP_m_env apb_m, ABP_s_env apb_s);
    this.pkt    = new();
    this.chk    = new();
    this.apb_m  = apb_m;
    this.apb_s  = apb_s;
    this.ifc_m  = ifc_m;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- runMaster(): DUT emulator. Task should be called only once. */
  /////////////////////////////////////////////////////////////////////////////
  task runMaster();
    packet inPkt0, inPkt1, outPkt;
    bit8  tempData;
    bit32 dataInAddr0, dataInAddr1, dataOutAddr;
    int   dataLength;
    fork
      forever begin
        apb_m.pollWord(0, 'h98765432);
        apb_m.readWord(4, dataInAddr0);
        apb_m.readWord(8, dataInAddr1);
        apb_m.readWord(12,dataOutAddr);
        apb_m.readWord(16,dataLength);
        apb_m.writeWord(0, 0);
        apb_m.readData(dataInAddr0, inPkt0, dataLength);
        apb_m.readData(dataInAddr1, inPkt1, dataLength);
        outPkt = {};
        for (int i = 0; i < dataLength; i++) begin
          tempData = inPkt0[i] ^ inPkt1[i];
          outPkt = {outPkt, tempData};
        end
        apb_m.writeData(dataOutAddr, outPkt);
        apb_m.writeWord(20, 'h32323232);
      end
    join_none
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- testFinish(): Prints APB transactions and checker status.*/
  /////////////////////////////////////////////////////////////////////////////
  task testFinish();
    int trErrors_m = 0;
    int trErrors_s = 0;
    repeat (3) @ifc_m.cb;
    trErrors_m = this.apb_m.printFailedTrInfo();
    trErrors_s = this.apb_s.printFailedTrInfo();
    $display("-----------------------Test Done------------------------");
    $display("------------------Printing Test Status------------------");
    $display("---------------------Master Status----------------------");
    if (trErrors_m == this.expError_m) begin
      $display("-Transactions have 0 unexpected TimeOut or Slave Errors-");
    end else begin
      $display("--Transactions have unexpected TimeOut or Slave Errors--");
      $display("Expected  error amount is %d", this.expError_m);
      $display("Generated error amount is %d", trErrors_m);
    end
    $display("----------------------Slave Status----------------------");
    if (trErrors_s == this.expError_s) begin
      $display("------Transactions have 0 unexpected TimeOut Errors-----");
    end else begin
      $display("-----Transactions have unexpected TimeOut Errors-----");
      $display("Expected  error amount is %d", this.expError_s);
      $display("Generated error amount is %d", trErrors_s);
    end
    $display("--------------------------------------------------------");
    this.chk.printFullStatus();
    $display("--------------------------------------------------------");
  endtask
  //
endclass // TestEnv
//
endpackage
