#!/bin/csh

set ScriptName=`basename $0`

if ( $#argv > 1 ) then 
    echo "Error: too many arguments!"
    echo ""
    echo "Example 1: $ScriptName"
    echo "Example 2: $ScriptName tb_assert_formal_pass_sim_wrapper"
    echo ""
    exit 1
endif

if ( $#argv == 1 ) then
    set TBENCH="$1"
else
    set TBENCH="tb_assert_simulation"; # Default
endif

module load cadence/ius/6.1

set LOG="log/${TBENCH}-NC_SVA.log"
set VC="../${TBENCH}.vc"

# Backup old log
if ( -f ${LOG} ) then
     mv ${LOG} ${LOG}.BAK
endif

# Run NC
ncverilog +sv -l $LOG -f $VC

# Add contents header to log
../../../bin/contents $LOG

# Tidy up
/bin/rm -rf INCA_libs
/bin/rm -rf ncverilog* waves* 
