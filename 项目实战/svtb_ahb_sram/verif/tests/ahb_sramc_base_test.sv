program automatic ahb_sramc_base_test(ahb_slv_if.driver drv_if);

  ahb_slv_generator generator;
  ahb_slv_driver    driver;
  
  ahb_slv_pkt  pkt_sent ;

  int number_packets;
  
  initial begin
    pkt_sent = new();
    number_packets = 3;
    generator = new("ahb_slv_generator", number_packets);
    driver = new("ahb_slv_driver", generator.gen_mbx, drv_if);

    reset();
    generator.start();
    driver.start();
    repeat(number_packets*2+1) @(drv_if.drv_cb);
    $display($time, "WE ARE DONE ... GO HOME AND SLEEP!!! ... ACTUALLY NOT YET ...");

  end

  task reset();
    $display($time, "ns: [RESET] Design Reset Start ...");
    drv_if.hresetn <= 1'b0;
    repeat(5) @(drv_if.drv_cb);
    drv_if.hresetn <= 1'b1;
    $display ($time, "ns: [RESET] Design Reset End");
  endtask : reset


endprogram: ahb_sramc_base_test
