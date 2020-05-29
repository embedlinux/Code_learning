// ===================================================
// CPU_Board.   Uses two named always blocks to
// simulate the interaction between a CPU and a 
// watch-dog device.
//
// This way of doing the exercise also takes the 
// opportunity of showing two verilog features:
//   1. A bidirectional module port declaration.
//   2. Hierarchical names to address substructure
//      (used in the testbench; should be avoided
//       in the design).
//
// The CPU and WatchDog state operations are collected
// into tasks, one for each state.
//
// The always blocks control the states; the tasks
// perform the communications.
//
// To understand the design most easily, read comments
// explaining the always blocks before those for the
// task declarations.
//
// The implementation below uses (effectively) one-shot
// pulses to issue interrupts.   These also could be 
// done as clocked edges, with, say, a disable after one
// cycle.   Good digital design practise, as opposed to
// exposure to the full verilog language, would require
// fully synchronized interrupts of some kind.
//
// ---------------------------------------------------
// 2006-05-27 jmw:  v. 1.5 Renamed WDWatching to
//      WD_Watching, for consistency.   Changed all task
//      names to t* or t_*.
// 2006-04-25 jmw:  v. 1.4 Fixed widths of inits; left
//      delays on individual statements for waveform
//      display clarity.   Made minor comment changes.
// 2005-10-25 jmw:  v. 1.3 Minor comment fixes.
// 2005-04-22 jmw:  v. 1.2 Moved external task variable
//      declarations to top of CPU_Board module, because
//      VCS sees the internal task refs before the
//      declarations.  Minor comment rewording.
// 2005-02-03 jmw:  v. 1.1 Removed unnecessary
//      fork-joins.  Replaced all nonblocking
//      assignments with blocking ones, leaving delays
//      the same.  Seems OK.
// 2005-01-12 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module CPU_Board
      #( parameter IntrWidth = 16 ) // INT protocol.
       ( output[31:0] Abus, output RecoveryMode, INT00
       , INT00_Ack, inout[31:0] Dbus, input Halt, Clk
       );
//
// These reg's are associated with module I/O's and
// probably should not be declared elsewhere:
//
reg[31:0] DbusReg, AbusReg;
reg RecoveryModeReg, INT00Reg, INT00_AckReg;
//
// Next two moved here in v. 1.2, for Lab14:
reg CPUHalted;   // For CPU internal state control.
reg WD_Watching;  // For WD internal state control.
//
// --------------------------------------
// Generic interrupt-related tasks.  These are separated
// from the other tasks so that they might be maintained
// independently.  For example, instead of one-shot pulses,
// the interrupt protocol might be clocked (synchronous).
// This would be easier on the logic synthesizer and would
// be conformant with good IC design.
task t_doINT00;
  begin  // A pulse depending on blocking assigns:
  #1         INT00Reg = 1'b0;
  #2         INT00Reg = 1'b1;
  #IntrWidth INT00Reg = 1'b0;
  end
endtask
//
task t_doINT00_Ack;
  begin  // A pulse depending on blocking assigns:
  #1         INT00_AckReg = 1'b0;
  #2         INT00_AckReg = 1'b1;
  #IntrWidth INT00_AckReg = 1'b0;
  end
endtask
//
// --------------------------------------
// tNormal_CPU: This task is called on every clock
// by the CPU always block if Halt is not asserted and
// if a previous halt has not left the CPUHalted flag set.
//
// It shares control of the INT00_Ack flag with Halt_CPU.
//
task tNormal_CPU; // No I/O required.
  begin
  DbusReg = $random($time); // Delays moved to assign's.
  AbusReg = $random($time);
  // Service the interrupt (by doing nothing)
  // while running:
  #1 if (INT00Reg==1'b1) t_doINT00_Ack; // task.
  end // tNormal_CPU.
