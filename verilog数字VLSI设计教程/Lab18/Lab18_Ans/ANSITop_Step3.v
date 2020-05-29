// =============================================
// ANSITop.  Parameter overrides in ANSI and
// nonANSI module instantiations.
//
//  Note:  Silos may not recognize signed parameters.
//
// Step 3 lab answer.
//
// 2005-09-12 jmw:  v. 1.0  = Step 3 answer.
// =============================================
//
`timescale 1ns/100ps
//
module ANSItop #( parameter A=1, B=3
                , parameter signed[4:1] List=4'b1010
                )
                (output[3:0] BusOut, output ClockOut
                , input[3:0] BusIn, input ClockIn
                , input[1:0] Select
                );
reg ClockOutReg;
reg[63:0] Aresult;
assign #(2,3) ClockOut = ClockOutReg;
//
initial 
  begin
  #1 Aresult = A;
  #1 $finish;
  end
// ...
endmodule // ANSItop.
//
//
module ParamOver; // No I/O's necessary.
//
// No port map necessary:
ANSItop    #( 8'hab ) ANSI_01( );
//
endmodule // ParamOver.

