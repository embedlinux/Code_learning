//`include "sramc_fsm.v"
//`include "sramc_cs.v"

module sramc (	
	// AHB Bus Signal
   hclk,    
   hreset_n,
   hsel,   
   hready,
   hwrite, 
   hsize, 
   htrans,
   haddr,
   hwdata,
   hrdata, 
   hready_resp,  
   hresp,  
		   
   // SRAM signal
   sram_clk, 
   sram_cs_n, 
   sram_cb_n,
   sram_write_n,
   sram_addr,  
   sram_wdata,
   sram_rdata 
   );
   
// -- define AHB Bus Width and SRAM address width --
parameter  AHB_ADDR_WIDTH   = 32  ;
parameter  AHB_DATA_WIDTH   = 32  ;
parameter  SRAM_ADDR_WIDTH  = 12  ;
parameter  SRAM_DATA_WIDTH  = 32  ;

//-- define the port direction --
input                          hclk         ;
input	                         hreset_n     ;
input	                         hsel         ;
input                          hready       ;
input			                     hwrite       ;
input	[2:0]	                   hsize        ;
input	[1:0]	                   htrans       ;
input   [AHB_ADDR_WIDTH-1:0]   haddr        ;
input	[AHB_DATA_WIDTH-1:0]     hwdata       ;

output  [AHB_DATA_WIDTH-1:0]   hrdata       ;
output			                   hready_resp  ;
output  [1:0]	                 hresp        ;	

output			                   sram_clk     ;
output  [3:0]                  sram_cb_n	;
output	[3:0]	                 sram_cs_n    ;
output	[SRAM_ADDR_WIDTH-1:0]  sram_addr    ;
output			                   sram_write_n ;
output	[SRAM_DATA_WIDTH-1:0]  sram_wdata   ;
output	[SRAM_DATA_WIDTH-1:0]  sram_rdata   ;

// -- define the internal port type --
wire			                   hwrite_reg   ;    
wire	[2:0]	                 hsize_reg    ;    
wire	[AHB_ADDR_WIDTH-1:0]   haddr_reg    ;    
wire                         hsel_reg     ;

//--define the BUS transfer type which control the slave`s transaction--
parameter    HTRANS_IDLE   = 2'b00 ;	
parameter    HTRANS_BUSY   = 2'b01 ;
parameter    HTRANS_NONSEQ = 2'b10 ;	
parameter    HTRANS_SEQ	   = 2'b11 ;
	   
//--define the FSM name--
parameter    IDLE          = 4'b0000 ;
parameter    WRITE         = 4'b0001 ;
parameter    WRITE_BUSY	   = 4'b0010 ;
parameter    READ	         = 4'b0100 ;
parameter    READ_BUSY	   = 4'b1000 ;	
	   
//-- define the SRAM bank sequence --		
parameter    SRAM_BANK1	= 2'b00 ;	
parameter    SRAM_BANK2	= 2'b01 ;
parameter    SRAM_BANK3	= 2'b10 ;	
parameter    SRAM_BANK4	= 2'b11 ;
	   
//-- define switch constants --
parameter    ON   = 1'b1 ;
parameter    OFF  = 1'b0 ;	 
	   
sramc_fsm U_sramc_fsm(
	// AHB Bus Signal
	.hclk	       (hclk),
	.hreset_n    (hreset_n),
	.hsel        (hsel),
  .hready      (hready),
	.haddr	     (haddr),
	.hwrite	     (hwrite),
	.hsize	     (hsize),
	.htrans      (htrans),
	.hwdata	     (hwdata),
	.hready_resp (hready_resp),
	.hresp	     (hresp),		
			
	// SRAM control signal
	.hsel_reg    (hsel_reg),
	.hwrite_reg  (hwrite_reg),
	.hsize_reg   (hsize_reg),
	.haddr_reg   (haddr_reg)
	);

sramc_cs U_sramc_cs (
	// AHB Bus Signal
	.hclk	       (hclk),
  .htrans      (htrans),
	.hreset_n    (hreset_n),
	.hsel_reg    (hsel_reg),
	.haddr_reg   (haddr_reg),
	.hwrite_reg  (hwrite_reg),
	.hsize_reg   (hsize_reg),
	.hwdata	     (hwdata),
	.hrdata      (hrdata),		
			
	// SRAM control signal
	.sram_clk    (sram_clk),
	.sram_cb_n   (sram_cb_n),
	.sram_cs_n   (sram_cs_n),
	.sram_addr   (sram_addr),
  .sram_write_n(sram_write_n),
	.sram_wdata  (sram_wdata),
	.sram_rdata  (sram_rdata)
	);
                
endmodule
         
