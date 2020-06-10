//******************************************************************************
// wb_control.v
//
// Write Back Control Logic
//
// Decode destination register number:
//	The following logic examines a 32-bit instruction and decodes the 
//	appropriate fields in order to find a register file destination 
//	address for the result.  If the operation does not write to the 
//	register file, decode_rd returns a destination register of zero. 
//******************************************************************************

module wb_control (IR, WBsel);

input	[31:0]	IR;		// Instruction Register 
output	[2:0]	WBsel;
reg	[2:0]	WBsel;		// Select lines for WB register

always @(IR)
begin
   casex ({IR[`op], IR[`function]})
        // Write back load data from cache
        {`LW,      `dc6 }: WBsel = `select_wb_load;

        // Write back PC link value
        {`JAL,     `dc6 }: WBsel = `select_wb_link;
        {`SPECIAL, `JALR}: WBsel = `select_wb_link;

        // Write back result from ALU
        default          : WBsel = `select_wb_alu;
   endcase
end

endmodule	// wb_control 

