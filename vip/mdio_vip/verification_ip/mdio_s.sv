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

package MDIO_S;
typedef class MDIO_s_busTrans;
`ifdef VCS
typedef mailbox TransMBox;
`else
typedef mailbox #(MDIO_s_busTrans) TransMBox;
`endif
///////////////////////////////////////////////////////////////////////////////
// Class MDIO_s_busTrans:
///////////////////////////////////////////////////////////////////////////////
class MDIO_s_busTrans;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  int                                 st;
  int                                 op;
  int                                 phyAddr;
  int                                 regAddr;    // reg address or dev type
  int                                 data16;     // Data or address
  string                              failedTr;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- genErrorMsg(): Generate error message and keep in the "failedTr" string.*/
  /////////////////////////////////////////////////////////////////////////////
  function void genErrorMsg(string errString);
    string tempStr;
    errString = {errString, " at sim time "};
    $write(errString);
    $write("%0d\n", $time());
    tempStr.itoa($time);
    this.failedTr = errString;
    this.failedTr = {this.failedTr, " ", tempStr, "ns"};
  endfunction
  //
endclass // MDIO_s_busTrans
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Class MDIO_s_busBFM:
///////////////////////////////////////////////////////////////////////////////
class MDIO_s_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  int phyAddr, regAddr;
  virtual mdio_s_if ifc;
  // Mailboxes
  TransMBox statusBox;
  // Internal memory
  int intMemArray[int];
  int memClean = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- startBFM(): Start main loop.*/
  /////////////////////////////////////////////////////////////////////////////
  task startBFM();
    fork
      this.main_loop();
    join_none
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- main_loop():*/
  /////////////////////////////////////////////////////////////////////////////
  local task main_loop();
    // Init
    MDIO_s_busTrans tr;
    logic [1:0] stInt;
    int addr;
    this.ifc.cb.mdo     <= 1'b0;
    this.ifc.cb.mdo_en  <= 1'b0;
    // Start main loop
    forever begin
      tr = new();
      stInt = 3;
      // Detect start of frame. (00 for Clause 45) or (01 for Clause 22).
      // Wait untill ST == 2'b00 or ST == 2'b01.
      do begin
        @this.ifc.cb;
        stInt = {stInt[0], this.ifc.cb.mdi};
      end while((stInt !== 2'b00) && (stInt !== 2'b01));
      tr.st = stInt;
      // Get OP code
      tr.op = 0;
      repeat(2) begin
        @this.ifc.cb;
        tr.op <<= 1;
        tr.op[0] = this.ifc.cb.mdi;
      end
      // Get PHY address
      tr.phyAddr = 0;
      repeat(5) begin
        @this.ifc.cb;
        tr.phyAddr <<= 1;
        tr.phyAddr[0] = this.ifc.cb.mdi;
      end
      // Get device type. Or Register address for Clause 22 (ST == 2'b01).
      repeat(5) begin
        @this.ifc.cb;
        tr.regAddr <<= 1;
        tr.regAddr[0] = this.ifc.cb.mdi;
      end
      // Wait 2 clocks. Turnaround time to change bus ownership(direction).
      repeat(2) @this.ifc.cb;
      // If OP code is read start data output.
      tr.data16 = 0;
      // ST == 2'b01 mode(Clause 22). Check only PHY address as a chip select
      // Use register address from the current frame as a data address
      if((tr.st[1:0] == 2'b01) && (tr.phyAddr == phyAddr) && (tr.op == 2)) begin
        this.ifc.cb.mdo_en  <= 1'b1;
        if(this.intMemArray.exists(tr.regAddr)) begin
          tr.data16 = this.intMemArray[tr.regAddr];
        end
      end
      // ST == 2'b00 mode(Clause 45). Check both PHY address and device type
      // as a chip select.
      // Use address value from the address frame as a data address
      if((tr.st[1:0] == 2'b00) && (tr.phyAddr == phyAddr) && (tr.regAddr == regAddr) &&
          ((tr.op == 2) || (tr.op == 3))) begin
        this.ifc.cb.mdo_en  <= 1'b1;
        if(this.intMemArray.exists(addr)) begin
          tr.data16 = this.intMemArray[addr];
        end
        if(tr.op == 2) addr++;
      end
      // Write data or address
      repeat(16) begin
        this.ifc.cb.mdo     <= tr.data16[15];
        @this.ifc.cb;
        tr.data16 <<= 1;
        tr.data16[0] = this.ifc.cb.mdi;
      end
      // Default state must always be Z value
      this.ifc.cb.mdo_en  <= 1'b0;
      // ST == 2'b01 mode(Clause 22). Check only PHY address as a chip select
      // Use register address from the current frame as a data address
      if((tr.st[1:0] == 2'b01) && (tr.phyAddr == phyAddr) && (tr.op == 1)) begin
        this.intMemArray[tr.regAddr] = tr.data16;
      end
      // ST == 2'b00 mode(Clause 45). Check both PHY address and device type
      // as a chip select.
      // Use address value from the address frame as a data address
      if((tr.st[1:0] == 2'b00) && (tr.phyAddr == phyAddr) && (tr.regAddr == regAddr)) begin
        if(tr.op == 0) begin
          addr = tr.data16;
        end else if(tr.op == 1) begin
          this.intMemArray[addr] = tr.data16;
        end
      end
      tr = null;
    end
  endtask
  //
endclass // MDIO_s_busBFM
///////////////////////////////////////////////////////////////////////////////
// Class MDIO_s_env:
///////////////////////////////////////////////////////////////////////////////
class MDIO_s_env extends MDIO_s_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local int envStarted      = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Connect physical interface to virtual and set data bus size.*/
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual mdio_s_if ifc);
    super.ifc              = ifc;
    super.statusBox        = new();
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- startEnv(): Start BFM. Only after this task transactions will appear on
  //  the MDIO bus.*/
  /////////////////////////////////////////////////////////////////////////////
  task startEnv();
    if(envStarted == 0) begin
      super.startBFM();
      this.envStarted = 1;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setAddr(): Set PHY address and device type.*/
  /////////////////////////////////////////////////////////////////////////////
  task setAddr(int phyAddr, devType);
    super.phyAddr  = phyAddr;
    super.regAddr  = devType;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setMemCleanMode(): Set internal memory clean mode.
  // 0 - no memory clean
  // 1 - only MDIO master read transactions will clean memory
  // 2 - only "getData" function will clean memory
  // 3 - Both MDIO master read transactions and "getData" function will
  //     clean memory
  // Cleaning memory will accelerate simulation time.*/
  /////////////////////////////////////////////////////////////////////////////
  task setMemCleanMode(int memClean = 0);
    super.memClean     = memClean;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- putWord(): Put data word to the internal memory.*/
  /////////////////////////////////////////////////////////////////////////////
  task putWord(input int startAddr, int dataIn);
    super.intMemArray[startAddr] = dataIn;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- getWord(): Get data word from the internal memory.*/
  /////////////////////////////////////////////////////////////////////////////
  task getWord(input int startAddr, output int dataOut);
    if(super.intMemArray.exists(startAddr)) begin
      dataOut = super.intMemArray[startAddr];
      // Clean internal memory
      if((super.memClean == 2) || (super.memClean == 3)) begin
        super.intMemArray.delete(startAddr);
      end
    end else begin
      dataOut = 0;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- pollWord(): Poll specified address until read word is equal to the pollWord.
  // If poll counter is reached to "pollTimeOut" value stop polling and
  // generate error message.*/
  /////////////////////////////////////////////////////////////////////////////
  task pollWord(input int address, pollExpWord, int pollTimeOut = 10000);
    int dataWord;
    MDIO_s_busTrans trErr;
    $display("Polling address 0x%h: @sim time %0d", address, $time);
    fork: poll
    begin
      do begin
        this.getWord(address, dataWord);
        @super.ifc.cb;
      end while(dataWord != pollExpWord);
      $display("Poll Done!");
    end
    begin
      repeat(pollTimeOut) @super.ifc.cb;
      trErr = new();
      trErr.genErrorMsg("ERROR: Slave poll Time Out Detected");
      super.statusBox.put(trErr);
      trErr = null;
    end
    join_any
    disable poll;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- printStatus(): Print poll timeout errors and return errors count.*/
  /////////////////////////////////////////////////////////////////////////////
  function int printStatus();
    MDIO_s_busTrans tr;
    tr = new();
    printStatus = this.statusBox.num();
    while(this.statusBox.num() != 0)begin
      void'(this.statusBox.try_get(tr));
      $display(tr.failedTr);
    end
    tr = null;
  endfunction
  //
endclass // MDIO_s_env
//
endpackage
