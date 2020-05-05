//****************************************************
//wrapper for ahb_sram_controller
//version:0.0
//date:2009-8-3
//****************************************************

module sramc_wrapper(  AHB_if.slave  sramc_ahb );
		          
  //instance  ahb_sram_top
  
  sramc_top  U_sramc_top (
                             .hclk(sramc_ahb.clock)                 , 
                             .hreset_n(sramc_ahb.reset_n)           , 
                             .haddr(sramc_ahb.haddr)                , 
                             .hwdata(sramc_ahb.hwdata)              , 
                             .hwrite(sramc_ahb.hwrite)              , 
                             .hready(sramc_ahb.hready_in)              , 
                             .hsize(sramc_ahb.hsize)                , 
                             .hsel(sramc_ahb.hsel)                  , 
                             .htrans(sramc_ahb.htrans)              , 
                             .hrdata(sramc_ahb.hrdata)              , 
                             .hready_resp(sramc_ahb.hready_out)    , 
                             .hresp(sramc_ahb.hresp)               
			 
                         );
endmodule

