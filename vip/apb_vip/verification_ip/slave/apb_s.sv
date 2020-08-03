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

package APB_S;
typedef bit [31:0]   bit32;
typedef bit [7:0]    bit8;
typedef class APB_s_busTrans;
`ifdef VCS
typedef mailbox TransMBox;
`else
typedef mailbox #(APB_s_busTrans) TransMBox;
`endif
///////////////////////////////////////////////////////////////////////////////
// Class APB_s_busConfig:
///////////////////////////////////////////////////////////////////////////////
class APB_s_busConfig;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  int         DataBlockSize     = 4;
  // pready delay control
  rand int    preadyDelay       = 0;
  int         pollTimeOut       = 0;
  // Random delay constraints
  local int   maxPready         = 0;
  local int   minPready         = 0;
  // FIFO adresses
  bit32       inFifoAddr        = 32'h0;
  bit32       outFifoAddr       = 32'h0;
  int         fifoEn            = 0;
  // Slave error generation address space
  bit32       slaveErrStartAddr = 0;
  bit32       slaveErrEndAddr   = 0;
  int         slaveErrEn        = 0;
  // Constraints for "preadyDelay" random variable
  constraint c_preadyDelay {
                             preadyDelay inside {[minPready:maxPready]};
                           }
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- setRndDelay(): Enable "pready" random delays and set constraints.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setRndDelay(int minPready, maxPready);
    this.preadyDelay.rand_mode(1);
    this.maxPready         = maxPready;
    this.minPready         = minPready;
    this.genRndDelay();
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- genRndDelay(): Randomize all random variables in the class.*/
  /////////////////////////////////////////////////////////////////////////////
  function void genRndDelay();
    assert (this.randomize())
    else $fatal(0, "APB_s_busConfig: Randomize failed");
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setDelay(): Disable "pready" random delays and set to fixed value.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setDelay(int preadyDelay);
    this.preadyDelay.rand_mode(0);
    this.preadyDelay    = preadyDelay;
  endfunction
  //
endclass // APB_s_busConfig
///////////////////////////////////////////////////////////////////////////////
// Class APB_s_busTrans:
///////////////////////////////////////////////////////////////////////////////
class APB_s_busTrans;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  enum {WRITE, READ}           TrType;
  bit32                        address;
  bit32                        dataBlock;
  bit32                        TrNum;
  string                       failedTrInfo;
  //
endclass // APB_s_busTrans
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Class APB_s_busBFM:
///////////////////////////////////////////////////////////////////////////////
class APB_s_busBFM;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  virtual apb_s_if ifc;
  TransMBox trInBox, trOutBox, failedTrBox;
  local APB_s_busTrans tr;
  local APB_s_busConfig cfg;
  bit8  ram[bit32];
  // "TrNum": Is storing transactions count during all simulation time.
  local bit32 TrNum = 32'd0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Get virtual interface, in/out fifo and failed transaction
  //  mailboxes, configuration object handle and assign them to the internal
  //  variables.*/
  /////////////////////////////////////////////////////////////////////////////
  function new (virtual apb_s_if ifc, input TransMBox trInBox, trOutBox,
                failedTrBox, APB_s_busConfig cfg);
    this.ifc             = ifc;
    this.trInBox         = trInBox;
    this.trOutBox        = trOutBox;
    this.failedTrBox     = failedTrBox;
    this.cfg             = cfg;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- run_loop():*/
  /////////////////////////////////////////////////////////////////////////////
  task run_loop();
    // Set "pready" initial value. If "preadyDelay" is 0 then "pready" is 1.
    this.ifc.cb.pready  <= (this.cfg.preadyDelay == 0);
    // Set "pslverr" initial value to 0.
    this.ifc.cb.pslverr <= 1'b0;
    // Aligning with clock edge.
    this.ifc.clockAlign();
    forever begin
      this.TrNum++;
      this.tr = new();
      // Wait untill "psel" is 1 and "penable" is 0
      do begin
        @this.ifc.cb;
      end while((this.ifc.cb.psel !== 1'b1) || (this.ifc.cb.penable !== 1'b0));
      // "pready" will be always 1 if no delay specified
      this.ifc.cb.pready       <= (this.cfg.preadyDelay == 0);
      // Get address
      this.tr.address           = this.ifc.cb.paddr;
      // Set Slave error if address is inside slave error generation space
      if((this.tr.address >= this.cfg.slaveErrStartAddr) &&
         (this.tr.address <= this.cfg.slaveErrEndAddr) &&
         (this.cfg.slaveErrEn == 1)) begin
        this.ifc.cb.pslverr <= 1'b1;
      end
      // Get transaction type read/write
      if(this.ifc.cb.pwrite) begin
        this.tr.TrType = APB_s_busTrans::WRITE;
      end else begin
        this.tr.TrType = APB_s_busTrans::READ;
        // If "paddr" is equal to "outFifoAddr" and fifo mode is enabled then
        // data will be read from "trOutBox" mailbox.
        if((this.tr.address == this.cfg.outFifoAddr) && (this.cfg.fifoEn == 1)) begin
          // Set "pready" to 0 and get transaction is ready in the mailbox
          this.ifc.cb.pready       <= 1'b0;
          this.trOutBox.get(tr);
          this.ifc.cb.pready       <= (this.cfg.preadyDelay == 0);
        end else begin
          // Read from internal memory
          if(ram.exists(this.tr.address))
            this.tr.dataBlock[7:0]    = this.ram[this.tr.address];
          if(ram.exists((this.tr.address+1)))
            this.tr.dataBlock[15:8]   = this.ram[this.tr.address+1];
          if(ram.exists((this.tr.address+2)))
            this.tr.dataBlock[23:16]  = this.ram[this.tr.address+2];
          if(ram.exists((this.tr.address+3)))
            this.tr.dataBlock[31:24]  = this.ram[this.tr.address+3];
        end
        // Put data to the APB bus
        this.ifc.cb.prdata        <= this.tr.dataBlock;
      end
      // Delay "pready" if necessary
      if(this.cfg.preadyDelay != 0)repeat(this.cfg.preadyDelay-1)@this.ifc.cb;
      this.ifc.cb.pready          <= 1'b1;
      // Wait one clock cycle
      @this.ifc.cb;
      // "penable" must be active. If not generate protocol error
      if(this.ifc.cb.penable != 1'b1) begin
        string tempStr;
        this.tr.TrNum            = this.TrNum;
        tempStr.itoa($time);
        this.tr.failedTrInfo     = "Protocol error detected. penable is low.";
        this.tr.failedTrInfo     = {this.tr.failedTrInfo,
                                    "\nSimtime is ", tempStr, "ns"};
        this.failedTrBox.put(this.tr);
      end
      // After transaction is done we can set "pready" to 0 or leave it as is.
      // The best way is to do it randomly to cover more corner cases.
      if((this.cfg.preadyDelay != 0) && ($urandom_range(0, 1) == 1)) begin
        this.ifc.cb.pready        <= 1'b0;
      end
      // Randomize "preadyDelay" value
      this.cfg.genRndDelay();
      //
      if(this.tr.TrType == APB_s_busTrans::WRITE) begin
        this.tr.dataBlock            = this.ifc.cb.pwdata;
        // If "paddr" is equal to "inFifoAddr" and fifo mode is enabled then
        // data will be written to "trInBox" mailbox.
        if((this.tr.address == this.cfg.inFifoAddr) && (this.cfg.fifoEn == 1)) begin
          this.trInBox.put(this.tr);
        end else begin
          // Write data to internal memory
          this.ram[this.tr.address]     = this.tr.dataBlock[7:0];
          if(this.cfg.DataBlockSize >= 2) begin
            this.ram[this.tr.address+1] = this.tr.dataBlock[15:8];
          end
          if(this.cfg.DataBlockSize == 4) begin
            this.ram[this.tr.address+2] = this.tr.dataBlock[23:16];
            this.ram[this.tr.address+3] = this.tr.dataBlock[31:24];
          end
        end
      end
      this.tr = null;
    end
  endtask
  //
endclass // APB_s_busBFM
///////////////////////////////////////////////////////////////////////////////
// Class ABP_s_env:
///////////////////////////////////////////////////////////////////////////////
class ABP_s_env;
  /////////////////////////////////////////////////////////////////////////////
  //************************ Class Variables ********************************//
  /////////////////////////////////////////////////////////////////////////////
  local TransMBox trInBox, trOutBox, failedTrBox;
  virtual apb_s_if ifc;
  local APB_s_busBFM bfm;
  local APB_s_busConfig cfg;
  local int envStarted = 0;
  /////////////////////////////////////////////////////////////////////////////
  //************************* Class Methods *********************************//
  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  /*- new(): Connect physical interface to the virtual. Set APB data bus size.
  // Create in/out fifo and failed transaction mailboxes. Create new BFM and
  // configuration objects. Pass virtual interface, in/out fifo and failed
  // transaction mailboxes, configuration object handles to BFM class.*/
  /////////////////////////////////////////////////////////////////////////////
  function new(virtual apb_s_if ifc, int blockSize = 4);
    this.ifc               = ifc;
    this.trInBox           = new();
    this.trOutBox          = new();
    this.failedTrBox       = new();
    this.cfg               = new();
    this.bfm               = new (ifc, trInBox, trOutBox, failedTrBox, cfg);
    if ((blockSize == 1) || (blockSize == 2) || (blockSize == 4)) begin
      this.cfg.DataBlockSize = blockSize;
    end else begin
      $display("Error: Wrong block size is selected. It must be 1, 2 or 4");
      $finish;
    end
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- startEnv(): Start main loop in the BFM class.*/
  /////////////////////////////////////////////////////////////////////////////
  task startEnv();
    if(envStarted == 0) begin
      fork
        this.bfm.run_loop();
      join_none
      envStarted = 1;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- putData(): Put data buffer to the memory starting from "startAddr"
  // address. Input data buffer is a bytes sequence (SystemVerilog queue).
  // "dataInBuff" size should be multiple to "DataBlockSize". Otherwise buffer
  // size will be rounded up to be multiple to "DataBlockSize".*/
  /////////////////////////////////////////////////////////////////////////////
  task putData (input bit32 startAddr, bit8 dataInBuff[$]);
    bit32 tempData;
    for (int i = 0; i < dataInBuff.size(); i+=this.cfg.DataBlockSize) begin
      tempData[7:0]     = dataInBuff[i];
      tempData[15:8]    = dataInBuff[i+1];
      tempData[23:16]   = dataInBuff[i+2];
      tempData[31:24]   = dataInBuff[i+3];
      this.putWord((startAddr+i), tempData);
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- putWord(): Put data word to the memory. Data word is a 32 bit vector.
  //  If "this.cfg.DataBlockSize == 1" only dataWord[7:0]  will be written.
  //  If "this.cfg.DataBlockSize == 2" only dataWord[15:0] will be written.
  //  If "this.cfg.DataBlockSize == 4" full dataWord will be written.*/
  /////////////////////////////////////////////////////////////////////////////
  function void putWord (input bit32 address, dataWord);
    this.bfm.ram[address]   = dataWord[7:0];
    if(this.cfg.DataBlockSize >= 2) begin
      this.bfm.ram[address+1] = dataWord[15:8];
    end
    if(this.cfg.DataBlockSize == 4) begin
      this.bfm.ram[address+2] = dataWord[23:16];
      this.bfm.ram[address+3] = dataWord[31:24];
    end
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- getWord(): Get data word from the memory. Data word is a 32 bit vector.*/
  //  If "this.cfg.DataBlockSize == 1" only 1 bytes will be read.
  //  If "this.cfg.DataBlockSize == 2" only 2 bytes will be read.
  //  If "this.cfg.DataBlockSize == 4" 4 bytes will be read.
  /////////////////////////////////////////////////////////////////////////////
  function bit32 getWord (input bit32 address);
    getWord        = 'h0;
    if(this.bfm.ram.exists(address))
      getWord[7:0]   = this.bfm.ram[address];
    if((this.cfg.DataBlockSize >= 2) && (this.bfm.ram.exists(address+1))) begin
      getWord[15:8]  = this.bfm.ram[address+1];
    end
    if((this.cfg.DataBlockSize == 4) && (this.bfm.ram.exists(address+2)) &&
                                        (this.bfm.ram.exists(address+3))) begin
      getWord[23:16] = this.bfm.ram[address+2];
      getWord[31:24] = this.bfm.ram[address+3];
    end
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- getData(): Get data buffer from the memory starting from "startAddr"
  // address. Output data buffer is a bytes sequence (SystemVerilog queue).*/
  /////////////////////////////////////////////////////////////////////////////
  task getData(input bit32 startAddr, output bit8 dataOutBuff[$], input int lenght);
    bit32 dataOut;
    dataOutBuff = {};
    for(int i = 0; i < lenght; i+=this.cfg.DataBlockSize) begin
      if(this.bfm.ram.exists(startAddr+i))
        dataOut[7:0]   =  this.bfm.ram[startAddr+i];
      if(this.bfm.ram.exists(startAddr+i+1))
        dataOut[15:8]  = this.bfm.ram[startAddr+i+1];
      if(this.bfm.ram.exists(startAddr+i+2))
        dataOut[23:16] = this.bfm.ram[startAddr+i+2];
      if(this.bfm.ram.exists(startAddr+i+3))
        dataOut[31:24] = this.bfm.ram[startAddr+i+3];

      if (this.cfg.DataBlockSize == 4) begin
        dataOutBuff = {dataOutBuff, dataOut[7:0], dataOut[15:8],
                       dataOut[23:16], dataOut[31:24]};
      end else if (this.cfg.DataBlockSize == 2) begin
        dataOutBuff = {dataOutBuff, dataOut[7:0], dataOut[15:8]};
      end else begin
        dataOutBuff = {dataOutBuff, dataOut[7:0]};
      end
    end
    dataOutBuff = dataOutBuff[0:lenght-1];
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- pollWord(): Polling "pollAddr" internal memory address until the data
  //  match with expected one or time out detection.*/
  /////////////////////////////////////////////////////////////////////////////
  task pollWord(bit32 pollAddr, pollData);
    APB_s_busTrans tr;
    int pollCounter   = 0;
    bit32 tempData    = this.getWord(pollAddr);
    $display("Polling data at address 0x%h: @sim time %0d", pollAddr, $time);
    while ((tempData != pollData) && ((pollCounter != this.cfg.pollTimeOut) ||
            this.cfg.pollTimeOut == 0)) begin
      @this.ifc.cb;
      pollCounter++;
      tempData = this.getWord(pollAddr);
    end
    if(tempData == pollData) begin
      $display("Poll Done!");
    end else begin
      string tempStr;
      tr = new();
      $display("Poll Time Out Detected at sim time %0d", $time());
      tempStr.itoa($time);
      tr.failedTrInfo     = "Poll TimeOut detected. At simulation time ";
      tr.failedTrInfo     = {tr.failedTrInfo, tempStr, "ns"};
      this.failedTrBox.put(tr);
      tr = null;
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeFifo(): Push data buffer to the output FIFO.
  //  Data buffer is a bytes sequence (SystemVerilog queue).*/
  /////////////////////////////////////////////////////////////////////////////
  task writeFifo(bit8 dataInBuff[$]);
    for (int i = 0; i < dataInBuff.size(); i+=this.cfg.DataBlockSize) begin
      this.writeFifoWord({dataInBuff[3], dataInBuff[2], dataInBuff[1], dataInBuff[0]});
      dataInBuff = dataInBuff[this.cfg.DataBlockSize:$];
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- writeFifoWord(): Push one block data to the output FIFO.*/
  /////////////////////////////////////////////////////////////////////////////
  task writeFifoWord(bit32 dataWord);
    APB_s_busTrans tr = new();
    tr.dataBlock = dataWord;
    this.trOutBox.put(tr);
    tr = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- readFifo(): Pop "lenght" byte amount data from input FIFO and put it into
  // "dataOutBuff" buffer. Output data buffer is a bytes sequence
  //(SystemVerilog queue).
  // "lenght" should be multiple to "DataBlockSize". Otherwise output buffer
  // size will be rounded up to be multiple to "DataBlockSize".*/
  /////////////////////////////////////////////////////////////////////////////
  task readFifo(output bit8 dataOutBuff[$], input int lenght);
    bit32 dataOut;
    dataOutBuff = {};
    for(int i = 0; i < lenght; i+=this.cfg.DataBlockSize) begin
      this.readFifoWord(dataOut);
      if (this.cfg.DataBlockSize == 4) begin
        dataOutBuff = {dataOutBuff, dataOut[7:0], dataOut[15:8],
                       dataOut[23:16], dataOut[31:24]};
      end else if (this.cfg.DataBlockSize == 2) begin
        dataOutBuff = {dataOutBuff, dataOut[7:0], dataOut[15:8]};
      end else begin
        dataOutBuff = {dataOutBuff, dataOut[7:0]};
      end
    end
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- readFifoWord(): Pop one block data from input FIFO.*/
  /////////////////////////////////////////////////////////////////////////////
  task readFifoWord(output bit32 dataWord);
    APB_s_busTrans tr = new();
    bit32 mask      = 32'hffffffff;
    int pollCounter = 0;
    int dataWidth   = this.cfg.DataBlockSize*8;
    dataWord        = 'h0;
    fork: readFifoWordPoll
      this.trInBox.peek(tr);
      while ((pollCounter != this.cfg.pollTimeOut) || (this.cfg.pollTimeOut == 0)) begin
        @this.ifc.cb;
        pollCounter++;
      end
    join_any
    disable readFifoWordPoll;
    if(this.trInBox.num() != 0) begin
      this.trInBox.get(tr);
    end else begin
      string tempStr;
      $display("FIFO read Time Out Detected at sim time %0d", $time());
      tempStr.itoa($time);
      tr.failedTrInfo     = "FIFO read Time Out detected. At simulation time ";
      tr.failedTrInfo     = {tr.failedTrInfo, tempStr, "ns"};
      this.failedTrBox.put(tr);
    end
    dataWord = tr.dataBlock;
    mask >>= (32 - this.cfg.DataBlockSize*8);
    dataWord &= mask;
    tr = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- fifoReset(): Clear all transactions in the in/out FIFOs.*/
  /////////////////////////////////////////////////////////////////////////////
  task fifoReset();
    APB_s_busTrans tr = new();
    // Clearing transactions in the input mailbox
    while(this.trInBox.num() != 0) this.trInBox.get(tr);
    // Clearing transactions in the output mailbox
    while(this.trOutBox.num() != 0) this.trOutBox.get(tr);
    tr = null;
  endtask
  /////////////////////////////////////////////////////////////////////////////
  /*- setPollTimeOut(): Set the maximum number of wait clock cycles after which
  // poll time out error will be generated.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setPollTimeOut(int pollTimeOut);
    this.cfg.pollTimeOut = pollTimeOut;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setDelay(): Set "pready" timing delay. After valid "psel" the "pready"
  // will wait for the specified amount of clock cycles and then go to high.
  // This function disables random delays if those are enabled.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setDelay(int preadyDelay);
    this.cfg.setDelay(preadyDelay);
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- rndDelayEn(): Enable "pready" timing random delays and specify minimum
  // and maximum constraints.*/
  /////////////////////////////////////////////////////////////////////////////
  function void rndDelayEn(int minPready, maxPready);
    this.cfg.setRndDelay(minPready, maxPready);
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setFifoAddr(): Set input and output FIFO addresses and enable FIFO mode.
  //  Each APB read/write transaction from/to outFifoAddr/inFifoAddr addresses
  //  will be directed to output and input FIFOs.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setFifoAddr(bit32 inFifoAddr, outFifoAddr);
    this.cfg.inFifoAddr        = inFifoAddr;
    this.cfg.outFifoAddr       = outFifoAddr;
    this.cfg.fifoEn            = 1;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- disableFifoMode(): Disable FIFO mode. outFifoAddr/inFifoAddr addresses
  //  will be switched to usual memory addresses.*/
  /////////////////////////////////////////////////////////////////////////////
  function void disableFifoMode();
    this.cfg.fifoEn            = 0;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- setSlaveErrAddr(): Set input and output FIFO addresses and enable FIFO mode.
  //  Each APB read/write transaction from/to outFifoAddr/inFifoAddr addresses
  //  will be directed to output and input FIFOs.*/
  /////////////////////////////////////////////////////////////////////////////
  function void setSlaveErrAddr(bit32 startAddr, endAddr);
    this.cfg.slaveErrStartAddr        = startAddr;
    this.cfg.slaveErrEndAddr          = endAddr;
    this.cfg.slaveErrEn               = 1;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- disableSlaveErr(): Disable slave error generation.*/
  /////////////////////////////////////////////////////////////////////////////
  function void disableSlaveErr();
    this.cfg.slaveErrEn      = 0;
  endfunction
  /////////////////////////////////////////////////////////////////////////////
  /*- printFailedTrInfo(): Print all time out errors if those exist. Return
  // integer which contains amount of all errors.*/
  /////////////////////////////////////////////////////////////////////////////
  function int printFailedTrInfo();
    APB_s_busTrans tr = new();
    printFailedTrInfo = this.failedTrBox.num();
    while(this.failedTrBox.num() != 0)begin
      void'(this.failedTrBox.try_get(tr));
      $display(tr.failedTrInfo);
    end
    tr = null;
  endfunction
  //
endclass // ABP_s_env
//
endpackage
