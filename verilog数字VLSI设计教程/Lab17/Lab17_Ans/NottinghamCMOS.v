// ================================================
// NottinghamCMOS (Step 4).  Switch-level vs verilog
// primitive inverters.
//
//   My VCS or Silos result:
/*
 * ---------------------------
 *     cmos Truth Table      
 * ---------------------------
 * out  in    n-ctl    p-ctl
 *  1    1      1        1
 *  1    1      1        0
 *  1    1      0        0
 *  z    1      0        1
 *  0    0      1        1
 *  0    0      1        0
 *  0    0      0        0
 *  z    0      0        1
 *  x    1      x        x
 *  1    1      x        0
 *  0    0      x        0
 *  x    1      x        1
 *  x    0      x        1
 *  x    1      0        x
 *  x    0      0        x
 *  1    1      1        x
 *  0    0      1        x
 *  1    1      1     unconn
 *  0    0      1     unconn
 *  x    1      0     unconn
 *  x    0      0     unconn
 */
//
// 2005-05-03 jmw: v. 1.3 Minor comment changes.
// 2005-02-24 jmw: v. 1.2 Added `DC switch.
// 2005-01-23 jmw: v. 1.1 Added cmos to check truth table.
// 2005-01-23 jmw: v. 1.0 implemented
// ================================================
//
`timescale 1ns/100ps
//
module Nottingham (output Tran, Notter, cmoser, input In, Nctl, Pctl);
wire TranWire, cmosWire;
wire vdd, gnd;

pullup(vdd);
pulldown(gnd);

assign Tran = TranWire;
assign cmoser = cmosWire;
//
pmos #(2, 3, 5) pmosInst(TranWire, vdd, In);
nmos #(1, 2, 2) nmosInst(TranWire, gnd, In);
//
not #(1.2, 1.3) NotInst(Notter, In);
//
cmos #(1,1,1) cmosInst(cmosWire, In, Nctl, Pctl);

//
endmodule // Nottingham.
//
// --------------------------------------------
//
`ifdef DC
`else
module NottinghamTst;
//
reg InStim, NctlStim, PctlStim;
//
always@(InStim) #10 InStim <= ~InStim;
//
initial
  begin
  #0 InStim = 1'b0;
  
  #5  NctlStim = 1'b1; PctlStim = 1'b1;
  #25 NctlStim = 1'b0; PctlStim = 1'b0;
  #25 NctlStim = 1'b1; PctlStim = 1'b0;
  #25 NctlStim = 1'b0; PctlStim = 1'b1;
  #25 NctlStim = 1'bx; PctlStim = 1'bx;
  #25 NctlStim = 1'bx; PctlStim = 1'b0;
  #25 NctlStim = 1'bx; PctlStim = 1'b1;
  #25 NctlStim = 1'b0; PctlStim = 1'bx;
  #25 NctlStim = 1'b1; PctlStim = 1'bx;
  #25 NctlStim = 1'b1; PctlStim = 1'bz;
  #25 NctlStim = 1'b0; PctlStim = 1'bz;
  #50 $finish;
  end
//
Nottingham U1
  ( .Tran(TranWatch), .Notter(NotterWatch), .cmoser(cmosWatch)
  , .In(InStim), .Nctl(NctlStim), .Pctl(PctlStim) );
//
endmodule // NottinghamTst.
`endif
