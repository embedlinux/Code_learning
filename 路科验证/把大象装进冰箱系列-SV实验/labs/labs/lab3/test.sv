program automatic test (router_io.TB rtr_io) ;
  bit[3:0] sa;
  bit[3:0] da;
  int run_for_n_packets = 21;
  logic[7:0] payload[$];
  logic[7:0] pkt2cmp_payload[$];
  initial begin
//	  $vcdpluson;
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
  	get_payload();	
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
	if(!compare(message)) begin
		$display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime,pkts_checked,message);
		$finish;
	end
	$display("\n%m\n[NOTE]%t Packet #%0d %s\n", $realtime,pkts_checked,message);
  endtask: check

  function bit compare(ref string message);
  	if(payload.size() != pkt2cmp_payload.size()) begin
		message = "Payload Size misatch:\n";
		message = {message, $sformatf("payload.szie()=%0d,pkt2cmp_payload.size()=%0d",payload.size,pkt2cmp_payload.size())};
		return 0;
	end
	if(payload == pkt2cmp_payload);
	else begin
		message = "Payload Content misatch:\n";
		message = {message, $sformatf("packet sent:%p\npkt received:%0p",payload,pkt2cmp_payload)};
		return 0;
	end
	return 1;
  endfunction: compare

  task send();
  	send_addrs();
	send_pad();
	send_payload();
  endtask: send

  task send_addrs();
	$display("send addr: %d", sa);
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
		$display("send data: %0x", payload[index]);
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
	  sa = 3;
	  da = 7;
	  payload.delete();
	  repeat($urandom_range(2, 4)) 
	  	payload.push_back($urandom);
//	  $display("gen data:");	
//	  foreach(payload[i])
//		  $display("    data %0d :%0x",i, payload[i]);
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
