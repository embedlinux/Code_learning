//******************************************************************************
// quick_compare.v
//
// Quick Compare Logic
//
// The quick compare logic computes results for 6 different 
// types of conditions for use with conditional branches.  QCsel 
// specifies the type of comparision to be computed.
//******************************************************************************

module quick_compare (RSbus, RTbus, QCsel, Result);

input	[31:0]	RSbus;			// S operand input
input	[31:0]	RTbus;			// T operand input
input	[5:0]	QCsel;			// Select comparision operation
output		Result;	
reg		Result;			// Result of comparision operation

always @(RSbus or RTbus or QCsel)
  begin		// Instructions Supported
    case (QCsel)
      `select_qc_ne:	Result = (RSbus != RTbus);		// BNE
      `select_qc_eq:	Result = (RSbus == RTbus);		// BEQ
      `select_qc_lez:	Result = (RSbus[31]==1) | (RSbus == 0);	// BLEZ
      `select_qc_gtz:	Result = (RSbus[31]==0) & (RSbus != 0);	// BGTZ
      `select_qc_gez:	Result = (RSbus[31]==0);		// BGEZ
      `select_qc_ltz:	Result = (RSbus[31]==1);		// BLTZ
      default:		Result = `dc;				// Undefined
    endcase
  end

endmodule	// quick_compare

