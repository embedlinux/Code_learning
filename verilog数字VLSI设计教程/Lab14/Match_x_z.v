// =====================================================
// Match_x_z Shows equality match for expressions with
// 'x' or 'z'.
//
// -----------------------------------------------------
// 2005-02-24 jmw: v. 1.0 implemented.
// =====================================================
`timescale 1ns/10ps
//
module Match_x_z;
reg[3:0] X, Y;
reg[1:0] Z;
reg t;
//
initial
  begin
  #0 X = 4'b101x;
     Y = 4'b101z;
     t = 1'b0;
  //
  #1 t = 1'b1;
  #0.1 t = 1'b0;
  //
     if (X==4'b101x)
          Z = 2'b11;
     else Z = 2'b00;
  //
  #1 t = 1'b1;
  #0.1 t = 1'b0;
     if (X==Y)
          Z = 2'b11;
     else Z = 2'b00; 
  //
  #1 t = 1'b1;
  #0.1 t = 1'b0;
     if (X==X)
          Z = 2'b11;
     else Z = 2'b00; 
  //
  #1 t = 1'b1;
  #0.1 t = 1'b0;
  case (X)
    4'b1010: Z = 2'b00;
    4'b1011: Z = 2'b01;
    4'b101z: Z = 2'b10;
    4'bxxxx,
    4'bzzzz: Z = 2'b11;
    default: Z = 2'bzz;
  endcase
  //
  #1 t = 1'b1;
  #0.1 t = 1'b0;
  case (X)
    4'b1010: Z = 2'b00;
    4'b101x: Z = 2'b01;
    4'b101z: Z = 2'b10;
    4'bxxxx,
    4'bzzzz: Z = 2'b11;
    default: Z = 2'bzz;
  endcase
  //
  #1 t = 1'b1;
  #0.1 t = 1'b0;
  Z = (X==Y )? 2'b11: 2'b00;
  #5 $finish;
end // initial.
//
endmodule // Match_x_z.
