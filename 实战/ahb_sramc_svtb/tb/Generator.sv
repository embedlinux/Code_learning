/*****************************************************
FileName    : Generator.sv
Auhtor	    : Jy
Data	      : 2011-6-8
Version	    : 0.10
Function    : It is used to generate transfer packets,
	            and mail to driver.
------------------------------------------------------
Data	      : 2011-6-29
Version	    : 0.11
Function    : It add BUSY state insert, default is NO
	            BUSY state, if config "usr_busy_insert",
	            it insert BUSY state.
*****************************************************/

class Generator;
  string      name;

  Packet      pkt2send;
  mailbox     out_box;

  logic[1:0]  usr_def_mode = 2'b00;   // 00:random test; 01: config register; 10: random test register; 11:reserved (default random test)
  logic	      usr_busy_insert = 1'b0; // insert BUSY state, 1:yes, 0:no (default no BUSY insert)
  logic[31:0] def_addr_q[$]; 	      // user define haddr
  logic[2:0]  def_burst;     	      // user define hburst
  logic[2:0]  def_size;	     	      // user define hsize
  logic	      def_write;     	      // user define hwrite
  logic[31:0] def_wdata_q[$];	      // user define hwdata
  logic	      def_lock;	     	      // user define hlock
  logic[3:0]  def_prot;      	      // user define hprot

  extern function new(string name = "Generator");
  // user config the test mode and BUSY state insert
  extern virtual task cfg(logic[1:0]  usr_def_mode = 2'b00,
  			  logic       usr_busy_insert = 1'b0, 
  			  logic[31:0] def_addr_q[$], 
		          logic[2:0]  def_burst = 3'h0, 
		          logic[2:0]  def_size = 3'h0, 
		          logic       def_write = 1'b0, 
		          logic[31:0] def_wdata_q[$],
			  logic	      def_lock = 1'b0,
			  logic[3:0]  def_prot = 4'h0);
  // generate random transaction,
  // "reg_cfg_addr" used to judge whether reg_test mode, (default: normal random)
  // (32'hFFFF_FFFF:normal random transaction, others:register test mode)
  extern virtual task gen_rand(logic[31:0] reg_cfg_addr = 32'hFFFF_FFFF);
  // generate the user config transaction
  extern virtual task gen_cfg();
  // deal with HTRANS signal depends on transaction
  extern virtual task trans_type_input();
  // start the main thread
  extern virtual task start();
endclass

function Generator::new(string name); 
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  this.name = name;
  this.pkt2send = new();
  this.out_box  = new();
endfunction

//-----------------------------------------//
// user config generator, input AHB signals,
// random mode do not need.
//-----------------------------------------//
task Generator::cfg(logic[1:0] usr_def_mode, logic usr_busy_insert, logic[31:0] def_addr_q[$],
		    logic[2:0] def_burst,    logic[2:0]  def_size,
		    logic def_write,         logic[31:0] def_wdata_q[$],
		    logic def_lock, 	     logic[3:0]  def_prot);
  // user define himself
  this.usr_def_mode    = usr_def_mode;	  // default: randomize
  this.usr_busy_insert = usr_busy_insert; // default: no BUSY insert
  this.def_addr_q      = def_addr_q;
  this.def_burst       = def_burst;
  this.def_size        = def_size;
  this.def_write       = def_write;
  this.def_wdata_q     = def_wdata_q;
  this.def_lock        = def_lock;
  this.def_prot        = def_prot;
endtask

// accord user's configuration, generate user config packet
task Generator::gen_cfg();
  static int pkts_generated = 0;
  pkt2send.name     = $psprintf("Packet[%0d]", pkts_generated++);
  pkt2send.haddr_q  = def_addr_q;
  pkt2send.hburst   = def_burst;
  pkt2send.hlock    = def_lock;
  pkt2send.hprot    = def_prot;
  pkt2send.hsize    = def_size;
  pkt2send.hwrite   = def_write;
  pkt2send.hwdata_q = def_wdata_q;
  // generate HTRANS signal
  trans_type_input();

endtask

// generate packet randomly
// "reg_cfg_addr" used to judge whether reg_test mode, (default: normal random)
// (32'hFFFF_FFFF:normal random transaction, others:register test mode)
task Generator::gen_rand(logic[31:0] reg_cfg_addr);
  static int pkts_generated = 0;
  logic[31:0] address;	// used to store current address temporary
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  pkt2send.name = $psprintf("Packet[%0d]", pkts_generated++);

  // random the packet
  if (!pkt2send.randomize()) begin
    $display("\n%m\n[ERROR]%t Randomization Failed!\n", $realtime);
    $finish;
  end
  // begin to store HADDR queue, first clear the queue
  pkt2send.haddr_q.delete();
  // if it is register test mode, change the address queue's first address; otherwise, NOT change
  if (reg_cfg_addr == 32'hFFFF_FFFF)
    address = pkt2send.haddr;	
  else
    address = reg_cfg_addr;	
  // according to the number of HWDATA, to push address
  foreach(pkt2send.hwdata_q[i]) begin
    // the first HADDR is the Packet generate randomly
    if (i == 0) 
      pkt2send.haddr_q.push_back(address);
    // the others is add according to constraint from the first HADDR
    else begin
      case(pkt2send.hsize)
          3'b010: begin
        	    // WRAP4
        	    if (pkt2send.hburst==WRAP4) begin
        	      if (!((address%16)==12)) begin
      	        	address += 4;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	      	      else begin
      	          	address = address - 12;
        	      pkt2send.haddr_q.push_back(address);
      	      	      end
      	    	    end
        	    // WRAP8
        	    else if (pkt2send.hburst==WRAP8) begin
        	      if (!((address%32)==28)) begin
      	        	address += 4;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	      	      else begin
      	          	address = address - 28;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	    	    end
        	    // WRAP16
        	    else if (pkt2send.hburst==WRAP16) begin
        	      if (!((address%64)==60)) begin
      	        	address += 4;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	      	      else begin
      	          	address = address - 60;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	            end
        	    // OTHERS(INCR*)
		    else begin
      	              address += 4;
        	      pkt2send.haddr_q.push_back(address);
		    end
      	  	  end
        
          3'b001: begin
        	    // WRAP4
        	    if (pkt2send.hburst==WRAP4) begin
        	      if (!((address%8)==6)) begin
      	        	address += 2;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	      	      else begin
      	          	address = address - 6;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	    	    end
        	    // WRAP8
        	    else if (pkt2send.hburst==WRAP8) begin
        	      if (!((address%16)==14)) begin
      	        	address += 2;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	      	      else begin
      	          	address = address - 14;
        	      	pkt2send.haddr_q.push_back(address);
      	      	      end
      	    	    end
        	    // WRAP16
        	    else if (pkt2send.hburst==WRAP16) begin
        	      if (!((address%32)==30)) begin
      	        	address += 2;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	              else begin
      	          	address = address - 30;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	    	    end
        	    // OTHERS(INCR*)
		    else begin
      	              address += 2;
        	      pkt2send.haddr_q.push_back(address);
		    end
      	  	  end

          3'b000: begin
        	    // WRAP4
        	    if (pkt2send.hburst==WRAP4) begin
        	      if (!((address%4)==3)) begin
      	        	address += 1;
        	        pkt2send.haddr_q.push_back(address);
      	              end
      	      	      else begin
      	          	address = address -3;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	    	    end
        	    // WRAP8
        	    else if (pkt2send.hburst==WRAP8) begin
        	      if (!((address%8)==7)) begin
      	        	address += 1;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	      	      else begin
      	          	address = address - 7;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	    	    end
        	    // WRAP16
        	    else if (pkt2send.hburst==WRAP16) begin
        	      if (!((address%16)==15)) begin
      	        	address += 1;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	      	      else begin
      	          	address = address - 15;
        	        pkt2send.haddr_q.push_back(address);
      	      	      end
      	       	    end
        	    // OTHERS(INCR*)
		    else begin
      	              address += 1;
        	      pkt2send.haddr_q.push_back(address);
		    end
      	  	  end
      endcase
    end
  end
  // generate HTRANS signal, 
  trans_type_input();
endtask

//---------------------------------------//
// HTRANS signal is not random in packet,
// so it's number accoding to HADDR number,
// if test put BUSY state insert,
// HTRANS must be change to 1 randomly.
//---------------------------------------//
task Generator::trans_type_input();
  // clear the queue of htrans_q
  pkt2send.htrans_q.delete();
  // adjust HTRANS signal
  foreach(pkt2send.haddr_q[i]) begin
    // the first HTRANS is NONSEQ(2)
    if (i == 0) begin
      pkt2send.htrans_q.push_back(2);
    end
    // the others is SEQ(3) or BUSY(1, if BUSY insert ture)
    else begin
      // if test ask for BUSY insert, generate BUSY randomly.
      if (usr_busy_insert) begin
        bit sel;
	sel = $urandom_range(0, 1);
	if (sel) pkt2send.htrans_q.push_back(1); // insert BUSY state
        pkt2send.htrans_q.push_back(3);
      end
      // if case no ask for BUSY insert, just to do normally.
      else
        pkt2send.htrans_q.push_back(3);
    end
  end
endtask

//----------------------------------//
// start generator,
// accord "usr_def_mode", there are 3 mode,
// 2'b00(default): random test mode;
// 2'b01: user define operation mode;
// 2'b10: register test mode.
//----------------------------------//
task Generator::start();
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  case (usr_def_mode) 
  // normal random test
  2'b00:
    for (int i=0; i<run_for_n_packets || run_for_n_packets<=0; i++) begin
      gen_rand();
      begin
        Packet pkt = new pkt2send;
        out_box.put(pkt);
      end
    end
  // register configure mode
  2'b01:
    begin
      gen_cfg();
      begin
        Packet pkt = new pkt2send;
        out_box.put(pkt);
      end
    end
  // register round over test
  2'b10:
    for (int i=0; i<(run_for_n_packets/3) || run_for_n_packets<=0; i++) begin
      // before register config, a random transfer
      gen_rand();
      begin
        Packet pkt = new pkt2send;
        out_box.put(pkt);
      end
      // register config
      gen_rand(def_addr_q[0]);
      begin
        Packet pkt = new pkt2send;
	pkt.hwrite = WRITE;// make sure the HWRITE is high
        out_box.put(pkt);
      end
      // after register config, a random transfer
      gen_rand();
      begin
        Packet pkt = new pkt2send;
        out_box.put(pkt);
      end
    end
  endcase
endtask
