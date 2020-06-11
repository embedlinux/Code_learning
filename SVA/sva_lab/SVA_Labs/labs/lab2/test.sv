program automatic test(router_io.TB router);
  int run_for_n_packets;	// number of packets to test
  bit[3:0] sa;			// source address
  bit[3:0] da; 			// destination address
  reg[7:0] payload[$];		// expected packet data array
  reg[7:0] pkt2cmp_payload[$];	// actual packet data array

  initial begin
    $vcdpluson;
    run_for_n_packets = 200;
    reset();
    repeat(run_for_n_packets) begin
      gen();
      fork
        send();
        recv();
      join
      check();
    end
    repeat(10) @(router.cb);
  end

  task reset();
    router.reset_n <= 1'b0;
    router.cb.frame_n <= '1;
    router.cb.valid_n <= '1;
    ##2 router.cb.reset_n <= 1'b1;
    repeat(15) @(router.cb);
  endtask

  task gen();
    sa = $urandom;
    da = $urandom;
    payload.delete();
    repeat($urandom_range(2,4))
      payload.push_back($urandom);
  endtask

  task send();
    send_addrs();
    send_pad();
    send_payload();
  endtask

  task send_addrs();
    router.cb.frame_n[sa] <= 1'b0;
    for(int i=0; i<4; i++) begin
      router.cb.din[sa] <= da[i];
      @(router.cb);
    end
  endtask

  task send_pad();
    router.cb.frame_n[sa] <= 1'b0;
    router.cb.valid_n[sa] <= 1'b1;
    router.cb.din[sa] <= 1'b1;
    repeat(5) @(router.cb);
  endtask

  task send_payload();
    foreach(payload[index]) begin
      for(int i=0; i<8; i++) begin
        router.cb.din[sa] <= payload[index][i];
        router.cb.valid_n[sa] <= 1'b0;
        router.cb.frame_n[sa] <= (index == (payload.size() - 1)) && (i == 7);
        @(router.cb);
      end
    end
    router.cb.valid_n[sa] <= 1'b1;
  endtask

  task recv();
    get_payload();
  endtask

  task get_payload();
    pkt2cmp_payload.delete();
    @(negedge router.cb.frameo_n[da]);
    forever begin: payload
      reg[7:0] datum;
      for (int i=0; i<8; ) begin: get_byte
        if (!router.cb.valido_n[da]) begin: valid
          datum[i++] = router.cb.dout[da];
          Unknown_dout: assert(!$isunknown(router.cb.dout[da]))
          else $error("[ERROR]:%t (%m) X in port %0d", $realtime, da);
        end
        if (router.cb.frameo_n[da])
          if (i == 8) begin
            pkt2cmp_payload.push_back(datum);
            return;
          end
          else begin
            $display("\n%m\n[ERROR]%t Packet payload not byte aligned!\n", $realtime);
            $finish;
          end
        @(router.cb);
      end
      pkt2cmp_payload.push_back(datum);
    end
  endtask

  function bit compare(ref string message);
    if (payload.size() != pkt2cmp_payload.size()) begin
      message = "Payload Size Mismatch:\n";
      message = { message, $psprintf("payload.size() = %0d, pkt2cmp_payload.size() = %0d\n", payload.size(), pkt2cmp_payload.size()) };
      return(0);
    end
    foreach(payload[i]) begin
      if (payload[i] != pkt2cmp_payload[i]) begin
        message = "Payload Content Mismatch:\n";
        foreach(payload[i])
          message = { message, $psprintf("payload[%0d] = %0d,\tpkt2cmp_payload[%0d] = %0d\n", i, payload[i], i, pkt2cmp_payload[i]) };
        return(0);
      end
    end
    message = "Successfully Compared";
    return(1);
  endfunction

  task check();
    string message;
    static int pkts_checked = 0;
    if (!compare(message)) begin
      $display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime, pkts_checked, message);
      $finish;
    end
    $display("[NOTE]%t Packet #%0d %s", $realtime, pkts_checked++, message);
  endtask

endprogram
