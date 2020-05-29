// ==================================================
// DFF_UDP.   Shows implementation of a D flip-flop
// using a sequential UDP and an inverter.
//
// Because a UDP can't include delays, delays must be
// supplied by the instantiating module.  The UDP must
// be included in a module if the component it
// represents is to include timing.
//
// --------------------------------------------------
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-20 jmw: v. 1.0 implemented.
// ==================================================
`timescale 1ns/100ps
//
module DFF_UDP(output Q, Qn, input D, Clk, Rst);
//
wire uQNet;
assign  #2 Q  = uQNet;
assign  #3 Qn = ~uQNet;
//
uFF u01( uQNet, D, Clk, Rst); // no named mapping.
//
endmodule // DFF_UDP.
//
// The UDP:  Positional port mapping, only.
// Output bit must be first; ANSI form
// of declaration.
//
// This FF model is for posedge clock and reset:
//
primitive uFF(output reg uQ, input uD, uClk, uRst);
//
initial uQ = 1'bx; // Not same as module initial block.
//
table
// Output on right; inputs in declared order:
//               current  next
// uD  uClk uRst   uQ      uQ
   0   (01)   0 :   ?  :   0  ;  // Clock in 0
   1   (01)   0 :   ?  :   1  ;  // Clock in 1
   0   (0?)   0 :   0  :   0  ;  // Clock in same 0
   1   (0?)   0 :   1  :   1  ;  // Clock in same 1
     
   ?   (1?)   0 :   ?  :   -  ;  // Ignore negedge.
  (??)   ?    0 :   ?  :   -  ;  // Retain state.

   ?     ?  (01):   ?  :   0  ;  // Posedge reset
   ?   (??)   1 :   ?  :   0  ;  // Ignore clock edge
  (??)  ?     1 :   ?  :   0  ;  // Ignore clock state
   ?    ?     1 :   ?  :   0  ;  // Ignore clock state
endtable
endprimitive
// ------------------------------
//
`ifdef DC
`else
module DFF_UDPTst;
reg DStim, ClkStim, RstStim;
wire QWatch;
//
always@(ClkStim) #4 ClkStim <= ~ClkStim;
//
initial
  begin
  #0  DStim = 1'b0;
  #0  ClkStim = 1'b0;
  #0  RstStim = 1'b0;
  #10 DStim   = 1'b1;
  #40 DStim   = 1'b0;
  #50 DStim   = 1'b1;
  #5  RstStim = 1'b1;
  #20 RstStim = 1'b0;
  #100  $finish;
  end
//
DFF_UDP U1 ( .Q(QWatch), .Qn(QnWatch)
           , .D(DStim), .Clk(ClkStim), .Rst(RstStim) );
//
endmodule
`endif
