// ==================================================
// AndLatch.   Shows UDP implementation of a transparent
// latch which stores the and of two input bits.
//
// There is no reset input.
//
// 2005-05-03 jmw: v. 1.2 Renamed ClkDiv2 to EnaStim.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-23 jmw: v. 1.0 implemented.
// --------------------------------------------------
`timescale 1ns/100ps
//
module AndLatch(output Q, Qn, input D1, D2, Ena);
//
wire uQNet;
assign  #1 Q  = uQNet;
assign  #2 Qn = ~uQNet;
//
uAndLatch u01( uQNet, D1, D2, Ena);
//
endmodule // AndLatch.
//
primitive uAndLatch(output reg uQ, input uD1, uD2, uEna);
//
initial uQ = 1'bx; // Not same as module initial block.
//
table
// Output on right; inputs in declared order:
//                current  next
// uD1  uD2  uEna    uQ     uQ
    0    0    1   :   ?  :   0  ;  // Latch 0
    0    1    1   :   ?  :   0  ;  // Latch 0
    1    0    1   :   ?  :   0  ;  // Latch 0
    1    1    1   :   ?  :   1  ;  // Latch 1
    //
    ?    ?    0   :   ?  :   -  ;  // Disabled
    //

    //
endtable
endprimitive // uAndLatch
// ------------------------------
//
`ifdef DC
`else
module AndLatchTst;
reg[1:0] DStim;
reg      ClkStim, EnaStim;
wire QWatch, QnWatch;
//
always@(ClkStim) #5 ClkStim <= ~ClkStim;

always@(negedge ClkStim) #1 EnaStim <= ~EnaStim;

always@(negedge ClkStim) #2 DStim <= DStim + 1;
//
initial
  begin
  #0  DStim   = 'b0;
  #0  ClkStim = 1'b0;
  #0  EnaStim = 1'b0;

  #100  $finish;
  end
//
AndLatch U1 ( .Q(QWatch), .Qn(QnWatch)
            , .D1(DStim[0]), .D2(DStim[1])
            , .Ena(EnaStim) );
//
endmodule // AndLatchTst.
`endif
