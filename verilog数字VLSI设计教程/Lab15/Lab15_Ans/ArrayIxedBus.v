// ===================================================
// ArrayIxedBus.   Replaces a looping generate 
// statement with arrayed instances to implement a
// register of buffered flip-flops.
//
// The FF submodule involved is kept together
// in this one file, for illustration.
//
// NOTE:  The Silos simulator apparently can't
// accept arrayed user-defined module instances.
//
// 2005-04-28 jmw: v. 1.3 Minor comment & tb changes.
// 2005-02-28 jmw: v. 1.2 Inverted Clr reset logic.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-13 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module ArrayIxedBus
      #( parameter DHiBit = 7 )
       ( output[DHiBit:0] DBusBuf
       , input[DHiBit:0] DBus, QEna, input Rst, Clk
       );
//
wire[DHiBit:0] QWire;
//
DFFa    FF[DHiBit:0] (.Q(QWire), .D(DBus), .Clr(Rst), .Clk(Clk) );
notif1 Nuf[DHiBit:0] (DBusBuf, QWire, QEna);
//
endmodule // ArrayIxedBus.
//
// --------------
module DFFa(output Q, input D, Clr, Clk);
//
reg QReg;
assign #1 Q = QReg;
//
always@(posedge Clk, posedge Clr)
  if (Clr==1'b1)
       QReg <= 1'b0;
  else QReg <= D;
//
endmodule // DFFa.
// --------------
`ifdef DC
`else
module ArrayIxedBusTst;
//
localparam HiBit = 7;
//
wire[HiBit:0] DBusBufWatch;
reg[HiBit:0] DBusStim, QEnaStim;
reg RstStim, ClkStim;
//
always@(ClkStim) #5 ClkStim <= ~ClkStim;
//
initial
  begin
  fork // Just to illustrate legal syntax.
  #0.0 DBusStim =  'b0;
  #0.1 QEnaStim =  'b0;
  #0.2 ClkStim  = 1'b0;
  #1   RstStim  = 1'b0;
  join
  // Time here will be 1.
  #02  DBusStim = 8'h77;
  #12  QEnaStim = 8'h0e;
  #10  DBusStim = 8'hff;
  #02  QEnaStim = 8'hee;
  #10  DBusStim = 8'hbb;
  #10  DBusStim = 8'h00;
  #02  QEnaStim = 8'hff;
  #10  DBusStim = 8'hbb;
  #10  DBusStim = 8'h11;
  #0   RstStim  = 1'b1;
  #10  RstStim  = 1'b0;
  #10  DBusStim = 8'hff;
  #10  DBusStim = 8'he7;
  #20  $finish;
  end
//
ArrayIxedBus #( .DHiBit(HiBit) ) U1
   ( .DBusBuf(DBusBufWatch), .DBus(DBusStim)
   , .QEna(QEnaStim), .Rst(RstStim), .Clk(ClkStim)
   );
//
endmodule // ArrayIxedBusTst.
`endif
