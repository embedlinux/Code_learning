program automatic test;
import uvm_pkg::*;

`include "../uvm_tb/testcases/test_base.sv"
`include "../uvm_tb/testcases/write_test.sv"

initial begin
  $timeformat(-9, 1, "ns", 10);
  run_test();
end

endprogram

