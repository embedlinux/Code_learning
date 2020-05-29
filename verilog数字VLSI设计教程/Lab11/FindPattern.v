// ===========================================================
// FindPattern:  Uses verilog code developed in the Workbook
// to search for and identify the frame pattern to be used
// in the SerDes design.
//
// For simplicity, a fixed 64-bit vector is searched for the
// pattern, rather than a real-time serial stream.
// The vector is initialized and then kept constant.
//
// The basic idea is just to shift a matching pattern across
// the input data until a match is obtained for the pad pattern.
// 
// The actual serial stream is assumed to arrive MSB first, so
// the search starts at the MSB and continues downward.
//
// ------------------------------------------------------------
// 2006-10-27 jmw: v. 3.0 Rewritten for better style.
//            Time resolution changed from 100 ps to 1 ns.
//      Added fork-joins to tb to align checks at regular times.
//      Added Reset to FindPattern module.   Fixed for loop
//      signed compare.  Changed for loop variable to j to 
//      initialize it to a constant (synthesis).
// 2005-01-29 jmw: v. 2.0 Rewritten for synthesis.
// 2004-12-29 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/1ns
//
module FindPattern #(parameter AdrHi = 5) // 2^6 = 64 bits.
                   ( output Found, input[(1<<AdrHi+1)-1:0] SerVect
                   , input StartSearch, Reset
                   );
// ----------------------------------
// Declarations:
//
localparam AdrWid = AdrHi + 1;
localparam VecHi  = (1<<AdrWid) - 1;
localparam PadHi  = 7;
localparam PadWid = PadHi + 1;
//
// // The pad patterns:
localparam[PadHi:0] pad_00 = 8'b000_00_000;
localparam[PadHi:0] pad_01 = 8'b000_01_000;
localparam[PadHi:0] pad_10 = 8'b000_10_000;
localparam[PadHi:0] pad_11 = 8'b000_11_000;
//
//
reg[AdrHi:0] OffSet; // Offset of current comparison.
reg FoundPads;       // Flags successful find of frame padding.
//
// With a view to portability, one function checks a pad pattern:
// The index value passed is the upper bit at which the check
// should begin.  The offset in the pad always is the same.
// Another function calls the first successively at each of the
// four pad offset MSB's.
//
function 
checkPad
   ( input[(1<<AdrHi+1)-1:0] Stream, input[PadHi:0] pad, input[AdrHi:0] iX );
  reg OK;      // Flags pattern match.
  integer i    // i is the data stream offset.
        , j;   // j is the pad-byte pattern offset.
  begin
  i   = iX;   // Init to stream MSB to be searched.
  OK  = 0;    // Init to failed state.
  begin : For // Capitalized, this is not a verilog keyword.
  for (j=PadHi; j>=0; j = j-1)
    begin
    if (Stream[i]==pad[j])
         OK = 1;
    else begin
         OK = 0;
         disable For; // Break the for loop.
         end
    i = i - 1;
    end // for loop.
  end // For.
  checkPad = OK;
  end
endfunction
//
// This function just calls the other:
function checkPads(input[(1<<AdrHi+1)-1:0] Stream, input[AdrHi:0] OffSet);
  begin
   if (   checkPad(Stream, pad_11, OffSet-(1*PadWid))
       && checkPad(Stream, pad_10, OffSet-(3*PadWid)) 
       && checkPad(Stream, pad_01, OffSet-(5*PadWid))
       && checkPad(Stream, pad_00, OffSet-(7*PadWid))
      )
       checkPads = 1;
  else checkPads = 0;
  end
endfunction
//
// ----------------------------------
// Runtime:
//
assign #1 Found = FoundPads;
//
always@(posedge StartSearch, posedge Reset) // Clocked, so, sequential logic.
  if (Reset==1'b1)
       begin : Initialize
       OffSet    <= (1<<AdrHi+1)-1;
       FoundPads <= 1'b0;
       end
  else begin : Search
       if ( checkPads(SerVect, OffSet) )
            begin
            FoundPads <= 1'b1;
            end
       else FoundPads <= 1'b0;
       OffSet         <= OffSet - 1;  // Remove alignment after one try.
       end // Search.
//
endmodule // FindPattern.
//
`ifdef DC
`else
module FindPatternTst;
//
localparam AdrHi = 5;
//
reg StartSearchStim, ResetStim;
// Change the pad patterns in this to test frame rejection:
reg[(1<<AdrHi+1)-1:0] SerVect =
/*    The numbers in this comment help identify bits in this vector:
 *     'a'     pad 3     'b'      pad 2    'y'      pad 1    'z'      pad 0
 *    60         50         40          30         20         10          0
 *  32109876 54321098 76543210 98765432 10987654 32109876 54321098 76543210 */
64'b01100001_00011000_01100010_00010000_01111001_00001000_01111010_00000000;
//
initial
  begin
      StartSearchStim = 1'b0;
      ResetStim       = 1'b0;
  #5  ResetStim       = 1'b1;
  #4  ResetStim       = 1'b0;
  #1  StartSearchStim = 1'b1;
  fork
  #2  StartSearchStim = 1'b0;
  #10 StartSearchStim = 1'b1;
  join
  fork
  #2  StartSearchStim = 1'b0;
  #10 StartSearchStim = 1'b1;
  join
  #2  StartSearchStim = 1'b0;
  #5  $finish;
  end
//
FindPattern #(.AdrHi(AdrHi))
FindU1( .Found(FoundWatch), .SerVect(SerVect)
      , .StartSearch(StartSearchStim), .Reset(ResetStim) );
//
endmodule //FindPatternTst.
`endif

