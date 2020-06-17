/*----------------------- PREP OPTIMIZED DESIGN REPORT -------------------
-- FILE NAME             : alu.v
-- DESIGN NAME           : ALU for R4000
-- DESIGN DESCRIPTION    : MIPS R4000 Processor
-- LANGUAGE              : Verilog
-- SYNTHESIS PRODUCT/REV : Synplify Lite 2.1c
-- SYNTHESIS VENDOR      : Synplicity, Inc.
-- SIMULATION PRODUCT/REV: SILOS III V95.1
-- SIMULATION VENDOR     : SIMUCAD, Inc
-- APR PRODUCT/REV       : SpDE 5.04
-- AUTHOR NAME           : Joel Naumann, Amarpreet Chawla, Micheal Povlin
-- AUTHOR COMPANY        : IDT, Stratacom, QuickLogic
-- AUTHOR EMAIL          : jcn@strata.com, povlin@idtinc.com, amar@qlogic.com
-- COMMENTS              :
-- DATE                  : 7/21/94
------------------------------------------------------------------------*/
/*********************************************************************
*
*               Module Name:    alu.v
*               Purpose:        ALU description for R4000
*               Copyright:      Michael Povlin, Amarpreet S. Chawla
*                               Joel Naumann
*
* Please feel free to distribute as long as the header is attached.
*
*********************************************************************/
/********************************************************************
$Revision: 1.3 $
$Log: alu.v $
Revision 1.3  1995/07/21  18:09:27  chawla
added prep header

Revision 1.2  1995/06/26  16:12:40  chawla
added scalability to implement 32 bit or 64 bit version

Revision 1.1  1995/06/16  16:57:19  chawla
Initial revision


*********************************************************************/

module mAlu (
/* Input */
      PC,
      ReadData1,
      ReadData2,
      Instruction,
      ALUSelA,
      ALUSelB,
      ALUOp,

/* Output */
      Zero,
      ALU_result);

//parameter pBuswidth  = 32;// dummy width


input[31:0]   PC;
input[31:0]   ReadData1;
input[31:0]   ReadData2;
input[15:0]            Instruction;
input                  ALUSelA;
input[1:0]             ALUSelB;
input[1:0]             ALUOp;

output                 Zero;
output[31:0]  ALU_result;

reg[31:0]     MuxA;
reg[31:0]     MuxB;
reg                    Zero;
reg[31:0]     ALU_result;

parameter pZero      = 32'b0;
parameter pPositive  = 16'h0000;
parameter pNegative  = 16'hffff;

/* Multilexer A */

always @(ALUSelA or ReadData1 or PC)
   begin
   if(ALUSelA) begin
      MuxA=ReadData1;
      end
   else begin
      MuxA=PC;
      end
   end

/* Multiplexer B and sign extender */

always @(ALUSelB or ReadData2 or Instruction)
   begin
   case(ALUSelB[1:0])
      2'b00 : MuxB = ReadData2;
      2'b01 : MuxB = 1;                   // Increment address
      2'b10,
      2'b11 : if(Instruction[15]) begin   // Sign extension
                MuxB = {pNegative,Instruction};
                end
              else begin
                MuxB = {pPositive,Instruction};
                end
    endcase
    end


/* ALU */

always @(ALUOp or Instruction or MuxA or MuxB)
   begin
      casex({ALUOp[1:0],Instruction[5:0]})
        8'b00xxxxxx : ALU_result = MuxA + MuxB; // Addition
        8'b01xxxxxx : ALU_result = MuxA - MuxB; // Subtraction
        /*R-Type operations */
        8'b10100100 : ALU_result = MuxA & MuxB; // AND
        8'b10100101 : ALU_result = MuxA | MuxB; // OR
        8'b10100110 : ALU_result = MuxA ^ MuxB; // XOR
        8'b10100000 : ALU_result = MuxA + MuxB; // Addition
        8'b10100010 : ALU_result = MuxA - MuxB; // Subtraction
        8'b10000010 : ALU_result = MuxB >> 1;   // Shift right
        8'b10000000 : ALU_result = MuxB << 1;   // Shift left

        default: ALU_result = 'bx;
      endcase

      if (ALU_result == pZero) begin
         Zero=1;
         end
      else begin
         Zero=0;
         end
   end

endmodule

