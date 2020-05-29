// ===========================================================
// Legal:   A check on legality of various memory
// reference constructs.
//
// $strobe is like $display:  Both are system tasks which
// print a message to the simulator console.   The difference
// between them will be explained in class later.
//
// ANSI module header.
// ------------------------------------------------------------
// 2005-11-02 jmw:  v. 1.1 comments added.
// 2005-01-27 jmw:  v. 1.0 implemented.
// ============================================================
`timescale 1ns/100ps
//
module Legal; // No need for I/O.
parameter HiAddr = 63;
parameter Width  = HiAddr+1;
parameter AnAddr = HiAddr/2;
//
reg[HiAddr:0]    MemArray[HiAddr:0];
reg[Width/4-1:0] ByteRegister;
reg[Width/2-1:0] WordRegister;
//
integer i;
//
initial
  begin
  #0  ByteRegister = 4'h7;
  #0  WordRegister = 4'h3;
  //
  // This for loop controls just one statement:
  #1 for (i=0; i<=HiAddr; i=i+1)
     #0.1 MemArray[i] = 1 + i + 1<<i;
  //
  // Use blocking assignments to space out events:
  //
  #5 ByteRegister = ByteRegister + 1;
  #0 $strobe("%04d: ByteRegister=%h", $time, ByteRegister);
  //
  #5 ByteRegister =    MemArray[AnAddr];
  #0 $strobe("%04d: ByteRegister=%h Mem[%02d]=%h"
            , $time, ByteRegister, AnAddr,  MemArray[AnAddr]);
  //
  #5 ByteRegister =    MemArray[AnAddr][7:0];
  #0 $strobe("%04d: ByteRegister=%h Mem[%02d]=%h"
            , $time, ByteRegister,  AnAddr, MemArray[AnAddr]);
  //
  #5 ByteRegister =    MemArray[AnAddr][15:8];
  #0 $strobe("%04d: ByteRegister=%h Mem[%02d]=%h"
            , $time, ByteRegister, AnAddr,  MemArray[AnAddr]);
  //
  #5    MemArray[AnAddr-1][Width/2-1:Width/4-1] = WordRegister;
  #0 $strobe("%04d:               Mem[%02d]=%h"
            , $time, AnAddr-1,   MemArray[AnAddr-1]);
  //
  #5 WordRegister =    MemArray[AnAddr-1][31:0];
  #0 $strobe("%04d: WordRegister=%h Mem[%02d]=%h"
            , $time, WordRegister, AnAddr-1,   MemArray[AnAddr-1]);
  //
  #5 $finish;
  end
//
endmodule // Legal.
