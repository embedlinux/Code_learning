// ===================================================
// IxOffset. Demonstrates a verilog indexed offset.
// Relevant to Lab07.
//
// Apparently not implemented in Silos or VCS.
//
// 2005-02-09 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module IxOffset(output Nufo, input iEnaNuf, iNor, iNand); 
//
reg[127:0] PixLine2, PixLine1;
integer j;
//
initial
  begin
  #0   PixLine1 = 128'h1111_2222_3333_4444_5555_6666_7777_8888;
  #0   PixLine2 = 128'h9999_aaaa_bbbb_cccc_dddd_eeee_ffff_0000;
  for (j=1; j<8; j = j+1)
    #5 PixLine2[(j*8) + : 8] = PixLine1[(j*8) + : 8];
  #100 $finish;
  end

endmodule // IxOffset.

