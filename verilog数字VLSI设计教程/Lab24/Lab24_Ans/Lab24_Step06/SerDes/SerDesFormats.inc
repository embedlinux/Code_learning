// =======================================================
// SerDesFormats.inc   This file contains SerDes frame
// formats shared between the Ser and Des ends of the
// SerDes.  It is included in any design file requiring
// these formats.
//
// The class project sends a byte of data in a 16-bit stream;
// each frame totals 64 bits to transfer 32 bits of data.
// The data are represented by the 'x' bits below.
//
/* The numbers help identify bits in the shift register vector:
*  60         50         40          30         20         10          0
*32109876 54321098 76543210 98765432 10987654 32109876 54321098 76543210
*xxxxxxxx_00011000_xxxxxxxx_00010000_xxxxxxxx_00001000_xxxxxxxx_00000000;
*           PAD3              PAD2              PAD1              PAD0
*          8'h18             8'h10             8'h08             8'h00
*/
// -------------------------------------------------------
// 2006-06-01 jmw:  v. 1.2 Sized params to 1 & 8 bits.
// 2005-05-24 jmw:  v. 1.1 Added hex 'h' to PAD? numbers.
// 2005-02-26 jmw:  v. 1.0 Created by removing the content
//            from the Lab23 DesDecoder and SerEncoder
//            modules, which now `include this file.
// =======================================================
// ---------------------------------------------------
// Some useful constants.  Upper case is to remind
// reader these are not variable names, but constant
// (parameter) names:
//
localparam[0:0] YES  = 1'b1; // For general readability.
localparam[0:0]  NO  = 1'b0;
localparam[7:0] PAD3 = 8'b000_11_000;
localparam[7:0] PAD2 = 8'b000_10_000;
localparam[7:0] PAD1 = 8'b000_01_000;
localparam[7:0] PAD0 = 8'b000_00_000;
