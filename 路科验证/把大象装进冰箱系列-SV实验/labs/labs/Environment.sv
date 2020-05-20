`ifndef INC_ENVIRONMENT_SV
`define INC_ENVIRONMENT_SV

	class Environment;
	  string name;
	  rand int run_for_n_packets;
	  virtual router_io.TB rtr_io;

	  semaphore sem[];
	  Driver drvr[];
	  Receiver rcvr[];
	  Generator gen;
	  Scoreboard sb;

	  constraint valid {
		this.run_for_n_packets inside {[1500:2500]};
	  }

		extern function new(string name = "Env", virtual router_io.TB rtr_io);
		extern virtual task run();
		extern virtual function void configure();
		extern virtual function void build();
		extern virtual task start();
		extern virtual task wait_for_end();
		extern virtual task reset();

	endclass

		extern function new(string name = "Env", virtual router_io.TB rtr_io);
			if(TRACE_ON) $display("[TRACE]%t %m:%s", $realtime, name);
			this.name = name;
			this.rtr_io = rtr_io;
		endfunction: new

		 task Environment::run();
			if(TRACE_ON) $display("[TRACE]%t %m:%s", $realtime, this.name);
			this.build();
			this.reset();
			this.start();
			this.wait_for_reset();
		 endtask: run

		 function void Environment::configure();
			if(TRACE_ON) $display("[TRACE]%t %m:%s", $realtime, this.name);
			this.randomize();
		 endfunction: configurie

		 function void Environment::build();
			if(TRACE_ON) $display("[TRACE]%t %m:%s", $realtime, this.name);
			if(this.run_for_npackets == 0)  this.run_for_n_packets = 2000;
			  this.sem = new[16];
			  this.drvr = new[16];
			  this.rcvr = new[16];
			  this.gen = new();
			  this.sb = new();
			  foreach(sem[i])
				this.sem[i] = new(i);
			  
			  for(int i = 0; i < drvr.size();i++ )
				this.drvr[i] = new($sformatf("drvr[%0d]", i), i, sem, gen.out_box[i], this.sb.driver_mbox, this.rtr_io);
			  
			  for(int i = 0; i < rcvr.size();i++ )
				this.rcvr[i] = new($sformatf("rcvr[%0d]", i), i, this.sb.receiver_mbox, this.rtr_io);
		 endfunction

		 task Environment::start();
		 
		 endtask

		 task Environment::wait_for_end();
		 
		 endtask

		 task Environment::reset();
			  if(TRACE_ON) $display("[TRACE]%t: %m", $realtime);
			  rtr_io.reset_n = 1'b0;
			  rtr_io.cb.framei_n <= '1;
			  rtr_io.cb.validi_n <= '1;
			  rtr_io.cb.din <= '0;
			  #2 rtr_io.cb.reset_n <= 1'b1;
			  repeat(15) @(rtr_io.cb);
		  endtask: reset
`endif
