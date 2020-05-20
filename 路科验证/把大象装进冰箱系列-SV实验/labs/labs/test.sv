program automatic test (router_io.TB rtr_io) ;
    
  int TRACE_ON = 1;

  `include "Packet.sv"
  `include "Driver.sv"
  `include "Receiver.sv"
  `include "Generator.sv"
  `include "Scoreboard.sv"
//  `include "router_test.svh"

  initial begin
//	  $vcdpluson;

	  reset();
	  gen.start();
      sb.start();
	  foreach(drvr[i]) drvr[i].start();
	  foreach(rcvr[i]) rcvr[i].start();

	  wait(sb.DONE.triggered);
      $display("Finish Test");
  end

endprogram: test
