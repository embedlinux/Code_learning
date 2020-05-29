// =============================================
// DelayParam.  Shows how to specify both a
// parameter and delay for an instance, by passing
// the delay value as a parameter.
//
// 2005-05-03 jmw:  v. 1.1 Minor comment change.
// 2005-02-02 jmw:  v. 1.0 completed.
// =============================================
`timescale 1ns/100ps
//
module DelayParam (output OutWire, input InWire);
//
DelayThenParam #(.A(1), .R(3:4:5), .F(5:6:7) )
               U1 (OutWire, InWire);
//
endmodule // DelayParam.
//
module DelayThenParam #(parameter A=3, R=2, F=3 )
                     (output Out, input In);
  assign #(R,F) Out = In;
  always@(Out) 
    $strobe("time=[%02d] Out=%01b; A=[%01d] R=[%01d] F=[%01d]"
            , $time,     Out,      A,       R,       F);
endmodule // DelayThenParam.
//
// Testbench:
//
module DelayParamTst;
reg InReg;
wire OutWatch;
//
always@(InReg) #10 InReg <= ~InReg;
//
initial
  begin
  #0 InReg = 1'b0;
  #100 $finish;
  end
//
DelayParam DP_Inst1( .OutWire(OutWatch), .InWire(InReg) );
//
endmodule // DelayParamTst.
