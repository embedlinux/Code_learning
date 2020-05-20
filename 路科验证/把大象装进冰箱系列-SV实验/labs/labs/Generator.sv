`ifndef INC_GENERATOR_SV
`define INC_GENERATOR_SV

	class Generator;
		string name;
		Packet pkt2send;
		pkt_mbox out_box[];

		extern function new(string name="Generator");
		extern virtual task start();
		extern virtual task gen();
	endclass: Generator

	function Generator::new(string name="Generator");
			if(TRACE_ON) $display("[TRACE]%t %m:%s", $realtime, name);
			this.name = name;
			this.pkt2send = new();
			this.out_box= new[16];

			foreach(this.out_box[i])
				this.out_box[i] = new();
	endfunction: new

	task Generator::start();
		if(TRACE_ON) $display("[TRACE]%t %m:%s", $realtime, this.name);
		fork
			for(int i =0; i< run_for_n_packets || run_for_n_packets <= 0; i++) begin
				this.gen();
				begin
					Packet pkt = new this.pkt2send;
					this.out_box[pkt.sa].put(pkt);
				end
			end
		join_none
	endtask:start

	task Generator::gen();
	  static int pkts_generated = 0;
	  if(TRACE_ON) $display("[TRACE]%t %m:%s", $realtime, this.name);
	  this.pkt2send.name = $sformatf("Packet[%0d]", pkts_generated++);
	  if (!this.pkt2send.randomize()) begin
			$display("\n%m\n[ERROR]%t gen(): Randomization Failed!", $realtime);
			$finish;
	  end

	endtask:gen

`endif
