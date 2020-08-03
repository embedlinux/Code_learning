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

package AVALONST_M;
typedef bit [7:0]    bit8;
typedef bit [255:0]  bit256;
typedef bit8         bit8_32[32];
typedef class AVALONST_m_busTrans;
`ifdef VCS
typedef mailbox TransMBox;
`else
typedef mailbox #(AVALONST_m_busTrans) TransMBox;
`endif
///////////////////////////////////////////////////////////////////////////////
// Class AVALONST_m_busTrans:
///////////////////////////////////////////////////////////////////////////////
class AVALONST_m_busTrans;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  int                                 TrNum;
  enum {WRITE, IDLE, WAIT,
        CFG_DELAY, CFG_TIMEOUT}       TrType;
  bit8_32                             dataBlock;
  bit                                 startofpacket;
  bit                                 endofpacket;
  int                                 empty;
  string                              failedTr;
  int                                 idleCycles;
  // Configuration variables
  int minBurst, maxBurst, minWait, maxWait;
  int readyTimeOut;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- unpack2pack():*/
  /////////////////////////////////////////////////////////////////////////////
  function bit256 unpack2pack(bit8_32 dataBlock);
    for (int i = 0; i < 32; i++) unpack2pack[8*i+:8] = dataBlock[i];
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- pack2unpack():*/
  /////////////////////////////////////////////////////////////////////////////
  function bit8_32 pack2unpack(bit256 dataBlock);
    for (int i = 0; i < 32; i++) pack2unpack[i] = dataBlock[8*i+:8];
  endfunction
  //
endclass // AVALONST_m_busTrans
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Class AVALONST_m_busBFM:
///////////////////////////////////////////////////////////////////////////////
class AVALONST_m_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  // Configuration variables
  int       blockSize;
  int       readyTimeOut= 0;
  int       burstDelayEn= 0;
  rand int  maxBurstLen = 0;
  rand int  waitCycles  = 0;
  local int maxBurst, minBurst;
  local int maxWait, minWait;
  // Constraints for random timing
  constraint c_timing {
    this.maxBurstLen          inside {[this.minBurst:this.maxBurst]};
    this.waitCycles           inside {[this.minWait:this.maxWait]};
  }
  /////////////////////////////////////////////////////////////////////////////
  virtual avalon_st_m_if ifc;
  TransMBox trInBox, trOutBox, statusBox;
  local AVALONST_m_busTrans tr;
  int burstCnt;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- startBFM(): Start main loop.*/
  /////////////////////////////////////////////////////////////////////////////
  task startBFM();
    fork
      this.run_loop();
    join_none
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- run_loop(): Main loop.*/
  /////////////////////////////////////////////////////////////////////////////
  local task run_loop();
    // Init
    this.ifc.data           <= 256'd0;
    this.ifc.valid          <= 1'b0;
    this.ifc.startofpacket  <= 1'b0;
    this.ifc.endofpacket    <= 1'b0;
    this.ifc.empty          <= 5'd0;
    this.burstCnt            = 0;
    // Start main loop
    forever begin
      this.trInBox.get(this.tr);
      // Clock alignment
      this.ifc.clockAlign();
      // Transaction decoder
      if(this.tr.TrType == AVALONST_m_busTrans::IDLE) begin
        repeat(this.tr.idleCycles) @this.ifc.cb;
      end else if(this.tr.TrType == AVALONST_m_busTrans::WAIT)begin
        this.trOutBox.put(this.tr);
      end else if(this.tr.TrType == AVALONST_m_busTrans::CFG_DELAY) begin
        // Set configuration. Random delays.
        this.maxBurst     = this.tr.maxBurst;
        this.minBurst     = this.tr.minBurst;
        this.minWait      = this.tr.minWait;
        this.maxWait      = this.tr.maxWait;
        this.burstCnt     = 0;
        this.burstDelayEn = this.tr.maxBurst;
        assert (this.randomize())
        else $fatal(0, "Avalon ST Master: Init Randomize failed");
      end else if(this.tr.TrType == AVALONST_m_busTrans::CFG_TIMEOUT) begin
        // Set configuration. Timeout.
        this.readyTimeOut = this.tr.readyTimeOut;
      end else begin
        // Write transaction.
        this.blockWr();
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- blockWr(): Generate Write transaction.*/
  /////////////////////////////////////////////////////////////////////////////
  local task blockWr();
    AVALONST_m_busTrans trErr;
    string tempStr;
    int readyWaitCnt = 0;
    this.ifc.data           <= this.tr.unpack2pack(this.tr.dataBlock);
    this.ifc.valid          <= 1'b1;
    this.ifc.startofpacket  <= this.tr.startofpacket;
    this.ifc.endofpacket    <= this.tr.endofpacket;
    this.ifc.empty          <= this.tr.empty[4:0];
    // Wait for slave ready.
    do begin
      @this.ifc.cb;
      readyWaitCnt++;
    end while((this.ifc.cb.ready !== 1'b1)&&(readyWaitCnt != this.readyTimeOut));
    // Check ready timeout
    if(this.ifc.cb.ready !== 1'b1) begin
      trErr = new();
      $display("Transaction TimeOut. No ready detected at sim time %0d", $time());
      tempStr.itoa($time);
      trErr.failedTr = "Transaction TimeOut. No ready detected at sim time ";
      trErr.failedTr     = {trErr.failedTr, tempStr, "ns"};
      this.statusBox.put(trErr);
      trErr = null;
    end
    this.ifc.valid          <= 1'b0;
    this.ifc.endofpacket    <= 1'b0;
    this.ifc.startofpacket  <= 1'b0;
    // Random timing control.
    if((this.burstDelayEn != 0) && (this.maxBurstLen != 0))begin
      this.burstCnt            = this.burstCnt + 1;
    end
    if((this.burstCnt == this.maxBurstLen) && (this.burstDelayEn != 0)) begin
      if(this.maxBurstLen != 0) repeat(waitCycles) @this.ifc.cb;
      assert (this.randomize())
      else $fatal(0, "Avalone ST Master: Randomize failed");
      this.burstCnt           = 0;
    end
    //
  endtask
  //
endclass // AVALONST_m_busBFM
///////////////////////////////////////////////////////////////////////////////
// Class AVALONST_m_env:
///////////////////////////////////////////////////////////////////////////////
class AVALONST_m_env extends AVALONST_m_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local AVALONST_m_busTrans tr;
  // "TrNum": Is storing transactions count during all simulation time.
  local int TrNum           = 0;
  local int envStarted      = 0;
  local bit startofpacketEn = 1'b1;
  local bit endofpacketEn   = 1'b1;
  local int dataEndian      = 1;
  local int emptyRndEn      = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Takes physical interface as an input value and connects it to
  // virtual interface. Creates transaction mailboxes.*/
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual avalon_st_m_if ifc, int blockSize = 4);
    super.ifc              = ifc;
    super.trInBox          = new();
    super.trOutBox         = new();
    super.statusBox        = new();
    super.blockSize        = blockSize;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- startEnv(): Start BFM. Only after this task transactions will appear on
  //  the bus.*/
  /////////////////////////////////////////////////////////////////////////////
  task startEnv();
    if(envStarted == 0) begin
      super.startBFM();
      this.envStarted = 1;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setRndDelay(): Set/Disable bus random delays. To disable delays set all
  //  arguments zero.*/
  /////////////////////////////////////////////////////////////////////////////
  task setRndDelay(int minBurst=0, maxBurst=0, minWait=0, maxWait=0);
    this.tr              = new();
    this.tr.TrType       = AVALONST_m_busTrans::CFG_DELAY;
    this.tr.minBurst     = minBurst;
    this.tr.maxBurst     = maxBurst;
    this.tr.minWait      = minWait;
    this.tr.maxWait      = maxWait;
    super.trInBox.put(this.tr);
    this.tr              = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setTimeOut(): Set ready wait timeout.*/
  /////////////////////////////////////////////////////////////////////////////
  task setTimeOut(int readyTimeOut=0);
    this.tr              = new();
    this.tr.TrType       = AVALONST_m_busTrans::CFG_TIMEOUT;
    this.tr.readyTimeOut = readyTimeOut;
    super.trInBox.put(this.tr);
    this.tr              = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setEndian(): Set data endian. 1 big-endian, 0 little-endian.*/
  /////////////////////////////////////////////////////////////////////////////
  task setEndian(int dataEndian);
    this.dataEndian = dataEndian;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setPacketConfig(): Enable/Disable startofpacket and endofpacket signals.
  // Can be useful during negative testing.*/
  /////////////////////////////////////////////////////////////////////////////
  task setPacketConfig(int startofpacketEn, endofpacketEn, emptyRndEn);
    this.startofpacketEn = 1'b0;
    this.endofpacketEn   = 1'b0;
    if(startofpacketEn != 0) begin
      this.startofpacketEn = 1'b1;
    end
    if(endofpacketEn != 0) begin
      this.endofpacketEn = 1'b1;
    end
    this.emptyRndEn = emptyRndEn;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- busIdle(): Hold bus in idle for the specified clock cycles.*/
  /////////////////////////////////////////////////////////////////////////////
  task busIdle(int idleCycles);
    this.tr             = new();
    this.tr.TrType      = AVALONST_m_busTrans::IDLE;
    this.tr.idleCycles  = idleCycles;
    super.trInBox.put(this.tr);
    this.tr             = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeData(): Send data buffer.*/
  /////////////////////////////////////////////////////////////////////////////
  task writeData(bit8 inBuff[$]);
    bit startofpacket = this.startofpacketEn;
    //
    while(inBuff.size() != 0) begin
      this.tr = new();
      this.TrNum++;
      this.tr.endofpacket   = 1'b0;
      this.tr.startofpacket = startofpacket;
      this.tr.empty         = 'd0; // Future notes: Set empty random inside tr class
      if(this.emptyRndEn == 1) begin
        this.tr.empty = $urandom_range(0, (super.blockSize-1));
      end
      if(this.dataEndian == 1) begin
        for(int j = super.blockSize; j > this.tr.empty; j--) begin
          this.tr.dataBlock[j-1] = inBuff.pop_front();
          if(inBuff.size() == 0) begin
            this.tr.endofpacket = this.endofpacketEn;
            this.tr.empty       = j - 1;
            break;
          end
        end
      end else begin
        for(int j = 0; j < (super.blockSize-this.tr.empty); j++) begin
          this.tr.dataBlock[j] = inBuff.pop_front();
          if(inBuff.size() == 0) begin
            this.tr.endofpacket = this.endofpacketEn;
            this.tr.empty       = super.blockSize - (j + 1);
            break;
          end
        end
      end
      //
      this.tr.TrType    = AVALONST_m_busTrans::WRITE;
      super.trInBox.put(this.tr);
      this.tr = null;
      startofpacket = 1'b0;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- waitCommandDone(): Wait until all instructions in the input mailbox are
  //  finished.*/
  /////////////////////////////////////////////////////////////////////////////
  task waitCommandDone();
    this.tr         = new();
    this.tr.TrType  = AVALONST_m_busTrans::WAIT;
    this.trInBox.put(this.tr);
    this.trOutBox.get(this.tr);
    this.tr = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- printStatus(): Print all errors if there are any and
  // return errors count. Otherwise return 0.*/
  /////////////////////////////////////////////////////////////////////////////
  function int printStatus();
    this.tr = new();
    printStatus = this.statusBox.num();
    while(this.statusBox.num() != 0)begin
      void'(this.statusBox.try_get(this.tr));
      $display(this.tr.failedTr);
    end
    this.tr = null;
  endfunction
  //
endclass // AVALONST_m_env
//
endpackage