endtask
//
// --------------------------------------
// tHalt_CPU: This task is called on every clock, by
// the CPU always block, if Halt is asserted.
// It keeps the CPU halted until an interrupt.  It
// exclusively controls the state of the CPUHalted
// bit.
// It shares control of the INT00_Ack flag with
// the tNormal_CPU task.
//
task tHalt_CPU; // No I/O required.
  begin
  if (CPUHalted==1'b0) // If a new halt.
       begin
       #1 CPUHalted = 1'b1;
       end
  else // Subsequent clock, after halt:
       if (INT00Reg==1'b1 && Halt!=1'b1)
         begin
         #1 CPUHalted = 1'b0; // Restart if Halt removed.
         t_doINT00_Ack; // task.
         end // "else', don't do anything.  
  end // tHalt_CPU.
endtask
//
// --------------------------------------
// tWD_Counting:  This task is called by the WatchDog
// always block on every clock, if WD_Watching is
// asserted (1'b1).
//
// It shares control of the WD_Watching state bit with
// tWD_Recovering, to determine which of the tasks is called
// from the WatchDog always block.
//
// It monitors Abus for a change while counting clocks.
// When Abus changes, the count is reset to 0; if the
// count reaches 10, WD goes into a recovery mode in
// which it sends interrupts to the CPU, assuming the
// CPU has been hung by a temporary hardware or software
// malfunction.
// The problem here is to continue to count clocks
// while concurrently monitoring Abus for change.  If
// we use @Abus, it will hang something until Abus changes.
// So, we save each successive Abus value and compare
// it on each clock:
//
// The counter is initialized to 0 for simulation locally,
// to make Silos compatible with VCS (Silos apparently
// can't see local task data):
//
reg[3:0] ClkCount; // Abus clock counter; init==0.
//
task tWD_Counting; // No I/O.
  reg[31:0] Old_Abus;
  begin
  if (Old_Abus!=Abus) // We don't care about Old_Abus uninit'ed.
       begin
       #1 ClkCount   =  'b0;
       #1 WD_Watching = 1'b1;
       end
  else if (ClkCount<=4'h9)
            begin
            #1 ClkCount   = ClkCount+1; // Inc clock counter.
            #1 WD_Watching = 1'b1;
            end
       else begin
            #1 ClkCount   =  'b0;
            #1 WD_Watching = 1'b0; // Enter Recovering state.
            end
  #2 Old_Abus = Abus;  // This delay of #2 guarantees that the
  end // tWD_Counting.  // new value will be easily visible.
endtask
//
// --------------------------------------
// tWD_Recovering:  This task is called by the WatchDog
// always block on every clock if WD_Watching is not
// asserted.
// It exclusively initiates an INT00 interrupt every 
// 5th clock.
// 
// It exclusively controls the state of the RecoveryMode
// flag.  It exclusively handles an INT00_Ack from the CPU.
//
// It shares control of the WD_Watching state bit with
// tWD_Counting, to determine which of the tasks is called
// from the WatchDog always block.
//
reg[2:0] IntCount;  // INT00 clock counter; init==0.
//
task tWD_Recovering; // No I/O.
  begin
  if (RecoveryModeReg==1'b0) // First recovery attempt:
       begin
       #1 WD_Watching      = 1'b0; // Enter Recovery state.
       #1 RecoveryModeReg = 1'b1; // Broadcast the problem.
       #1 IntCount        =  'b0; // Init clock counter.
       t_doINT00; // task to attempt CPU recovery.
       end
  else begin // Subsequent recovery attempt:
       if (INT00_Ack==1'b1) // Check for CPU up.
            begin
            #1 RecoveryModeReg = 1'b0; // Cancel the broadcast.
            #1 IntCount        =  'b0; // Init clock counter.
            #1 WD_Watching      = 1'b1; // Enter Watching state.
            end
       else begin // Prepare for more INT00's:
            if (IntCount>=3'h5)
                 begin
                 t_doINT00; // task to attempt CPU recovery.
                 #1 IntCount = 'b0;  // Reset clock counter.
                 end
            else #1 IntCount = IntCount+1; // Inc clock counter.
            end
       end
  end // tWD_Recovering.
endtask
//
// ------------------ Runtime: ----------
//
assign #1 RecoveryMode = RecoveryModeReg;
assign #1 INT00        = INT00Reg;
assign #1 INT00_Ack    = INT00_AckReg;
assign #2 Dbus = DbusReg; // Treated as an output.
assign #2 Abus = AbusReg;
//
// ----------------------------------
// The CPU always block. Only the CPU responds to Halt.
// When Halt is asserted, the CPU goes into a Halted state,
// and it can not do anything until interrupted, even
// after Halt is deasserted:
//
always@(posedge Clk)
  begin : CPU
  if (Halt==1'b0 && CPUHalted==1'b0)
       tNormal_CPU; // task.
  else tHalt_CPU;   // task.
  end
//
// ----------------------------------
// The WatchDog always block.   Ignores Halt
// but watches the address bus.   There are two
// distinct states, watching and trying to get CPU
// restarted; so, we define two different tasks,
// tWD_Counting and tWD_Recovering to separate them.
//
always@(negedge Clk)
  begin : WatchDog
    if (WD_Watching==1'b1)
         tWD_Counting;   // task.
    else tWD_Recovering; // task.
  end
//
endmodule // CPU_Board.
//
// ==================================================
// Testbench module:
//
module CPU_BoardTst;
//
wire[31:0] AbusWatch, DbusWatch;
wire       RecoveryModeWatch, INT00Watch
         , INT00_AckWatch;
reg        HaltStim, ClkStim;
//
always@(ClkStim) #5 ClkStim <= ~ClkStim;
//
initial
  begin
  #0   ClkStim         = 1'b0;
  #0   HaltStim        = 1'b0;
  #0   U1.INT00Reg     = 1'b0;
  #0   U1.INT00_AckReg = 1'b0;
  #0   U1.CPUHalted    = 1'b0;
  #0   U1.ClkCount     =  'b0;
  #0   U1.IntCount     =  'b0;
  #0   U1.RecoveryModeReg = 1'b0;
  #0   U1.WD_Watching   = 1'b1; // Otherwise, WatchDog asleep!
  #30  HaltStim = 1'b1;
  #12  HaltStim = 1'b0;
  #220 HaltStim = 1'b1;
  #300 HaltStim = 1'b0;
  #300 $finish;
  end
//
CPU_Board U1 ( .Abus(AbusWatch), .RecoveryMode(RecoveryModeWatch)
             , .INT00(INT00Watch), .INT00_Ack(INT00_AckWatch)
             , .Dbus(DbusWatch), .Halt(HaltStim), .Clk(ClkStim)
             );
//
endmodule // CPU_BoardTst.
