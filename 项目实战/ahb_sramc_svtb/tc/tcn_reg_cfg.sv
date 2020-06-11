/*****************************************************
FileName    : tcn_reg_cfg.sv
Auhtor	    : Jy
Data	      : 2011-6-8
Version	    : 0.10
Function    : It is the register config mode.
------------------------------------------------------
Data	      : 2011-7-4
Version	    : 0.11
Modification: the case'sencapsulation more higher and abstract,
	            it serves 2 functions: write & read.
*****************************************************/

program automatic VIP_MASTER(AHB_if.master m_if);
  int run_for_n_packets;	// used in Generator
  int TRACE_ON = 0;

  parameter AMBA_AHB_ADDR_WIDTH = 32;
  parameter AMBA_AHB_DATA_WIDTH = 32;
  `define   BASE_ADDR		  32'h4000_0000	// Slave2(SRAM)
  `define   OFFSET		  32'h010

  `include "../tb/Packet.sv"
  `include "../tb/Table.sv"
  `include "../tb/Generator.sv"
  `include "../tb/Driver.sv"

  Generator gen;
  Driver    drvr;

  initial begin
    $vcdpluson;
    gen  = new();
    drvr = new("drvr", gen.out_box, m_if); // IDLE state insert
    // define the number of transaction
    run_for_n_packets = 0;

    fork
      begin
	// store read register value
	logic[31:0] r_data;
	//**************************//
  // user define here*********//
	`include "tcc.sv"//*********//
	//**************************//
      end
      drvr.start();
    join
  end

  // write register
  task write_reg(input logic[31:0] w_addr, input logic[31:0] w_data);
    gen.cfg(2'b01,	// user define transfer
    	1'b0,		// BUSY state insert
    	{w_addr},	// haddr queue
    	3'h0,		// hburst
    	3'b010,		// hsize
    	1'b1,		// hwrite
    	{w_data},	// hwdata
    	1'b0,		// hlock
    	4'h0		// hprot
    	);
    gen.start();
    run_for_n_packets++;
  endtask

  // read register
  task read_reg(input logic[31:0] r_addr, output logic[31:0] r_data);
    gen.cfg(2'b01,	// user define transfer
    	1'b0,		// BUSY state insert
    	{r_addr},	// haddr queue
    	3'h0,		// hburst
    	3'b010,		// hsize
    	1'b0,		// hwrite
    	{},		// hwdata
    	1'b0,		// hlock
    	4'h0		// hprot
    	);
    gen.start();
    run_for_n_packets++;
    wait (drvr.RD_DONE.triggered);
    r_data = drvr.pkt_rdata.hrdata_q.pop_back;
  endtask
    
endprogram
