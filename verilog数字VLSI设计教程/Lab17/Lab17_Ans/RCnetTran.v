// ================================================
// RCnet.  Switch-level model of a RC filter
// network.  Enabled rnmos switches substitute
// for resistors.  Replacing the mos
// switches with rtran's gives a better delay.
//
// Tap[1] is at the driving buffer output;
// Tap[2] is at the first rnmos output;
// Tap[3] is at the second rnmos output;
//
// 2007-10-19 jmw: v. 1.21 Increased `timescale
//         resolution to 10 ps for wider waves.
// 2005-05-03 jmw: v. 1.2 Added `RTRAN switch.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-24 jmw: v. 1.0 implemented
// ================================================
//
// Use this define to substitute rtran for rnmos discharge:
`define RTRAN
//
`timescale 1ns/10ps
//
module RCnet (output OutPut, input In);
wire[1:3] Tap;
wire vdd, gnd;
wire Out;

pullup(vdd);
pulldown(gnd);
//
trireg (small)  #(3,3,10)   Tri01;
trireg (large)  #(15,15,50) Tri02;
trireg (medium) #(7,7,30)   Tri03;
trireg (small)  #(3,3,10)   Tri04;
//
// To monitor changes:
assign Tap[1] = Tri01 ;
assign Tap[2] = Tri02;
assign Tap[3] = Tri03;
assign OutPut = Out;
//
bufif1 #1 InBufInst(Tri01, vdd, In);
//
`ifdef RTRAN
tran (Tri02, Tri01);
tran (Tri03, Tri02);
tran (Out,   Tri03);
`else
// Alternative:
rnmos #1 (Tri02, Tri01, vdd);
rnmos #1 (Tri03, Tri02, vdd);
rnmos #1 (Out,   Tri03, vdd);
`endif
//
endmodule // RCnet.
//
// ------------------------------------------
//
`ifdef DC
`else
module RCnetTst;
//
wire OutPutWatch;
//
reg InStim;
//
always@(InStim) #100 InStim <= ~InStim;
//
initial
  begin
  #0 InStim = 1'b1;
  
  #500 $finish;
  end
//
RCnet U1(.OutPut(OutPutWatch), .In(InStim));
//
endmodule // RCnetTst.
`endif
