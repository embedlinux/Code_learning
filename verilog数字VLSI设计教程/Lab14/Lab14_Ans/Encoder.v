// ===================================================
// Encoder.   Shows use of a case statement to encode 
// an 8-bit 0ne-hot register.
//
// 2005-01-10 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module Encoder
       ( output[2:0] Number, output[7:0] ASCII
       , input[7:0] OneHot, input Clk
       );
//
reg[2:0] NumberReg;
reg[7:0] ASCIIReg;
//
assign #1 Number = NumberReg;
assign #1 ASCII = ASCIIReg;
//
always@(posedge Clk)
  begin : EncodeCase
  case (OneHot)
  8'b0000_0001: begin
                NumberReg <= 3'h0;
                ASCIIReg  <= 8'h30;
                end
  8'b0000_0010: begin
                NumberReg <= 3'h1;
                ASCIIReg  <= 8'h31;
                end
  8'b0000_0100: begin
                NumberReg <= 3'h2;
                ASCIIReg  <= 8'h32;
                end
  8'b0000_1000: begin
                NumberReg <= 3'h3;
                ASCIIReg  <= 8'h33;
                end
  8'b0001_0000: begin
                NumberReg <= 3'h4;
                ASCIIReg  <= 8'h34;
                end
  8'b0010_0000: begin
                NumberReg <= 3'h5;
                ASCIIReg  <= 8'h35;
                end
  8'b0100_0000: begin
                NumberReg <= 3'h6;
                ASCIIReg  <= 8'h36;
                end
  8'b1000_0000: begin
                NumberReg <= 3'h7;
                ASCIIReg  <= 8'h37;
                end
  default     : begin  // NEVER omit the default!
                NumberReg <= 'b0;
                ASCIIReg  <= 'b0;
                end
  endcase
  end
//
endmodule // Encoder.
//
module EncoderTst;
//
wire[7:0] ASCIIWatch;
wire[2:0] NumberWatch;
reg[7:0]  OneHotStim;
integer i;
//
reg ClkStim;
always@(ClkStim) #5 ClkStim <= ~ClkStim;
//
initial
  begin
  #1   ClkStim = 1'b0;
  repeat(2)
    begin
    #10 OneHotStim = 8'h01;
    for (i=0; i<8; i = i+1)
      #10 OneHotStim = OneHotStim <<1;
    end
  #20  $finish;
  end
//
Encoder U1 ( .Number(NumberWatch), .ASCII(ASCIIWatch)
           , .OneHot(OneHotStim), .Clk(ClkStim)
           );

//
endmodule // EncoderTst.
