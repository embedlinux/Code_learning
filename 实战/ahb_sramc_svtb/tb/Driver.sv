/*****************************************************
FileName    : Driver.sv
Auhtor	    : Jy
Data	      : 2011-6-8
Version	    : 0.10
Function    : It accepts a packet from generator, and
	            sends the whole signals according the 
	            AHB protocol.
------------------------------------------------------
Data	      : 2011-6-30
Version	    : 0.11
Modification: 1. The read Packet has changed to same with
	            send Packet, (the former is confused!)
	            2. Recall a perl to deal with read data
	            and address, put them into a file. (the
	            former is that data and address in the
	            different files!)
	            3. make the $finish task in the Driver,
	            (the former is in the program, and depend
	            on a fixed period, not flexible!)
------------------------------------------------------
Data	      : 2011-7-1
Version	    : 0.12
Modification: 1. Change the write and read operation's
	            data width according to HSIZE.
	            (the original is always a word data width)
*****************************************************/

class Driver;
  virtual AHB_if.master m_if;	// master ports interface
  string  name;			// unique identifier
  Packet  pkt2send;		// stimulus Packet object
  Packet  pkt_rdata;		// Packet which include read data	
  mailbox in_box;		// connect Generator
  logic wr_valid   = 0;		// indicate write data is valid
  logic rd_valid   = 0;		// indicate read data may be sent
  logic rd_valid_r = 0;		// indicate read data is valid, register "rd_valid" after a valid cycle
  logic[1:0]  trans_tmp_r = 0;	// register the "trans_tmp" after a valid cycl, used to BUSY state jude
  logic[31:0] haddr_tmp;	// used to store HADDR temporary
  logic[31:0] haddr_r = 0;	// register the "haddr_tmp" after a valid cycle, used to read operation
  logic[2:0]  hsize_r = 0;	// register the "hsize" after a valid cycle, used to read operation
  int run_after_n_packets = 0;	// actual transfer number
  int length;			// the length of burst
  int length_r = 0;		// register "length" after a valid cycle
  int idle_ctrl;		// decide weather BURSTs connect
  int rd_num = 0;		// record the read data number in a transaction
  event RD_DONE;		// indicate the read register operation is done.
  Table tab;			// a table which two queue store HADDR & HWDATA; another twos store HADDR & HRDATA

  // declare AHB signals in a transaction
  logic [AMBA_AHB_ADDR_WIDTH-1:0] haddr_q[$];
  logic	[2:0]			  hburst;
  logic				  hlock;
  logic	[3:0]			  hprot;
  logic	[2:0]			  hsize;
  logic	[1:0]			  htrans_q[$];
  logic [AMBA_AHB_DATA_WIDTH-1:0] hwdata_q[$];
  logic				  hwrite;
  logic [AMBA_AHB_DATA_WIDTH-1:0] hrdata_q[$];

  // function coverage
  covergroup trans_cov;
    coverpoint hburst;
    coverpoint hsize;
    coverpoint hwrite;
    cross hburst, hsize, hwrite;
  endgroup

  extern function new(string name="Driver", mailbox in_box, virtual AHB_if.master m_if, int idle_ctrl=1);
  // the main thread run start with the task
  extern virtual task start();
  // at the begining of simulation, reset the DUT's input
  extern virtual task reset();
  // the following 3 task run at the sam time, there are several control signals to control HWDATA & HRDATA output
  extern virtual task send_addr();
  extern virtual task send_wdata();
  extern virtual task recv_rdata();
endclass

// IDLE state between transactons controlled by "idle_ctrl", which is configued by function new().
function Driver::new(string name, mailbox in_box, virtual AHB_if.master m_if, int idle_ctrl);
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  this.name   	 = name;
  this.m_if   	 = m_if;
  this.in_box 	 = in_box;
  this.idle_ctrl = idle_ctrl;
  this.tab  	 = new();
  trans_cov 	 = new();
  pkt_rdata 	 = new();
endfunction

// reset the VIP_MASTER's output AHB signals
task Driver::reset();
  m_if.cb_master.haddr	 <= 0;
  m_if.cb_master.hburst	 <= 3'b0; 
  m_if.cb_master.hbusreq <= 0;
  m_if.cb_master.hlock	 <= 0;
  m_if.cb_master.hprot	 <= 4'b0;
  m_if.cb_master.hsize	 <= 3'h0;
  m_if.cb_master.htrans	 <= 2'h0; 
  m_if.cb_master.hwrite	 <= 1'h0;
  m_if.cb_master.hwdata	 <= 0;  
endtask

