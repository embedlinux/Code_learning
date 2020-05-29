// =============================================
// ANSITop.  Parameter overrides in ANSI and
// nonANSI module instantiations.
//
//  Note:  Silos may not recognize signed parameters.
//
// Step 2 lab answer.
//
// 2005-09-12 jmw:  v. 2.0 New Step 2 ans.
// 2005-05-03 jmw:  v. 1.1 Comments; renamed 
//            file from ParamOver.v.
// 2005-02-02 jmw:  v. 1.0 completed.
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
assign #(2,3) ClockOut = ClockOutReg;
//
reg[63:0] Aresult, Bresult, ListResult;
//
initial
  begin
  #1 Aresult = A;
  #1 Bresult = B;
  #1 ListResult = List;
  #1 $finish;
  end
// ...
endmodule // ANSItop.
//
module nonANSItop (BusOut, ClockOut, BusIn, ClockIn, Select);
parameter A=1, B=3;
parameter signed[4:1] List=4'b1010;
output[3:0] BusOut;
output      ClockOut;
input[3:0]  BusIn;
input       ClockIn;
input[1:0]  Select;
//
reg ClockOutReg;
assign #(2,3) ClockOut = ClockOutReg;
// ...
endmodule // nonANSItop.
//
module ParamOver; // No I/O's necessary.
//
// No port map necessary:
ANSItop    #( .B(20), .List(-2) ) ANSI_01( );
ANSItop    #( 1, 20, -2 )         ANSI_02( );
nonANSItop #( .B(20), .List(-2) ) NANSI_01( );
nonANSItop #( 1, 20, -2 )         NANSI_02( );
//
endmodule // ParamOver.

