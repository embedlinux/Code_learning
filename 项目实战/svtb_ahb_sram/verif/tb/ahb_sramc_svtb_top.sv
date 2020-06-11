module ahb_sramc_svtb_top();
 
  bit  hclk;
  bit  sram_clk;
  bit  hresetn;

  ahb_slv_if ahb_sramc_if(hclk);
 
  sramc_top u_sramc_top
  (
	.hclk	  	(hclk),
	.sram_clk	(sram_clk),
	.hresetn	(ahb_sramc_if.hresetn),
	.hsel		  (ahb_sramc_if.hsel),
	.hwrite		(ahb_sramc_if.hwrite),
	.hready		(ahb_sramc_if.hready),
	.hsize		(ahb_sramc_if.hsize),    
	.hburst		(3'b0), //the input port can`t be floating !
	.htrans		(ahb_sramc_if.htrans),
	.hwdata		(ahb_sramc_if.hwdata),
	.haddr		(ahb_sramc_if.haddr),		
	.dft_en		(1'b0),
	.bist_en	(1'b0),
	.hready_resp(ahb_sramc_if.hready_resp),
	.hresp		(ahb_sramc_if.hresp),
	.hrdata		(ahb_sramc_if.hrdata),
	.bist_done	(),
	.bist_fail	()
);

  ahb_sramc_base_test test(ahb_sramc_if); 
  
  initial begin
    hclk = 0;
    forever begin
      #10 hclk = ~hclk;
    end
  end 

  initial begin
    sram_clk = 1;
    forever begin
      #10 sram_clk = ~sram_clk;
    end
   end  
endmodule
