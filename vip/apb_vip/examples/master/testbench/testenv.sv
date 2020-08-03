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
import AES_MODEL::*;
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
  local Aes        aes;
  local ABP_m_env  apb;
  virtual apb_m_if ifc;
  local int        expError = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual apb_m_if ifc, ABP_m_env apb);
    this.pkt = new();
    this.chk = new();
    this.aes = new();
    this.apb = apb;
    this.ifc = ifc;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- PktProc(): Generate "pktNum" packets and send to the engine. Read result
  // from engine and compare with model.
  // "modeIn"     - is 2 encrypt/decrypt modes will generated randomly.
  // "modeIn"     - is 0 encrypt mode will enabled.
  // "modeIn"     - is 1 decrypt mode will enabled.
  // "min", "max" - generated packet length will be in range specified here.
  // "rndRW"      - Set this to 0 if you want to have optimal read/write
  //                transactions sequence.
  //                Set it to 1 if you want to have more coverage.
  //                Set it to 2 if you want to test more corner cases. When it
  //                set 2 random read/write with wrong address is generated and
  //                Engine mus set slave error signal.*/
  /////////////////////////////////////////////////////////////////////////////
  task PktProc(int pktNum, min, max, modeIn=2, rndRW=0);
    packet keyIn, pktIn, tempPkt, tempPkt1, outPkt, expPkt;
    int length[], aesBlkLen, wrCnt, mode, checkSize;
    string mode_str[2];
    length = new[pktNum];
    mode_str = '{"ENC", "DEC"};
    mode = 0;
    outPkt = {};
    expPkt = {};
    pktIn  = {};
    for(int i = 0; i < pktNum; i++)begin
      length[i] = this.pkt.genRndNum(min, max, 16);
    end
    wrCnt = 0;
    for(int i = 0; i < pktNum; i++)begin
      if((i != 0) && (outPkt.size() != 0))begin
        checkSize = outPkt.size();
        void'(this.chk.CheckPkt(outPkt, expPkt, checkSize));
        expPkt  = expPkt[checkSize:$];
        outPkt  = {};
      end
      $display("Pkt number is %d", (i+1));
      $display("Pkt length is %d bytes", length[i]);
      if(modeIn==2)begin
        mode = this.pkt.genRndNum(0, 1);
      end else begin
        mode = modeIn;
      end
      if ((rndRW == 2) && (this.pkt.genRndNum(0, 1))) this.insertRndDummyRW();
      this.apb.writeWord('h10, mode);
      this.pkt.genRndPkt(16, keyIn);
      if ((rndRW == 2) && (this.pkt.genRndNum(0, 1))) this.insertRndDummyRW();
      this.apb.writeData(0, keyIn);
      pktIn = {};
      for(int j = 0; j < length[i]; j+=16) begin
        int rdEn;
        this.pkt.genRndPkt(16, tempPkt);
        if ((rndRW == 2) && (this.pkt.genRndNum(0, 1))) this.insertRndDummyRW();
        this.apb.writeData('h14, tempPkt, 0);
        pktIn = {pktIn, tempPkt};
        wrCnt++;
        do begin
          rdEn = (pkt.genRndNum(0, 1) || (wrCnt == 3)) && (rndRW > 0);
          if((wrCnt == 3) || rdEn) begin
            wrCnt--;
            if ((rndRW == 2) && (this.pkt.genRndNum(0, 1))) this.insertRndDummyRW();
            this.apb.readData('h18, tempPkt, 16, 0);
            outPkt = {outPkt, tempPkt};
          end
        end while((wrCnt > 0) & rdEn);
      end
      this.aes.CryptECB (mode_str[mode], keyIn, pktIn, tempPkt);
      expPkt = {expPkt, tempPkt};
    end
    for(int i = 0; i < wrCnt; i++)begin
      if ((rndRW == 2) && (this.pkt.genRndNum(0, 1))) this.insertRndDummyRW();
      this.apb.readData('h18, tempPkt, 16, 0);
      outPkt = {outPkt, tempPkt};
    end
    void'(this.chk.CheckPkt(outPkt, expPkt));
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- insertRndDummyRW(): Insert random read or write with wrong address.
  // Engine must generated slave error.*/
  /////////////////////////////////////////////////////////////////////////////
  task insertRndDummyRW();
    int addr = 0;
    packet tempPkt;
    this.expError++;
    if(pkt.genRndNum(0, 1)) begin
      do addr = this.pkt.genRndNum(0, 'h1f);
      while((addr <= 'h14)&&((addr&3) == 0));
      this.apb.writeWord(addr, 'hac);
    end else begin
      do addr = this.pkt.genRndNum(0, 'h1f); while(addr == 'h18);
      this.apb.readData(addr, tempPkt, 1, 0);
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- testStart(): Starting APB environment and waiting 10 clock cycles to be
  // sure that engine is resetted.*/
  /////////////////////////////////////////////////////////////////////////////
  task testStart();
    this.apb.startEnv();
    repeat (10) @ifc.cb;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- testFinish(): Prints APB transactions and checker status.*/
  /////////////////////////////////////////////////////////////////////////////
  task testFinish();
    int trErrors = 0;
    repeat (3) @ifc.cb;
    trErrors = this.apb.printFailedTrInfo();
    $display("-----------------------Test Done------------------------");
    $display("------------------Printing Test Status------------------");
    if (trErrors == this.expError) begin
      $display("-Transactions have 0 unexpected TimeOut or Slave Errors-");
    end else begin
      $display("--Transactions have unexpected TimeOut or Slave Errors--");
      $display("Expected  error amount is %d", this.expError);
      $display("Generated error amount is %d", trErrors);
    end
    $display("--------------------------------------------------------");
    this.chk.printFullStatus();
    $display("--------------------------------------------------------");
  endtask
  //
endclass // TestEnv
//
endpackage
