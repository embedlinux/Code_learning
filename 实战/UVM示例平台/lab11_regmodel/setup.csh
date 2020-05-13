#!/bin/csh -f 

# SET UVM_HOME to current $UVMHOME variable (ireggen needs both)
setenv UVM_HOME $UVMHOME
echo "UVM_HOME is set to ${UVM_HOME}"

# SET IREG_GEN to installation of iregGen
setenv IREG_GEN `ncroot`/tools/methodology/iregGen
echo "IREG_GEN is set to ${IREG_GEN}"

# SET BASELINE INSTALL DIR
setenv PROJ_HOME `pwd`
echo "PROJ_HOME is set to ${PROJ_HOME}"
