#!/bin/csh -f 

if ! $?UVMHOME  then
   echo " ***ERROR - $UVM_HOME not set - please run setup script"; exit 1
endif

# consolidate UVM variables
if ! $?UVM_HOME  then
  setenv UVM_HOME $UVMHOME
endif

# set IREG_GEN path
if ! $?IREG_GEN  then
   echo " ***ERROR - $IREG_GEN not set - please run setup script"; exit 1
endif

#invoke iregGen with:
#   input memctl_reg_def.xml
#   output memctl_reg_pkg.sv
#   package name memctl_reg_pkg
#   quicktest generated
#   typename with suffix _c
#   using UVM1.1a syntax 
# For a full list of iregGen options, type:   
# $IREG_GEN/bin/iregGen –help

  $IREG_GEN/bin/iregGen \
    -i ./memctl_reg_def.xml \
    -o  memctl_reg_pkg.sv \
    -pkg memctl_reg_pkg \
    -qt quickTest.sv \
    -ta _c \
    -uvm11a

