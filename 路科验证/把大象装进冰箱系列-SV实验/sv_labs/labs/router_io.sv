interface router_io(input bit clock);
	logic reset_n ;
	logic [15:0] din ;
	logic [15:0] framei_n ;
	logic [15:0] validi_n;
	logic [15:0] dout;
	logic [15:0] frameo_n ;
	logic [15:0] valido_n ;
	logic [15:0] busy_n;

	clocking cb @(posedge clock);
		default input #1ns output #1ns;	
		output reset_n ;
		output din ;
		output framei_n ;
		output validi_n;
		input  dout;
		input  frameo_n ;
		input  valido_n ;
		input  busy_n;
	endclocking :cb

	modport TB(clocking cb, output reset_n);

endinterface: router_io
