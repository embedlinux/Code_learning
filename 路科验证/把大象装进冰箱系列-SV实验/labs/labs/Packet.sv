`ifndef INC_PACKET_SV
`define INC_PACKET_SV

class Packet;
	rand bit[3:0] sa, da;
	rand logic[7:0] payload[$];
	string name;

	constraint Limit {
		sa inside {[0:15]};
		da inside {[0:15]};
		payload.size() inside {[2:4]};
	
	}

	extern function new(string name = "Packet");
	extern function bit compare(Packet pkt2cmp, ref string message);
	extern function void display(string prefix = "NONE");

endclass: Packet

	function Packet::new(string name = "Packet");
		this.name = name;
	endfunction: new
	
function bit Packet::compare(Packet pkt2cmp, ref string message);
	if(payload.size() != pkt2cmp.payload.size()) begin
		message = "Payload Size misatch:\n";
		message = {message, $sformatf("payload.szie()=%0d,pkt2cmp_payload.size()=%0d",payload.size,pkt2cmp.payload.size())};
		return 0;
	end
	if(payload == pkt2cmp.payload);
	else begin
		message = "Payload Content misatch:\n";
		message = {message, $sformatf("packet sent:%p\npkt received:%0p",payload,pkt2cmp.payload)};
		return 0;
	end
	message = "successfully compared";
	return 1;
endfunction: compare
	
function void Packet::display(string prefix);
	$display("[%s]%t %s sa = %0d, da = %0d", prefix, $realtime, name, sa, da);
	foreach(payload[i])
		$display("[%s]%t %s payload[%0d] = %0d", prefix, $realtime, name, i, payload[i]);
endfunction: display

typedef class Packet;
typedef mailbox #(Packet) pkt_mbox;

`endif
