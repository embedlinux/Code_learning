module ahb_sramc_svtb_top();
  
  bit    hclk;
  bit    sram_clk;
  bit    hresetn;    

  ahb_slv_if ahb_sramc_if(hclk);           //接口例化
 
  ahb_sram_test  test(ahb_sramc_if);       //1.通过接口例化连接测试用例testcase
 
  sramc_top   u_sramc_top(                 //2.通过接口例化连接DUT顶层文件；结合1、2两步骤建立DUT与TB之间的连接
              .hclk           (hclk),
              .sram_clk       (sram_clk),
              .hresetn        (ahb_sramc_if.hresetn),
              .hsel           (ahb_sramc_if.hsel),
              .hwrite         (ahb_sramc_if.hwrite),
              .htrans         (ahb_sramc_if.htrans),
              .hsize          (ahb_sramc_if.hsize),
              .hready         (ahb_sramc_if.hready),
              .hburst         (3'b0),                   //无用
              .haddr          (ahb_sramc_if.haddr),
              .hwdata         (ahb_sramc_if.hwdata),
              .hrdata         (ahb_sramc_if.hrdata),
              .dft_en         (1'b0),                   //不测              
              .bist_en        (1'b0),                   //不测
              .hready_resp    (ahb_sramc_if.hready_resp),              
              .hresp          (ahb_sramc_if.hresp),
              .bist_done      ( ),                      //不测              
              .bist_fail      ( )                       //不测
               );

  initial begin
     forever  #10  hclk = ~ hclk;               //产生时钟信号
  end
   
  always @(*)     sram_clk = ~hclk;
   
  initial begin
     hresetn = 1;
     #1 hresetn = 0;          //复位处理
     #10 hresetn = 1;         //撤销复位
  end
   
  assign ahb_sramc_if.hresetn = hresetn;         //在开始时，先进行复位操作

endmodule