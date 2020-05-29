// ===================================================
// GenericSyncDes.   A generic deserializer,
// with synchronization to a pattern of
// 12 '0' vs 12 '1'.
//
// ---------------------------------------------------
// 2007-10-26 jmw: v. 1.5 Minor comment change.
// 2005-11-01 jmw: v. 1.4 Minor comment change.
// 2005-04-28 jmw: v. 1.3 Shifted delays to cts assigns.
//            Fixed Shift1 task else.
// 2005-02-24 jmw: v. 1.2 Added `DC switch.
// 2005-01-31 jmw: v. 1.1 No nonblocks for synthesis.
// 2005-01-16 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module GenericSyncDes
      #( parameter ParHi = 31 )
       ( output[ParHi:0] ParBus, output ParValid
       , input SerIn, SerValid, ParClk, ParRst
       );
reg[ParHi:0] ParSR      // Input shift register.
           , ParBusReg; // Drives the parallel bus.
reg ParValidReg;
//
reg[5:0] N; // Holds the shift count between SerValid episodes.
//
// Synchronization patterns:
localparam StopPattern  = 12'b0000_0000_0000;
localparam StartPattern = 12'b1111_1111_1111;
localparam SHIFT = 1'b0; // For task readability.
localparam RESET = 1'b1; // For task readability.
//
task Unload32; // Copies the parallel SR to the bus.
  begin
  ParValidReg = 1'b0;  // Lower Flag.
  ParBusReg   = ParSR; // Transfer the data.
  #3 ParSR    =  'b0;  // Clear the SR.
  ParValidReg = 1'b1;  // Set the flag.
  end
endtask
// --------------------------------------------------
// We require more than one result, so a function
// won't work, and a task replaces it:
// If stopped, the shift register continues to check
// the first 12 bits until Start is found.
//
task Shift1(output[ParHi:0] NewSR
           , input[ParHi:0] OldSR, input NewBit, Reset);
  reg[ParHi:0] temp, tempSaved;
  reg Stopped;    // Retains stopped state between shifts.
  begin
  // Have to init states:
  if (Reset==1'b1)
		 begin
		 Stopped = 1'b0;
		 N       = 'b0;
		 temp    = 'b0;
		 tempSaved = 'b0;
		 end
  else begin
		 temp    = OldSR;
		 temp    = temp<<1;
		 temp[0] = NewBit;
		 N = N + 6'd1; // N==32 triggers parallel unload.
		 //
		 // Except for assigning the new shift-register value,
		 // we are done.  But, we have to handle several special
		 // cases involving synchronization patterns.
		 //
		 case (temp[11:0])
		  StopPattern:
					if (Stopped==1'b0) // if new stop pattern.
						  begin
						  // Back off the previous 11 shifts,
						  // save old good data, and then stop:
						  temp = temp>>12;
						  N = N - 6'd12;
						  tempSaved = temp; // Save good data.
						  Stopped = 1'b1;
						  end
					else // Just don't let N get to 32;
						  // SR contents don't matter:
						  N = N - 6'd1;
		 StartPattern: // Restart on next bit, if stopped:
					if (Stopped==1'b1)
						  begin
						  temp    = tempSaved;
						  Stopped = 1'b0;
						  end
				default:  // Don't let N get to 32, if stopped:
					if (Stopped==1'b1) N = N - 6'd1;
		 endcase
		 NewSR = temp;
		 end // else
  end
endtask
//
// ----------------------
// Runtime:  Assumes serial stream synchronized
// with the parallel clock:
assign #1 ParBus = ParBusReg;
assign #1 ParValid = ParValidReg;
//
always@(posedge ParClk, posedge ParRst)
  begin : Parizer
  if (ParRst==1'b1)
       begin
       ParSR       =  'b0; // The shift register.
       ParBusReg   =  'bz; // The parallel out bus.
       ParValidReg = 1'b0; // ParValid.
       Shift1(ParSR, ParSR, SerIn, RESET);  // Resets N to 0.
       end
  else if (SerValid) // Ignore the serial line if not.
         begin
         Shift1(ParSR, ParSR, SerIn, SHIFT); // shift & set N.
         #1
         if (N>ParHi) // 32 bits shifted.
           begin
           Unload32;
           ParSR = 'b0;
           Shift1(ParSR, ParSR, SerIn, RESET);  // Resets N to 0.
           end
         end // SerValid.
  end // Parizer named block.
//
endmodule // GenericSyncDes.
//
// --------------------
`ifdef DC
`else
module GenericSyncDesTst;
//
localparam ParHi = 31;
wire[ParHi:0] ParBusWatch;
wire ParValidWatch;
reg ClkStim, SerInStim, SerValidStim, ParRstStim;
//
reg[31:0] temp;
reg[4:0] ClkCnt;
//
always@(ClkStim) #5 ClkStim <= ~ClkStim;
//
always@(ClkStim)
  begin
       if ($time>1100 && $time<1250) #1 SerInStim = 1'b0;
  else if ($time>2000 && $time<2150) #1 SerInStim = 1'b1;
  else begin
       temp = $random;
       #1 SerInStim = temp[0];
       end
  //
  if (ParRstStim==1'b1)
       ClkCnt = 'b0;
  else if (SerValidStim==1'b1) ClkCnt = ClkCnt+ClkStim;
  end
//
initial
  begin
  #0  SerValidStim =  'b1;
  #0  SerInStim    =  'bz;
  #0  ClkStim      = 1'b0;
  #0  ParRstStim   = 1'b0;
  #1  ParRstStim   = 1'b1;
  #9  ParRstStim   = 1'b0;
  //
  #100 SerValidStim = 1'b0;
  #51  SerValidStim = 1'b1;
  #3000  $finish;
  end
//
GenericSyncDes #( .ParHi(ParHi) )
       U1
       ( .ParBus(ParBusWatch), .ParValid(ParValidWatch)
       , .SerIn(SerInStim), .SerValid(SerValidStim)
       , .ParClk(ClkStim), .ParRst(ParRstStim)
       );
//
endmodule // GenericSyncDesTst.
`endif
