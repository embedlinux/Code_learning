
-uvmhome $UVM_HOME 
//+uvm_set_type_override=memctl_rf_c,nocheck_memctl_rf_c 

-incdir ./
-incdir $PROJ_HOME/memctl_rtl 
-incdir $PROJ_HOME/apb/sv 
-incdir ./sequence_lib 
-timescale 1ns/1ns 

+UVM_TESTNAME=memctl_base_test

//+UVM_VERBOSITY=UVM_NONE
+UVM_VERBOSITY=UVM_LOW
//+UVM_VERBOSITY=UVM_MEDIUM
//+UVM_VERBOSITY=UVM_HIGH
//+UVM_VERBOSITY=UVM_FULL

// APB UVC
$PROJ_HOME/apb/sv/apb_if.sv
$PROJ_HOME/apb/sv/apb_pkg.sv

noreg_top.sv 
$PROJ_HOME/memctl_rtl/memctl.sv 
$PROJ_HOME/memctl_rtl/memctldut.sv 

//-----------------------------------------------------------
//  OTHER OPTIONS 
//-----------------------------------------------------------
//  -svseed random 
// -gui -access rwc -linedebug 
