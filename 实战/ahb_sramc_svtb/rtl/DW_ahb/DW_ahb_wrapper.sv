//**************************************************
//DW AHB bus wrapper
//**************************************************

module DW_ahb_wrapper(
                      AHB_if.bs cpu_bs,
             		  AHB_if.bs dma_bs,
                      AHB_if.bm dma_bm,
                      AHB_if.bm sram_bm,
                      AHB_if.bm sdc_bm,
                      AHB_if.bm xxx_bm
                     );

  //internal signals
  
  wire [31:0] rdata_i;
  wire [1:0]  resp_i;

  wire        ready_i;
  wire        write_i;
  wire [31:0] addr_i;
  wire [2:0]  burst_i; 
  wire [3:0]  prot_i; 
  wire [2:0]  size_i; 
  wire [1:0]  trans_i; 
  wire [31:0] wdata_i;
  wire [3:0]  master_i; 
  wire        mastlock_i; 

  //spread the bus 
  
  assign cpu_bs.hrdata    = rdata_i; 
  assign dma_bs.hrdata    = rdata_i; 
  assign cpu_bs.hresp     = resp_i; 
  assign dma_bs.hresp     = resp_i; 
  assign cpu_bs.hready_in = ready_i; 
  assign dma_bs.hready_in = ready_i; 
  

  assign dma_bm.haddr     = addr_i;
  assign dma_bm.hready_in = ready_i;
  assign dma_bm.hwrite    = write_i;
  assign dma_bm.hburst    = burst_i;
  assign dma_bm.hprot     = prot_i;
  assign dma_bm.hsize     = size_i;
  assign dma_bm.htrans    = trans_i;
  assign dma_bm.hwdata    = wdata_i;
  assign dma_bm.hmaster   = master_i;
  assign dma_bm.hmastlock = mastlock_i;

  assign sram_bm.haddr     = addr_i;
  assign sram_bm.hready_in = ready_i;
  assign sram_bm.hwrite    = write_i;
  assign sram_bm.hburst    = burst_i;
  assign sram_bm.hprot     = prot_i;
  assign sram_bm.hsize     = size_i;
  assign sram_bm.htrans    = trans_i;
  assign sram_bm.hwdata    = wdata_i;
  assign sram_bm.hmaster   = master_i;
  assign sram_bm.hmastlock = mastlock_i;

  assign sdc_bm.haddr      = addr_i;
  assign sdc_bm.hready_in  = ready_i;
  assign sdc_bm.hwrite     = write_i;
  assign sdc_bm.hburst     = burst_i;
  assign sdc_bm.hprot      = prot_i;
  assign sdc_bm.hsize      = size_i;
  assign sdc_bm.htrans     = trans_i;
  assign sdc_bm.hwdata     = wdata_i;
  assign sdc_bm.hmaster    = master_i;
  assign sdc_bm.hmastlock  = mastlock_i;

  assign xxx_bm.haddr      = addr_i;
  assign xxx_bm.hready_in  = ready_i;
  assign xxx_bm.hwrite     = write_i;
  assign xxx_bm.hburst     = burst_i;
  assign xxx_bm.hprot      = prot_i;
  assign xxx_bm.hsize      = size_i;
  assign xxx_bm.htrans     = trans_i;
  assign xxx_bm.hwdata     = wdata_i;
  assign xxx_bm.hmaster    = master_i;
  assign xxx_bm.hmastlock  = mastlock_i;

  //instance DW ahb bus

  DW_ahb  U_dw_ahb(
                   .hclk(cpu_bs.clock),
                   .hresetn(cpu_bs.reset_n),
                   //master interface common
                   .hrdata(rdata_i), 
                   .hresp(resp_i), 
                   //master1 interface
                   //input signals
                   .hgrant_m1(cpu_bs.hgrant), 
                   //output signals
                   .haddr_m1(cpu_bs.haddr), 
                   .hburst_m1(cpu_bs.hburst), 
                   .hbusreq_m1(cpu_bs.hbusreq), 
                   .hlock_m1(cpu_bs.hlock), 
                   .hprot_m1(cpu_bs.hprot), 
                   .hsize_m1(cpu_bs.hsize), 
                   .htrans_m1(cpu_bs.htrans), 
                   .hwdata_m1(cpu_bs.hwdata), 
                   .hwrite_m1(cpu_bs.hwrite), 
                   //master2 interface
                   //input signals
                   .hgrant_m2(dma_bs.hgrant), 
                   //output signals
                   .haddr_m2(dma_bs.haddr), 
                   .hburst_m2(dma_bs.hburst), 
                   .hbusreq_m2(dma_bs.hbusreq), 
                   .hlock_m2(dma_bs.hlock), 
                   .hprot_m2(dma_bs.hprot), 
                   .hsize_m2(dma_bs.hsize), 
                   .htrans_m2(dma_bs.htrans), 
                   .hwdata_m2(dma_bs.hwdata), 
                   .hwrite_m2(dma_bs.hwrite), 
                   //slave interface common
                   .haddr(addr_i), 
                   .hready(ready_i), 
                   .hwrite(write_i), 
                   .hburst(burst_i), 
                   .hprot(prot_i), 
                   .hsize(size_i), 
                   .htrans(trans_i), 
                   .hwdata(wdata_i), 
                   .hmaster(master_i), 
                   .hmastlock(mastlock_i), 
                   //slave1 interface
                   //input signals
                   .hready_resp_s1(dma_bm.hready_out), 
                   .hresp_s1(dma_bm.hresp), 
                   .hrdata_s1(dma_bm.hrdata), 
                   //output signals
                   .hsel_s1(dma_bm.hsel), 
                   //slave2 interface
                   //input signals
                   .hready_resp_s2(sram_bm.hready_out), 
                   .hresp_s2(sram_bm.hresp), 
                   .hrdata_s2(sram_bm.hrdata), 
                   //output signals
                   .hsel_s2(sram_bm.hsel), 
                   //slave3 interface
                   //input signals
                   .hready_resp_s3(sdc_bm.hready_out), 
                   .hresp_s3(sdc_bm.hresp), 
                   .hrdata_s3(sdc_bm.hrdata), 
                   //output signals
                   .hsel_s3(sdc_bm.hsel), 
                   //slave4 interface
                   //input signals
                   .hready_resp_s4(xxx_bm.hready_out), 
                   .hresp_s4(xxx_bm.hresp), 
                   .hrdata_s4(xxx_bm.hrdata), 
                   //output signals
                   .hsel_s4(xxx_bm.hsel) 
                  );
endmodule
