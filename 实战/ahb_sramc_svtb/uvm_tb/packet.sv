`ifndef PACKET__SV
`define PACKET__SV

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
parameter  AMBA_AHB_ADDR_WIDTH = 32,
           AMBA_AHB_DATA_WIDTH = 32;

class packet extends uvm_sequence_item;
  rand logic [AMBA_AHB_ADDR_WIDTH-1:0] haddr;
  rand logic [2:0]                     hburst;
  rand logic 			                     hlock;
  rand logic [3:0]                     hprot;
  rand logic [2:0]                     hsize;
  rand logic [1:0]                     htrans;	
  rand logic [AMBA_AHB_DATA_WIDTH-1:0] hwdata;
  rand logic 			                     hwrite;
       logic [AMBA_AHB_DATA_WIDTH-1:0] hrdata;

  `uvm_object_utils_begin(packet)
    `uvm_field_int(haddr, UVM_ALL_ON)
    `uvm_field_int(hburst, UVM_ALL_ON)
    `uvm_field_int(hlock, UVM_ALL_ON)
    `uvm_field_int(hprot, UVM_ALL_ON)
    `uvm_field_int(hsize, UVM_ALL_ON)
    `uvm_field_int(htrans, UVM_ALL_ON)
    `uvm_field_int(hwdata, UVM_ALL_ON)
    `uvm_field_int(hwrite, UVM_ALL_ON)
    `uvm_field_int(hrdata, UVM_ALL_ON)
  `uvm_object_utils_end
 
  constraint valid{
      //hsize == WORD;
     // haddr%4 == 0;
     // haddr inside {[`BASE_ADDR:`BASE_ADDR+`OFFSET]};
      haddr inside {[32'h2000_0000:32'h2000_3FFF]};
      
    }

   /*constraint trans_valid { 
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

  }*/
 function new(string name = "packet");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

endclass: packet
`endif

