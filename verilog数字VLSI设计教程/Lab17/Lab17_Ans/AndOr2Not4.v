// ==================================================
// AndOr2Not4.   Shows implementation of a complex
// combinational UDP.
//
// 2007-10-19 jmw: v. 1.21 increased `timescale
//         resolution to 10 ps for wider waves.
// 2005-05-03 jmw: v. 1.2 Removed unused int i.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-23 jmw: v. 1.0 implemented.
// --------------------------------------------------
`timescale 1ns/10ps
//
module AndOr2Not4(output X, input a, b, c, d);
//
uAndOrNot4 #0.1 u01( X, a, b, c, d); // no named mapping.
//
endmodule // AndOr2Not4.
//
// The UDP:  Positional port mapping, only.
// Output bit must be first; ANSI form
// of declaration.
//
// The expression is: X = ( ~a | ~b ) & ( ~c | ~d )
//
primitive uAndOrNot4(output X, input a, b, c, d);
//
initial X = 1'b0; // Not same as module initial block.
//
table
// Output on right; inputs in declared order:
// a  b  c  d  : X
   x  x  x  x  : x;
   x  x  x  0  : x;
   x  x  ?  0  : x;
   x  x  0  x  : x;
   x  x  0  ?  : x;
   x  0  ?  0  : 1;
   x  0  0  1  : 1;
   x  0  0  ?  : 1;
   x  0  1  1  : 0;
   x  0  1  1  : 0;
   x  1  ?  0  : x;
   x  1  0  ?  : x;
   x  1  0  1  : x;
   x  1  1  1  : 0;
   ?  0  x  0  : 1;
   ?  0  x  x  : x;
   ?  0  0  x  : 1;
   ?  0  1  x  : x;
   0  x  x  x  : x;
   0  x  ?  0  : 1;
   0  x  0  ?  : 1;
   0  x  1  0  : x;
   0  x  1  1  : 0;
   0  ?  x  0  : 1;
   0  ?  x  x  : x;
   0  ?  x  1  : x;
   0  ?  0  x  : 1;
   0  ?  1  x  : x;
   0  1  x  0  : 1;
   0  1  1  x  : x;
   1  x  ?  0  : x;
   1  x  0  1  : x;
   1  x  1  1  : 0;
   1  0  0  x  : 1;
   1  0  1  x  : x;
   1  0  x  0  : 1;
   1  0  x  1  : x;
   1  1  x  1  : 0;
   1  1  x  0  : 0;
   1  1  1  x  : 0;
   1  1  0  x  : 0;
   1  1  0  x  : 0;
   // It's not certain all 'x' cases are
   // properly covered, but if so,
   // the rest is just a count:
   0  0  0  0  : 1;
   1  0  0  0  : 1;
   0  1  0  0  : 1;
   1  1  0  0  : 0;
   0  0  1  0  : 1;
   1  0  1  0  : 1;
   0  1  1  0  : 1;
   1  1  1  0  : 0;
   0  0  0  1  : 1;
   1  0  0  1  : 1;
   0  1  0  1  : 1;
   1  1  0  1  : 0;
   0  0  1  1  : 0;
   1  0  1  1  : 0;
   0  1  1  1  : 0;
   1  1  1  1  : 0;
endtable
endprimitive
// ------------------------------
//
`ifdef DC
`else
module AndOr2Not4Tst;
//
wire aStim, bStim, cStim, dStim;
reg[3:0] abcd, Cnt;
wire XWatch;
//
assign aStim = abcd[3];
assign bStim = abcd[2];
assign cStim = abcd[1];
assign dStim = abcd[0];
//
reg ClkStim;
always@(ClkStim)
  begin
  #5 ClkStim <= ~ClkStim;
  end
always@(ClkStim)
  begin
  #1 Cnt <= Cnt + 1;
  end
always@(Cnt)
  begin
  abcd = Cnt;
  end
//
initial
  begin
  #0  Cnt = 'b0;
  #0  abcd = 'b0;
  #1  ClkStim = 1'b0;
  //
  #18 abcd[2] = 1'bx;
  #100  $finish;
  end
//
AndOr2Not4 U1 ( .X(XWatch)
              , .a(aStim), .b(bStim), .c(cStim), .d(dStim) );
//
endmodule // AndOr2Not4Tst.
`endif
