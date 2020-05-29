// ===========================================================
// Truncate:  Miscellaneous truncation and normalizing
// operations.
//
// ------------------------------------------------------------
// 2005-12-16 jmw: v. 1.1 Changed all #10 to #20 for better
//                 waveform display.   Change resolution from
//                 100 ps to 1 ns.
// 2004-12-02 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/1ns
//
module Truncate;
  //
  integer     Int;
  reg[007:0] Byte = 'b0;
  reg[031:0] Word = 'b0;
  reg[063:0] Long = 'b0;
  reg[127:0]Dlong = 'b0;
  //
  initial
    begin
    Int = 'b0; // Can't initialize in declaration.
    #20
         Int = 6'd1;
        Byte = 6'd1;
        Word = 6'd1;
        Long = 6'd1;
       Dlong = 6'd1;
    //
    #20
         Int = -6'd1;
        Byte = -6'd1;
        Word = -6'd1;
        Long = -6'd1;
       Dlong = -6'd1;
    //
    #20
         Int = 36'd1;
        Byte = 36'd1;
        Word = 36'd1;
        Long = 36'd1;
       Dlong = 36'd1;
    //
    #20
         Int = -36'd1;
        Byte = -36'd1;
        Word = -36'd1;
        Long = -36'd1;
       Dlong = -36'd1;
    //
    Int = 1;
    #20
        Byte = Int;
        Word = Int;
        Long = Int;
       Dlong = Int;
    //
    Int = -1;
    #20
        Byte = Int;
        Word = Int;
        Long = Int;
       Dlong = Int;
    //
    Word = 32'h7eee_777f;
    #20
        Byte = Word;
         Int = Word;
        Long = Word;
       Dlong = Word;
    //
    Word = 32'hf777_eee7;
    #20
        Byte = Word;
         Int = Word;
        Long = Word;
       Dlong = Word;
    //
    #20 $finish;
    end
  //
endmodule // Truncate.
