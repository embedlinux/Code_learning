/*****************************************************
FileName    : Packet.sv
Auhtor	    : Jy
Data	      : 2011-6-8
Version	    : 0.10
Function    : It is a transaction, which include all the
	            transfer signals, and is generate random.
*****************************************************/

// paramized transfer number
parameter SINGLE = 3'b000,
          INCR   = 3'b001,
          WRAP4  = 3'b010,
          INCR4  = 3'b011,
          WRAP8  = 3'b100,
          INCR8  = 3'b101,
          WRAP16 = 3'b110,
          INCR16 = 3'b111;
// paramized transfer size
parameter WORD 	   = 3'b010,
	  HALFWORD = 3'b001,
	  BYTE	   = 3'b000;
// paramized w/r operation
parameter WRITE = 1'b1,
	  READ  = 1'b0;
	  
class Packet;
  rand logic [AMBA_AHB_ADDR_WIDTH-1:0] haddr;
       logic [AMBA_AHB_ADDR_WIDTH-1:0] haddr_q[$];
  rand logic [2:0]                     hburst;
  rand logic 			                     hlock;
  rand logic [3:0]                     hprot;
  rand logic [2:0]                     hsize;
       logic [1:0]                     htrans_q[$];	
  rand logic [AMBA_AHB_DATA_WIDTH-1:0] hwdata_q[$];
  rand logic 			                     hwrite;
       logic [AMBA_AHB_DATA_WIDTH-1:0] hrdata_q[$];
       string			                     name;

  constraint trans_valid { 
    // only for test
    // hwrite == 1'b0;
    // hsize == 3'b10;

    // HSIZE
    hsize inside {[BYTE: WORD]};

    // HLOCK & HPROT
    hlock  == 1'b0;
    hprot  == 4'b0;

    // HBURST
    if (hburst == SINGLE) {
      hwdata_q.size() == 1;
    }
    if (hburst == INCR) {
      hwdata_q.size() inside {[1:16]};
    }
    if (hburst == WRAP4) {
      hwdata_q.size() == 4;
    }
    if (hburst == INCR4) {
      hwdata_q.size() == 4;
    }
    if (hburst == WRAP8) {
      hwdata_q.size() == 8;
    }
    if (hburst == INCR8) {
      hwdata_q.size() == 8;
    }
    if (hburst == WRAP16) {
      hwdata_q.size() == 16;
    }
    if (hburst == INCR16) {
      hwdata_q.size() == 16;
    }

    // HADDR && HWDATA
    if (hsize == WORD) {
      haddr%4 == 0;
      haddr inside {[`BASE_ADDR:`BASE_ADDR+`OFFSET]};
    }
    if (hsize == HALFWORD) {
      haddr%2 == 0;
      haddr inside {[`BASE_ADDR:`BASE_ADDR+`OFFSET]};
      foreach(hwdata_q[i]) hwdata_q[i] inside {[0:16'hFFFF]};
    }
    if (hsize == BYTE) {
      haddr inside {[`BASE_ADDR:`BASE_ADDR+`OFFSET]};
      foreach(hwdata_q[i]) hwdata_q[i] inside {[0:8'hFF]};
    }

  }

  extern function new(string name = "Packet");
  // used to compare Packet's content
  extern function bit compare(Packet pkt2cmp, ref string message);
  // used to display Packet's content
  extern function void display(string prefix = "NOTE");
endclass

function Packet::new(string name);
  this.name = name;
endfunction

function bit Packet::compare(Packet pkt2cmp, ref string message);
  if(haddr_q.size()  != pkt2cmp.haddr_q.size()  ||
     hwdata_q.size() != pkt2cmp.hwdata_q.size() ||
     hrdata_q.size() != pkt2cmp.hrdata_q.size()) begin
    message = "Payload Size Mismatch:\n";
    message = { message, $psprintf("haddr_q.size() = %0d, pkt2cmp.haddr_q.size() = %0d\n", haddr_q.size(), pkt2cmp.haddr_q.size()) };
    message = { message, $psprintf("hwdata_q.size() = %0d, pkt2cmp.hwdata_q.size() = %0d\n", hwdata_q.size(), pkt2cmp.hwdata_q.size()) };
    message = { message, $psprintf("hrdata_q.size() = %0d, pkt2cmp.hrdata_q.size() = %0d\n", hrdata_q.size(), pkt2cmp.hrdata_q.size()) };
    return(0);
  end
  /*--NEED MORE COMPARE--*/
endfunction

function void Packet::display(string prefix);
  foreach(haddr_q[i])
    $display("[%s]%t %s haddr[%0d] = %0h", prefix, $realtime, name, i, haddr_q[i]);
  $display("[%s]%t %s hwrite = %0d", prefix, $realtime, name, hwrite);
  foreach(hwdata_q[i])
    $display("[%s]%t %s hwdata_q[%0d] = %0h", prefix, $realtime, name, i, hwdata_q[i]);
  foreach(hrdata_q[i])
    $display("[%s]%t %s hrdata_q[%0d] = %0h", prefix, $realtime, name, i, hrdata_q[i]);
  foreach(htrans_q[i])
    $display("[%s]%t %s htrans_q[%0d] = %0d", prefix, $realtime, name, i, htrans_q[i]);
  $display("[%s]%t %s hburst = %0d", prefix, $realtime, name, hburst);
  $display("[%s]%t %s hsize = %0d", prefix, $realtime, name, hsize);
  $display("*********************************************************");
endfunction