// send address and other control signals
task Driver::send_addr();
  int idle_cycle;
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  // the transaction's length
  length = haddr_q.size();
  // the number of idle state, after the transfer is over, depends on "idle_ctrl"
  if (idle_ctrl)
    idle_cycle = $urandom_range(1, 5);	
  else
    idle_cycle = 0;

  //-------------------------------------------------//
  // before send address, request the bus first;
  // when the first transaction is going over,
  // if there is no idle between the next transaction,
  // keep HBUSREQ high; otherwise down.
  //-------------------------------------------------//
  while(1) begin
    // after the reset is high, request bus
    if(m_if.reset_n) begin
      m_if.cb_master.hbusreq <= 1'b1;
      break;
    end
    else
      @(m_if.cb_master);
  end
      
  // start to send signals
  for(int i=0; ; ) begin
    // send IDLE state after a transaction is over, must wait HREADY is
    // high. (no need wait HGRANT && HREADY both high)
    wait(m_if.cb_master.hready_in);
    //-----------------------------------------------------------------------//
    // when a transaction is over, send the IDLE trans (random 0~5 cycle),
    // according "idle_ctrl" and the last transaction,
    // "idle_ctrl"=1: send IDLE state randomly;
    // "idle_ctrl"=0 & last transaction: send IDLE state;
    // "idle_ctrl"=0 & NOT last transaction: NO IDLE state, keep HBUSREQ high.
    //-----------------------------------------------------------------------//
    if(i == length) begin
      if(idle_ctrl) begin
	// send IDLE state
        m_if.cb_master.htrans <= 1'b0;
	// clear W/R indicate signals
        wr_valid <= 1'b0;
        rd_valid <= 1'b0;
	// repeat random cycles
        repeat(idle_cycle) begin
          wait(m_if.cb_master.hready_in);
          @(m_if.cb_master);
        end
	// the whole Packets has been sent, finish the simulation
        if(run_after_n_packets == run_for_n_packets) begin
	  repeat(50) @(m_if.cb_master);
	  tab.close();
	  $finish;
	end
      end
      else begin
        // if the whole transfers wre over, keep IDLE, low HBUSREQ, finish the simulation
        if(run_after_n_packets == run_for_n_packets) begin
	  // send IDLE state
          m_if.cb_master.htrans <= 1'b0;
	  // clear W/R indicate signals
          wr_valid <= 1'b0;
          rd_valid <= 1'b0;
	  // wait for 50 cycles, and finish the simulation
	  repeat(50) @(m_if.cb_master);
	  tab.close();
	  $finish;
	end
      end
      break;
    end

    //------------------------------------------------------------//
    // a transaction's HBUSREQ must stop at the (n-1)th cycle.
    // (must judge at the posedge of the HGRANT is high)
    // [NOTE] when HGRANT=1, the HBUSREQ=1 then =0(in a quick time),
    // so the HBUSREQ in the wave is low!
    //------------------------------------------------------------//
    wait(m_if.cb_master.hgrant);
    // (n-1)th HBUSREQ, according to "idle_ctrl", 
    // if the next cycle is IDLE, low HBUSREQ;
    // else if the whole transactions is over, low HBUSREQ;
    // else keep HBUSREQ high.
    if(i == length-1) begin
      // used to store the (n-1)th HTRANS, if it is BUSY state, keep HBUSREQ high
      // NOTE: in the end of the block, push it back
      logic[1:0] trans_n_1; 
      trans_n_1 = htrans_q.pop_front;
      // if the (n-1)th HTRANS is not BUSY state, do something
      if (trans_n_1 != 2'b01) begin
        // the next cycle is IDLE, low HBUSREQ 
        if (idle_ctrl)
          m_if.cb_master.hbusreq <= 1'b0;
        else begin
          // if the whole transfers wre over, keep IDLE, low HBUSREQ
          if (run_after_n_packets == run_for_n_packets) 
            m_if.cb_master.hbusreq <= 1'b0;
          // the next cycle is still work, keep HBUSREQ high
          else
            m_if.cb_master.hbusreq <= 1'b1;
        end
      end
      // NOTE: push the (n-1)th HTRANS back
      htrans_q.push_front(trans_n_1);
    end
    // if not the (n-1)th cycle, keep HBUSREQ high
    else
      m_if.cb_master.hbusreq <= 1'b1;

    // send address and other AHB control signals
    begin
      // used to store the current HTRANS signal
      logic[1:0] trans_tmp;
      trans_tmp = htrans_q.pop_front;
      // send AHB control signals
      // if HTRANS is NONSEQ or SEQ, send new address, else is BUSY keep stable
      if (trans_tmp_r!=2'b01) begin // NONSEQ or SEQ
	// "haddr_tmp" used to store current HADDR temporary, for late read operation
        haddr_tmp = haddr_q.pop_front;
        m_if.cb_master.haddr <= haddr_tmp;
      end
      m_if.cb_master.htrans  <= trans_tmp;
      m_if.cb_master.hburst  <= hburst;
      m_if.cb_master.hwrite  <= hwrite;
      m_if.cb_master.hsize   <= hsize;
      m_if.cb_master.hlock   <= hlock;
      m_if.cb_master.hprot   <= hprot;      
      trans_tmp_r	     <= trans_tmp;
      // sample the coverage
      //--trans_cov.sample();
      // set W/R indiacte signal
      if ((trans_tmp==2'b10) || (trans_tmp==2'b11)) begin // NONSEQ or SEQ
        if (hwrite) begin
          wr_valid <= 1'b1;
          rd_valid <= 1'b0;
        end
        else begin
          wr_valid <= 1'b0;
          rd_valid <= 1'b1;
        end
    	// control loop var, if HTRANS is NONSEQ or SEQ, add himself
    	i++; 
      end
      else if (trans_tmp==2'b01) begin // BUSY
	// if BUSY state, not sample HRDATA and HWDATA
        rd_valid <= 1'b0;
        wr_valid <= 1'b0;
      end
    end

    // judge at every posedge clock 
    @(m_if.cb_master);
  end
endtask

// according "wr_valid" send write data
task Driver::send_wdata();
  while(1)begin
    // "hwdata_tmp" used to store HWDATA from queue temporary
    logic[31:0] hwdata_tmp;
    // if the clock point is output HWDATA
    if (m_if.cb_master.hready_in && wr_valid) begin
      hwdata_tmp = hwdata_q.pop_front;
      // according to HISZE
      case(hsize)
        3'b010:       // WORD
      		   m_if.cb_master.hwdata 	<= hwdata_tmp;
        3'b001: begin //HALFWORD
	  case (haddr_tmp[1:0])
	    2'b00: m_if.cb_master.hwdata[15:0 ] <= hwdata_tmp;
	    2'b10: m_if.cb_master.hwdata[31:16] <= hwdata_tmp;
	  endcase
	end
        3'b000: begin //BYTE
	  case (haddr_tmp[1:0])
	    2'b00: m_if.cb_master.hwdata[7 :0 ] <= hwdata_tmp;
	    2'b01: m_if.cb_master.hwdata[15:8 ] <= hwdata_tmp;
	    2'b10: m_if.cb_master.hwdata[23:16] <= hwdata_tmp;
	    2'b11: m_if.cb_master.hwdata[31:24] <= hwdata_tmp;
	  endcase
	end
      endcase
    end
    @(m_if.cb_master);
  end
endtask

// according "m_if.rd_valid_r" receive read data
task Driver::recv_rdata();
fork
  // it is used to register signals that is useful to read operation
  while(1)begin
    if (m_if.cb_master.hready_in) begin
        rd_valid_r <= rd_valid;
	length_r   <= length;
	haddr_r    <= haddr_tmp;
	hsize_r    <= hsize;
    end
    @(m_if.cb_master);
  end
  
  // receive read data one transaction one time, after receive one transaction read data, record them
  while(1)begin
    // HREADY is high and read valid, begin to read data
    if (m_if.cb_master.hready_in && rd_valid_r) begin
      // according to HISZE
      case (hsize_r)
        3'b010:       // WORD
	           hrdata_q.push_back(m_if.cb_master.hrdata);
        3'b001: begin // HALFWORD
	  case (haddr_r[1:0])
	    2'b00: hrdata_q.push_back(m_if.cb_master.hrdata[15:0 ]);
	    2'b10: hrdata_q.push_back(m_if.cb_master.hrdata[31:16]);
	  endcase
	end
        3'b000: begin // BYTE
	  case (haddr_r[1:0])
	    2'b00: hrdata_q.push_back(m_if.cb_master.hrdata[7 :0 ]);
	    2'b01: hrdata_q.push_back(m_if.cb_master.hrdata[15:8 ]);
	    2'b10: hrdata_q.push_back(m_if.cb_master.hrdata[23:16]);
	    2'b11: hrdata_q.push_back(m_if.cb_master.hrdata[31:24]);
	  endcase
	end
      endcase

      // used to compute the number of read data
      rd_num++;
      // when the counter shows a transaction is over, put the read in the packet, wait to be record
      if (rd_num == length_r) begin
        pkt_rdata.hrdata_q = hrdata_q;
        pkt_rdata.hwrite = READ;
        // print the read data in the terminal
        foreach(hrdata_q[i])
          $display("hrdata[%0d] = %0h", i, hrdata_q[i]);
        $display("---------------------------------------------");
        // when a transaction is over, clear the data queue and counter
        hrdata_q.delete();
        rd_num = 0;
        // record the read data
        tab.record(pkt_rdata, 1'b0);
	// the flag of read register operation done
	-> RD_DONE;
      end
    end
    @(m_if.cb_master);
  end
join
endtask

// start the main thread
task Driver::start();
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  reset();
  fork
    forever begin
      in_box.get(pkt2send);
      // pkt2send.display("NOTE");
      run_after_n_packets++;
      // record the HADDR & HWDATA, or HADDR for read operation
      tab.record(pkt2send);
      // AHB signals evaluation
      this.haddr_q   = pkt2send.haddr_q;
      this.hburst    = pkt2send.hburst;
      this.hlock     = pkt2send.hlock;
      this.hprot     = pkt2send.hprot;
      this.hsize     = pkt2send.hsize;
      this.htrans_q  = pkt2send.htrans_q;
      this.hwdata_q  = pkt2send.hwdata_q;
      this.hwrite    = pkt2send.hwrite;
      // recall the address send task
      send_addr();
    end
    send_wdata();
    recv_rdata();
  join
endtask
