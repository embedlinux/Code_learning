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

package MDIO_M;
typedef class MDIO_m_busTrans;
`ifdef VCS
typedef mailbox TransMBox;
`else
typedef mailbox #(MDIO_m_busTrans) TransMBox;
`endif
///////////////////////////////////////////////////////////////////////////////
// Class MDIO_m_busTrans:
///////////////////////////////////////////////////////////////////////////////
class MDIO_m_busTrans;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  enum {WRITE_READ, IDLE, WAIT}       TrType;
  int                                 st;
  int                                 op;
  int                                 phyAddr;
  int                                 regAddr;    // reg address or dev type
  int                                 data16;     // Data or address
  int                                 idleCycles;
  string                              failedTr;
  int unsigned                        rdDataPtr;
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
endclass // MDIO_m_busTrans
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Class MDIO_m_busBFM:
///////////////////////////////////////////////////////////////////////////////
class MDIO_m_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  virtual mdio_m_if ifc;
  // Mailboxes
  TransMBox trInBox, statusBox;
  semaphore waitSem;
  local MDIO_m_busTrans tr;
  // Read data buffers
  TransMBox RdDataArrayBox[*];
  int minDelay, maxDelay;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- startBFM(): Start loop for each channel.*/
  /////////////////////////////////////////////////////////////////////////////
  task startBFM();
      fork
        this.main_loop();
      join_none
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- main_loop(): Get mailbox data. Check transaction type and call
  //  corresponding function.*/
  /////////////////////////////////////////////////////////////////////////////
  task main_loop();
    // Init
    int unsigned rndDelay;
    this.ifc.cb.mdo_en         <= 'd0;
    this.ifc.cb.mdo            <= 1'b0;
    // Start main loop
    forever begin
      this.trInBox.get(this.tr);
      if(this.tr.TrType == MDIO_m_busTrans::IDLE) begin
        repeat (this.tr.idleCycles) @this.ifc.cb;
      end if(this.tr.TrType == MDIO_m_busTrans::WAIT) begin
        this.waitSem.put(1);
      end else begin
        this.writeRead();
        // Insert random delay
        rndDelay = $urandom_range (this.minDelay, this.maxDelay);
        repeat (rndDelay) @this.ifc.cb;
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeRead(): Generate write/read timings.*/
  /////////////////////////////////////////////////////////////////////////////
  local task writeRead();
    MDIO_m_busTrans trErr;
    string tempStr;
    bit [29:0] shiftReg;
    shiftReg = {this.tr.st[1:0], this.tr.op[1:0], this.tr.phyAddr[4:0],
                this.tr.regAddr[4:0], this.tr.data16[15:0]};
    // Clock alignment
    this.ifc.clockAlign();
    // Generate timing
    this.ifc.cb.mdo_en         <= 'd1;
    this.ifc.cb.mdo            <= 1'b1;
    @this.ifc.cb;
    // Send ST, OP, PHY ADDRESS, DEV TYPE.
    repeat(14) begin
      this.ifc.cb.mdo          <= shiftReg[29];
      @this.ifc.cb;
      shiftReg <<= 1;
    end
    // MDIO becomes input during read (or read increment).
    if((this.tr.op == 3) || (this.tr.op == 2)) begin
      this.ifc.cb.mdo_en       <= 'd0;
    end
    // 2 clock cycles. Turnaround time to change bus ownership from STA to MMD if required
    repeat(2) @this.ifc.cb;
    // Send/Receive data.
    repeat(16) begin
      this.ifc.cb.mdo          <= shiftReg[29];
      this.tr.data16 <<= 1;
      this.tr.data16[0]         = this.ifc.cb.mdi;
      @this.ifc.cb;
      shiftReg <<= 1;
    end
    // MDIO is input during IDLE.
    this.ifc.cb.mdo_en         <= 'd0;
    // Insert 2 clock cycles between frames. Turnaround time to change bus
    // ownership from MMD to STA
    repeat(2) @this.ifc.cb;
    if((this.tr.op == 2) || (this.tr.op == 3)) begin
      this.RdDataArrayBox[this.tr.rdDataPtr].put(this.tr);
    end
  endtask
  //
endclass // MDIO_m_busBFM
///////////////////////////////////////////////////////////////////////////////
// Class MDIO_m_env:
///////////////////////////////////////////////////////////////////////////////
class MDIO_m_env extends MDIO_m_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local MDIO_m_busTrans tr;
  local int envStarted;
  local int st;
  local int unsigned rdDataPtr;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Connect physical interface to virtual. Set data bus size.*/
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual mdio_m_if ifc);
    this.envStarted          = 0;
    this.rdDataPtr           = 0;
    super.ifc                = ifc;
    super.trInBox            = new();
    super.statusBox          = new();
    super.waitSem            = new();
    this.st                  = 0;
    super.minDelay           = 0;
    super.maxDelay           = 0;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- startEnv(): Start BFM. Only after this task transactions will appear on
  //  the MDIO bus.*/
  /////////////////////////////////////////////////////////////////////////////
  task startEnv();
    if(this.envStarted == 0) begin
      super.startBFM();
      this.envStarted = 1;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setRndDelay(): Enable/Disable bus random delays between frames. To disable
  //  delays set all arguments to zero.*/
  /////////////////////////////////////////////////////////////////////////////
  task setRndDelay(int minDelay, maxDelay);
    super.maxDelay = maxDelay;
    super.minDelay = minDelay;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setIdle(): Hold MDIO in idle for the specified clock cycles.*/
  /////////////////////////////////////////////////////////////////////////////
  task setIdle(int idleCycles);
    this.tr               = new();
    this.tr.TrType        = MDIO_m_busTrans::IDLE;
    this.tr.idleCycles    = idleCycles;
    super.trInBox.put(this.tr);
    this.tr               = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- mdioDone(): Wait until all transactions in the input mailbox
  //  are finished.*/
  /////////////////////////////////////////////////////////////////////////////
  task mdioDone();
    this.tr               = new();
    this.tr.TrType        = MDIO_m_busTrans::WAIT;
    super.trInBox.put(this.tr);
    this.tr               = null;
    super.waitSem.get(1);
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setST(): Set ST mode. ST == 2'b00 for Clause 45 or
  //  ST == 2'b01 for Clause 22.*/
  /////////////////////////////////////////////////////////////////////////////
  task setST(int st);
    this.st = st;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeAddr(): Send address frame. Don't use in Clause 22 mode.*/
  /////////////////////////////////////////////////////////////////////////////
  task writeAddr(input int phyAddr, devType, addrData);
    // Put address information
    this.tr = new();
    this.tr.TrType  = MDIO_m_busTrans::WRITE_READ;
    this.tr.phyAddr = phyAddr;
    this.tr.regAddr = devType;
    this.tr.data16  = addrData;
    this.tr.st      = this.st;
    this.tr.op      = 0;
    super.trInBox.put(this.tr);
    this.tr         = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeWord(): Send data write frame.*/
  /////////////////////////////////////////////////////////////////////////////
  task writeWord(input int phyAddr, devType, data16);
    // Put data information
    this.tr = new();
    this.tr.TrType  = MDIO_m_busTrans::WRITE_READ;
    this.tr.phyAddr = phyAddr;
    this.tr.regAddr = devType;
    this.tr.data16  = data16;
    this.tr.st      = this.st;
    this.tr.op      = 1;
    super.trInBox.put(this.tr);
    this.tr         = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- readWord(): Read data word(16 bit).
  //  Returns buffer pointer where the read word will be located.*/
  /////////////////////////////////////////////////////////////////////////////
  task readWord(output int unsigned dataOutPtr, input int phyAddr, devType, incr = 0);
    // Put address information
    dataOutPtr = this.rdDataPtr;
    // Create new transaction mailbox for read data buffer with current pointer
    super.RdDataArrayBox[this.rdDataPtr] = new();
    this.tr = new();
    this.tr.TrType    = MDIO_m_busTrans::WRITE_READ;
    this.tr.phyAddr   = phyAddr;
    this.tr.regAddr   = devType;
    this.tr.data16    = 0;
    this.tr.st        = this.st;
    this.tr.op        = 3;
    if((incr == 1) || (this.st == 1)) this.tr.op = 2;
    this.tr.rdDataPtr = this.rdDataPtr;
    super.trInBox.put(this.tr);
    this.tr           = null;
    // Increment read data memory pointer
    this.rdDataPtr++;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- getWord(): Get read data buffer with specified pointer.*/
  /////////////////////////////////////////////////////////////////////////////
  task getWord(int unsigned rdDataPtr, output int data16);
    super.RdDataArrayBox[rdDataPtr].get(this.tr);
    data16 = this.tr.data16;
    // Delete current memory cell to accelerate simulation.
    super.RdDataArrayBox.delete(rdDataPtr);
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- pollWord(): Poll specified addresses until read data word is equal to
  // pollDataWord word. If poll counter is reached to "pollTimeOut" value
  // stop polling and generate error message.*/
  /////////////////////////////////////////////////////////////////////////////
  task pollWord(input int phyAddr, devType, addr, int pollDataWord, pollTimeOut = 10000);
    int unsigned dataOutPtr;
    int tempData16;
    MDIO_m_busTrans trErr;
    if(this.st == 0) begin
      $display("Polling address 0x%h: @sim time %0d", addr, $time);
      this.writeAddr(phyAddr, devType, addr);
    end else begin
      // In Clause 22 mode "devType" is used as an address
      $display("Polling address 0x%h: @sim time %0d", devType, $time);
    end
    fork: poll
      begin
        repeat(pollTimeOut) @super.ifc.cb;
        trErr = new();
        trErr.genErrorMsg("ERROR: Master poll Time Out Detected");
        super.statusBox.put(trErr);
        trErr = null;
      end
      begin
        do begin
          this.readWord(dataOutPtr, phyAddr, devType);
          this.getWord(dataOutPtr, tempData16);
        end while(tempData16 != pollDataWord);
        $display("Poll Done!");
      end
    join_any
    disable poll;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- printStatus(): Print all time out errors and return errors count.*/
  /////////////////////////////////////////////////////////////////////////////
  function int printStatus();
    MDIO_m_busTrans tr;
    tr = new();
    printStatus = this.statusBox.num();
    while(this.statusBox.num() != 0)begin
      void'(this.statusBox.try_get(tr));
      $display(tr.failedTr);
    end
    tr = null;
  endfunction
  //
endclass //MDIO_m_env
//
endpackage
