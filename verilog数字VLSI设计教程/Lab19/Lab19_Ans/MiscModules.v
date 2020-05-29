// =============================================
// MiscModules.  Lab problem in Hierarchical
// connections.
//
// 2005-05-12 jmw:  v. 1.1 Added `ifdefs.
// 2005-02-09 jmw:  v. 1.0 completed.
// =============================================
`timescale 1ns/100ps
//
// Uncomment one at a time:
// `define Step2 1
// `define Step3 1
// `define Step4 1
// `define Step5 1
//
module Wide(output[95:0] OutWide, input[71:0] InWide);
initial
  begin
  #10 $finish;
  end
`ifdef Step5
assign #5 OutWide = 95'h7fff_ffff_ffff_ffff_ffff_fff2;
`endif
endmodule
//
module Narrow(output[1:0] OutNarrow, input[1:0] InNarrow);
`ifdef Step2
 Bit Bit1( .Out(OutNarrow), .In(InNarrow) );
`endif
`ifdef Step3
 Bit Bit1( .Out(OutNarrow), .In(InNarrow) );
`endif
`ifdef Step4
 assign OutNarrow = 2'b10;
`endif
`ifdef Step5
 assign OutNarrow = 2'b10;
 Wide Wide1( .OutWide(OutNarrow), .InWide(InNarrow) );
`endif
endmodule
//
`ifdef Step5
`else
module Bit(output Out, input In);
`ifdef Step2
 assign Out = 1'b1;
`endif
`ifdef Step3
 assign Out = 1'b1;
 Narrow Narrow1();
`endif
`ifdef Step4
 Narrow Narrow1(.OutNarrow(Out), .InNarrow(In) );
`endif
endmodule
`endif

