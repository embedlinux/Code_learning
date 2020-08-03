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

package APB_M;
typedef bit [31:0]   bit32;
typedef bit [7:0]    bit8;
typedef class APB_m_busTrans;
`ifdef VCS
typedef mailbox TransMBox;
`else
typedef mailbox #(APB_m_busTrans) TransMBox;
`endif
///////////////////////////////////////////////////////////////////////////////
// Class APB_m_busConfig:
///////////////////////////////////////////////////////////////////////////////
class APB_m_busConfig;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  int         DataBlockSize     = 4;
  // Time Out control Variables
  int         preadyTimeOut     = 256;
  int         pollTimeOut       = 0;
  string      timeOutMsg        = "Polling TimeOut pready";
  string      slaveErrorMsg     = "Slave error detected";
  // Burst length and wait Cycles control Variables
  rand int    burstLength       = 0;
  rand int    waitCycle         = 0;
  // Random delay constraints
  local int   maxBurst          = 0;
  local int   minBurst          = 0;
  local int   maxWaitCycle      = 0;
  local int   minWaitCycle      = 0;
  // Constraints for "burstLength" and "waitCycle" random variable
  constraint c_burst {
                        burstLength inside {[minBurst:maxBurst]};
                        waitCycle   inside {[minWaitCycle:maxWaitCycle]};
                     }
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- setRndDelay(): Enable random delays and set constraints for burst
  // length and wait cycle.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setRndDelay(int minBurst, maxBurst, minWaitCycle, maxWaitCycle);
    this.burstLength.rand_mode(1);
    this.waitCycle.rand_mode(1);
    this.maxBurst       = maxBurst;
    this.minBurst       = minBurst;
    this.maxWaitCycle   = maxWaitCycle;
    this.minWaitCycle   = minWaitCycle;
    this.genRndDelay();
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- genRndDelay(): Randomize all random variables in the class.*/
  /////////////////////////////////////////////////////////////////////////////
  function void genRndDelay();
    assert (this.randomize())
    else $fatal(0, "APB_m_busConfig: Randomize failed");
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setDelay(): Disable random delays and set fixed values for burst length
  // and wait cycle.
  // "burstLength" - burst length is the maximum number of blocks during which
  //                 "psel" signal can be continuously high
  // "waitCycle"  -  wait cycle is the minimum number of clock cycles when
  //                 "psel" signal will be low after reaching "burstLength".*/
  /////////////////////////////////////////////////////////////////////////////
  function void setDelay(int burstLength, waitCycle);
    this.burstLength.rand_mode(0);
    this.waitCycle.rand_mode(0);
    this.burstLength    = burstLength;
    this.waitCycle      = waitCycle;
  endfunction
  //
endclass // APB_m_busConfig
///////////////////////////////////////////////////////////////////////////////
// Class APB_m_busTrans:
///////////////////////////////////////////////////////////////////////////////
class APB_m_busTrans;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  enum {WRITE, READ, IDLE}     TrType;
  bit32                        address;
  bit32                        dataIn;
  bit32                        dataOut;
  bit32                        TrNum;
  int                          idleCycles;
  string                       failedTrInfo;
  //
endclass // APB_m_busTrans
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Class APB_m_busBFM:
///////////////////////////////////////////////////////////////////////////////
class APB_m_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  virtual apb_m_if ifc;
  TransMBox trInBox, trOutBox, trResetInBox, trResetOutBox, failedTrBox;
  local APB_m_busTrans tr;
  local APB_m_busConfig cfg;
  local int blockCnt = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Takes physical interface as an input value and connects it to
  // virtual interface. Takes input, output and reset mailbox references
  // created in the APB_env class and assigns them to internal
  // mailboxes ("trInBox", "trOutBox", "trResetInBox", "trResetOutBox").
  // Mailboxes declared here and created in APB_env class will point to the
  // same objects.*/
  /////////////////////////////////////////////////////////////////////////////
  function new (virtual apb_m_if ifc,
                input TransMBox trInBox, trOutBox, trResetInBox, trResetOutBox,
                failedTrBox, APB_m_busConfig cfg);
    this.ifc             = ifc;
    this.trInBox         = trInBox;
    this.trOutBox        = trOutBox;
    this.trResetInBox    = trResetInBox;
    this.trResetOutBox   = trResetOutBox;
    this.failedTrBox     = failedTrBox;
    this.cfg             = cfg;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- blockReadWrite(): Generates APB bus read/write timings. Gets address,
  //  data and transaction type(read/write) from APB_m_busTrans class.
  // Configuration is stored in the APB_m_busConfig class. This function will
  // write or read one block data and report failed transaction information.*/
  /////////////////////////////////////////////////////////////////////////////
  local task blockReadWrite();
    int timeOutCnt = 0;
    string faildInfo, tempStr;
    // Aligning with the clock edge
    this.ifc.clockAlign();
    // Starting write block.
    ifc.cb.pwrite    <= (this.tr.TrType == APB_m_busTrans::WRITE);
    ifc.cb.psel      <= 1'b1;
    // Getting current data block address from APB_m_busTrans class
    ifc.cb.paddr   <= this.tr.address;
    // Getting data form input buffer in the APB_m_busTrans class. Depends from
    // block size it can be 1, 2, or 4 bytes.
    ifc.cb.pwdata  <= this.tr.dataIn;
    @ifc.cb;
    blockCnt++;
    ifc.cb.penable <= 1'b1;
    // Waiting for APB "pready" signal to finish current block processing.
    // "pready" will be polled untill "preadyTimeOut" value defined in the
    // APB_m_busConfig class.
    do begin
      @ifc.cb;
      if (((timeOutCnt == this.cfg.preadyTimeOut) && (ifc.cb.pready == 1'b0))||
          ((ifc.cb.pready == 1'b1) && (ifc.cb.pslverr == 1'b1))) begin
        // If time out or slave error detected put failed transaction number
        // and information to the "failedTrBox" mailbox and finish current
        // transaction.
        faildInfo.itoa(this.tr.TrNum);
        if(ifc.cb.pslverr == 1'b1) begin
          faildInfo = {"Slave error detected. Transaction number is ",faildInfo};
          $display(this.cfg.slaveErrorMsg);
        end else begin
          faildInfo = {"TimeOut detected. Transaction number is ", faildInfo};
          $display(this.cfg.timeOutMsg);
        end
        faildInfo = {faildInfo, "\nSimulation time is "};
        tempStr.itoa($time);
        faildInfo = {faildInfo, tempStr, "ns"};
        this.tr.failedTrInfo = faildInfo;
        this.failedTrBox.put(this.tr);
        break;
      end
      timeOutCnt++;
    end while (ifc.cb.pready == 1'b0);
    // Putting read data from APB prdata bus into the data out buffer in
    // APB_m_busTrans class.
    this.tr.dataOut = ifc.cb.prdata;
    ifc.cb.penable    <= 1'b0;
    ifc.cb.psel       <= 1'b0;
    if ((blockCnt >= this.cfg.burstLength) && (this.cfg.burstLength != 0)) begin
      blockCnt = 0;
      repeat(this.cfg.waitCycle) @ifc.cb;
      this.cfg.genRndDelay();
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- resetTrans(): Clears transaction input, output and reset mailboxes. Sets
  // all APB output signals to '0'.*/
  /////////////////////////////////////////////////////////////////////////////
  task resetTrans();
    // Aligning with the clock edge
    this.ifc.clockAlign();
    ifc.cb.psel     <= 1'b0;
    ifc.cb.penable  <= 1'b0;
    ifc.cb.pwrite   <= 1'b0;
    // Clearing transactions in the input mailbox
    while(this.trInBox.num() != 0) this.trInBox.get(tr);
    // Clearing transactions in the output mailbox
    while(this.trOutBox.num() != 0) this.trOutBox.get(tr);
    // Clearing transactions in the reset input mailbox
    while(this.trResetInBox.num() != 0) this.trResetInBox.get(tr);
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- busIdle(): Hold bus in idle for corresponding clock cycles.*/
  /////////////////////////////////////////////////////////////////////////////
  task busIdle();
    // Aligning with the clock edge
    this.ifc.clockAlign();
    repeat(this.tr.idleCycles) @ifc.cb;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- run_loop(): Poll "trResetInBox" and "trInBox" mailboxes until one of them
  // is not empty. Check which mailbox is not empty and call corresponding
  // function.*/
  /////////////////////////////////////////////////////////////////////////////
  task run_loop();
    forever begin
      // Poll "trResetInBox" and "trInBox" mailboxes. If one of them is not
      // empty disable fork statement
      fork: poll_mboxes
        this.trResetInBox.peek(tr);
        this.trInBox.peek(tr);
      join_any
      disable poll_mboxes;
      // Check which mailbox is not empty and call corresponding function
      if(this.trResetInBox.num()!=0) begin
        this.trResetInBox.get(this.tr);
        this.resetTrans();
        this.trResetOutBox.put(this.tr);
      end else if (this.trInBox.num()!=0) begin
        this.trInBox.get(this.tr);
        if(this.tr.TrType == APB_m_busTrans::IDLE) begin
          this.busIdle();
        end else begin
          this.blockReadWrite();
        end
        // During read transaction put read data to the "trOutBox"
        if(this.tr.TrType == APB_m_busTrans::READ)begin
          this.trOutBox.put(tr);
        end
      end
    end
  endtask
  //
endclass // APB_m_busBFM
///////////////////////////////////////////////////////////////////////////////
// Class ABP_m_env:
///////////////////////////////////////////////////////////////////////////////
class ABP_m_env;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local TransMBox trInBox, trOutBox, trResetInBox, trResetOutBox, failedTrBox;
  virtual apb_m_if ifc;
  local APB_m_busTrans tr;
  local APB_m_busBFM bfm;
  local APB_m_busConfig cfg;
  // "TrNum": Is storing transactions count during all simulation time.
  local bit32 TrNum = 32'd0;
  local int envStarted = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Takes physical interface as an input value and connects it to
  // virtual interface. Creates transaction and reset mailboxes and new
  // configuration and BFM objects.*/
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual apb_m_if ifc, int blockSize = 4);
    this.ifc               = ifc;
    this.trInBox           = new();
    this.trOutBox          = new();
    this.trResetInBox      = new();
    this.trResetOutBox     = new();
    this.failedTrBox       = new();
    this.cfg               = new();
    this.bfm               = new (ifc, trInBox, trOutBox, trResetInBox,
                                trResetOutBox, failedTrBox, cfg);
    if ((blockSize == 1) || (blockSize == 2) || (blockSize == 4)) begin
      this.cfg.DataBlockSize = blockSize;
    end else begin
      $display("Error: Wrong block size is selected. It must be 1, 2 or 4");
      $finish;
    end
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- startEnv(): Starts main loop in the BFM class. Only after this task
  // transactions will appear on the APB bus.*/
  /////////////////////////////////////////////////////////////////////////////
  task startEnv();
    if(envStarted == 0) begin
      fork
        this.bfm.run_loop();
      join_none
      this.EnvReset();
      this.envStarted = 1;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeData(): Gets input data buffer and start address. Creates new write
  // transactions and puts them into the "trInBox" input mailbox.
  // Input data buffer is a bytes sequence (SystemVerilog queue). Each
  // transaction is one block. Block size is defined in the configuration
  // class and can be 1, 2 or 4 bytes.
  // "addrIncr" parameter will enable or disable address increment after each
  // block transaction. If it is enabled address will be incremented by
  // "DataBlockSize" value after each transmit. "DataBlockSize" is defined in
  // the configuration class.*/
  /////////////////////////////////////////////////////////////////////////////
  task writeData(input bit32 address, bit8 dataInBuff[$], int addrIncr = 1);
    bit32 dataWord;
    for (int i = 0; i < dataInBuff.size(); i+=this.cfg.DataBlockSize) begin
      dataWord = {dataInBuff[i+3], dataInBuff[i+2],
                  dataInBuff[i+1], dataInBuff[i]};
      this.writeWord(address, dataWord);
      if(addrIncr == 1) begin
        address += this.cfg.DataBlockSize;
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeWord(): Create one write transaction and put it into the "trInBox"
  //  input mailbox.*/
  /////////////////////////////////////////////////////////////////////////////
  task writeWord(input bit32 address, dataWord);
    this.tr         = new();
    this.tr.TrType  = APB_m_busTrans::WRITE;
    this.tr.address = address;
    this.tr.dataIn  = dataWord;
    TrNum++;
    this.tr.TrNum   = TrNum;
    this.trInBox.put(this.tr);
    this.tr = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- readData(): Gets data length(amount of data in bytes which should be read
  // form APB bus) and start address. Creates new read transactions and puts
  // them into the "trInBox" input mailbox. Each
  // transaction is one block. Block size is defined in the configuration class
  // and can be 1, 2 or 4 bytes.
  // "addrIncr" parameter will enable or disable address increment after each
  // block transaction. If it is enabled address will be incremented by
  // "DataBlockSize" value after each transmit. "DataBlockSize" is defined in
  // the configuration class.
  // Waits untill all data was read and get it from "trOutBox" output mailbox.
  // Output data buffer is a bytes sequence (SystemVerilog queue)*/
  /////////////////////////////////////////////////////////////////////////////
  task readData(input bit32 address, output bit8 dataOutBuff[$],
                input int lenght, addrIncr = 1);
    bit32 dataWord;
    dataOutBuff = {};
    for(int i = 0; i < lenght; i+=this.cfg.DataBlockSize) begin
      this.readWord(address, dataWord);
      if(addrIncr == 1) begin
        address += this.cfg.DataBlockSize;
      end
      if (this.cfg.DataBlockSize == 4) begin
        dataOutBuff = {dataOutBuff, dataWord[7:0], dataWord[15:8],
                       dataWord[23:16], dataWord[31:24]};
      end else if (this.cfg.DataBlockSize == 2) begin
        dataOutBuff = {dataOutBuff, dataWord[7:0], dataWord[15:8]};
      end else begin
        dataOutBuff = {dataOutBuff, dataWord[7:0]};
      end
    end
    dataOutBuff = dataOutBuff[0:lenght];
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- readWord(): Create one read transaction and put it into the "trInBox"
  //  input mailbox. Wait untill data block will be read and get it from
  // "trOutBox" output mailbox.*/
  /////////////////////////////////////////////////////////////////////////////
  task readWord(input bit32 address, output bit32 dataWord);
    bit32 mask      = 32'hffffffff;
    this.tr         = new();
    this.tr.TrType  = APB_m_busTrans::READ;
    this.tr.address = address;
    TrNum++;
    this.tr.TrNum   = TrNum;
    this.trInBox.put(this.tr);
    this.trOutBox.get(this.tr);
    dataWord        = this.tr.dataOut;
    mask >>= (32 - this.cfg.DataBlockSize*8);
    dataWord &= mask;
    this.tr = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- pollWord(): Poll specified address until read data is equal to pollData.
  // If poll counter is reached to "pollTimeOut" value stop polling and
  // generate error message. Poll counter is incrementing after each read
  // transaction. If "pollTimeOut" is null then poll time out never occur.*/
  /////////////////////////////////////////////////////////////////////////////
  task pollWord(input bit32 address, pollData);
    bit32 dataWord;
    int pollCounter = 0;
    $display("Polling address 0x%h: @sim time %0d", address, $time);
    do begin
      this.readWord(address, dataWord);
      pollCounter++;
    end while((dataWord != pollData) &&
              ((pollCounter != this.cfg.pollTimeOut) ||
               (this.cfg.pollTimeOut == 0)));
    if(dataWord == pollData) begin
      $display("Poll Done!");
    end else begin
      string tempStr;
      APB_m_busTrans tr = new();
      $display("Poll Time Out Detected at sim time %0d", $time());
      tempStr.itoa($time);
      tr.failedTrInfo     = "Poll TimeOut detected. At simulation time ";
      tr.failedTrInfo     = {tr.failedTrInfo, tempStr, "ns"};
      this.failedTrBox.put(tr);
    end
    tr = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- EnvReset(): Puts reset transaction into the "trResetInBox" input mailbox
  // and waits untill reset is done. Gets reset done information from
  // "trResetOutBox" output mailbox. This function is clearing all mailboxes.*/
  /////////////////////////////////////////////////////////////////////////////
  task EnvReset();
    this.tr      = new();
    this.trResetInBox.put(tr);
    this.trResetOutBox.get(tr);
    this.tr = null;
    this.TrNum = 32'd0;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- busIdle(): Hold bus in idle for specified clock cycles.*/
  /////////////////////////////////////////////////////////////////////////////
  task busIdle(int idleCycles);
    this.tr             = new();
    this.tr.TrType      = APB_m_busTrans::IDLE;
    this.tr.idleCycles  = idleCycles;
    this.trInBox.put(this.tr);
    this.tr             = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setPollTimeOut(): Set poll time out value.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setPollTimeOut(int pollTimeOut);
    this.cfg.pollTimeOut = pollTimeOut;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setPreadyTimeOut(): Set maximum number of "pready" wait cycles. After
  // activating "penable" the BFM will wait for valid "pready" signal. If
  // maximum number of clock cycles is reached BFM will finish current block
  // transaction, generate time out message and continue with next transaction.
  // If the maximum number is set to '0' the "pready" should be valid during
  // the same clock cycle as "penable".*/
  /////////////////////////////////////////////////////////////////////////////
  function void setPreadyTimeOut(int timeOutCycles);
    this.cfg.preadyTimeOut = timeOutCycles;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setDelay(): Sets APB bus timing delays. "burstLength" is the maximum
  // number of blocks when "psel" signal can be continuously high. After
  // reaching this value "psel" will be set to '0' and wait "waitCycle" clock
  // cycles. "burstLength" default value is 0 which means no delay.
  // "minWait" default value is 2.
  // This function disables random delays if those are enabled.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setDelay(int burstLength, waitCycle);
    this.cfg.setDelay(burstLength, waitCycle);
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- rndDelayEn(): Enables APB bus timing random delays and sets min and max
  // constraints. Random delays will be in a range specified in the
  // "minBurst".."maxBurst" and "minWaitCycle".."maxWaitCycle" parameters.*/
  /////////////////////////////////////////////////////////////////////////////
  function void rndDelayEn(int minBurst, maxBurst, minWaitCycle, maxWaitCycle);
    this.cfg.setRndDelay(minBurst, maxBurst, minWaitCycle, maxWaitCycle);
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setErrMsgs(): Sets error message texts wich will be displayed during
  // time out or slave errors.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setErrMsgs(string timeOutMsg, slaveErrorMsg);
    this.cfg.timeOutMsg     = timeOutMsg;
    this.cfg.slaveErrorMsg  = slaveErrorMsg;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- printFailedTrInfo(): Will print all error information and return '0' if
  // any errors (timeout or slave error) detected during transactions.
  // Otherwise will return '1'.*/
  /////////////////////////////////////////////////////////////////////////////
  function int printFailedTrInfo();
    this.tr = new();
    printFailedTrInfo = this.failedTrBox.num();
    while(this.failedTrBox.num() != 0)begin
      void'(this.failedTrBox.try_get(tr));
      $display(this.tr.failedTrInfo);
    end
    this.tr = null;
  endfunction
  //
endclass // ABP_m_env
//
endpackage
