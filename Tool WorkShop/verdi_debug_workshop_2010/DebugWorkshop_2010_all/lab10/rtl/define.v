`timescale 1 ns / 1ns
typedef logic [7:0] ubyte;

interface pram_interface;
   logic       VMA;
   logic       R_W;
   ubyte       addr;
   wire  [7:0] data;
   
   modport master(output VMA, R_W, addr, inout data);
   modport slave (input  VMA, R_W, addr, inout data);
endinterface

typedef enum bit[2:0] {ADD, SUB, SUB1, AND_OP, OR_OP, XOR_OP, XOR1_OP} ALU_OP;

typedef struct {
   logic       VMA;
   logic       R_W;
   ubyte     addr;
   ubyte     data;
} PRAM_ACCESS;

typedef struct packed {
	logic 	C21;
	logic 	C20;
	logic 	C19;
	logic 	carry_mode;
	logic  	[2:0] bus_mode;
	ALU_OP 	alu_mode;
	logic 	[4:0] CH;
	logic 	C6;
	logic 	C5;
	logic 	[2:0] mux_sel;
	logic 	C1;
	logic 	C0;
} MPROM_ENCODE;

