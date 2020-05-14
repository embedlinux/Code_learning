`timescale 1ns/1ps

import components::*;


module testbench;

	logic pclk,presetn;
	logic [DATA_W-1:0] paddr,pwdata,prdata;
	logic pwrite,pselx,penable;
	logic req_tx_vld;

	wire pready,pslverr;
	wire int_rx,int_tx;
	wire sda_enable,scl_enable;
	wire scl;
	wire sda;

	wire [DATA_W-1:0] data_r;
	wire data_r_vld;
	//apb_bus_t apb_bus;

	assign pwrite = apb_bus.write; 
	assign pselx = apb_bus.sel;
	assign penable = apb_bus.enable;
	assign pwdata = apb_bus.wdata;
	assign paddr = apb_bus.addr;

	assign apb_bus.rdata = prdata;
	assign apb_bus.ready = pready;
	assign apb_bus.slverr = pslverr;
	assign apb_bus.clk = pclk;

	//logic event_tx_i2c_vld,event_tx_vld;
	assign event_tx_vld     = req_tx_vld == 1'b1;
	assign event_tx_i2c_vld = data_r_vld == 1'b1;
	//data_t data_tx_i2c;
	//logic data_tx_i2c_vld;
	assign data_tx_i2c = data_r;
	assign data_tx_i2c_vld = data_r_vld;


	initial begin
		pclk = 1;
		forever begin
			#(T/2.0) pclk = ~pclk;
		end
	end

	initial begin
		presetn = 1;
		#1;
		presetn = 0;
		#(T*2);
		presetn = 1;
	end


	assign req_tx_vld = pselx & pwrite & penable & pready & ~pslverr & (paddr == ADDR_TX_FIFO || paddr == ADDR_RX_FIFO);

	Environment env;
	Config req_config;
	initial begin
		env = new();
		//req_config = new(CONFIG_WR_DATA);
		req_config = new(CONFIG_RD_DATA);
		env.req_config = req_config;
		
		#1;
		#(T*2);
		
		env.env_run();
	end
	///////////////////////////      
	i2c_slave 
	#(.DATA_WIDTH(DATA_W))
	i2c_slave_vip(
		.clk            (pclk),
		.scl            (scl),
		.sda            (sda),
		.sda_master_en  (sda_enable),
		.data_r            (data_r),
		.data_r_vld        (data_r_vld),
		.data_w            (),
		.data_w_vld        ()
	);


	i2c DUT(
		//APB PORTS
		.PCLK            (pclk),
		.PRESETn        (presetn),
		.PADDR            (paddr),
		.PWDATA            (pwdata),
		.PWRITE            (pwrite),
		.PSELx            (pselx),
		.PENABLE        (penable),
		. PREADY        (pready),
		. PSLVERR        (pslverr),
		. INT_RX        (int_rx),    
		. INT_TX        (int_tx),
		. PRDATA        (prdata),
		. SDA_ENABLE    (sda_enable),
		. SCL_ENABLE    (scl_enable),
		.SDA            (sda),
		.SCL            (scl)    
	);

endmodule