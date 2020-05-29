// ===========================================================
// BIST:  The built-in self-tester for Mem.
//
// In test mode, the two different tests described in the
// Workbook are carried out in sequence.  If any one fails,
// or if a parity error is received from Mem, the TestOK
// flag is set low and testing is terminated.
//
// The tests are as follows:
// 1. Addressing & decoding test:  Store a different value at
//    every address and then read out the stored values.
// 2. Independent stuck-bit test:  Store a '1' at every
//    addressable bit, then read out.  After that, store
//    a '0' likewise.
//
// Parity error detection is done by the memory itself; any
// parity error (not emulated during these tests) is 
// hendled here during testing.
//
// The testing sequence therefore will be in these phases:
//   1. Generate & store values at all addresses.
//   2. Read out and compare values stored.
//   3. Store '1' in every addressable bit.
//   4. Read out and check stored '1' values.
//   5. Store a '0' in every addressable bit.
//   6. Read out and check '0' values.
//
// We shall design an 8-state state machine to sequence the
// tests:  State 0 = initialize, states 1 - 6 as above, and
// state 7 = report pass or fail result.
//
// The test sequencer will be a simple always block counter
// in which counting is disabled during any particular test
// or when the BIST is not active.
// Each different count value enables another always block which
// is dedicated to one of the test sequence phases.

// ------------------------------------------------------------
// 2007-11-12 jmw: v. 1.3 set TestNo don't touch & specified
//      its width in all literal assignments.
// 2006-06-19 jmw: v. 1.2 Minor TestNo dec & comment change.
// 2006-06-18 jmw: v. 1.1 Added mux of Addrr and DataOr for
//      synthesis.
// 2006-06-17 jmw: v. 1.0 Initial synthesizable implementation
//      done as a complete redesign of previous answer.
// ============================================================
//
module BIST 
  #(parameter AWid=5, DWid=32)
   ( output[DWid-1:0] DataO // Test data to Mem.
   , output[AWid-1:0] Addr  // Address to be tested.
   , output ReadCmd         // Read at Addr for DataI.
   ,        WriteCmd        // Write DataO to Addr.
   ,        Testing         // '1' during bist.
   ,        TestOK          // Set '1' upon test pass; normally '0'.
   , input[DWid-1:0] DataI  // Test data result from Mem.
   , input DoSelfTest       // posedge to start bist.
   ,       ParityErr        // Mem parity err report.
   ,       Clk              // The Mem read clock.
   ,       Reset            // The system reset.
   ); 
localparam MemHi = (1<<AWid) - 1; // To iterate over addresses.
//
reg[AWid-1:0] Addrr;  // For addressing the Mem.
reg[AWid-1:0] Addr1   // These are muxed onto Addrr:
            , Addr2, Addr3, Addr4, Addr5, Addr6;
reg[DWid-1:0] DataOr; // For DataO writes.
reg[DWid-1:0] DataO1  // These are muxed onto DataOr:
            , DataO2, DataO3, DataO4, DataO5, DataO6;
reg ReadCmdr  // Mem read cmd.
  , WriteCmdr // Mem write cmd.
  , Testingr  // Announce test mode.
  , TestOKr   // Represent current test result.
  , AllDoner; // Flag completion of bist.
//
assign DataO    = DataOr;
assign Addr     = Addrr;
assign ReadCmd  = ReadCmdr;
assign WriteCmd = WriteCmdr;
assign Testing  = Testingr;
assign TestOK   = TestOKr;
//
reg[2:0] State; // Sequencer state register.
//
// Test shared always-block controls:
reg[2:0] TestNo;     // Identifies test phase.
reg[6:1] TestDone    // High set bit is last always block done.
       , TestResult; // Set bit for each test phase pass.
