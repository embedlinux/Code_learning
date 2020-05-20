program automatic test (router_io.TB rtr_io) ;
  
  int run_for_n_packets;

  `include "Packet.sv"

  bit [3:0] da;
  bit [3:0] sa;
  logic[7:0] payload[$];
  logic[7:0] pkt2cmp_payload[$];

  Packet pkt2send = new();
  Packet pkt2cmp = new(); 

  initial begin
//	  $vcdpluson;
	  run_for_n_packets = 2000;
	  reset();
	  repeat(run_for_n_packets) begin
	  	gen();
		fork
	  		send();
			recv();
		join
		check();
	  end
	  repeat(10) @rtr_io.cb;

	  $finish();
  end

  task recv();
    static int pkt_int = 0;
  	get_payload();	
	pkt2cmp.da = da;
	pkt2cmp.payload = pkt2cmp_payload;
	pkt2cmp.name = $sformatf("RecvPkt[%0d]", pkt_int++);
  endtask: recv

  task get_payload();
  	pkt2cmp_payload.delete();
	fork
		begin: wd_timer_fork
			fork:frameo_wd_timer				
  				@(negedge rtr_io.cb.frameo_n[da]);
				begin
					repeat(1000) @rtr_io.cb;
					$display("\n%m\n[ERROR]%t Frame signal timed out!\n", $realtime);
					$finish;
				end
			join_any: frameo_wd_timer
			disable fork;
		end: wd_timer_fork
	join

	forever begin
		logic[7:0] datum;
		for(int i=0;i<8;) begin
			if(!rtr_io.cb.valido_n[da])
				datum[i++] = rtr_io.cb.dout[da];
			if(rtr_io.cb.frameo_n[da])
				if(i==8) begin
					pkt2cmp_payload.push_back(datum);
					return;
				end
				else begin
					$display("\n%m\n[ERROR] Packet payload not byte aligned!\n");
					$finish;
				end
			@rtr_io.cb;
		end
		pkt2cmp_payload.push_back(datum);
	end
  endtask: get_payload

  task check();
  	string message;
	static int pkts_checked = 0;
	if(!pkt2send.compare(pkt2cmp, message)) begin
		$display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime,pkts_checked,message);
		pkt2send.display("ERROR");
		pkt2cmp.display("ERROR");
		$finish;
	end
	$display("[NOTE] Packet #%0d %s\n", pkts_checked++, message);
  endtask: check


  task send();
  	send_addrs();
	send_pad();
	send_payload();
  endtask: send

  task send_addrs();
	rtr_io.cb.framei_n[sa] <= 1'b0;
	for(int i = 0; i < 4;i++) begin
		rtr_io.cb.din[sa] <= da[i];
		@(rtr_io.cb);
	end
  endtask: send_addrs

  task send_pad();
	rtr_io.cb.framei_n[sa] <= 1'b0;
	rtr_io.cb.validi_n[sa] <= 1'b1;
	rtr_io.cb.din[sa] <= 1'b1;
	repeat(5) @(rtr_io.cb);
  endtask: send_pad

  task send_payload();
	  foreach(payload[index]) begin
		for(int i = 0;i < 8;i++) begin
			rtr_io.cb.din[sa] <= payload[index][i];
			rtr_io.cb.validi_n[sa] <= 1'b0;
			rtr_io.cb.framei_n[sa] <= ((i == 7) && (index == (payload.size()-1)));
			@(rtr_io.cb);
		end
	  end
	  rtr_io.cb.validi_n[sa] <= 1'b1;
	
  endtask: send_payload

  task gen();
	  static int pkts_generated = 0;
	  pkt2send.name = $sformatf("Packet[%0d]", pkts_generated);
	  if (!pkt2send.randomize()) begin
			$display("\n%m\n[ERROR]%t gen(): Randomization Failed!", $realtime);
			$finish;
	  end

	  sa = pkt2send.sa;
	  da = pkt2send.da;
	  payload = pkt2send.payload;
  endtask: gen

  task reset();
	  rtr_io.reset_n = 1'b0;
	  rtr_io.cb.framei_n <= '1;
	  rtr_io.cb.validi_n <= '1;
	  rtr_io.cb.din <= '0;
	  #2 rtr_io.cb.reset_n <= 1'b1;
	  repeat(15) @(rtr_io.cb);
  endtask: reset
endprogram: test
