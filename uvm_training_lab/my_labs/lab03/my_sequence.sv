`ifndef __MY_SEQUENCE__SV__
`define __MY_SEQUENCE__SV__

class my_sequence extends uvm_sequence #(my_transaction);

	`uvm_object_utils(my_sequence)
	
	function new(string name = "my_sequence");
		super.new(name);
	endfunction : new


	virtual task body();

		if (starting_phase != null)
			starting_phase.raise_objection(this);

		repeat (10) begin 
			`uvm_do(req)
		end

		#100;
		if (starting_phase != null)
			starting_phase.drop_objection(this);

	endtask : body


endclass : my_sequence

`endif // __MY_SEQUENCE__SV__