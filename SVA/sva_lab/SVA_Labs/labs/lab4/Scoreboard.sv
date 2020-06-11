`ifndef INC_SCOREBOARD_SV
`define INC_SCOREBOARD_SV
class Scoreboard;
  string  name;			// unique identifier
  event   DONE;			// flag to indicate goal reached
  Packet  refPkt[$];		// reference Packet array
  Packet  pkt2send;		// Packet object from Drivers
  Packet  pkt2cmp;		// Packet object from Receivers
  mailbox driver_mbox;		// mailbox for Packet objects from Drivers
  mailbox receiver_mbox;	// mailbox fro Packet objects from Receivers

  extern function new(string name = "Scoreboard", mailbox driver_mbox = null, receiver_mbox = null);
  extern virtual task start();
  extern virtual task check();
endclass

function Scoreboard::new(string name, mailbox driver_mbox, receiver_mbox);
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  this.name = name;
  if (driver_mbox == null) driver_mbox = new();
  this.driver_mbox = driver_mbox;
  if (receiver_mbox == null) receiver_mbox = new();
  this.receiver_mbox = receiver_mbox;
endfunction

task Scoreboard::start();
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  fork
    while (1) begin
      receiver_mbox.get(pkt2cmp);
      while (driver_mbox.num()) begin
        Packet pkt;
        driver_mbox.get(pkt);
        refPkt.push_back(pkt);
      end
      check();
    end
  join_none
endtask

task Scoreboard::check();
  int    index[$];
  string message;
  static int  pkts_checked = 0;
  if (TRACE_ON) $display("[TRACE]%t %s:%m", $realtime, name);
  index = refPkt.find_first_index() with (item.da == pkt2cmp.da);
  if (index.size() <= 0) begin
    $display("\n%m\n[ERROR]%t %s not found in Reference Queue\n", $realtime, pkt2cmp.name);
    pkt2cmp.display("ERROR");
    $finish;
  end
  pkt2send = refPkt[index[0]];
  refPkt.delete(index[0]);
  if (!pkt2send.compare(pkt2cmp, message)) begin
    $display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime, pkts_checked, message);
    pkt2send.display("ERROR");
    pkt2cmp.display("ERROR");
    $finish;
  end
  $display("[NOTE]%t Packet #%0d %s", $realtime, pkts_checked++, message);
  if (pkts_checked >= run_for_n_packets)
    ->DONE;
endtask
`endif
