`ifndef __MY_SEQUENCE_LIB__SV__
`define __MY_SEQUENCE_LIB__SV__


class my_sequence_lib extends uvm_sequence_library#(my_transaction);

	`uvm_object_utils(my_sequence_lib)
	`uvm_sequence_library_utils(my_sequence_lib)


	function new(string name = "my_sequence_lib");
		super.new(name);
		init_sequence_library();
	endfunction : new
	

endclass : my_sequence_lib


`endif // __MY_SEQUENCE_LIB__SV__
