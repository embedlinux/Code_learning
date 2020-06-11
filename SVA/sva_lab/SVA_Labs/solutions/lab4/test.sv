program automatic test(router_io.TB router);
  // The following program variables will be seen by the included files without extern
  int run_for_n_packets;	// number of packets to test
  int TRACE_ON = 0;			// subroutine tracing control

  `include "Packet.sv"
  `include "Driver.sv"
  `include "Receiver.sv"
  `include "Generator.sv"
  `include "Scoreboard.sv"

  // The following program variables can be seen by the included files withextern
  semaphore  sem[];		// prevent output port collision
  Driver     drvr[];		// driver objects
  Receiver   rcvr[];		// receiver objects
  Generator  gen;		// generator object
  Scoreboard sb;		// scoreboard object

  initial begin
    $vcdpluson;
    run_for_n_packets = 200;
    sem = new[16];
    drvr = new[16];
    rcvr = new[16];
    gen = new();
    sb = new();
    foreach (sem[i])
      sem[i] = new(1);
    for (int i=0; i<drvr.size(); i++)
      drvr[i] = new($psprintf("drvr[%0d]", i), i, sem, gen.out_box[i], sb.driver_mbox, router);
    for (int i=0; i<rcvr.size(); i++)
      rcvr[i] = new($psprintf("rcvr[%0d]", i), i, sb.receiver_mbox, router);
    reset();
    gen.start();
    sb.start();
    foreach(drvr[i])
      drvr[i].start();
    foreach(rcvr[i])
      rcvr[i].start();
    wait(sb.DONE.triggered);
#10;
@(router.cb);
  end

  task reset();
    if (TRACE_ON) $display("[TRACE]%t %m", $realtime);
    router.reset_n <= 1'b0;
    router.cb.frame_n <= '1;
    router.cb.valid_n <= '1;
    ##2 router.cb.reset_n <= 1'b1;
    repeat(15) @(router.cb);
  endtask

endprogram
