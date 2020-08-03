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

package AVALONST_S;
typedef bit [7:0]    bit8;
typedef bit [255:0]  bit256;
typedef bit8         bit8_32[32];
typedef class AVALONST_s_busTrans;
`ifdef VCS
typedef mailbox TransMBox;
`else
typedef mailbox #(AVALONST_s_busTrans) TransMBox;
`endif
///////////////////////////////////////////////////////////////////////////////
// Class AVALONST_s_busTrans:
///////////////////////////////////////////////////////////////////////////////
class AVALONST_s_busTrans;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  int                                 TrNum;
  enum {READ, CFG_DELAY}              TrType;
  bit8_32                             dataBlock;
  bit                                 startofpacket;
  bit                                 endofpacket;
  bit [4:0]                           empty;
  string                              failedTr;
  // Configuration variables
  int minReadyDelay, maxReadyDelay;
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
endclass // AVALONST_s_busTrans
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Class AVALONST_s_busBFM:
///////////////////////////////////////////////////////////////////////////////
class AVALONST_s_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  // Configuration variables
  int blockSize;
  rand int readyDelay = 0;
  int readyDelayEn    = 0;
  int minReadyDelay, maxReadyDelay;
  // Constraints for random timing
   constraint c_timing {
    this.readyDelay          inside {[minReadyDelay:maxReadyDelay]};
  }
  /////////////////////////////////////////////////////////////////////////////
  virtual avalon_st_s_if ifc;
  TransMBox trInBox, trOutBox, statusBox;
  local AVALONST_s_busTrans tr;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- startBFM(): Start main loop.*/
  /////////////////////////////////////////////////////////////////////////////
  task startBFM();
      //
      fork
        this.run_loop();
      join_none
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- run_loop(): Main loop.*/
  /////////////////////////////////////////////////////////////////////////////
  local task run_loop();
    AVALONST_s_busTrans trErr;
    string tempStr;
    bit startofpacket = 1'b1;
    // Init
    this.ifc.ready        <= 1'b1;
    // Clock alignment
    this.ifc.clockAlign();
    // Start main loop
    forever begin
      do begin
        // If new configuration available apply it to the current configuration.
        while(this.trInBox.try_get(this.tr) == 1) begin
          if(this.tr.TrType == AVALONST_s_busTrans::CFG_DELAY) begin
            this.minReadyDelay = this.tr.minReadyDelay;
            this.maxReadyDelay = this.tr.maxReadyDelay;
            this.readyDelayEn  = this.maxReadyDelay;
          end
        end
        // Generate random ready delay if enabled.
        if(this.readyDelayEn != 0) begin
          assert (this.randomize())
          else $fatal(0, "Avalon ST Slave: Randomize failed");
        end
        // Hold ready active if delay is zero.
        if(this.readyDelay != 0) begin
          this.ifc.cb.ready   <= 1'b0;
        end else begin
          this.ifc.cb.ready   <= 1'b1;
        end
        @this.ifc.cb;
      end while(this.ifc.cb.valid !== 1'b1);
      // Data processing.
      this.tr                  = new();
      // Get transaction from master.
      this.tr.dataBlock     = this.tr.pack2unpack(this.ifc.cb.data);
      this.tr.startofpacket = this.ifc.cb.startofpacket;
      this.tr.endofpacket   = this.ifc.cb.endofpacket;
      this.tr.empty         = this.ifc.cb.empty;
      // Delay ready signal.
      if(this.readyDelay != 0) repeat(this.readyDelay-1) @this.ifc.cb;
      // Generate response.
      this.ifc.cb.ready     <= 1'b1;
      if(this.readyDelay != 0) begin
        @this.ifc.cb;
        this.ifc.cb.ready     <= 1'b0;
      end
      if(this.tr.endofpacket == 1'b0) begin
        //this.tr.empty         = 'd0;
      end
      if(startofpacket == 1'b1) begin
        if(this.tr.startofpacket != 1'b1) begin
          // Error case
          trErr = new();
          $display("Error: No start of packet detected at sim time %0d", $time());
          $display("Data will be ignored");
          tempStr.itoa($time);
          trErr.failedTr = "Error: No start of packet detected at sim time ";
          trErr.failedTr     = {trErr.failedTr, tempStr, "ns"};
          this.statusBox.put(trErr);
          trErr = null;
        end else begin
          // Normal case
          // Put transaction to the mailbox.
          this.trOutBox.put(this.tr);
          startofpacket = this.tr.endofpacket;
        end
      end else begin
        // Put transaction to the mailbox.
        this.trOutBox.put(this.tr);
        startofpacket = this.tr.endofpacket;
        if(this.tr.startofpacket == 1'b1) begin
          // Error case
          trErr = new();
          $display("Error: Wrong start of packet detected at sim time %0d", $time());
          $display("Data will not be ignored");
          tempStr.itoa($time);
          trErr.failedTr = "Error: Wrong start of packet detected at sim time ";
          trErr.failedTr     = {trErr.failedTr, tempStr, "ns"};
          this.statusBox.put(trErr);
          trErr = null;
        end
      end
      this.tr               = null;
    end
  endtask
  //
endclass // AVALONST_s_busBFM
///////////////////////////////////////////////////////////////////////////////
// Class AVALONST_s_env:
///////////////////////////////////////////////////////////////////////////////
class AVALONST_s_env extends AVALONST_s_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local AVALONST_s_busTrans tr;
  // "TrNum": Is storing transactions count during all simulation time.
  local int TrNum           = 0;
  local int envStarted      = 0;
  local int timeOut         = 10000;
  local int dataEndian      = 1;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Takes physical interface as an input value and connects it to
  // virtual interface. Create transaction mailboxes.*/
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual avalon_st_s_if ifc, int blockSize = 4);
    super.ifc              = ifc;
    super.trInBox          = new();
    super.trOutBox         = new();
    super.statusBox        = new();
    super.blockSize        = blockSize;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- startEnv(): Start BFM.*/
  /////////////////////////////////////////////////////////////////////////////
  task startEnv();
    if(envStarted == 0) begin
      super.startBFM();
      this.envStarted = 1;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setRndDelay(): Set 'ready' random delays. To disable random delays set all
  //  arguments to zero.*/
  /////////////////////////////////////////////////////////////////////////////
  task setRndDelay(int minReadyDelay=0, maxReadyDelay=0);
    this.tr               = new();
    this.tr.TrType        = AVALONST_s_busTrans::CFG_DELAY;
    this.tr.minReadyDelay = minReadyDelay;
    this.tr.maxReadyDelay = maxReadyDelay;
    super.trInBox.put(this.tr);
    this.tr               = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setTimeOut(): Set data read timeout.*/
  /////////////////////////////////////////////////////////////////////////////
  task setTimeOut(int timeOut);
    this.timeOut = timeOut;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setEndian(): Set data endian. 1 big-endian, 0 little-endian.*/
  /////////////////////////////////////////////////////////////////////////////
  task setEndian(int dataEndian);
    this.dataEndian = dataEndian;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- readData(): Get data buffer.*/
  /////////////////////////////////////////////////////////////////////////////
  task readData(output bit8 outBuff[$]);
    AVALONST_s_busTrans trErr;
    string tempStr;
    fork:readTimeOut
      begin
        repeat(timeOut) @super.ifc.cb;
        trErr = new();
        $display("Error: Read TimeOut detected at sim time %0d", $time());
        tempStr.itoa($time);
        trErr.failedTr = "Error: Read TimeOut detected at sim time ";
        trErr.failedTr     = {trErr.failedTr, tempStr, "ns"};
        super.trInBox.put(trErr);
        trErr = null;
      end
      do begin
        super.trOutBox.get(this.tr);
        if(this.dataEndian == 1) begin
          for(int i = super.blockSize; i > this.tr.empty; i--) begin
            outBuff.push_back(this.tr.dataBlock[i-1]);
          end
        end else begin
          for(int i = 0; i < (super.blockSize-this.tr.empty); i++) begin
            outBuff.push_back(this.tr.dataBlock[i]);
          end
        end
      end while(this.tr.endofpacket == 1'b0);
    join_any
    disable readTimeOut;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- printStatus(): Print poll timeout errors if there are any and
  // return errors count. Otherwise return 0.*/
  /////////////////////////////////////////////////////////////////////////////
  function int printStatus();
    this.tr = new();
    printStatus = super.statusBox.num();
    while(super.statusBox.num() != 0)begin
      void'(super.statusBox.try_get(this.tr));
      $display(this.tr.failedTr);
    end
    this.tr = null;
  endfunction
  //
endclass // AVALONST_s_env
//
endpackage
