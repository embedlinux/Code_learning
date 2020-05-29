// ===========================================================
// EventCtl:  Shows what happens when sensitivity list omits
//            a RHS variable.
//
// The inferred latches WOULD be multiport . . ..
//
// ------------------------------------------------------------
// 2005-09-07 jmw: 2.0 Restored original EventCtlPart from Step
//            of Lab12; kept misc. other modules which were not
//            in the assignment.
// 2005-04-21 jmw: 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module EventCtl( input a, b, c
               , output xPart, yPart
               , xOnly, yOnly, xOnePort, xLatch, yLatch
               );
  //
  EventCtlLatch Latch_U5 ( .xLatch(xLatch), .yLatch(yLatch)
                         , .a(a), .b(b), .c(c));
  //
  EventCtlPart Part_U2( .xPart(xPart), .yPart(yPart)
                      , .a(a), .b(b), .c(c)
                      );
  //
  EventCtlOnly Only_U3(.xOnly(xOnly), .yOnly(yOnly)
                      , .a(a), .b(b), .c(c)
                      );
  //
  EventCtlOnePort OnePort_U4(.xOnePort(xOnePort), .a(a), .b(b), .c(c));
  //
endmodule // EventCtl.
//
// EventCtlLatch:  From Lab exercise:
// The following is a latch inference style
// which will not synthesize combinational logic:
// 
module EventCtlLatch(output xLatch, yLatch, input a, b, c);
reg xReg, yReg;
assign xLatch = xReg;
assign yLatch = yReg;
//
always@(a)
  begin:  aLatcher
  if (a==1'b1)
    xReg <= b & c;
  end
//
always@(b)
  begin:  bLatcher
  if (b==1'b1)
    yReg <=  (b | c)^a;
  end
endmodule // EventCtlLatch.
//
// EventCtlPart:  From Lab exercise:
module EventCtlPart(output xPart, yPart, input a, b, c);
reg xReg, yReg;
assign xPart = xReg;
assign yPart = yReg;
//
always@(a,b)
  begin: PartList
  xReg <= a & b & c;
  yReg <= (b | c)^a;
  end
endmodule // EventCtlPart.
//
module EventCtlOnly(output xOnly, yOnly, input a, b, c);
reg xReg, yReg;
assign xOnly = xReg;
assign yOnly = yReg;
//
always@(a)
  begin:  OnlyList
  xReg <= a & b & c;
  yReg <= (b | c)^a;
  end
endmodule // EventCtlOnly.
//
module EventCtlOnePort(output xOnePort, input a, b, c);
reg xReg;
assign xOnePort = xReg;
//
always@(a)
  begin:  OnePortList
  xReg <= a & b & c;
  end
endmodule // EventCtlOnePort.
//
