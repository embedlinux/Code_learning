// ===========================================================
// FindPatternTask:  Uses verilog code develeoped in the Workbook
// to seaarch for and identify the frame pattern to be used
// in the SerDes design.
//
// In this behavioral model, we want different values set on
// different executions of the for statements.  This requires
// the use of BLOCKING assignments, to ensure the assignment is 
// evaluated and completed before the next value of i or j.
//
// ------------------------------------------------------------
// 2007-02-07 jmw: v. 1.4 Renamed ForI to WhileLoop.
// 2005-02-28 jmw: v. 1.3 Changed for to while for synthesis.
// 2005-02-24 jmw: v. 1.2 Explanation shortened; `DC switch on
//            testbench.
// 2005-01-01 jmw: v. 1.1 uses a task for repeated code; renamed
//            to FindPatternTask.
// 2004-12-29 jmw: v. 1.0 of FindPattern implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module FindPatternTask ( output Found, input[5:0] StartI
                       , input StartSearch
                       );
  //
  // If there's time, try changing this:
  reg[63:0] SerVect =
    // The numbers in this comment help identify bits in this vector:
    //    60         50         40          30         20         10          0
    //  32109876 54321098 76543210 98765432 10987654 32109876 54321098 76543210
    64'b01100001_00011000_01100010_00010000_01111001_00001000_01111010_00000000;
  //
  // When in doubt, use parameters:
  parameter IJump = 16;  // Distance to jump for next pad byte.
  //
  reg[7:0] Nkeeper;
  reg[5:0] i; // Indexes into a saved 64-bit SerVect vector.
  reg[2:0] j; // Counts which of 4 assumed nn's we are on.
  reg[2:0] k; // Generic index.
  reg[1:0] nNow, nPrev  // To compare nn values.
         , CountOK;     // Counts number of down-counts OK.
  reg FoundPadPattern;  // Flags successful find of 64-bit frame padding.
  //
  // The new task.  Declared after all variables referenced
  // in it:
  task reStartCount;
    begin
    // If not a down-count, start all over:
    #1 i = i + IJump*j - 1; // See * below:
    #1 j = 0;
    #1 Nkeeper = 'b0;
    end
  endtask
  //
  assign #1 Found = FoundPadPattern;
  //
  always@(posedge StartSearch) // Clocked, maybe sequential logic?
  begin : AlwaysSearch
  #1 Nkeeper = 'b0;          // Init count keeper every search start.
  #1 FoundPadPattern = 1'b0; // Move this init here.
  #1 i = StartI;
  for ( j=0; j<=3; j=j ) // No increment.  '<=' is relational operator!
    begin : WhileLoop
    while(1)
      begin
      if (   SerVect[i]==1'b0   && SerVect[i-1]==1'b0 && SerVect[i-2]==1'b0
          && SerVect[i-5]==1'b0 && SerVect[i-6]==1'b0 && SerVect[i-7]==1'b0
         )
           begin
           #1 Nkeeper[2*j+1] = SerVect[i-3]; // MSB.
           #1 Nkeeper[2*j]   = SerVect[i-4]; // LSB.
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
                       // Issue a pulse, then stop everything:
                       #1 FoundPadPattern = 1'b1;
                       #2 FoundPadPattern = 1'b0; // 2 ns pulse.
                       #1 disable AlwaysSearch;
                       end
                  else // If not a down-count, call restart task:
                       reStartCount;
                end // if j==3
           else begin // j not 3:
                #1 j = j + 1;
                #1 i = i - IJump; // Jump ahead, for another padded nn.
                #1 disable WhileLoop;
                end // else not j==3.
           end // if 6 0 matches.
      else begin // No nn possible at this i:
           if (j==0)
                begin
                // First nn not found yet:
                #1 i = i - 1;
                end
           else // This was not first apparent nn found: Call task:
                reStartCount;
           end
      end // for i block.
    end // WhileLoop labelled block.
    //
  end // always StartSearch.
  //
endmodule // FindPatternTask.
//
`ifdef DC
`else
module FindPatternTaskTst;
  //
  reg[5:0] StartIStim;
  reg StartSearchStim;
  wire FoundWatch;
  //
  initial
    begin
    #0 StartIStim = 6'b111111; // Change this to change initial i.
    #0 StartSearchStim = 1'b0;
    #1  StartSearchStim = 1'b1;
    #1  StartSearchStim = 1'b0;
    #0 StartIStim = 'b0;
    #58 $finish;
    end
  //
  FindPatternTask FindPatternTask1
                  ( .Found(FoundWatch), .StartI(StartIStim) 
                  , .StartSearch(StartSearchStim) 
                  );
  //
endmodule //FindPatternTaskTst.
`endif
