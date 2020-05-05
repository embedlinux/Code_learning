/***************8*****************************************************
FileName    : AHB_if.sv
Auhtor	    : Zhaoql
Data	      : 2009-7-29
Version	    : 1.00
Function    : It is a AHB interface, which include many modports, like 
              master, slave etc.
----------------------------------------------------------------------
Data	      : 2011-6-21
Version	    : 1.10
ModifyBy    : Jy
Description : Remove the whole tasks;
	            Add slave and monitor clocking block;
	            Add master modport.
*********************************************************************/

interface AHB_if #(parameter AMBA_AHB_ADDR_WIDTH = 32,parameter AMBA_AHB_DATA_WIDTH = 32)
                  (input logic clock, input logic reset_n);
    
    //list the AHB bus related signals
    logic  [AMBA_AHB_ADDR_WIDTH-1:0]   haddr;
    logic  [1:0]                       htrans;
    logic                              hwrite;
    logic  [2:0]                       hsize;
    logic  [2:0]                       hburst;
    logic  [3:0]                       hprot;
    logic  [AMBA_AHB_DATA_WIDTH-1:0]   hwdata;
    logic                              hsel;
    logic  [AMBA_AHB_DATA_WIDTH-1:0]   hrdata;
    logic                              hready_in;
    logic                              hready_out;
    logic  [1:0]                       hresp;
    logic                              hbusreq;
    logic                              hlock;
    logic                              hgrant;
    logic  [3:0]                       hmaster;
    logic                              hmastlock;
    logic  [15:0]                      hsplit;

    clocking  cb_master @(posedge clock);
       default input #1 output #1;
       output haddr;
       output hburst;
       output hbusreq;
       output hlock;
       output hprot;
       output hsize;
       output htrans;
       output hwdata;
       output hwrite;
       input  hrdata;
       input  hready_in;
       input  hresp;
       input  hgrant;
    endclocking

    clocking  cb_slave @(posedge clock);
       default input #1 output #1;
       input  hsel;
       input  haddr;
       input  hwrite;
       input  htrans;
       input  hsize;
       input  hburst;
       input  hwdata;
       input  hmaster;
       input  hmastlock;
       input  hready_in;
       output hrdata;
       output hready_out;
       output hresp;
       output hsplit;
    endclocking

    clocking  cb_monitor @(posedge clock);
       default input #1 output #1;
       input hsel;
       input haddr;
       input hwrite;
       input htrans;
       input hsize;
       input hburst;
       input hwdata;
       input hmaster;
       input hmastlock;
       input hready_in;
       input hrdata;
       input hready_out;
       input hresp;
       input hsplit;
    endclocking

    //modport for AHB master
    modport master(
                  input clock,reset_n,
		              clocking cb_master
                   );

    modport bs    (
                  input clock,reset_n,
                  output hgrant,hrdata,hready_in,hresp,hmaster,
                  input haddr,hburst,hbusreq,hlock,hprot,hsize,htrans,hwdata,hwrite
                   );

    //modport for AHB slave
    modport slave (
                  input clock,reset_n,
                  input haddr,hburst,hmaster,hmastlock,hprot,hready_in,hsel,hsize,htrans,hwdata,hwrite,
                  output hrdata,hready_out,hresp,hsplit
                   );

    modport  bm   (
                  input clock,reset_n,
                  output haddr,hburst,hmaster,hmastlock,hprot,hready_in,hsel,hsize,htrans,hwdata,hwrite,
                  input hrdata,hready_out,hresp,hsplit
                   );

    //modport for AHB slave
    modport monitor(
                   input clock,reset_n,
		               clocking cb_monitor
                     );

  // reset bus
  task reset_bm_bus();
      begin
       cb_master.haddr<=0;
       cb_master.hburst<=3'b0; //single transfer
       cb_master.hbusreq<=0;
       cb_master.hlock<=0;
       cb_master.hprot<=4'b0;
       cb_master.hsize<=3'h0;
       cb_master.htrans<=2'h0; //NONSEQ
       cb_master.hwrite<=1'h0;
       cb_master.hwdata<=0;  //the data to be writen
      end
  endtask

endinterface
