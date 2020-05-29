// ===================================================
// HierRef.   Shows hierarchical references.
//          Named "A" in Workbook section on hier names.
//
// 2005-01-15 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module A;  // No port; not for simulation.
//
wire Clock, Clear;
//
assign Clock = 1'b0;
assign Clear = 1'b0;
//
assign B.D = C.Q;
assign C.D = B.Q;
//
assign D.E.OutBus = C.OutWire;
//
DFFC B( .Clr(Clear), .Clk(Clock) );
//
DFFC C(.Q(), .D(), .Clr(Clear), .Clk(Clock) );
//
D_Type D(.Dout(C.D));
//
endmodule // A.
//
// --------------
module DFFC(output Q, input D, Clr, Clk);
//
wire OutWire;
//
assign A.D.E.OutBus = OutWire;
//
reg QReg;
assign #1 Q = QReg;
//
always@(posedge Clk, posedge Clr)
  if (Clr!=1'b0)
       QReg <= 1'b0;
  else QReg <= D;
//
endmodule // DFFC.
// --------------
module D_Type(output Dout);
//
assign Dout = 1'b1;
wire Ein, Q;
E_Type E(.Eout(Ein) );
//
assign A.B.D = A.C.Q;
//
endmodule // D_Type.
// --------------
module E_Type(output Eout, OutBus);
assign Eout = 1'b1;
//
endmodule // C_Type.

