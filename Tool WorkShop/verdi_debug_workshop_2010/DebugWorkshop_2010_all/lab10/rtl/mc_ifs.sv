`timescale 1 ns / 1ns

typedef logic [7:0] ubyte;

interface pram_interface;
   logic       VMA;
   logic       R_W;
   ubyte       addr;
   wire  [7:0] data;
   
   modport master(output VMA, R_W, addr, inout data);
   modport slave (input  VMA, R_W, addr, input data);
endinterface