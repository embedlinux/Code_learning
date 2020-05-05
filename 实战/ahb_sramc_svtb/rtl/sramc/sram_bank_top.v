module sram_bank_top (

	sram_clk,        
	sram_cb_n,
  sram_cs_n,	
	sram_addr,	
  sram_write_n,    
	sram_wdata,     
	sram_rdata      
);

parameter SRAM_ADDR_WIDTH = 12,
	        SRAM_DATA_WIDTH = 32;


input                         sram_clk;
input  [3:0]                  sram_cb_n;
input  [3:0]                  sram_cs_n;
input  [SRAM_ADDR_WIDTH-1:0]  sram_addr;
input                         sram_write_n;
input  [SRAM_DATA_WIDTH-1:0]  sram_wdata;
output [SRAM_DATA_WIDTH-1:0]  sram_rdata;

reg    [3:0]                  sram_cb_n_reg;
reg    [SRAM_DATA_WIDTH-1:0]  sram_rdata;
wire   [SRAM_DATA_WIDTH-1:0]  sram_bank0_rdata;
wire   [SRAM_DATA_WIDTH-1:0]  sram_bank1_rdata;
wire   [SRAM_DATA_WIDTH-1:0]  sram_bank2_rdata;
wire   [SRAM_DATA_WIDTH-1:0]  sram_bank3_rdata;


always @ (posedge sram_clk)
		sram_cb_n_reg <=#1 sram_cb_n;

always @ (*)
    case (sram_cb_n_reg )
     	4'b1110: sram_rdata = sram_bank0_rdata;
    	4'b1101: sram_rdata = sram_bank1_rdata;
    	4'b1011: sram_rdata = sram_bank2_rdata;
    	4'b0111: sram_rdata = sram_bank3_rdata;
      default: sram_rdata = 32'h0;
     endcase
 
 sram_bank sram_bank0(
                .QA	    (sram_bank0_rdata),
                .QB 	  (),
                .CLKA	  (sram_clk),
                .CENA	  (sram_cs_n),
                .WENA	  (sram_write_n),
                .AA     (sram_addr),
                .DA	    (sram_wdata),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                 );

 sram_bank sram_bank1(
                .QA	    (sram_bank1_rdata),
                .QB 	  (),
                .CLKA	  (sram_clk),
                .CENA	  (sram_cs_n),
                .WENA	  (sram_write_n),
                .AA     (sram_addr),
                .DA	    (sram_wdata),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                 );

 sram_bank sram_bank2(
                .QA	    (sram_bank2_rdata),
                .QB 	  (),
                .CLKA	  (sram_clk),
                .CENA	  (sram_cs_n),
                .WENA	  (sram_write_n),
                .AA     (sram_addr),
                .DA	    (sram_wdata),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                 );

 sram_bank sram_bank3(
                .QA	    (sram_bank3_rdata),
                .QB 	  (),
                .CLKA	  (sram_clk),
                .CENA	  (sram_cs_n),
                .WENA	  (sram_write_n),
                .AA     (sram_addr),
                .DA	    (sram_wdata),
                .CLKB   (1'b1),
                .CENB   (1'b1),
                .WENB   (1'b1),
                .AB     (12'h000),
                .DB     (8'h00),
                .EMAA   (3'h0),
                .EMAB   (3'h0)
                 );
endmodule