//
//synopsys dc_tcl_script_begin
// set_dont_touch TestNo
//synopsys dc_tcl_script_end
//
// Individual always block 1 - 6 output flags:
reg TDone6, TDone5, TDone4, TDone3, TDone2, TDone1;
reg  TRes6,  TRes5,  TRes4,  TRes3,  TRes2,  TRes1;
//
// ---------------
// These next are to overcome the synthesis limitation which
// doesn't allow modify of same data in more than one always block:
always@(*)
  if (Reset==1'b1)
       begin
       TestDone   = 'b0;
       TestResult = 'b0;
       end
  else begin
       TestDone   = {TDone6,TDone5,TDone4,TDone3,TDone2,TDone1};
       TestResult = {TRes6,TRes5,TRes4,TRes3,TRes2,TRes1};
       end
//
always@(*)
  if (Reset==1'b1)
       Addrr = 'b0;
  else case (TestNo)
         3'h1 : Addrr = Addr1;
         3'h2 : Addrr = Addr2;
         3'h3 : Addrr = Addr3;
         3'h4 : Addrr = Addr4;
         3'h5 : Addrr = Addr5;
         3'h6 : Addrr = Addr6;
       default: Addrr = 'b0;
       endcase
//
// Must keep separate from Addrr event control:
always@(*)
  if (Reset==1'b1)
       DataOr = 'b0;
  else case (TestNo)
         3'h1 : DataOr = DataO1;
         3'h2 : DataOr = DataO2;
         3'h3 : DataOr = DataO3;
         3'h4 : DataOr = DataO4;
         3'h5 : DataOr = DataO5;
         3'h6 : DataOr = DataO6;
       default: DataOr = 'b0;
       endcase
//
// --------------------------------------
// The test sequencer:
// It initiates each test phase by setting the TestNo to a value
// allowing that test's always block to run to completion.
// It checks for test completion and test success on every clock;
// on a pass, it initiates the next test phase.   After the last
// test, it reports bist pass/fail and terminates testing.
// It also controls memory read and write for each test phase,
// as well as handling a memory parity error during testing.
// --------------------------------------
//
always@(posedge Clk, posedge Reset)
  begin : TestSequencer
  if (Reset==1'b1)
       begin
       ReadCmdr  <= 1'b0;
       WriteCmdr <= 1'b0;
       Testingr  <= 1'b0;
       TestOKr   <= 1'b0;
       AllDoner  <= 1'b0; // Normal level (noncommittal).
       TestNo    <=  'b0;
       State     <=  'b0;
       end
  else // Must be a clock:
       begin : TestClocked
       if (DoSelfTest==1'b0)
            begin // Init, but leave TestOK alone:
            Testingr <= 1'b0;
            AllDoner <= 1'b0;
            TestNo   <=  'b0;
            State    <=  'b0;
            end
       else if (AllDoner==1'b1 || ParityErr==1'b1)
              begin 
              Testingr <= 1'b0;
              if (ParityErr==1'b1)
                begin
                TestOKr  <= 1'b0;
                AllDoner <= 1'b1;
                end
              end // AllDone & ParityErr check.
            else
            begin : NoParityErr
            if (Testing==1'b0)
                 begin
                 ReadCmdr  <= 1'b0;
                 WriteCmdr <= 1'b0;
                 Testingr  <= 1'b1;
                 TestNo    <=  'b0;
                 State     <=  'b0;
                 end
            else begin : TestInProgress // Test is in progress:
                 case (State)
                 3'h0 : begin // Initialize:
                        ReadCmdr  <= 1'b0;
                        WriteCmdr <= 1'b0;
                        TestOKr   <= 1'b0;
                        AllDoner  <= 1'b0;
                        TestNo    <=  'b0;
                        State     <= 3'h1;
                        end
                 3'h1 : begin // Generate & store values at all addresses:
                        TestNo    <= 3'h1;
                        ReadCmdr  <= 1'b0;
                        WriteCmdr <= 1'b1;
                        if ( TestDone[1]==1'b1 )
                          begin
                          if ( TestResult[1]==1'b1 )
                               State <= 3'h2;  // Pass.  Go to next phase.
                          else begin
                               TestNo   <= 3'h0;
                               Testingr <= 1'b0;
                               TestOKr  <= 1'b0;
                               AllDoner <= 1'b1;
                               State    <= 3'h7; // Fail = go to report phase.
                               end
                          ReadCmdr  <= 1'b0;
                          WriteCmdr <= 1'b0;
                          end
                        end
                 3'h2 : begin // Read out and compare values stored:
                        TestNo    <= 3'h2;
                        ReadCmdr  <= 1'b1;
                        WriteCmdr <= 1'b0;
                        if ( TestDone[2]==1'b1 )
                          begin
                          if ( TestResult[2]==1'b1 )
                               State <= 3'h3;  // Pass.  Go to next phase.
                          else begin
                               TestNo   <= 3'h0;
                               Testingr <= 1'b0;
                               TestOKr  <= 1'b0;
                               AllDoner <= 1'b1;
                               State    <= 3'h7; // Fail = go to report phase.
                               end
                          ReadCmdr  <= 1'b0;
                          WriteCmdr <= 1'b0;
                          end
                        end
                 3'h3 : begin // Store '1' in every addressable bit:
                        TestNo    <= 3'h3;
                        ReadCmdr  <= 1'b0;
                        WriteCmdr <= 1'b1;
                        if ( TestDone[3]==1'b1 )
                          begin
                          if ( TestResult[3]==1'b1 )
                               State <= 3'h4;  // Pass.  Go to next phase.
                          else begin
                               TestNo   <= 3'h0;
                               Testingr <= 1'b0;
                               TestOKr  <= 1'b0;
                               AllDoner <= 1'b1;
                               State    <= 3'h7; // Fail = go to report phase.
                               end
                          ReadCmdr  <= 1'b0;
                          WriteCmdr <= 1'b0;
                          end
                         end
                 3'h4 : begin // Read out and check stored '1' values:
                        TestNo    <= 3'h4;
                        ReadCmdr  <= 1'b1;
                        WriteCmdr <= 1'b0;
                        if ( TestDone[4]==1'b1 )
                          begin
                          if ( TestResult[4]==1'b1 )
                               State <= 3'h5;  // Pass.  Go to next phase.
                          else begin
                               TestNo   <= 3'h0;
                               Testingr <= 1'b0;
                               TestOKr  <= 1'b0;
                               AllDoner <= 1'b1;
                               State    <= 3'h7; // Fail = go to report phase.
                               end
                          ReadCmdr  <= 1'b0;
                          WriteCmdr <= 1'b0;
                          end
                        end
                 3'h5 : begin // Store a '0' in every addressable bit:
                        TestNo <= 3'h5;
                        ReadCmdr  <= 1'b0;
                        WriteCmdr <= 1'b1;
                        if ( TestDone[5]==1'b1 )
                          begin
                          if ( TestResult[5]==1'b1 )
                               State <= 3'h6;  // Pass.  Go to next phase.
                          else begin
                               TestNo   <= 3'h0;
                               Testingr <= 1'b0;
                               TestOKr  <= 1'b0;
                               AllDoner <= 1'b1;
                               State    <= 3'h7; // Fail = go to report phase.
                               end
                          ReadCmdr  <= 1'b0;
                          WriteCmdr <= 1'b0;
                          end
                        end
                 3'h6 : begin // Read out and check '0' values:
                        TestNo    <= 3'h6;
                        ReadCmdr  <= 1'b1;
                        WriteCmdr <= 1'b0;
                        if ( TestDone[6]==1'b1 )
                          begin
                          if ( TestResult[6]==1'b1 )
                               State <= 3'h7;  // Pass.  Go to next phase.
                          else begin
                               TestNo   <= 3'h0;
                               Testingr <= 1'b0;
                               TestOKr  <= 1'b0;
                               AllDoner <= 1'b1;
                               State    <= 3'h7; // Fail = go to report phase.
                               end
                          ReadCmdr  <= 1'b0;
                          WriteCmdr <= 1'b0;
                          end
                        end
                 3'h7 : begin // Report test result:
                        ReadCmdr  <= 1'b0;
                        WriteCmdr <= 1'b0;
                        AllDoner  <= 1'b1;
                        Testingr  <= 1'b0;
                        if (TestResult==6'b111111)
                             begin
                             TestOKr   <= 1'b1;
                             end
                        else begin
                             TestOKr   <= 1'b0;
                             end
                        end
                 default: // Handle unknowns:
                        begin
                        ReadCmdr  <= 1'b0;
                        WriteCmdr <= 1'b0;
                        AllDoner  <= 1'b1;
                        Testingr  <= 1'b0;
                        TestOKr   <= 1'b0;
                        State     <=  'b0;
                        end
                 endcase
                 end // TestInProgress.
            end // SelfTest.
       end // TestClocked.
  end // TestSequencer.
//
// --------------------------------------
// The individual-test always blocks.
// They all are written in blocking assignments so each
// result will be set up for proper sampling by the nonblockings
// in the sequencing block.
// For synthesizability, each block uses its own address counter
// and, if necessary, wait-state toggler.
// --------------------------------------
//
// Phase 0: Initialize (done by sequencer).
//
// Phase 1: Generate & store values at all addresses:
// Updates TDone1 & TRes1.
//
reg[AWid-1:0] i1;
//
always@(posedge Clk, posedge Reset)
  begin : TestPhase01
  if (Reset==1'b1)
       begin
       TDone1 = 1'b0;
       TRes1  = 1'b0;
       i1     = 0;
       end
  else if (TestNo==1 && i1<=MemHi)
         begin
         Addr1 = i1;
         DataO1[31:24] = i1;
         DataO1[23:16] = i1;
         DataO1[15:8]  = i1;
         DataO1[7:0]   = i1;
         i1 = i1 + 1;
         if (i1>=MemHi)
           begin
           TDone1 = 1'b1;
           TRes1  = 1'b1;
           end
         end
  end
//
// Phase 2: Verify stored values from phase 1:
// Update TDone2 & TRes2.
//
reg[AWid-1:0] i2;
reg Wait2;
//
// Negedge sampling and a wait state allow the memory
// to provide the correct datum for comparison:
//
always@(negedge Clk, posedge Reset)
  begin : TestPhase02
  if (Reset==1'b1)
       begin
       TDone2 = 1'b0;
       TRes2  = 1'b0;
       i2     = 0;
       Wait2  = 1'b1;
       end
  else if (TestNo==2 && i2<=MemHi)
         begin
         Addr2 = i2;
         if (Wait2==1'b0)
              begin : DelayedSample
              if (   DataI[31:24]!=i2
                  || DataI[23:16]!=i2
                  || DataI[15:8] !=i2
                  || DataI[7:0]  !=i2
                 )
                   begin
                   TDone2 = 1'b1;
                   TRes2  = 1'b0;
                   end
              else begin
                   i2    = i2 + 1;
                   Wait2 = 1'b1;
                   if (i2>=MemHi)
                     begin
                     TDone2 = 1'b1;
                     TRes2  = 1'b1;
                     end
                   end
              end // DelayedSample.
         else Wait2 = 1'b0;
         end
end // TestPhase02.
//
// Phase 3: Store '1' in every addressable bit:
// Updates TDone3 & TRes3.
//
reg[AWid-1:0] i3;
//
always@(posedge Clk, posedge Reset)
  begin : TestPhase03
  if (Reset==1'b1)
       begin
       TDone3 = 1'b0;
       TRes3  = 1'b0;
       i3     = 0;
       end
  else if (TestNo==3 && i3<=MemHi)
         begin
         Addr3 = i3;
         DataO3 = 32'hffff_ffff;
         i3 = i3 + 1;
         if (i3>=MemHi)
           begin
           TDone3 = 1'b1;
           TRes3  = 1'b1;
           end
         end
  end // TestPhase03.
//
// Phase 4:  Read out and check stored '1' values:
// Update TDone4 & TRes4.
//
reg[AWid-1:0] i4;
reg Wait4;
//
// Negedge sampling and a wait state allow the memory
// to provide the correct datum for comparison:
//
always@(negedge Clk, posedge Reset)
  begin : TestPhase04
  if (Reset==1'b1)
       begin
       TDone4 = 1'b0;
       TRes4  = 1'b0;
       i4     = 0;
       Wait4  = 1'b1;
       end
  else if (TestNo==4 && i4<=MemHi)
         begin
         Addr4 = i4;
         if (Wait4==1'b0)
              begin : DelayedSample
              if ( DataI!=32'hffff_ffff )
                   begin
                   TDone4 = 1'b1;
                   TRes4  = 1'b0;
                   end
              else begin
                   i4    = i4 + 1;
                   Wait4 = 1'b1;
                   if (i4>=MemHi)
                     begin
                     TDone4 = 1'b1;
                     TRes4  = 1'b1;
                     end
                   end
              end  // DelayedSample
         else Wait4 = 1'b0;
         end
  end // TestPhase04.
//
// Phase 5:  Store a '0' in every addressable bit:
// Updates TDone5 & TRes5.
//
reg[AWid-1:0] i5;
//
always@(posedge Clk, posedge Reset)
  begin : TestPhase05
  if (Reset==1'b1)
       begin
       TDone5 = 1'b0;
       TRes5  = 1'b0;
       i5     = 0;
       end
  else if (TestNo==5 && i5<=MemHi)
         begin
         Addr5  = i5;
         DataO5 = 'b0;
         i5 = i5 + 1;
         if (i5>=MemHi)
           begin
           TDone5 = 1'b1;
           TRes5  = 1'b1;
           end
         end
  end // TestPhase05.
//
// Phase 6:  Read out and check stored '0' values:
// Update TDone6 & TRes6.
//
reg[AWid-1:0] i6;
reg Wait6;
//
// Negedge sampling and a wait state allow the memory
// to provide the correct datum for comparison:
//
always@(negedge Clk, posedge Reset)
  begin : TestPhase06
  if (Reset==1'b1)
       begin
       TDone6 = 1'b0;
       TRes6  = 1'b0;
       i6     = 0;
       Wait6  = 1'b1;
       end
  else if (TestNo==6 && i6<=MemHi)
         begin
         Addr6 = i6;
         if (Wait6==1'b0)
              begin : DelayedSample
              if ( DataI!=32'h0 )
                   begin
                   TDone6 = 1'b1;
                   TRes6  = 1'b0;
                   end
              else begin
                   i6    = i6 + 1;
                   Wait6 = 1'b1;
                   if (i6>=MemHi)
                     begin
                     TDone6 = 1'b1;
                     TRes6  = 1'b1;
                     end
                   end
              end  // DelayedSample
         else Wait6 = 1'b0;
         end
  end // TestPhase06.
//
// Phase 7:  Report test result (done by sequencer).
//
endmodule // BIST.
