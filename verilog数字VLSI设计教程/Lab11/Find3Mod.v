// ------------------------------------------
// Find3Mod   Shows how a recursive function
//   call may succeed if declared automatic.
//
// Also shows a function call combined with a
// concatenation in a continuous assignment
// statement.
//
// The Find3Mod module reads a 4-bit hex value
// input (unsigned) and searches upward for
// the nearest value divisible by 3, outputting
// that value (with 3 bits of 'z' prepended).
//
// This design will not synthesize because of
// exceeding the default DC stack limit; this
// excess is a result of the recursive call
// of findUp.
// ------------------------------------------
// 2005-12-07 jmw:  v. 1.0 implemented.
// ------------------------------------------
// 
`timescale 1ns/1ns
//
module Find3Mod (output[6:0] Dout, input[3:0] Din);
//
function automatic [3:0] findUp(input[3:0] D);
  reg[3:0] temp;
  begin
  temp = 'b0;
  if (D%3==4'h0)
       temp = D;
  else temp = findUp(D + 4'h1);
  //
  findUp = temp;
  end
endfunction
//
assign #15 Dout = {3'bz,findUp(Din)};
//
endmodule // Find3Mod.
//
`ifdef DC
`else
module Find3Mod_Test;
//
wire[6:0] DoutWire;
 reg[3:0] DinReg;
integer   i;
//
initial
  begin
  DinReg = 4'h0;
  //
  #100
  for (i=0;i<=20; i=i+1)
    #50 DinReg = DinReg + 4'b0001;
  //
  #100 $finish;
  end
//
Find3Mod U01(.Dout(DoutWire), .Din(DinReg) );
//
endmodule // Find3Mod_Test.
`endif
