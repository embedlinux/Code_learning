class ahb_slv_generator;
  
  string name;
  ahb_slv_pkt  pkt2send;

  typedef mailbox #(ahb_slv_pkt) generator_mailbox;
  generator_mailbox  gen_mbx;

  int packet_number;
  int number_packets;

  extern function new (string name="ahb_slv_generator", int number_packets);
  extern virtual task gen();
  extern virtual task start();
endclass: ahb_slv_generator

function ahb_slv_generator::new(string name="ahb_slv_generator", int number_packets);
  this.name = name;
  this.pkt2send = new();
  this.gen_mbx = new;
  this.packet_number = 0;
  this.number_packets = number_packets;
endfunction : new

task ahb_slv_generator::gen();
  pkt2send.name = $psprintf("ahb_slv_pkt[%0d]", packet_number++);
  if(!pkt2send.randomize()) begin
    $display("\n%m\n[ERROR]%0d ahb_slv_generator(): Radomization Failed!", $time);
    $finish;
  end

  pkt2send.display();

  //pkt2send.enable = $urandom_range(0,1);
endtask : gen

task ahb_slv_generator::start();
  $display($ime, "ns: [ahb_slv_generator] Generator Started");
  fork
    for(int i=0; i<number_packets || number_packets <= 0; i++) begin
      gen();
      begin
        ahb_slv_pkt pkt = new pkt2send;
        gen_mbx.put(pkt);
      end
    end
    $display($time, "ns: [ahb_slv_generator] Generation Finished Creating %0d ahb_slv_pkts", number_packets);
  join_none
endtask: start
