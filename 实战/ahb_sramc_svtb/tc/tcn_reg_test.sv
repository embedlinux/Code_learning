/*****************************************************
FileName    : tcn_reg_test.sv
Auhtor	    : Jy
Data	      : 2011-6-8
Version	    : 0.10
Function    : It is the register random test mode.
	            it simulate CPU's operation to generate
	            random and pipe operation which before
	            and after the register operation.
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
    run_for_n_packets = 3*1;// MUST be 3x
    gen  = new();
    drvr = new("drvr", gen.out_box, m_if, 1);// idle_ctrl(1-BURST connect)

    fork
      begin
      	reg_test(`BASE_ADDR+32'h8);
      end
      drvr.start();
    join
  end

  task reg_test(input logic[31:0] addr);
    gen.cfg(2'b10,	// user define transfer
       	    1'b0,	// BUSY state insert
       	    {addr},	// haddr queue
       	    3'h0,	// hburst
       	    3'h2,	// hsize
       	    1'b1,	// hwrite
       	    {32'h6},	// hwdata
       	    1'h0,	// hlock
       	    4'h0	// hprot
       	    );
    gen.start();
  endtask

endprogram
