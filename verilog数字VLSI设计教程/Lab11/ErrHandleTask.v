// ===================================================
// ErrHandleTask. Demonstrates a verilog homemade
// assertion task.   Based on a Lab10 exercise.
//
// To use the ErrHandle task in a design, a condition
// must be checked in an if, case, etc, and the task
// then called with the desired message (up to 31
// bytes, in the default configuration here) and
// status code.
//
// There are four possible Actions:
// 0: The Sts is 0 or the Msg is null.  This condition 
//   is normal, and the task silently returns, with no
//   message.
// 1: The Sts is -1.  The condition is a fatal error 
//   and the simulation is finished.
// 2: The Sts is more negative than -1.  The condition 
//   is an error and the simulation is stopped but may 
//   be continued.
// 3: The Sts is positive.   The condition is a warning
//   or an informative one, the Msg is printed to the 
//   simulator console, but no other action is taken.
//
// -----------------------------------------------------
// 2005-11-23 jmw: v. 1.2   Removed unused TheStatus ref.
// 2005-10-18 jmw: v. 1.1   Modified comments; removed
//            unused TheMessage reg from testbench; made
//            message length configurable.
// 2005-02-10 jmw: v. 1.0 implemented.
// =====================================================
`timescale 1ns/100ps
//
module ErrHandleTask;  // Just a testbench.
//
localparam MsgBytes = 32;
localparam HiBit    = (8*MsgBytes)-1;
//
task ErrHandle(input[3:0] Sts, input[HiBit:0] Msg);
reg[1:0] Action;
  begin
  if (Sts==4'h0 || Msg=='b0)
                      Action = 2'b00;
  else if (Sts==4'hf) Action = 2'b01; // -1, 2's complement.
  else if (Sts>=4'h8) Action = 2'b10;
  else                Action = 2'b11;
  case (Action)
    2'b00: Sts = 0; // Do nothing.
    2'b01: begin
           $display("time=%4d: FATAL ERROR. %s"
                   , $time,                  Msg);
           $finish;
           end
    2'b10: begin
           $display("time=%4d: ERROR Sts=%02d. %s"
                   , $time,           Sts,     Msg);
           $display("\nYou may continue the simulation now.");
           $stop;
           end
  default: $display("time=%4d: Sts=%02d. NOTE: %s"
                   , $time,     Sts,           Msg);
  endcase
  end
endtask
//
// -------------------------------------------
//
initial
  begin
  #10 ErrHandle(1, "x" );
  #10 ErrHandle(1, "The status was 1");
  #10 ErrHandle(0, "Sts was 0");
  #10 ErrHandle(-3, "This was the nonfatal error.");
  #10 ErrHandle(-1, "This was the fatal error code at time 50.");
  #20 $finish;
  end

endmodule // ErrHandleTask.

