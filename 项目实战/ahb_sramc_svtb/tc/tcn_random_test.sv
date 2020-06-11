/*****************************************************
FileName    : tcn_random_test.sv
Auhtor	    : Jy
Data	      : 2011-6-8
Version	    : 0.10
Function    : It is the random test mode, it generate
	            random address which in a fix width,
	            and random write to access the memory.
*****************************************************/

program automatic VIP_MASTER(AHB_if.master m_if);
  int run_for_n_packets;	// used in Generator
  int TRACE_ON = 0;

  parameter AMBA_AHB_ADDR_WIDTH = 32;
  parameter AMBA_AHB_DATA_WIDTH = 32;
  `define   BASE_ADDR	  32'h4000_0000	// Slave2(SRAM)
  `define   OFFSET		  32'h010

  `include "../tb/Packet.sv"
  `include "../tb/Table.sv"
  `include "../tb/Generator.sv"
  `include "../tb/Driver.sv"

  Generator gen;
  Driver    drvr;

  initial begin
    $vcdpluson;
    run_for_n_packets = 4;
    gen  = new();
    drvr = new("drvr", gen.out_box, m_if, 1); // the last argument is control IDLE state between transactions

    fork
      begin
	      gen.cfg(,1'b0,  // BUSY insert
		    {},	// haddr queue
		    3'h1,	// hburst
		    3'h2,	// hsize
		    1'b0,	// hwrite
		    {},	// hwdata
		    1'h0,	// hlock
		    4'h0	// hprot
		    );
        gen.start();
      end
      drvr.start();
    join
  end

endprogram
