`ifndef INC_PACKET_SV
`define INC_PACKET_SV
class Packet;
  rand bit[3:0] sa, da;		// random port selection
  rand reg[7:0] payload[$];	// random data array
  string   name;		    // unique identifier

  constraint Limit {
    //sa inside {0,1};
    //da inside {0};
    sa inside {[0:15]};
    da inside {[0:15]};
    payload.size() inside {[2:4]};
  }

  extern function new(string name = "Packet");
  extern function bit compare(Packet pkt2cmp, ref string message);
  extern function void display(string prefix = "NOTE");
endclass

function Packet::new(string name);
  this.name = name;
endfunction

function bit Packet::compare(Packet pkt2cmp, ref string message);
  if (payload.size() != pkt2cmp.payload.size()) begin
    message = "Payload Size Mismatch:\n";
    message = { message, $psprintf("payload.size() = %0d, pkt2cmp.payload.size() = %0d\n", payload.size(), pkt2cmp.payload.size()) };
    return(0);
  end
  foreach(payload[i]) begin
    if (payload[i] == pkt2cmp.payload[i]) ;
    else begin
      message = "Payload Content Mismatch:\n";
      foreach(payload[i])
        message = { message, $psprintf("payload[%0d] = %0d,\tpkt2cmp.payload[%0d] = %0d\n", i, payload[i], i, pkt2cmp.payload[i]) };
      return(0);
    end
  end
  message = "Successfully Compared";
  return(1);
endfunction

function void Packet::display(string prefix);
  $display("[%s]%t %s sa = %0d, da = %0d", prefix, $realtime, name, sa, da);
  foreach(payload[i])
    $display("[%s]%t %s payload[%0d] = %0d", prefix, $realtime, name, i, payload[i]);
endfunction
`endif