program automatic test (router_io.TB rtr_io) ;
    
  int run_for_n_packets;
  int TRACE_ON = 1;

  `include "Packet.sv"
  `include "Driver.sv"
  `include "Receiver.sv"
  `include "Generator.sv"
  `include "Scoreboard.sv"
//  `include "router_test.svh"
  semaphore sem[];
  Driver drvr[];
  Receiver rcvr[];
  Generator gen;
  Scoreboard sb;

  initial begin
//	  $vcdpluson;
	  run_for_n_packets = 2000;
	  sem = new[16];
	  drvr = new[16];
	  rcvr = new[16];
	  gen = new();
	  sb = new();
	  foreach(sem[i])
		sem[i] = new(i);
	  
	  for(int i = 0; i < drvr.size();i++ )
		drvr[i] = new($sformatf("drvr[%0d]", i), i, sem, gen.out_box[i], sb.driver_mbox, rtr_io);
	  
	  for(int i = 0; i < rcvr.size();i++ )
		rcvr[i] = new($sformatf("rcvr[%0d]", i), i, sb.receiver_mbox, rtr_io);

	  reset();
	  gen.start();
      sb.start();
	  foreach(drvr[i]) drvr[i].start();
	  foreach(rcvr[i]) rcvr[i].start();

	  wait(sb.DONE.triggered);
      $display("Finish Test");
  end

  task reset();
	  if(TRACE_ON) $display("[TRACE]%t: %m", $realtime);
	  rtr_io.reset_n = 1'b0;
	  rtr_io.cb.framei_n <= '1;
	  rtr_io.cb.validi_n <= '1;
	  rtr_io.cb.din <= '0;
	  #2 rtr_io.cb.reset_n <= 1'b1;
	  repeat(15) @(rtr_io.cb);
  endtask: reset
endprogram: test
