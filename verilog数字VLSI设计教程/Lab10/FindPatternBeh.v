// ===========================================================
// FindPattern:  Uses verilog code developed in the Workbook
// to search for and identify the frame pattern to be used
// in the SerDes design.
//
// In this behavioral model, we want different values set on
// different executions of the for statements, and we also want
// scheduled delays, to separate the simulator edges in the
// waveform display.  This requires the use of BLOCKING
// assignments, to ensure that each assignment is evaluated
// and completed before the next value of i or j.
//
// For simplicity, a fixed 64-bit vector is searched for the
// pattern, rather than a real-time serial stream.
// The vector is initialized and then kept constant.
//
// ------------------------------------------------------------
// 2005-10-16 jmw: v. 1.5 Minor comment change.
// 2005-10-13 jmw: v. 1.4 Sized localparams to suppress warnings.
// 2005-10-12 jmw: v. 1.3 Simplified always to start at bit 63.
//            Replaced one if with a case.
// 2005-02-28 jmw: v. 1.2 Changed for to while for synthesis.
// 2005-02-24 jmw: v. 1.1 Explanation clarified; `DC switch on
//            testbench.
// 2004-12-29 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module FindPattern ( output Found, input StartSearch );
  //
  // If there's time, try changing this:
  reg[63:0] SerVect =
/*    The numbers in this comment help identify bits in this vector:
 *     'a'     pad 3     'b'      pad 2    'y'      pad 1    'z'      pad 0
 *    60         50         40          30         20         10          0
 *  32109876 54321098 76543210 98765432 10987654 32109876 54321098 76543210 */
64'b01100001_00011000_01100010_00010000_01111001_00001000_01111010_00000000;
  // When in doubt, use parameters:
  localparam[5:0]  IJump = 6'd16  // Distance to jump for next pad byte.
                , StartI = 6'd63; // Initial bit for search.
  //
  reg[7:0] Nkeeper;
  reg[5:0] i; // Indexes into a saved 64-bit SerVect vector.
  reg[2:0] j; // Counts which of 4 assumed nn's we are on.
  reg[2:0] k; // Generic index.
  reg[1:0] nNow, nPrev  // To compare nn values.
         , CountOK;     // Counts number of down-counts OK.
  reg FoundPads;  // Flags successful find of 64-bit frame padding.
  //
  assign #1 Found = FoundPads;
  //
  // Initialize on the negedge; search on posedge:
  //
  always@(negedge StartSearch)
    begin : Init
    Nkeeper   = 'b0;  // Init count keeper every search start.
    FoundPads = 1'b0; // Move this init here.
    i         = StartI;
    end
  //
  always@(posedge StartSearch) // Clocked, maybe sequential logic?
  begin : Search
  for ( j=0; j<=3; j=j ) // No increment.  '<=' is relational operator!
    begin : WhileLoop
    while(1==1)  // This while thus loops forever.
      begin
      if (   SerVect[i]==1'b0   && SerVect[i-1]==1'b0 && SerVect[i-2]==1'b0
          && SerVect[i-5]==1'b0 && SerVect[i-6]==1'b0 && SerVect[i-7]==1'b0
         )
           begin
           #1 Nkeeper[2*j+1] = SerVect[i-3]; // MSB of assumed pad id.
           #1 Nkeeper[2*j]   = SerVect[i-4]; // LSB of assumed pad id.
           //
           // Check whether done:
           if (j==3)
                begin
                //
                // We have 4 apparent nn values; do they count down?
                //
                #1 CountOK = 2'b00;
                for (k=1; k<=3; k=k+1)
                  begin
                  // Use concatenation to get 2-bit nn values:
                  #1 nPrev = { Nkeeper[2*k-1], Nkeeper[2*k-2] }; 
                  #1 nNow  = { Nkeeper[2*k+1], Nkeeper[2*k] }; 
                  if ((nNow+1)==nPrev) #1 CountOK = CountOK + 1;
                  end //for k.
                if (CountOK==3) // Total of 4 were OK.
                       begin
                       // Announce success, then stop everything:
                       #1 FoundPads = 1'b1;
                       #1 disable Search;
                       end
                  else begin
                       // If not a down-count, start all over:
                       #1 i = i + IJump*j - 1;
                       #1 j = 0;
                       #1 Nkeeper = 'b0;
                       end // if CountOK.
                end // if j==3
           else begin // j not 3:
                #1 j = j + 1;
                #1 i = i - IJump; // Jump ahead, for another padded nn.
                #1 disable WhileLoop;
                end // else not j==3.
           end // if 6 0 matches.
      else begin // No nn possible at this i:
           case (j)
              3'b000: #1 i = i - 1; // First nn not found yet.
             default: // Drop back after jump by mistake:
                      begin
                      #1 i = i + IJump*j - 1;
                      #1 j = 0;           // Reset nn counter.
                      #1 Nkeeper = 'b0;   // Reinit count keeper.
                      end
           endcase
           end
      end // Block contained in while loop.
    end // WhileLoop labelled block.
    //
  end // always StartSearch.
  //
endmodule // FindPattern.
//
`ifdef DC
`else
module FindPatternTst;
  //
  reg StartSearchStim;
  wire FoundWatch;
  //
  initial
    begin
    #0   StartSearchStim = 1'b0;
    #5   StartSearchStim = 1'b1;
    #100 StartSearchStim = 1'b0;
    #5   StartSearchStim = 1'b1;
    #300 $finish;
    end
  //
  FindPattern FindPatternInst1( .Found(FoundWatch), .StartSearch(StartSearchStim) );
  //
endmodule //FindPatternTst.
`endif
