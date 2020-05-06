
program automatic ahb_sramc_base_test(ahb_slv_if.driver drv_if);        //创建接口对象
	generator gen;
	driver dri;
	pkt pkt_sent;
	
	int number_packets;
	initial begin
		pkt_sent = new();
		number_packets = 3;
		gen = new("ahb_slv_generator",number_packets);
		dir = new("ahb_slv_driver",number_packets);
		
		reset();
		gen.start();
		dri.start();
		repeat(number_packets*2+1) @(dri.drv_cb);
	end
	
	


endprogram