// ===================================================
// Forever.   Demonstrates use of a forever statement,
// as explained in the Workbook.
//
// 2005-11-28 jmw:  v. 1.2 Toggled Clock1; changed
//            timescale from 1ns/100ps to 1ns/1ns.
// 2005-01-31 jmw:  v. 1.1 Changed to blocking.
// 2005-01-09 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/1ns
//
module Forever;
reg Clock1;
integer Count;
reg[5:0] Dbus;
//
initial
  begin
  Count  = 1'b0;
  Clock1 = 1'b0;
  #2
  begin: Mod16_Counter
    forever
      begin
      Clock1 = ~Clock1;
      Count  = Count + 1;      // Count is an integer or wide reg.
      #5 Dbus[4:0] = Count%16; // Delay avoids hanging the simulator.
      end
    end // Mod16_Counter.
  end // initial.
//
initial
  begin 
  #100 
  disable Mod16_Counter; 
  $finish; 
  end
//
endmodule // Forever.
