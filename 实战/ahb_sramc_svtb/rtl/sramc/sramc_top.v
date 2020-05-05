

module sramc_top (	
	// AHB Bus Signal
	hclk    , 
	hreset_n,
	hsel    ,
  hready  ,
	haddr   ,  
	hwrite  , 
	hsize   ,  
	htrans  , 
	hwdata  ,
	hrdata  ,
	hready_resp  , 
	hresp       
	);

parameter AHB_ADDR_WIDTH  = 32;
parameter AHB_DATA_WIDTH  = 32;
parameter SRAM_ADDR_WIDTH = 12;
parameter SRAM_DATA_WIDTH = 32;
	
input                        hclk       ;
input	                       hreset_n   ;
input	                       hsel       ;
input                        hready     ;
input		     	               hwrite     ;
input   [2:0]	               hsize      ;
input   [1:0]	               htrans     ;
input   [AHB_ADDR_WIDTH-1:0] haddr      ;
input	  [AHB_DATA_WIDTH-1:0] hwdata     ;

output  [AHB_DATA_WIDTH-1:0] hrdata     ;
output			                 hready_resp;
output  [1:0]	               hresp      ;	

// SRAM control signal
wire	  		                  sram_clk   ;
wire    [3:0]                 sram_cb_n  ;
wire  	[3:0]	                sram_cs_n  ;
wire    		                  sram_write_n;
wire    [SRAM_ADDR_WIDTH-1:0] sram_addr  ;
wire    [SRAM_DATA_WIDTH-1:0] sram_wdata ;
wire    [SRAM_DATA_WIDTH-1:0] sram_rdata ;

//-- instance of the ahb_sram_slave module --

sramc U_sramc(	
	.hclk	            (hclk),
	.hreset_n	        (hreset_n),
	.hsel             (hsel),
  .hready           (hready),
	.haddr	     	    (haddr),
	.hwrite		        (hwrite),
	.hsize		        (hsize),
	.htrans		        (htrans),
	.hwdata		        (hwdata),
	.hrdata	     	    (hrdata),
	.hready_resp      (hready_resp),
	.hresp		        (hresp),		
	
	.sram_clk 	      (sram_clk),
	.sram_cb_n        (sram_cb_n),
	.sram_cs_n 	      (sram_cs_n),
	.sram_addr	      (sram_addr),
  .sram_write_n     (sram_write_n),
	.sram_wdata       (sram_wdata),
	.sram_rdata       (sram_rdata)
	);


//-- instance of SRAM -

sram_bank_top  U_sram_bank_top (
	.sram_clk		      (sram_clk),     
  .sram_cb_n        (sram_cb_n),	
	.sram_cs_n		    (sram_cs_n), 	
	.sram_addr		    (sram_addr),	
  .sram_write_n	    (sram_write_n),    
	.sram_wdata		    (sram_wdata),     
	.sram_rdata		    (sram_rdata)  
  );
endmodule
