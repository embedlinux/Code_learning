// ===========================================================
// Vector: Some simple vector operations.
//
// No module I/O ports.
// ------------------------------------------------------------
// 2007-09-18 jmw:  v. 2.0 Added My48bits exercise.
// 2007-02-17 jmw:  v. 1.2 Minor comment change.
// 2004-12-05 jmw:  v. 1.1 Fixed "array" to "vector".
// 2004-11-27 jmw:  v. 1.0 implemented.
// ===========================================================
//
`timescale 1ns/100ps

module Vector;
reg [0:15] MyBus;  // A vector of 16 bits of storage.
wire[15:0] mybus;  // A 16-bit bus.
wire       mybit;  // One bit bus.
//
reg[47:0]  My48bits;
//
assign mybus = 16'heeee; // Continuously drive the wire bus.
assign mybit = 1'b0;     // Hold the wire at 0.
//
initial
  begin
  #10 MyBus        = 16'h3333;
  #10 MyBus[0:2]   = mybus[10:8];  // MSB always on the left.
  #10 MyBus        = mybus;
  #10 MyBus[0:15]  = mybus[15:0];
  #10 MyBus[0]     = mybit;        // Zero the MSB.
  //
  #10 MyBus = 16'hxxxx; // Flag the end of this step in the lab.
  #5  My48bits  = 'bz;
  #5  My48bits  = 'bx;
  #5  My48bits  = 'b0;
  #5  My48bits  = 'b1;
  #10 ;
  #5  My48bits  = 1'bz;
  #5  My48bits  = 1'bx;
  #5  My48bits  = 1'b0;
  #5  My48bits  = 1'b1;
  #5  $finish;
  end
endmodule // Vector
