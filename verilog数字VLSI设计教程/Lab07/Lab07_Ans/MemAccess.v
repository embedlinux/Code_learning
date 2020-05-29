// ===========================================================
// MemAccess:  Various memory access statements,
// mostly in answer to Workbook questions.
//
// Erroneous attempts are commented out.
//
// ------------------------------------------------------------
// 2005-04-12 jmw: v. 1.1 Removed unused reg; added VCS comments.
// 2004-12-16 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module MemAccess;  // No I/O's; just a testbench.
//
// Workbook "Verilog Arrays":
parameter HiAddr = 63;
//
// Workbook "Verilog Arrays":
reg[63:0] Memory[HiAddr:0]; // HiAddr is a parameter > 56.
reg[31:0] WordRegister;
//
// Workbook Step 1:
reg[63:0] WordReg;
reg[07:0] ByteReg;
reg[15:0] DByteReg;
reg[63:0] BigMem[255:0];
reg[3:0]  LilMem[255:0];
//
initial
  begin // Blocking assignments used for testbench:
  //
  // Workbook "Verilog Arrays":
  //
  #0  WordRegister    = 32'h1111_ffff;
  //
  // Step 1. Initialize:
  //
  #0 WordReg = 64'hffff_eeee_dddd_cccc;
  #0 ByteReg =  8'h01;
  #0 DByteReg = 16'h3355;
  #0 BigMem[200] = 64'h0000_1111_2222_3333;
  #0 LilMem[100] = 4'b0101;
  #0 BigMem[31]  = 64'h5555_6666_7777_8888;
  //
  // Print memory contents:
     $display("%02d: BigMem[ 31]=[%16h].", $time, BigMem[31]);
     $display("%02d: BigMem[200]=[%16h].", $time, BigMem[200]);
     $display("%02d: LilMem[100]=[%4b]." , $time, LilMem[100]);
  //
  #1 BigMem[31]         = WordReg;
  //
  // Print memory contents:
     $display("%02d: BigMem[ 31]=[%16h].", $time, BigMem[31]);
  // #1 WordReg         = BigMem;    // VCS & Silos reject this.
  // #1 LilMem[127:126] = ByteReg;   // VCS rejects this.
  // #1 LilMem          = ByteReg[3:0]; // VCS & Silos reject this.
  #1 DByteReg        = ByteReg;
  #1 ByteReg         = DByteReg + BigMem[31];
  // #1 WordReg[12:0]   = BigMem[12:0][0]; // VCS rejects this.
  //
  #8 $finish;
  end
endmodule // MemAccess.

