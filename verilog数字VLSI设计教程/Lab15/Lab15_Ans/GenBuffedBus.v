// ===================================================
// GenBuffedBus.   Shows use of a looping generate 
// statement to implement a register of buffered 
// flip-flops.
//
// The FF submodule involved is kept together
// in this one file, for illustration.
//
// 2005-02-28 jmw: v. 1.2 Inverted Clr logic.
// 2005-02-24 jmw: v. 1.1 Added `DC switch.
// 2005-01-13 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module GenBuffedBus
      #( parameter DHiBit = 7 )
       ( output[7:0] DBusBuf, input[7:0] DBus, QEna
       , input Rst, Clk
       );
//
localparam DWid = DHiBit + 1;
//
genvar i;
//
generate
  for(i=0; i<DWid; i=i+1)
    begin : BuffedBus  // Here is the block name.
    wire   QWire;
    DFFa   FF (.Q(QWire), .D(DBus[i]), .Clr(Rst), .Clk(Clk) );
    notif1 Nuf(DBusBuf[i], QWire, QEna[i]);
    end
endgenerate
//
endmodule // GenBuffedBus.
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
module GenBuffedBusTst;
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
  fork
  #0 DBusStim =  'b0;
  #0 QEnaStim =  'b0;
  #0 ClkStim  = 1'b0;
  #0 RstStim  = 1'b0;
  join
  #03  DBusStim = 8'h77;
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
GenBuffedBus #( .DHiBit(HiBit) ) U1
   ( .DBusBuf(DBusBufWatch), .DBus(DBusStim)
   , .QEna(QEnaStim), .Rst(RstStim), .Clk(ClkStim)
   );
//
endmodule // GenBuffedBusTst.
`endif
